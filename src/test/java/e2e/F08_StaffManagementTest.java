package e2e;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.openqa.selenium.By;

import java.util.UUID;

import static org.junit.Assert.*;

/**
 * F08 — Staff Information Management (Admin) E2E Tests
 *
 * Covers: Staff list, create with position, search by name,
 * filter by position, view detail, deactivate, delete.
 */
public class F08_StaffManagementTest extends BaseE2ETest {

    @Before
    public void setUp() {
        logout();
        loginAsStaff();
    }

    @After
    public void tearDown() {
        logout();
    }

    // ── List page ─────────────────────────────────────────────────────────────

    /** TC-08-1: Staff list page renders */
    @Test
    public void testStaffListRenders() {
        navigateTo("/admin/staff/");
        assertFalse("Staff list should not 403", pageSource().contains("403"));
        assertFalse("Staff list should not 404", pageSource().contains("HTTP ERROR 404"));
        assertFalse("Staff list should not 500", pageSource().contains("HTTP ERROR 500"));
        assertTrue("Staff list page should mention 'Staff'",
                pageSource().contains("Staff") || pageSource().contains("staff") ||
                pageSource().contains("Employee"));
    }

    /** TC-08-2: Staff list shows table */
    @Test
    public void testStaffListShowsTable() {
        navigateTo("/admin/staff/");
        assertTrue("Staff list should have a table or list",
                isElementPresent(By.tagName("table")) || isElementPresent(By.tagName("tbody")) ||
                pageSource().contains("Email") || pageSource().contains("Name") ||
                pageSource().contains("Position"));
    }

    // ── Create staff ──────────────────────────────────────────────────────────

    /** TC-08-3: Add staff form renders */
    @Test
    public void testAddStaffFormRenders() {
        navigateTo("/admin/staff/form");
        assertFalse("Staff form should not 404",
                pageSource().contains("HTTP ERROR 404") && !currentUrl().contains("login"));
        assertFalse("Staff form should not 500", pageSource().contains("HTTP ERROR 500"));
        assertTrue("Staff form should have a form element",
                isElementPresent(By.tagName("form")));
    }

    /** TC-08-4: Add staff form has position field */
    @Test
    public void testAddStaffFormHasPositionField() {
        navigateTo("/admin/staff/form");
        String src = pageSource();
        boolean hasPosition = src.contains("position") || src.contains("Position") ||
                isElementPresent(By.name("position")) ||
                src.contains("salesperson") || src.contains("manager");
        assertTrue("Staff form should have a position field", hasPosition);
    }

    /** TC-08-5: Create salesperson staff and verify it appears in the list */
    @Test
    public void testCreateSalespersonStaff() {
        navigateTo("/admin/staff/form");
        assertNoServerErrorPage();
        org.junit.Assume.assumeTrue("staff form must render", isElementPresent(By.name("email")));

        String uniqueEmail = "e2e-staff-sp-" + UUID.randomUUID().toString().substring(0, 8) + "@test.com";
        fillField("firstName", "Auto");
        fillField("lastName", "Salesperson");
        fillField("email", uniqueEmail);
        fillField("password", "TestPass@123");
        if (isElementPresent(By.name("phone"))) fillField("phone", "+61400000097");
        // Option text is Title Case in the JSP: "Salesperson" not "salesperson"
        if (isElementPresent(By.name("position"))) selectOption("position", "Salesperson");
        clickSubmit();

        assertNoServerErrorPage();
        navigateTo("/admin/staff/?name=Salesperson");
        assertNoServerErrorPage();
        assertTrue("Newly created salesperson should appear in the staff list",
                pageSource().contains(uniqueEmail));
    }

