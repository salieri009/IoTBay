package e2e;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.openqa.selenium.By;

import java.util.UUID;

import static org.junit.Assert.*;

/**
 * F09 — Supplier Management (Admin) E2E Tests
 *
 * Covers: Supplier list, create, search by contact/company name, view detail,
 * edit, activate/deactivate (toggle status), delete, and admin-only access control.
 */
public class F09_SupplierTest extends BaseE2ETest {

    @Before
    public void setUp() {
        logout();
        loginAsStaff();
    }

    @After
    public void tearDown() {
        logout();
    }

    /** Fails if the page rendered a server error (HTTP 500 or custom error page). */
    private void assertNoServerError() {
        String src = pageSource();
        assertFalse("Page should not 500", src.contains("HTTP ERROR 500"));
        assertFalse("Page should not show custom error page",
                src.contains("Oops! Something went wrong") ||
                src.contains("Development Error Information"));
    }

    // ── List page ─────────────────────────────────────────────────────────────

    /** TC-09-1: Supplier list page renders */
    @Test
    public void testSupplierListRenders() {
        navigateTo("/admin/supplier/");
        assertNoServerError();
        assertFalse("Supplier list should not 404", pageSource().contains("HTTP ERROR 404"));
        assertTrue("Supplier list page should mention 'Supplier'",
                pageSource().contains("Supplier") || pageSource().contains("supplier"));
    }

    /** TC-09-2: Supplier list shows seeded suppliers in a table */
    @Test
    public void testSupplierListShowsSeededData() {
        navigateTo("/admin/supplier/");
        assertNoServerError();
        assertTrue("Supplier list should render a table",
                isElementPresent(By.tagName("table")));
        // Seeded suppliers from DatabaseInitializer
        assertTrue("Seeded supplier company should appear",
                pageSource().contains("Tech Supplies Co") ||
                pageSource().contains("IoT Components Ltd") ||
                pageSource().contains("Smart Systems Pty"));
    }

    /** TC-09-3: Supplier list has a search form for contact/company name */
    @Test
    public void testSupplierListHasSearchForm() {
        navigateTo("/admin/supplier/");
        assertNoServerError();
        assertTrue("Supplier list should have a contact-name search input",
                isElementPresent(By.cssSelector("input[name='contactName']")));
        assertTrue("Supplier list should have a company-name search input",
                isElementPresent(By.cssSelector("input[name='companyName']")));
    }

    // ── Create supplier ───────────────────────────────────────────────────────

    /** TC-09-4: Add supplier form renders with required fields */
    @Test
    public void testAddSupplierFormRenders() {
        navigateTo("/admin/supplier/form");
        assertNoServerError();
        assertTrue("Supplier form should have a form element",
                isElementPresent(By.tagName("form")));
        assertTrue("Form should have companyName field",
                isElementPresent(By.name("companyName")));
        assertTrue("Form should have contactName field",
                isElementPresent(By.name("contactName")));
    }

    /** TC-09-5: Create a new supplier and verify it appears in the list */
    @Test
    public void testCreateSupplier() {
        navigateTo("/admin/supplier/form");
        assertNoServerError();

        String suffix = UUID.randomUUID().toString().substring(0, 6);
        String company = "E2E Supplier " + suffix;
        String contact = "E2E Contact " + suffix;
        String email = "e2e-supplier-" + suffix + "@test.com";

        fillField("companyName", company);
        fillField("contactName", contact);
        fillField("email", email);
        fillField("phone", "+61400000095");
        fillField("address", "1 Test St");
        fillField("city", "Sydney");
        fillField("state", "NSW");
        fillField("zipCode", "2000");
        fillField("country", "Australia");

        clickSubmit();
        assertNoServerError();

        // After create the controller redirects to the view page → should show the company
        assertTrue("Created supplier should be shown on its view page",
                pageSource().contains(company) || pageSource().contains(contact));

        // And it should now appear in the list
        navigateTo("/admin/supplier/");
        assertTrue("Newly created supplier should appear in the list",
                pageSource().contains(company));
    }

    // ── Search ────────────────────────────────────────────────────────────────

    /** TC-09-6: Search supplier by company name returns matching rows */
    @Test
    public void testSearchSupplierByCompanyName() {
        navigateTo("/admin/supplier/search?companyName=Tech");
        assertNoServerError();
        // Seeded "Tech Supplies Co" should match
        assertTrue("Company-name search should return the matching supplier",
                pageSource().contains("Tech Supplies Co"));
    }

    /** TC-09-7: Search supplier by contact name does not error */
    @Test
    public void testSearchSupplierByContactName() {
        navigateTo("/admin/supplier/search?contactName=John");
        assertNoServerError();
        // Seeded contact "John Smith"
        assertTrue("Contact-name search should return a matching supplier",
                pageSource().contains("John Smith") || pageSource().contains("Tech Supplies Co"));
    }

    // ── View / Edit ───────────────────────────────────────────────────────────

    /** TC-09-8: Supplier view page renders detail */
    @Test
    public void testSupplierViewPageExists() {
        navigateTo("/admin/supplier/view/1");
        assertNoServerError();
    }

    /** TC-09-9: Supplier edit page pre-fills the form */
    @Test
    public void testSupplierEditPageExists() {
        navigateTo("/admin/supplier/edit/1");
        assertNoServerError();
        assertTrue("Edit page should render a form with a hidden supplierId",
                isElementPresent(By.cssSelector("input[name='supplierId']")));
    }

    // ── Activate / Deactivate ───────────────────────────────────────────────────

    /** TC-09-10: Toggle (activate/deactivate) a supplier status */
    @Test
    public void testToggleSupplierStatus() {
        navigateTo("/admin/supplier/view/1");
        assertNoServerError();
        // The view page should expose an Activate/Deactivate toggle form
        assertTrue("View page should have a toggle-status form",
                isElementPresent(By.cssSelector("form[action*='toggle-status']")));

        java.util.List<org.openqa.selenium.WebElement> toggleForms =
                driver.findElements(By.cssSelector("form[action*='toggle-status'] [type='submit']"));
        if (!toggleForms.isEmpty()) {
            toggleForms.get(0).click();
            assertNoServerError();
            assertTrue("After toggle should show a success message or status",
                    pageSource().contains("successfully") ||
                    pageSource().contains("Active") || pageSource().contains("Inactive"));
        }
    }

    // ── Access control ────────────────────────────────────────────────────────

    /** TC-09-11: Customer role cannot access supplier management */
    @Test
    public void testCustomerCannotAccessSupplierManagement() {
        logout();
        loginAsCustomer();
        navigateTo("/admin/supplier/");
        boolean blocked = currentUrl().contains("login") ||
                pageSource().contains("403") ||
                pageSource().contains("Unauthorized") ||
                !currentUrl().contains("supplier");
        assertTrue("Customer role should NOT access supplier admin", blocked);
    }

    /** TC-09-12: Unauthenticated access is blocked */
    @Test
    public void testUnauthenticatedCannotAccessSupplierManagement() {
        logout();
        navigateTo("/admin/supplier/");
        boolean blocked = currentUrl().contains("login") ||
                pageSource().contains("login") ||
                pageSource().contains("401");
        assertTrue("Unauthenticated access to /admin/supplier/ should be blocked", blocked);
    }
}
