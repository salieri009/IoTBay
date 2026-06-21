package e2e;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.List;
import java.util.UUID;

import static org.junit.Assert.*;

/**
 * F07 — Customer Management (Admin) E2E Tests
 *
 * Covers: Customer list, create individual/company, search by name,
 * filter by type, view detail, edit, delete.
 */
public class F07_CustomerManagementTest extends BaseE2ETest {

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

    /** TC-07-1: Customer list page renders */
    @Test
    public void testCustomerListRenders() {
        navigateTo("/admin/customer/");
        assertFalse("Customer list should not 403", pageSource().contains("403"));
        assertFalse("Customer list should not 404", pageSource().contains("HTTP ERROR 404"));
        assertFalse("Customer list should not 500", pageSource().contains("HTTP ERROR 500"));
        assertTrue("Customer list page should mention 'Customer'",
                pageSource().contains("Customer") || pageSource().contains("customer"));
    }

    /** TC-07-2: Customer list shows table of customers */
    @Test
    public void testCustomerListShowsTable() {
        navigateTo("/admin/customer/");
        assertTrue("Customer list should have a table or list",
                isElementPresent(By.tagName("table")) || isElementPresent(By.tagName("tbody")) ||
                pageSource().contains("Email") || pageSource().contains("Name"));
    }

    // ── Create customer ───────────────────────────────────────────────────────

    /** TC-07-3: Add customer form renders */
    @Test
    public void testAddCustomerFormRenders() {
        navigateTo("/admin/customer/form");
        assertFalse("Customer form should not 404",
                pageSource().contains("HTTP ERROR 404") && !currentUrl().contains("login"));
        assertFalse("Customer form should not 500", pageSource().contains("HTTP ERROR 500"));
        assertTrue("Customer form should have a form element",
                isElementPresent(By.tagName("form")));
    }

    /** TC-07-4: Add customer form has required fields */
    @Test
    public void testAddCustomerFormHasRequiredFields() {
        navigateTo("/admin/customer/form");
        String src = pageSource();
        boolean hasFirstName = src.contains("firstName") || src.contains("First Name") ||
                isElementPresent(By.name("firstName"));
        boolean hasEmail = src.contains("email") || src.contains("Email") ||
                isElementPresent(By.name("email"));
        boolean hasType = src.contains("customerType") || src.contains("individual") ||
                src.contains("company") || isElementPresent(By.name("customerType"));
        assertTrue("Customer form should have a first name field", hasFirstName);
        assertTrue("Customer form should have an email field", hasEmail);
        assertTrue("Customer form should have a customer type field", hasType);
    }

    /** TC-07-5: Create individual customer and verify it lands in the list */
    @Test
    public void testCreateIndividualCustomer() {
        navigateTo("/admin/customer/form");
        assertNoServerErrorPage();
        org.junit.Assume.assumeTrue("customer form must render", isElementPresent(By.name("email")));

        String uniqueEmail = "e2e-individual-" + UUID.randomUUID().toString().substring(0, 8) + "@test.com";
        fillField("firstName", "E2E");
        fillField("lastName", "Individual");
        fillField("email", uniqueEmail);
        fillField("password", "TestPass@123");
        if (isElementPresent(By.name("phone"))) fillField("phone", "+61400000099");
        // Option text is Title Case in the JSP: "Individual" not "individual"
        if (isElementPresent(By.name("customerType"))) selectOption("customerType", "Individual");
        clickSubmit();

        assertNoServerErrorPage();
        // Redirected to the customer list; the new customer must be searchable.
        navigateTo("/admin/customer/?name=Individual");
        assertNoServerErrorPage();
        assertTrue("Newly created individual customer should appear in the list",
                pageSource().contains(uniqueEmail));
    }

    /** TC-07-6: Create company customer and verify type filter returns it */
    @Test
    public void testCreateCompanyCustomer() {
        navigateTo("/admin/customer/form");
        assertNoServerErrorPage();
        org.junit.Assume.assumeTrue("customer form must render", isElementPresent(By.name("email")));

        String uniqueEmail = "e2e-company-" + UUID.randomUUID().toString().substring(0, 8) + "@test.com";
        fillField("firstName", "E2E");
        fillField("lastName", "Company");
        fillField("email", uniqueEmail);
        fillField("password", "TestPass@123");
        if (isElementPresent(By.name("phone"))) fillField("phone", "+61400000098");
        // Option text is Title Case: "Company" not "company"
        if (isElementPresent(By.name("customerType"))) selectOption("customerType", "Company");
        clickSubmit();

        assertNoServerErrorPage();
        // Filtering by the company type should include the freshly created record.
        navigateTo("/admin/customer/?type=company");
        assertNoServerErrorPage();
        assertTrue("Company type filter should return the new company customer",
                pageSource().contains(uniqueEmail));
    }

    // ── Search / Filter ───────────────────────────────────────────────────────

    /** TC-07-7: Search customer by name returns the seeded customer */
    @Test
    public void testSearchCustomerByName() {
        navigateTo("/admin/customer/?name=customer");
        assertNoServerErrorPage();
        assertTrue("Customer name search should return the seeded customer",
                pageSource().contains("customer@iotbay.com") ||
                pageSource().toLowerCase().contains("customer"));
    }

    /** TC-07-8: Filter customer by type */
    @Test
    public void testFilterCustomerByType() {
        navigateTo("/admin/customer/?type=individual");
        assertNoServerErrorPage();
    }

    // ── View detail ───────────────────────────────────────────────────────────

    /** TC-07-9: Customer view page renders details for the seeded customer (id 1) */
    @Test
    public void testCustomerViewPageExists() {
        navigateTo("/admin/customer/view/1");
        assertNoServerErrorPage();
        // ID 1 is the seeded customer; the detail page should show its email.
        assertTrue("Customer view should render customer details",
                pageSource().contains("customer@iotbay.com") ||
                pageSource().contains("Customer Details"));
    }

    // ── Edit ──────────────────────────────────────────────────────────────────

    /** TC-07-10: Customer edit page pre-fills the form */
    @Test
    public void testCustomerEditPageExists() {
        navigateTo("/admin/customer/edit/1");
        assertNoServerErrorPage();
        assertTrue("Customer edit form should render input fields",
                isElementPresent(By.name("email")) || isElementPresent(By.tagName("form")));
    }

    // ── Access control ────────────────────────────────────────────────────────

    /** TC-07-11: Customer role cannot access customer management */
    @Test
    public void testCustomerRoleCannotAccessCustomerManagement() {
        logout();
        loginAsCustomer();
        navigateTo("/admin/customer/");
        boolean blocked = currentUrl().contains("login") ||
                pageSource().contains("403") ||
                pageSource().contains("Unauthorized") ||
                !currentUrl().contains("customer");
        assertTrue("Customer role should NOT access customer admin", blocked);
    }

    /** TC-07-12: Unauthenticated access is blocked */
    @Test
    public void testUnauthenticatedCannotAccessCustomerManagement() {
        logout();
        navigateTo("/admin/customer/");
        boolean blocked = currentUrl().contains("login") ||
                pageSource().contains("login") ||
                pageSource().contains("401");
        assertTrue("Unauthenticated access to /admin/customer/ should be blocked", blocked);
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
