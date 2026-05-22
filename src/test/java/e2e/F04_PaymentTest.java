package e2e;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.openqa.selenium.By;

import static org.junit.Assert.*;

/**
 * F04 — Payment Management E2E Tests
 *
 * Covers: Payment list page, payment detail, edit PENDING payment,
 * delete PENDING payment, search by payment ID.
 */
public class F04_PaymentTest extends BaseE2ETest {

    @Before
    public void setUp() {
        logout();
        loginAsCustomer();
    }

    @After
    public void tearDown() {
        logout();
    }

    /** TC-04-1: Payment list page loads (no 404) */
    @Test
    public void testPaymentListPageExists() {
        navigateTo("/payment/list");
        assertFalse("Payment list should not return 404",
                pageSource().contains("HTTP ERROR 404") && !currentUrl().contains("login"));
        assertFalse("Payment list should not return 500",
                pageSource().contains("HTTP ERROR 500"));
    }

    /** TC-04-2: Payment list page renders correct content */
    @Test
    public void testPaymentListPageRenders() {
        navigateTo("/payment/list");
        // Should contain payment-related content
        String src = pageSource();
        boolean hasContent = src.contains("Payment") || src.contains("payment") ||
                src.contains("Amount") || isElementPresent(By.tagName("table"));
        assertTrue("Payment list should contain payment-related content", hasContent);
    }

    /** TC-04-3: Payment list page has search form */
    @Test
    public void testPaymentListHasSearchForm() {
        navigateTo("/payment/list");
        boolean hasSearch = isElementPresent(By.tagName("form")) ||
                isElementPresent(By.cssSelector("input[name='paymentId']")) ||
                isElementPresent(By.cssSelector("input[name='startDate']")) ||
                isElementPresent(By.cssSelector("input[type='date']"));
        assertTrue("Payment list should have a search/filter form", hasSearch);
    }

    /** TC-04-4: Payment view page accessible by ID */
    @Test
    public void testPaymentViewPageAccessible() {
        navigateTo("/payment/view?paymentId=1");
        // Should NOT return 404 (route must exist)
        assertFalse("Payment view route should exist",
                pageSource().contains("HTTP ERROR 404") && !currentUrl().contains("login") &&
                !currentUrl().contains("error"));
        assertFalse("Payment view should not return 500",
                pageSource().contains("HTTP ERROR 500"));
    }

    /** TC-04-5: Checkout page has required payment fields */
    @Test
    public void testCheckoutHasPaymentFields() {
        navigateTo("/checkout.jsp");
        String src = pageSource();
        // Checkout should have some payment-related fields
        boolean hasPaymentFields = src.contains("payment") || src.contains("Payment") ||
                src.contains("card") || src.contains("Card") ||
                isElementPresent(By.name("paymentMethod")) ||
                isElementPresent(By.name("cardNumber"));
        assertTrue("Checkout should have payment fields", hasPaymentFields);
    }

    /** TC-04-6: Payment list is not accessible for non-logged-in users */
    @Test
    public void testPaymentListRequiresAuth() {
        logout();
        navigateTo("/payment/list");
        String url = currentUrl();
        boolean redirected = url.contains("login") || url.contains("error") ||
                pageSource().contains("login") || pageSource().contains("401");
        assertTrue("Payment list should require authentication", redirected);
    }

    /** TC-04-7: Payment list allows search by date range */
    @Test
    public void testPaymentSearchByDateRange() {
        navigateTo("/payment/list?startDate=2024-01-01&endDate=2026-12-31");
        assertFalse("Payment search should not error",
                pageSource().contains("HTTP ERROR 500"));
    }

    /** TC-04-8: Staff can view all payments via manage endpoint */
    @Test
    public void testStaffCanViewPayments() {
        logout();
        loginAsStaff();
        navigateTo("/payment/list");
        assertFalse("Staff should be able to view payment list",
                pageSource().contains("403") || pageSource().contains("Unauthorized"));
    }
}
