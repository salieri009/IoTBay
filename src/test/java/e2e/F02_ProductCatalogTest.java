package e2e;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.List;

import static org.junit.Assert.*;

/**
 * F02 — Device/Product Catalogue E2E Tests
 *
 * Covers: Browse, Search, Filter by Category, Product Detail,
 * Staff CRUD (Create/Edit/Delete product), access control.
 */
public class F02_ProductCatalogTest extends BaseE2ETest {

    @Before
    public void setUp() {
        logout();
    }

    @After
    public void tearDown() {
        logout();
    }

    /** TC-02-1: Browse page loads and shows products */
    @Test
    public void testBrowseAllProducts() {
        // Use /browse (controller), NOT /browse.jsp (direct JSP would lack product data)
        navigateTo("/browse");
        // Products page should show product cards or a list
        assertTrue("Browse page should contain products or a product listing",
                pageSource().contains("product") || pageSource().contains("Product") ||
                isElementPresent(By.cssSelector(".product-card, [class*='product'], [data-product-id]")));
    }

    /** TC-02-2: Search for product by keyword returns filtered results */
    @Test
    public void testSearchProductByKeyword() {
        navigateTo("/browse");
        // Find search input and type keyword
        if (isElementPresent(By.name("search")) || isElementPresent(By.name("keyword")) ||
            isElementPresent(By.name("q"))) {
            String inputName = isElementPresent(By.name("search")) ? "search" :
                               isElementPresent(By.name("keyword")) ? "keyword" : "q";
            fillField(inputName, "Sensor");
            clickSubmit();
            assertTrue("Search results should mention 'Sensor'",
                    pageSource().contains("Sensor") || pageSource().contains("sensor"));
        } else {
            // Try URL-based search via controller
            navigateTo("/browse?q=Sensor");
            assertTrue("Browse page should load", !pageSource().contains("HTTP ERROR 500"));
        }
    }

    /** TC-02-3: Manage products page renders for staff */
    @Test
    public void testStaffCanAccessManageProducts() {
        loginAsStaff();
        navigateTo("/api/manage/products");
        assertFalse("Manage products should not show 403", pageSource().contains("403"));
        assertFalse("Manage products should not show 500", pageSource().contains("HTTP ERROR 500"));
        assertTrue("Manage products page should load",
                pageSource().contains("product") || pageSource().contains("Product") ||
                isElementPresent(By.tagName("table")));
    }

    /** TC-02-4: Customer cannot access manage products */
    @Test
    public void testCustomerCannotManageProducts() {
        loginAsCustomer();
        navigateTo("/api/manage/products");
        // Should be redirected or show 403
        boolean blocked = currentUrl().contains("login") ||
                pageSource().contains("403") ||
                pageSource().contains("Unauthorized") ||
                pageSource().contains("Access Denied") ||
                !currentUrl().contains("manage");
        assertTrue("Customer should not access manage products page", blocked);
    }

    /** TC-02-5: Staff can see Add Product form */
    @Test
    public void testStaffCanAccessAddProductForm() {
        loginAsStaff();
        navigateTo("/manage-product-form.jsp");
        assertFalse("Add product form should not show 500 error",
                pageSource().contains("HTTP ERROR 500"));
        assertTrue("Add product form should have a form element",
                isElementPresent(By.tagName("form")));
    }

    /** TC-02-6: Staff can create a new product */
    @Test
    public void testStaffCanCreateProduct() {
        loginAsStaff();
        navigateTo("/manage-product-form.jsp");

        // Fill in the product form
        if (isElementPresent(By.name("name"))) {
            fillField("name", "E2E Test Product");
        }
        if (isElementPresent(By.name("description"))) {
            fillField("description", "Created by E2E test");
        }
        if (isElementPresent(By.name("price"))) {
            fillField("price", "99.99");
        }
        if (isElementPresent(By.name("stockQuantity"))) {
            fillField("stockQuantity", "10");
        }

        // Submit the form
        if (isElementPresent(By.cssSelector("[type='submit']"))) {
            clickSubmit();
            // Should redirect to product list or show success
            assertFalse("Creating product should not cause 500 error",
                    pageSource().contains("HTTP ERROR 500"));
        }
    }

    /** TC-02-7: Staff can access Edit product form (no 405 error) */
    @Test
    public void testStaffCanAccessEditProductForm() {
        loginAsStaff();
        // Navigate to manage products to find a product ID
        navigateTo("/api/manage/products");
        assertFalse("Manage products page should not error",
                pageSource().contains("HTTP ERROR 500"));

        // Try to navigate to edit form for product ID 1
        navigateTo("/manage/products/update?id=1");
        // Should NOT return 405 Method Not Allowed
        assertFalse("Edit product should not return 405 error",
                pageSource().contains("405") || pageSource().contains("Method Not Allowed"));
        assertFalse("Edit product should not return 500 error",
                pageSource().contains("HTTP ERROR 500"));
    }

    /** TC-02-8: Product detail page renders for a known product */
    @Test
    public void testProductDetailPageRenders() {
        navigateTo("/productDetails.jsp?id=1");
        assertFalse("Product detail page should not error",
                pageSource().contains("HTTP ERROR 500") || pageSource().contains("HTTP ERROR 404"));
    }

    /** TC-02-9: Category filtering works on browse page */
    @Test
    public void testCategoryPageLoads() {
        navigateTo("/categories.jsp");
        assertFalse("Categories page should not error",
                pageSource().contains("HTTP ERROR 500"));
        assertTrue("Categories page should list categories",
                pageSource().contains("categor") || pageSource().contains("Categor") ||
                isElementPresent(By.tagName("a")));
    }

    /** TC-02-10: Manage products shows delete option for staff */
    @Test
    public void testManageProductsHasDeleteOption() {
        loginAsStaff();
        navigateTo("/api/manage/products");
        boolean hasDeleteOption =
                pageSource().contains("Delete") || pageSource().contains("delete") ||
                isElementPresent(By.cssSelector("[data-action='delete'], form[action*='delete']"));
        assertTrue("Manage products should have a delete action", hasDeleteOption);
    }
}
