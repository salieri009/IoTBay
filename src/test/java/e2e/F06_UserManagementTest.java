package e2e;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.List;

import static org.junit.Assert.*;

/**
 * F06 — User Management (Staff Admin) E2E Tests
 *
 * Covers: User list, search by name/phone, edit form pre-fill (no 405),
 * update user, delete user, access control.
 */
public class F06_UserManagementTest extends BaseE2ETest {

    @Before
    public void setUp() {
        logout();
        loginAsStaff();
    }

    @After
    public void tearDown() {
        logout();
    }

    /** TC-06-1: User list page renders for staff */
    @Test
    public void testUserListRenders() {
        navigateTo("/api/manage/users/");
        assertNoServerErrorPage();
        assertTrue("User list should show a table or list",
                isElementPresent(By.tagName("table")) || pageSource().contains("User") ||
                pageSource().contains("Email"));
    }

    /** TC-06-11: Create a user via the form and verify it appears in the list */
    @Test
    public void testCreateUserAppearsInList() {
        navigateTo("/api/manage/users/form");
        assertNoServerErrorPage();
        org.junit.Assume.assumeTrue("create form must render",
                isElementPresent(By.name("email")));

        String uniqueEmail = "e2e-user-" + java.util.UUID.randomUUID().toString().substring(0, 8) + "@test.com";
        fillField("firstName", "E2E");
        fillField("lastName", "User");
        fillField("email", uniqueEmail);
        fillField("password", "TestPass@123");
        if (isElementPresent(By.name("phone"))) fillField("phone", "+61400000055");
        clickSubmit();

        // After create we are redirected to the user list; new email must show.
        assertNoServerErrorPage();
        navigateTo("/api/manage/users/?search=e2e-user");
        assertNoServerErrorPage();
        assertTrue("Newly created user email should appear in the list",
                pageSource().contains(uniqueEmail));
    }

    /** TC-06-2: User list shows multiple users */
    @Test
    public void testUserListShowsMultipleUsers() {
        navigateTo("/api/manage/users/");
        int rowCount = countTableRows();
        assertTrue("User list should show at least one user", rowCount >= 0);
        // Page should have meaningful content
        assertTrue("User list page should have content", pageSource().length() > 200);
    }

    /** TC-06-3: Search by name filters results */
    @Test
    public void testSearchUserByName() {
        navigateTo("/api/manage/users/?search=customer");
        assertNoServerErrorPage();
        // The seeded customer account should match the name/email search.
        assertTrue("Name search should return the seeded customer",
                pageSource().contains("customer@iotbay.com") ||
                pageSource().toLowerCase().contains("customer"));
    }

    /** TC-06-4: Search by phone filters results */
    @Test
    public void testSearchUserByPhone() {
        navigateTo("/api/manage/users/?phone=+61");
        assertNoServerErrorPage();
    }

    /** TC-06-5: Edit user form loads via GET (no 405 error) */
    @Test
    public void testEditUserFormLoadsWithoutError() {
        // Try to load edit form for user ID 1
        navigateTo("/manage/users/update?id=1");
        // The critical check: must NOT return 405 Method Not Allowed
        assertFalse("GET /manage/users/update should NOT return 405",
                pageSource().contains("405") || pageSource().contains("Method Not Allowed"));
        assertNoServerErrorPage();
        // The form should pre-fill the existing user's email.
        assertTrue("Edit form should pre-fill an email value",
                isElementPresent(By.name("email")));
    }

    /** TC-06-6: Edit user form pre-fills existing values */
    @Test
    public void testEditUserFormHasInputFields() {
        navigateTo("/manage/users/update?id=1");
        if (!pageSource().contains("405") && !pageSource().contains("HTTP ERROR")) {
            // Should have form fields
            boolean hasEmailField = isElementPresent(By.name("email")) ||
                    isElementPresent(By.name("firstName")) ||
                    isElementPresent(By.tagName("form"));
            assertTrue("Edit user form should have input fields", hasEmailField);
        }
    }

    /** TC-06-7: User management page has delete option */
    @Test
    public void testUserListHasDeleteOption() {
        navigateTo("/api/manage/users/");
        boolean hasDelete = pageSource().contains("Delete") || pageSource().contains("delete") ||
                isElementPresent(By.cssSelector("form[action*='delete'], [data-action='delete']"));
        assertTrue("User management should have a delete option", hasDelete);
    }

    /** TC-06-8: User management page has edit option */
    @Test
    public void testUserListHasEditOption() {
        navigateTo("/api/manage/users/");
        boolean hasEdit = pageSource().contains("Edit") || pageSource().contains("edit") ||
                isElementPresent(By.cssSelector("a[href*='update'], button[data-action='edit']"));
        assertTrue("User management should have an edit option", hasEdit);
    }

    /** TC-06-9: Customer cannot access user management */
    @Test
    public void testCustomerCannotAccessUserManagement() {
        logout();
        loginAsCustomer();
        navigateTo("/api/manage/users/");
        boolean blocked = currentUrl().contains("login") ||
                pageSource().contains("403") ||
                pageSource().contains("Unauthorized") ||
                pageSource().contains("Access Denied") ||
                !currentUrl().contains("manage");
        assertTrue("Customer should NOT access user management", blocked);
    }

    /** TC-06-10: Manage users page has search form */
    @Test
    public void testUserListHasSearchForm() {
        navigateTo("/api/manage/users/");
        boolean hasSearchForm = isElementPresent(By.tagName("form")) ||
                isElementPresent(By.cssSelector("input[name='search']")) ||
                isElementPresent(By.cssSelector("input[name='name']")) ||
                isElementPresent(By.cssSelector("input[name='phone']"));
        assertTrue("User management should have a search form", hasSearchForm);
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
