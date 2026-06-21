package e2e;

import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runners.MethodSorters;

/**
 * FE01 — Customer-facing pages: dark-theme correctness + WCAG AA contrast.
 *
 * Sweeps anonymous pages, then logs in as a customer and sweeps the authenticated
 * shopping/account pages. Each page: theme applied (no light leaks) + text contrast.
 */
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class FE01_CustomerThemeContrastTest extends FrontendTestBase {

    // ── Anonymous pages ──────────────────────────────────────────────────────

    @Test public void t01_home()        { auditPage("home", "/"); }
    @Test public void t02_browse()      { auditPage("browse", "/browse"); }
    @Test public void t03_product()     { auditPage("product", "/product?id=1"); }
    @Test public void t04_categories()  { auditPage("categories", "/categories"); }
    @Test public void t05_login()       { auditPage("login", "/login.jsp"); }
    @Test public void t06_register()    { auditPage("register", "/register.jsp"); }

    // ── Authenticated customer pages ─────────────────────────────────────────

    @Test public void t10_cart() {
        logout();
        loginAsCustomer();
        auditPage("cart", "/cart");
    }

    @Test public void t11_checkout() {
        loginAsCustomer();
        auditPage("checkout", "/checkout.jsp");
    }

    @Test public void t12_orderHistory() {
        loginAsCustomer();
        auditPage("order-history", "/orderhistory");
    }

    @Test public void t13_profile() {
        loginAsCustomer();
        auditPage("profile", "/api/profile");
    }

    @Test public void t14_paymentList() {
        loginAsCustomer();
        auditPage("payment-list", "/payment/list");
    }

    @Test public void t15_shipmentList() {
        loginAsCustomer();
        auditPage("shipment-list", "/shipment/list");
    }
}
