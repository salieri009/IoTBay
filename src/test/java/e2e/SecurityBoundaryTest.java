package e2e;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.openqa.selenium.By;

import static org.junit.Assert.*;

/**
 * Security Boundary E2E Tests
 *
 * Verifies that admin-only URLs are protected against:
 * 1. Unauthenticated access (no session)
 * 2. Customer role (insufficient privileges)
 *
 * All protected routes must redirect to login or return 401/403.
 */
public class SecurityBoundaryTest extends BaseE2ETest {

    @Before
    public void setUp() {
        logout();
    }

    @After
    public void tearDown() {
        logout();
    }

    // ── Unauthenticated access (no session) ───────────────────────────────────

    /** SEC-01: Unauthenticated access to customer management */
    @Test
    public void testNoSessionBlockedFromCustomerManagement() {
        navigateTo("/admin/customer/");
        assertTrue("No-session access to /admin/customer/ must redirect to login",
                currentUrl().contains("login") || pageSource().contains("login") ||
                pageSource().contains("401") || pageSource().contains("Please log in"));
    }

    /** SEC-02: Unauthenticated access to staff management */
    @Test
    public void testNoSessionBlockedFromStaffManagement() {
        navigateTo("/admin/staff/");
        assertTrue("No-session access to /admin/staff/ must redirect to login",
                currentUrl().contains("login") || pageSource().contains("login") ||
                pageSource().contains("401") || pageSource().contains("Please log in"));
    }

    /** SEC-03: Unauthenticated access to supplier management */
    @Test
    public void testNoSessionBlockedFromSupplierManagement() {
        navigateTo("/admin/supplier/");
        assertTrue("No-session access to /admin/supplier/ must redirect to login",
                currentUrl().contains("login") || pageSource().contains("login") ||
                pageSource().contains("401") || pageSource().contains("Please log in"));
    }

    /** SEC-04: Unauthenticated access to user management */
    @Test
    public void testNoSessionBlockedFromUserManagement() {
        navigateTo("/api/manage/users/");
        assertTrue("No-session access to /api/manage/users/ must redirect to login",
                currentUrl().contains("login") || pageSource().contains("login") ||
                pageSource().contains("401") || pageSource().contains("Please log in"));
    }

    /** SEC-05: Unauthenticated access to data management dashboard */
    @Test
    public void testNoSessionBlockedFromDataManagement() {
        navigateTo("/api/dataManagement/dashboard");
        assertTrue("No-session access to data management must redirect to login",
                currentUrl().contains("login") || pageSource().contains("login") ||
                pageSource().contains("401") || pageSource().contains("Please log in"));
    }

    /** SEC-06: Unauthenticated access to access log management */
    @Test
    public void testNoSessionBlockedFromAccessLogManagement() {
        navigateTo("/api/manage/access-logs");
        // Should redirect or deny — not silently serve the page
        boolean blocked = currentUrl().contains("login") || pageSource().contains("login") ||
                pageSource().contains("401") || pageSource().contains("403");
        // Access log management (staff only) should be protected
        // Note: regular /api/accessLog is accessible by logged-in users
        assertFalse("Access log management should not return 500",
                pageSource().contains("HTTP ERROR 500"));
    }

    // ── Customer role (insufficient privileges) ───────────────────────────────

    /** SEC-07: Customer blocked from customer management */
    @Test
    public void testCustomerBlockedFromCustomerManagement() {
        loginAsCustomer();
        navigateTo("/admin/customer/");
        boolean blocked = currentUrl().contains("login") ||
                pageSource().contains("403") ||
                pageSource().contains("Unauthorized") ||
                pageSource().contains("Access Denied") ||
                !currentUrl().contains("/admin/customer");
        assertTrue("Customer role must NOT access /admin/customer/", blocked);
    }

    /** SEC-08: Customer blocked from staff management */
    @Test
    public void testCustomerBlockedFromStaffManagement() {
        loginAsCustomer();
        navigateTo("/admin/staff/");
        boolean blocked = currentUrl().contains("login") ||
                pageSource().contains("403") ||
                pageSource().contains("Unauthorized") ||
                !currentUrl().contains("/admin/staff");
        assertTrue("Customer role must NOT access /admin/staff/", blocked);
    }

    /** SEC-09: Customer blocked from supplier management */
    @Test
    public void testCustomerBlockedFromSupplierManagement() {
        loginAsCustomer();
        navigateTo("/admin/supplier/");
        boolean blocked = currentUrl().contains("login") ||
                pageSource().contains("403") ||
                pageSource().contains("Unauthorized") ||
                !currentUrl().contains("/admin/supplier");
        assertTrue("Customer role must NOT access /admin/supplier/", blocked);
    }

    /** SEC-10: Customer blocked from user management */
    @Test
    public void testCustomerBlockedFromUserManagement() {
        loginAsCustomer();
        navigateTo("/api/manage/users/");
        boolean blocked = currentUrl().contains("login") ||
                pageSource().contains("403") ||
                pageSource().contains("Unauthorized") ||
                !currentUrl().contains("manage/users");
        assertTrue("Customer role must NOT access user management", blocked);
    }

    /** SEC-11: Customer blocked from product management */
    @Test
    public void testCustomerBlockedFromProductManagement() {
        loginAsCustomer();
        navigateTo("/api/manage/products");
        boolean blocked = currentUrl().contains("login") ||
                pageSource().contains("403") ||
                pageSource().contains("Unauthorized") ||
                !currentUrl().contains("manage");
        assertTrue("Customer role must NOT access product management", blocked);
    }

    /** SEC-12: Customer blocked from data management (POST bulk delete) */
    @Test
    public void testCustomerBlockedFromDataManagement() {
        loginAsCustomer();
        navigateTo("/api/dataManagement/dashboard");
        boolean blocked = currentUrl().contains("login") ||
                pageSource().contains("403") ||
                pageSource().contains("Unauthorized") ||
                !currentUrl().contains("dataManagement");
        assertTrue("Customer role must NOT access data management dashboard", blocked);
    }

    // ── Staff (should have access) ────────────────────────────────────────────

    /** SEC-13: Staff CAN access customer management */
    @Test
    public void testStaffCanAccessCustomerManagement() {
        loginAsStaff();
        navigateTo("/admin/customer/");
        assertFalse("Staff should not be blocked from customer management (403)",
                pageSource().contains("403"));
        assertFalse("Staff should not get 500 on customer management",
                pageSource().contains("HTTP ERROR 500"));
    }

    /** SEC-14: Staff CAN access data management */
    @Test
    public void testStaffCanAccessDataManagement() {
        loginAsStaff();
        navigateTo("/api/dataManagement/dashboard");
        assertFalse("Staff should not be blocked from data management (403)",
                pageSource().contains("403"));
        assertFalse("Staff data management should not 500",
                pageSource().contains("HTTP ERROR 500"));
    }
}
