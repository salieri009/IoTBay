package e2e;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.openqa.selenium.By;

import static org.junit.Assert.*;

/**
 * F01 — User Access Log E2E Tests
 *
 * Verifies that login/logout events create access log entries
 * and that the access log page renders with search functionality.
 */
public class F01_AccessLogTest extends BaseE2ETest {

    @Before
    public void setUp() {
        logout(); // ensure clean state
    }

    @After
    public void tearDown() {
        logout();
    }

    /** TC-01-1: Logging in should navigate to the home page successfully */
    @Test
    public void testLoginSuccess() {
        loginAsCustomer();
        // After login the URL should not be the login page
        assertFalse("Should have left login page after successful login",
                currentUrl().contains("login.jsp"));
    }

    /** TC-01-2: Access log page requires authentication */
    @Test
    public void testAccessLogRequiresAuth() {
        navigateTo("/api/accessLog");
        // Should redirect to login or show 401
        String url = currentUrl();
        boolean redirected = url.contains("login") || url.contains("error");
        assertTrue("Unauthenticated access to /api/accessLog should redirect", redirected);
    }

    /** TC-01-3: Authenticated user can view access log page */
    @Test
    public void testAccessLogPageLoadsForCustomer() {
        loginAsCustomer();
        navigateTo("/api/accessLog");
        // Must not be a server error (Jetty 500/404 OR custom 200 error page)
        assertNoServerErrorPage();
        // Page should show access log table or heading
        assertTrue("Access log page should contain 'Access' text or table",
                pageSource().contains("Access") || isElementPresent(By.tagName("table")));
    }

    /** TC-01-4: Access log page renders for staff */
    @Test
    public void testAccessLogPageLoadsForStaff() {
        loginAsStaff();
        navigateTo("/api/accessLog");
        assertNoServerErrorPage();
        assertTrue("Access log page should load",
                pageSource().contains("Access") || isElementPresent(By.tagName("table")));
    }

    /** TC-01-7: A login event creates an access-log entry visible to the user */
    @Test
    public void testLoginCreatesAccessLogEntry() {
        loginAsCustomer();              // generates a "logged in" access log row
        navigateTo("/api/accessLog");
        assertNoServerErrorPage();
        boolean hasEntry = isElementPresent(By.cssSelector("table tbody tr")) ||
                pageSource().toLowerCase().contains("logged in") ||
                pageSource().toLowerCase().contains("login");
        assertTrue("Access log should contain at least one entry after login", hasEntry);
    }

    /** TC-01-8: Date-range search on access logs does not error */
    @Test
    public void testAccessLogDateSearch() {
        loginAsCustomer();
        // Future end date should be rejected gracefully (validation), not a 500.
        navigateTo("/api/accessLog?startDate=2020-01-01&endDate=2099-01-01");
        assertNoServerErrorPage();
        // Valid open-ended range exercises getAccessLogsByUserIdAndDateRange.
        navigateTo("/api/accessLog?startDate=2020-01-01");
        assertNoServerErrorPage();
        assertTrue("Date-filtered access log page should still render",
                pageSource().contains("Access") || isElementPresent(By.tagName("form")));
    }

    /** TC-01-5: Access log page has a date search form */
    @Test
    public void testAccessLogHasSearchForm() {
        loginAsCustomer();
        navigateTo("/api/accessLog");
        // Should have a form with date inputs
        boolean hasForm = isElementPresent(By.tagName("form")) ||
                isElementPresent(By.cssSelector("input[type='date']")) ||
                isElementPresent(By.cssSelector("input[name='startDate']"));
        assertTrue("Access log page should have a search/filter form", hasForm);
    }

    /** TC-01-6: Profile page has a link to access logs */
    @Test
    public void testProfileHasAccessLogLink() {
        loginAsCustomer();
        navigateTo("/profile.jsp");
        assertTrue("Profile page should contain a link or reference to Access Log",
                pageSource().contains("Access") || pageSource().contains("accessLog") ||
                pageSource().contains("access-log"));
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
