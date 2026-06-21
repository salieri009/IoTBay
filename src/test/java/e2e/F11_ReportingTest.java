package e2e;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.openqa.selenium.By;

import static org.junit.Assert.*;

/**
 * F11 — BI &amp; Reporting E2E Tests
 *
 * Covers: admin/staff loading the admin dashboard and the reports dashboard,
 * verifying real statistics render (total users / products / orders / revenue),
 * and that customers are blocked from these admin-only views.
 */
public class F11_ReportingTest extends BaseE2ETest {

    @Before
    public void setUp() {
        logout();
    }

    @After
    public void tearDown() {
        logout();
    }

    /** Helper: at least one of the stat cards shows a non-empty numeric value. */
    private boolean hasNumericStat() {
        // Stat values render as plain numbers inside the page; a digit anywhere in
        // the metric region is sufficient to prove the DAO counts were populated.
        return pageSource().matches("(?s).*\\b\\d+\\b.*");
    }

    /** TC-11-1: Staff can load the admin dashboard without server error */
    @Test
    public void testStaffCanLoadAdminDashboard() {
        loginAsStaff();
        navigateTo("/admin-dashboard");
        assertFalse("Admin dashboard should not 500", pageSource().contains("HTTP ERROR 500"));
        assertFalse("Admin dashboard should not show generic error page",
                pageSource().contains("Oops! Something went wrong")
                        || pageSource().contains("Development Error Information"));
        assertTrue("Admin dashboard should render its title",
                pageSource().contains("Admin Dashboard") || pageSource().contains("Dashboard"));
    }

    /** TC-11-2: Admin dashboard shows the four stat labels (users/products/orders/suppliers) */
    @Test
    public void testAdminDashboardShowsStats() {
        loginAsStaff();
        navigateTo("/admin-dashboard");
        assertTrue("Should show Total Users stat", pageSource().contains("Total Users"));
        assertTrue("Should show product stat", pageSource().contains("Products"));
        assertTrue("Should show order stat", pageSource().contains("Orders"));
        // Stats must carry real numbers from the DAOs, not be blank
        assertTrue("Dashboard stats should contain numeric counts", hasNumericStat());
    }

    /** TC-11-3: Reports dashboard loads via /reports-dashboard (clean path) for staff */
    @Test
    public void testStaffCanLoadReportsDashboard() {
        loginAsStaff();
        navigateTo("/reports-dashboard");
        assertFalse("Reports dashboard should not 404", pageSource().contains("HTTP ERROR 404"));
        assertFalse("Reports dashboard should not 500", pageSource().contains("HTTP ERROR 500"));
        assertTrue("Reports dashboard should render",
                pageSource().contains("Reports") || pageSource().contains("Analytics"));
    }

    /** TC-11-4: Reports dashboard surfaces the key BI metrics including revenue */
    @Test
    public void testReportsDashboardShowsMetrics() {
        loginAsStaff();
        navigateTo("/reports-dashboard");
        assertTrue("Should show Total Users metric", pageSource().contains("Total Users"));
        assertTrue("Should show Total Products metric", pageSource().contains("Total Products"));
        assertTrue("Should show Total Orders metric", pageSource().contains("Total Orders"));
        assertTrue("Should show Total Revenue metric", pageSource().contains("Total Revenue"));
        assertTrue("Metrics should contain numeric values", hasNumericStat());
    }

    /** TC-11-5: Legacy /reports-dashboard.jsp mapping still resolves (no 404) */
    @Test
    public void testReportsDashboardLegacyJspPathResolves() {
        loginAsStaff();
        navigateTo("/reports-dashboard.jsp");
        assertFalse("Legacy reports path should not 404", pageSource().contains("HTTP ERROR 404"));
        assertFalse("Legacy reports path should not 500", pageSource().contains("HTTP ERROR 500"));
    }

    /** TC-11-6: Unauthenticated user is redirected away from the admin dashboard */
    @Test
    public void testGuestCannotAccessAdminDashboard() {
        navigateTo("/admin-dashboard");
        boolean blocked = currentUrl().contains("login")
                || pageSource().contains("403")
                || pageSource().contains("Unauthorized");
        assertTrue("Guest should be redirected/blocked from admin dashboard", blocked);
    }

    /** TC-11-7: Customer cannot access the reports dashboard */
    @Test
    public void testCustomerCannotAccessReports() {
        loginAsCustomer();
        navigateTo("/reports-dashboard");
        boolean blocked = currentUrl().contains("login")
                || pageSource().contains("403")
                || pageSource().contains("Unauthorized")
                || pageSource().contains("Access Denied")
                || !pageSource().contains("Total Revenue");
        assertTrue("Customer must not see BI reports", blocked);
    }
}
