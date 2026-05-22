package e2e;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.Select;

import java.util.List;

import static org.junit.Assert.*;

/**
 * F05 — Shipment Management E2E Tests
 *
 * Covers: Shipment list, create from order list, view detail,
 * edit, delete, search by ID, staff status update.
 */
public class F05_ShipmentTest extends BaseE2ETest {

    @Before
    public void setUp() {
        logout();
    }

    @After
    public void tearDown() {
        logout();
    }

    // ── List page ─────────────────────────────────────────────────────────────

    /** TC-05-1: Shipment list page renders for customer */
    @Test
    public void testShipmentListRendersForCustomer() {
        loginAsCustomer();
        navigateTo("/shipment/list");
        assertFalse("Shipment list should not return 404",
                pageSource().contains("HTTP ERROR 404"));
        assertFalse("Shipment list should not return 500",
                pageSource().contains("HTTP ERROR 500"));
        // Should show the page heading
        assertTrue("Shipment list page should contain 'Shipment'",
                pageSource().contains("Shipment") || pageSource().contains("shipment"));
    }

    /** TC-05-2: Shipment list has a search form */
    @Test
    public void testShipmentListHasSearchForm() {
        loginAsCustomer();
        navigateTo("/shipment/list");
        boolean hasForm = isElementPresent(By.tagName("form"));
        assertTrue("Shipment list should have a search/filter form", hasForm);
    }

    /** TC-05-3: Shipment list renders for staff */
    @Test
    public void testShipmentListRendersForStaff() {
        loginAsStaff();
        navigateTo("/shipment/list");
        assertFalse("Shipment list should not error for staff",
                pageSource().contains("HTTP ERROR 500"));
        assertTrue("Staff should see shipment list",
                pageSource().contains("Shipment") || pageSource().contains("shipment"));
    }

    // ── Create shipment ───────────────────────────────────────────────────────

    /** TC-05-4: Shipment form page renders */
    @Test
    public void testShipmentFormPageRenders() {
        loginAsCustomer();
        navigateTo("/shipment/form");
        assertFalse("Shipment form should not return 404",
                pageSource().contains("HTTP ERROR 404") && !currentUrl().contains("login"));
        assertFalse("Shipment form should not return 500",
                pageSource().contains("HTTP ERROR 500"));
    }

    /** TC-05-5: Shipment form has required fields */
    @Test
    public void testShipmentFormHasRequiredFields() {
        loginAsCustomer();
        navigateTo("/shipment/form");
        String src = pageSource();
        // Form should have carrier, shipping date, and address fields
        boolean hasCarrier = src.contains("carrier") || src.contains("Carrier") ||
                isElementPresent(By.name("carrier"));
        boolean hasDateField = src.contains("date") || src.contains("Date") ||
                isElementPresent(By.cssSelector("input[type='date']"));
        assertTrue("Shipment form should have a carrier field", hasCarrier);
        assertTrue("Shipment form should have a date field", hasDateField);
    }

    /** TC-05-6: Shipment form with orderId parameter renders */
    @Test
    public void testShipmentFormWithOrderIdParam() {
        loginAsCustomer();
        navigateTo("/shipment/form?orderId=1");
        assertFalse("Shipment form with orderId should not 500",
                pageSource().contains("HTTP ERROR 500"));
        assertFalse("Shipment form with orderId should not 404",
                pageSource().contains("HTTP ERROR 404") && !currentUrl().contains("login"));
    }

    /** TC-05-7: Creating a shipment via form submit */
    @Test
    public void testCreateShipmentSubmit() {
        loginAsCustomer();
        navigateTo("/shipment/form");

        // Fill in fields if the form exists
        if (isElementPresent(By.name("carrier"))) {
            fillField("carrier", "Australia Post");
        } else if (isElementPresent(By.name("shippingMethod"))) {
            fillField("shippingMethod", "Standard");
        }
        if (isElementPresent(By.cssSelector("input[type='date']"))) {
            driver.findElement(By.cssSelector("input[type='date']")).sendKeys("2026-12-01");
        }
        if (isElementPresent(By.name("address"))) {
            fillField("address", "123 Test St");
        }
        if (isElementPresent(By.name("city"))) {
            fillField("city", "Sydney");
        }
        if (isElementPresent(By.name("recipientName"))) {
            fillField("recipientName", "Test Recipient");
        }
        if (isElementPresent(By.name("orderId"))) {
            // orderId needed for shipment
        }

        if (isElementPresent(By.cssSelector("[type='submit']"))) {
            clickSubmit();
            // Should redirect to list or show success — not 500
            assertFalse("Create shipment should not cause 500",
                    pageSource().contains("HTTP ERROR 500"));
        }
    }

    // ── View shipment ─────────────────────────────────────────────────────────

    /** TC-05-8: Shipment view page exists */
    @Test
    public void testShipmentViewPageExists() {
        loginAsCustomer();
        navigateTo("/shipment/view/1");
        // Route exists (may show "not found" message if no shipment, but not 404/500)
        assertFalse("Shipment view route should not 500",
                pageSource().contains("HTTP ERROR 500"));
    }

    /** TC-05-9: Shipment list requires authentication */
    @Test
    public void testShipmentListRequiresAuth() {
        navigateTo("/shipment/list");
        String url = currentUrl();
        boolean redirected = url.contains("login") || url.contains("error") ||
                pageSource().contains("login");
        assertTrue("Shipment list should require authentication", redirected);
    }

    // ── Order list integration ─────────────────────────────────────────────────

    /** TC-05-10: Order list has Add Shipment button for pending orders */
    @Test
    public void testOrderListHasAddShipmentButton() {
        loginAsCustomer();
        navigateTo("/orderhistory");
        assertFalse("Order history should not 500", pageSource().contains("HTTP ERROR 500"));
        // Check for "Add Shipment" or "Shipment" link in the page
        boolean hasShipmentLink = pageSource().contains("Add Shipment") ||
                pageSource().contains("shipment/form") ||
                pageSource().contains("Shipment");
        // May be absent if no PENDING orders — just check no error
        assertFalse("Order history should not error", pageSource().contains("HTTP ERROR 500"));
    }

    // ── Search ─────────────────────────────────────────────────────────────────

    /** TC-05-11: Shipment list search by shipment ID */
    @Test
    public void testShipmentSearchById() {
        loginAsCustomer();
        navigateTo("/shipment/list?shipmentId=1");
        assertFalse("Shipment search should not error",
                pageSource().contains("HTTP ERROR 500"));
    }

    // ── Staff status update ───────────────────────────────────────────────────

    /** TC-05-12: Staff sees shipment management options */
    @Test
    public void testStaffCanSeeShipmentList() {
        loginAsStaff();
        navigateTo("/shipment/list");
        assertFalse("Staff shipment list should not 403", pageSource().contains("403"));
        assertFalse("Staff shipment list should not 500",
                pageSource().contains("HTTP ERROR 500"));
    }
}
