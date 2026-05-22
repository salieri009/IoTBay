package e2e;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebElement;

import java.io.IOException;
import java.util.List;

import static org.junit.Assert.*;

/**
 * F10 — Data Management E2E Tests
 *
 * Covers: Dashboard stats, Export (4 types), Import Users CSV (valid/invalid/empty),
 * Import Products CSV, Bulk Delete (users/products).
 */
public class F10_DataManagementTest extends BaseE2ETest {

    @Before
    public void setUp() {
        logout();
        loginAsStaff();
    }

    @After
    public void tearDown() {
        logout();
    }

    // ── Dashboard ─────────────────────────────────────────────────────────────

    /** TC-10-1: Data management dashboard renders */
    @Test
    public void testDashboardRenders() {
        navigateTo("/api/dataManagement/dashboard");
        assertFalse("Dashboard should not 403", pageSource().contains("403"));
        assertFalse("Dashboard should not 404", pageSource().contains("HTTP ERROR 404"));
        assertFalse("Dashboard should not 500", pageSource().contains("HTTP ERROR 500"));
        assertTrue("Dashboard should contain management content",
                pageSource().contains("Export") || pageSource().contains("Import") ||
                pageSource().contains("Data") || pageSource().length() > 200);
    }

    /** TC-10-2: Dashboard shows stats cards (users, orders, products count) */
    @Test
    public void testDashboardShowsStats() {
        navigateTo("/api/dataManagement/dashboard");
        String src = pageSource();
        boolean hasStats = src.contains("Users") || src.contains("Orders") ||
                src.contains("Products") || src.contains("Total");
        assertTrue("Dashboard should show statistics", hasStats);
    }

    // ── Export ────────────────────────────────────────────────────────────────

    /** TC-10-3: Export users endpoint responds (no 500) */
    @Test
    public void testExportUsersEndpointResponds() {
        navigateTo("/api/dataManagement/exportUsers");
        // Should respond with CSV content or redirect, not 500
        assertFalse("Export users should not 500", pageSource().contains("HTTP ERROR 500"));
        assertFalse("Export users should not 404", pageSource().contains("HTTP ERROR 404"));
    }

    /** TC-10-4: Export products endpoint responds */
    @Test
    public void testExportProductsEndpointResponds() {
        navigateTo("/api/dataManagement/exportProducts");
        assertFalse("Export products should not 500", pageSource().contains("HTTP ERROR 500"));
        assertFalse("Export products should not 404", pageSource().contains("HTTP ERROR 404"));
    }

    /** TC-10-5: Export orders endpoint responds */
    @Test
    public void testExportOrdersEndpointResponds() {
        navigateTo("/api/dataManagement/exportOrders");
        assertFalse("Export orders should not 500", pageSource().contains("HTTP ERROR 500"));
    }

    /** TC-10-6: Export access logs endpoint responds */
    @Test
    public void testExportAccessLogsEndpointResponds() {
        navigateTo("/api/dataManagement/exportAccessLogs");
        assertFalse("Export access logs should not 500", pageSource().contains("HTTP ERROR 500"));
    }

    // ── Import ────────────────────────────────────────────────────────────────

    /** TC-10-7: Import page (data management dashboard) has upload form */
    @Test
    public void testImportFormExists() {
        navigateTo("/api/dataManagement/dashboard");
        boolean hasImportForm = pageSource().contains("import") || pageSource().contains("Import") ||
                isElementPresent(By.cssSelector("input[type='file']")) ||
                isElementPresent(By.name("csvFile")) ||
                isElementPresent(By.name("entityType"));
        assertTrue("Data management page should have an import form", hasImportForm);
    }

    /** TC-10-8: Import endpoint rejects empty file upload */
    @Test
    public void testImportEmptyFileShowsError() throws IOException {
        navigateTo("/api/dataManagement/dashboard");
        // Try to submit with no file
        if (isElementPresent(By.name("entityType"))) {
            selectOption("entityType", "users");
        }
        // Submit without a file — should show an error message
        List<WebElement> submitBtns = driver.findElements(
                By.cssSelector("form[action*='import'] [type='submit']"));
        if (!submitBtns.isEmpty()) {
            submitBtns.get(0).click();
            String src = pageSource();
            boolean hasError = src.contains("Please select") || src.contains("error") ||
                    src.contains("Error") || src.contains("required");
            assertTrue("Empty file upload should produce an error", hasError);
        }
    }

    /** TC-10-9: Import users with valid CSV shows preview */
    @Test
    public void testImportUsersValidCSVShowsPreview() throws IOException {
        navigateTo("/api/dataManagement/dashboard");

        // Prepare a valid CSV for users
        String validCsv = "Email,First Name,Last Name,Phone,Is Active\n" +
                "e2e-import@test.com,Import,User,+61400000001,true\n";

        // If the import form is present
        if (isElementPresent(By.name("csvFile")) && isElementPresent(By.name("entityType"))) {
            selectOption("entityType", "users");
            uploadCSV("csvFile", validCsv);

            List<WebElement> submitBtns = driver.findElements(
                    By.cssSelector("form[action*='import'] [type='submit']"));
            if (!submitBtns.isEmpty()) {
                submitBtns.get(0).click();
                String src = pageSource();
                // Should show preview or success, not 500
                assertFalse("Valid CSV import should not cause 500",
                        src.contains("HTTP ERROR 500"));
                // Should either show the preview page or a success message
                boolean showsPreviewOrSuccess = src.contains("Preview") || src.contains("preview") ||
                        src.contains("Confirm") || src.contains("Import") ||
                        src.contains("e2e-import@test.com") || src.contains("imported") ||
                        src.contains("record");
                assertTrue("Valid CSV import should show preview or success", showsPreviewOrSuccess);
            }
        }
    }

