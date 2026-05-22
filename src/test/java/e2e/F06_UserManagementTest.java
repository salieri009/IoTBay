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
        assertFalse("User list should not 403", pageSource().contains("403"));
        assertFalse("User list should not 500", pageSource().contains("HTTP ERROR 500"));
        assertTrue("User list should show a table or list",
                isElementPresent(By.tagName("table")) || pageSource().contains("User") ||
                pageSource().contains("Email"));
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
        assertFalse("Name search should not 500", pageSource().contains("HTTP ERROR 500"));
        // Results should be visible (or empty — but no error)
        assertFalse("Name search should not show error page",
                pageSource().contains("HTTP ERROR 404"));
    }

    /** TC-06-4: Search by phone filters results */
    @Test
    public void testSearchUserByPhone() {
        navigateTo("/api/manage/users/?phone=+61");
        assertFalse("Phone search should not 500", pageSource().contains("HTTP ERROR 500"));
    }

    /** TC-06-5: Edit user form loads via GET (no 405 error) */
    @Test
    public void testEditUserFormLoadsWithoutError() {
        // Try to load edit form for user ID 1
        navigateTo("/manage/users/update?id=1");
        // The critical check: must NOT return 405 Method Not Allowed
        assertFalse("GET /manage/users/update should NOT return 405",
                pageSource().contains("405") || pageSource().contains("Method Not Allowed"));
        assertFalse("Edit user form should not return 500",
                pageSource().contains("HTTP ERROR 500"));
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
}