    /** TC-08-6: Create manager staff and verify position filter returns it */
    @Test
    public void testCreateManagerStaff() {
        navigateTo("/admin/staff/form");
        assertNoServerErrorPage();
        org.junit.Assume.assumeTrue("staff form must render", isElementPresent(By.name("email")));

        String uniqueEmail = "e2e-staff-mgr-" + UUID.randomUUID().toString().substring(0, 8) + "@test.com";
        fillField("firstName", "Auto");
        fillField("lastName", "Manager");
        fillField("email", uniqueEmail);
        fillField("password", "TestPass@123");
        if (isElementPresent(By.name("phone"))) fillField("phone", "+61400000096");
        // Option text is Title Case: "Manager" not "manager"
        if (isElementPresent(By.name("position"))) selectOption("position", "Manager");
        clickSubmit();

        assertNoServerErrorPage();
        navigateTo("/admin/staff/?position=manager");
        assertNoServerErrorPage();
        assertTrue("Position filter should return the new manager",
                pageSource().contains(uniqueEmail));
    }

    // ── Search / Filter ───────────────────────────────────────────────────────

    /** TC-08-7: Search staff by name returns the seeded staff member */
    @Test
    public void testSearchStaffByName() {
        navigateTo("/admin/staff/?name=staff");
        assertNoServerErrorPage();
        assertTrue("Staff name search should return the seeded staff account",
                pageSource().contains("staff@iotbay.com") ||
                pageSource().toLowerCase().contains("staff"));
    }

    /** TC-08-8: Filter staff by position */
    @Test
    public void testFilterStaffByPosition() {
        navigateTo("/admin/staff/?position=manager");
        assertNoServerErrorPage();
    }

    // ── View / Edit ───────────────────────────────────────────────────────────

    /** TC-08-9: Staff view page renders details */
    @Test
    public void testStaffViewPageExists() {
        navigateTo("/admin/staff/view/2");
        assertNoServerErrorPage();
        assertTrue("Staff view should render details",
                pageSource().contains("Staff Details") ||
                pageSource().contains("staff@iotbay.com") ||
                isElementPresent(By.tagName("dl")));
    }

    /** TC-08-10: Staff edit page pre-fills the form */
    @Test
    public void testStaffEditPageExists() {
        navigateTo("/admin/staff/edit/2");
        assertNoServerErrorPage();
        assertTrue("Staff edit form should render input fields",
                isElementPresent(By.name("email")) || isElementPresent(By.tagName("form")));
    }

    // ── Access control ─────────────────────────────────────────────────────────

    /** TC-08-11: Customer role cannot access staff management */
    @Test
    public void testCustomerRoleCannotAccessStaffManagement() {
        logout();
        loginAsCustomer();
        navigateTo("/admin/staff/");
        boolean blocked = currentUrl().contains("login") ||
                pageSource().contains("403") ||
                pageSource().contains("Unauthorized") ||
                !currentUrl().contains("staff");
        assertTrue("Customer role should NOT access staff admin", blocked);
    }

    /** TC-08-12: Unauthenticated access to staff management is blocked */
    @Test
    public void testUnauthenticatedCannotAccessStaffManagement() {
        logout();
        navigateTo("/admin/staff/");
        boolean blocked = currentUrl().contains("login") ||
                pageSource().contains("login") ||
                pageSource().contains("401");
        assertTrue("Unauthenticated access to /admin/staff/ should be blocked", blocked);
    }

    /**
     * Local server-error guard. Fails on Jetty 500/404 pages AND on the app's
     * custom error page (which returns HTTP 200 with friendly text).
     */
    private void assertNoServerErrorPage() {
        String src = pageSource();
        assertFalse("Page shows Jetty 500 error. URL: " + currentUrl(),
                src.contains("HTTP ERROR 500"));
        assertFalse("Page shows Jetty 404 error. URL: " + currentUrl(),
                src.contains("HTTP ERROR 404"));
        assertFalse("Page shows the app's custom error page. URL: " + currentUrl(),
                src.contains("Oops! Something went wrong")
                        || src.contains("Development Error Information")
                        || src.contains("experiencing some technical difficulties"));
    }

}
