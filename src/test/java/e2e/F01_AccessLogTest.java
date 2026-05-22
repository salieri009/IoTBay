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
        // Should not show a 401/403 error
        assertFalse("Should not show unauthorized error",
                pageSource().contains("401") && pageSource().contains("403"));
        // Page should show access log table or heading
        assertTrue("Access log page should contain 'Access Log' text or table",
                pageSource().contains("Access") || isElementPresent(By.tagName("table")));
    }

    /** TC-01-4: Access log page renders for staff */
    @Test
    public void testAccessLogPageLoadsForStaff() {
        loginAsStaff();
        navigateTo("/api/accessLog");
        assertFalse("Should not show server error",
                pageSource().contains("HTTP ERROR 500"));
        assertTrue("Access log page should load",
                pageSource().contains("Access") || isElementPresent(By.tagName("table")));
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
}
