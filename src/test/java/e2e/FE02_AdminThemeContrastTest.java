package e2e;

import org.junit.Before;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runners.MethodSorters;

/**
 * FE02 — Admin pages (t:admin-base layout): dark-theme correctness + WCAG AA contrast.
 *
 * Admin pages use a different layout (style.css/admin.css variable-driven dark,
 * no Tailwind CDN), so they exercise a different theming path than FE01.
 */
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class FE02_AdminThemeContrastTest extends FrontendTestBase {

    private static final String ADMIN_EMAIL = "admin@iotbay.com";
    private static final String ADMIN_PASS  = "admin123";

    @Before
    public void loginAdmin() {
        logout();
        loginAs(ADMIN_EMAIL, ADMIN_PASS);
    }

    @Test public void t01_adminDashboard()  { auditPage("admin-dashboard", "/admin-dashboard"); }
    @Test public void t02_manageUsers()     { auditPage("manage-users", "/api/manage/users/"); }
    @Test public void t03_manageProducts()  { auditPage("manage-products", "/api/manage/products/"); }
    @Test public void t04_customerList()    { auditPage("customer-list", "/admin/customer/"); }
    @Test public void t05_staffList()       { auditPage("staff-list", "/admin/staff/"); }
    @Test public void t06_supplierList()    { auditPage("supplier-list", "/admin/supplier/"); }
    @Test public void t07_reports()         { auditPage("reports-dashboard", "/reports-dashboard.jsp"); }
    @Test public void t08_dataManagement()  { auditPage("data-management", "/data-management"); }
}