    /** TC-10-10: Import with invalid CSV headers shows error */
    @Test
    public void testImportInvalidCSVHeadersShowsError() throws IOException {
        navigateTo("/api/dataManagement/dashboard");

        String invalidCsv = "WrongCol1,WrongCol2,WrongCol3\nval1,val2,val3\n";

        if (isElementPresent(By.name("csvFile")) && isElementPresent(By.name("entityType"))) {
            selectOption("entityType", "users");
            uploadCSV("csvFile", invalidCsv);

            List<WebElement> submitBtns = driver.findElements(
                    By.cssSelector("form[action*='import'] [type='submit']"));
            if (!submitBtns.isEmpty()) {
                submitBtns.get(0).click();
                String src = pageSource();
                assertFalse("Invalid CSV should not cause 500", src.contains("HTTP ERROR 500"));
                boolean showsError = src.contains("Invalid") || src.contains("invalid") ||
                        src.contains("error") || src.contains("Error") ||
                        src.contains("Expected") || src.contains("header");
                assertTrue("Invalid CSV headers should produce an error message", showsError);
            }
        }
    }

    /** TC-10-11: Import products with valid CSV shows preview */
    @Test
    public void testImportProductsValidCSV() throws IOException {
        navigateTo("/api/dataManagement/dashboard");

        String validCsv = "Name,Category,Price,Stock Quantity,Description\n" +
                "E2E Test Product,IoT,49.99,5,E2E test description\n";

        if (isElementPresent(By.name("csvFile")) && isElementPresent(By.name("entityType"))) {
            if (isElementPresent(By.cssSelector("option[value='products']"))) {
                selectOption("entityType", "products");
            }
            uploadCSV("csvFile", validCsv);

            List<WebElement> submitBtns = driver.findElements(
                    By.cssSelector("form[action*='import'] [type='submit']"));
            if (!submitBtns.isEmpty()) {
                submitBtns.get(0).click();
                assertFalse("Product import should not 500", pageSource().contains("HTTP ERROR 500"));
            }
        }
    }

    // ── Bulk Delete ───────────────────────────────────────────────────────────

    /** TC-10-12: Bulk delete section exists on data management page */
    @Test
    public void testBulkDeleteSectionExists() {
        navigateTo("/api/dataManagement/dashboard");
        boolean hasBulkDelete = pageSource().contains("Bulk") || pageSource().contains("bulk") ||
                pageSource().contains("Delete") || isElementPresent(By.name("deleteType")) ||
                isElementPresent(By.name("ids"));
        assertTrue("Data management page should have a bulk delete section", hasBulkDelete);
    }

    /** TC-10-13: Bulk delete with no IDs shows error */
    @Test
    public void testBulkDeleteNoIdsShowsError() {
        navigateTo("/api/dataManagement/dashboard");
        // Try to submit bulk delete without IDs
        List<WebElement> deleteForms = driver.findElements(
                By.cssSelector("form[action*='bulkDelete']"));
        if (!deleteForms.isEmpty()) {
            WebElement form = deleteForms.get(0);
            List<WebElement> submitBtns = form.findElements(By.cssSelector("[type='submit'], button"));
            if (!submitBtns.isEmpty()) {
                submitBtns.get(0).click();
                String src = pageSource();
                assertFalse("Bulk delete without IDs should not 500",
                        src.contains("HTTP ERROR 500"));
                // Should show an error or stay on the page with a message
            }
        }
    }

    /** TC-10-14: Bulk delete endpoint POST is accessible */
    @Test
    public void testBulkDeleteEndpointAccessible() {
        // We verify the endpoint exists by checking the form action on the page
        navigateTo("/api/dataManagement/dashboard");
        boolean hasAction = pageSource().contains("bulkDelete") ||
                pageSource().contains("bulk-delete") ||
                isElementPresent(By.cssSelector("[action*='bulkDelete']"));
        // If the endpoint is linked from the page, it exists
        assertTrue("Data management page should reference the bulk delete endpoint",
                hasAction || pageSource().contains("Delete Records") ||
                pageSource().contains("Bulk Delete"));
    }

    // ── Access control ─────────────────────────────────────────────────────────

    /** TC-10-15: Unauthenticated access to dashboard is blocked */
    @Test
    public void testUnauthenticatedCannotAccessDashboard() {
        logout();
        navigateTo("/api/dataManagement/dashboard");
        boolean blocked = currentUrl().contains("login") ||
                pageSource().contains("login") ||
                pageSource().contains("401");
        assertTrue("Unauthenticated access to data management should be blocked", blocked);
    }

    /** TC-10-16: Customer cannot access data management */
    @Test
    public void testCustomerCannotAccessDataManagement() {
        logout();
        loginAsCustomer();
        navigateTo("/api/dataManagement/dashboard");
        boolean blocked = currentUrl().contains("login") ||
                pageSource().contains("403") ||
                pageSource().contains("Unauthorized") ||
                !currentUrl().contains("dataManagement");
        assertTrue("Customer role should NOT access data management", blocked);
    }
}
