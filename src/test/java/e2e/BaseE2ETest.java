package e2e;

import io.github.bonigarcia.wdm.WebDriverManager;
import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.openqa.selenium.*;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.PageLoadStrategy;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.Select;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.openqa.selenium.JavascriptExecutor;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.time.Duration;
import java.util.List;

import static org.junit.Assert.*;

/**
 * Base class for all E2E tests.
 * Sets up a shared headless ChromeDriver instance and provides helper methods.
 *
 * Prerequisites: Jetty server must be running on localhost:8080 before tests run.
 *   mvn jetty:run (separate terminal)
 */
public abstract class BaseE2ETest {

    protected static WebDriver driver;
    protected static WebDriverWait wait;

    protected static final String BASE_URL       = "http://localhost:8080";
    protected static final String CUSTOMER_EMAIL = "customer@iotbay.com";
    protected static final String CUSTOMER_PASS  = "password123";
    protected static final String STAFF_EMAIL    = "staff@iotbay.com";
    protected static final String STAFF_PASS     = "staff123";

    // ── Driver lifecycle ────────────────────────────────────────────────────

    @BeforeClass
    public static void setUpDriver() {
        WebDriverManager.chromedriver().setup();
        ChromeOptions options = new ChromeOptions();
        options.addArguments(
                "--headless=new",
                "--no-sandbox",
                "--disable-dev-shm-usage",
                "--disable-gpu",
                "--window-size=1280,900",
                "--remote-allow-origins=*"
        );
        // EAGER strategy: fire pageLoad as soon as DOM is interactive,
        // without waiting for sub-resources (images, CDN scripts, etc.).
        // This prevents 300s hang when external CDN resources stall.
        options.setPageLoadStrategy(PageLoadStrategy.EAGER);
        driver = new ChromeDriver(options);
        driver.manage().timeouts().pageLoadTimeout(Duration.ofSeconds(30));
        wait = new WebDriverWait(driver, Duration.ofSeconds(8));
        driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(5));
    }

    @AfterClass
    public static void tearDownDriver() {
        if (driver != null) {
            driver.quit();
            driver = null;
        }
    }

    // ── Navigation helpers ───────────────────────────────────────────────────

    protected void navigateTo(String path) {
        driver.get(BASE_URL + path);
    }

    protected String currentUrl() {
        return driver.getCurrentUrl();
    }

    protected String pageSource() {
        return driver.getPageSource();
    }

    // ── Auth helpers ─────────────────────────────────────────────────────────

    /**
     * Log in using the standard login form at /login.jsp.
     * Uses JavaScript to set values and submit to bypass HTML5 validation quirks
     * in headless Chrome and any JS event handler that disables the button.
     */
    protected void loginAs(String email, String password) {
        navigateTo("/login.jsp");
        // Wait for the form to be present and rendered
        wait.until(ExpectedConditions.presenceOfElementLocated(By.id("loginForm")));

        // Use JavaScript to fill fields and submit — avoids HTML5 email validation
        // and button-disabled race conditions in headless Chrome
        JavascriptExecutor js = (JavascriptExecutor) driver;
        js.executeScript(
            "var frm = document.getElementById('loginForm');" +
            "frm.querySelector('[name=\"email\"]').value = arguments[0];" +
            "frm.querySelector('[name=\"password\"]').value = arguments[1];" +
            "frm.submit();",
            email, password
        );

        // Wait until redirected away from login page (successful auth → home)
        wait.until(ExpectedConditions.not(
                ExpectedConditions.urlContains("login.jsp")));
    }

    protected void loginAsCustomer() {
        loginAs(CUSTOMER_EMAIL, CUSTOMER_PASS);
    }

    protected void loginAsStaff() {
        loginAs(STAFF_EMAIL, STAFF_PASS);
    }

    /**
     * Log out by navigating to the logout endpoint.
     * The logout servlet is mapped to /logout (NOT /api/logout).
     */
    protected void logout() {
        navigateTo("/logout");
    }

    // ── Form helpers ─────────────────────────────────────────────────────────

    protected void fillField(By locator, String value) {
        WebElement el = driver.findElement(locator);
        // Set the value via JS and fire input/change. sendKeys is flaky on styled
        // inputs in headless Chrome (values intermittently don't stick), which made
        // create forms POST with empty fields.
        JavascriptExecutor js = (JavascriptExecutor) driver;
        js.executeScript("arguments[0].scrollIntoView({block:'center'});", el);
        try {
            el.clear();
            el.sendKeys(value);
        } catch (Exception ignored) {
            // non-editable for sendKeys; JS set below is authoritative
        }
        js.executeScript(
            "arguments[0].value = arguments[1];" +
            "arguments[0].dispatchEvent(new Event('input',{bubbles:true}));" +
            "arguments[0].dispatchEvent(new Event('change',{bubbles:true}));",
            el, value);
    }

    protected void fillField(String name, String value) {
        fillField(By.name(name), value);
    }

    protected void selectOption(By locator, String visibleText) {
        WebElement sel = driver.findElement(locator);
        try {
            new Select(sel).selectByVisibleText(visibleText);
        } catch (Exception ignored) {
            // fall through to JS enforcement
        }
        // JS-enforce the selection (Selenium's Select is flaky on styled selects in
        // headless Chrome). Match by option text OR value, case-insensitively.
        ((JavascriptExecutor) driver).executeScript(
            "var s=arguments[0], t=arguments[1];" +
            "for (var i=0;i<s.options.length;i++){var o=s.options[i];" +
            "  if (o.text.trim()===t || o.value===t || o.value.toLowerCase()===t.toLowerCase()" +
            "      || o.text.trim().toLowerCase()===t.toLowerCase()){" +
            "    s.selectedIndex=i; break; } }" +
            "s.dispatchEvent(new Event('change',{bubbles:true}));", sel, visibleText);
    }

    protected void selectOption(String name, String visibleText) {
        selectOption(By.name(name), visibleText);
    }

    protected void clickByText(String text) {
        wait.until(ExpectedConditions.elementToBeClickable(
                By.xpath("//*[normalize-space(text())='" + text + "']"))).click();
    }

    protected void clickByName(String name) {
        driver.findElement(By.name(name)).click();
    }

    protected void clickSubmit() {
        // Submit the page's create/action form directly. Every state-changing form
        // in this app carries a hidden csrfToken; the site header's search form (GET)
        // does not — so target the csrfToken form. force-submit (.submit()) avoids
        // both the sticky-header click interception and the first-submit-button trap.
        // Target the create/edit form precisely: it has BOTH a csrfToken hidden
        // field AND an email/primary text input. List pages' per-row delete/toggle
        // forms have a csrfToken but no email field, and the header search form has
        // neither — so this never accidentally submits a destructive form.
        Object submitted = ((JavascriptExecutor) driver).executeScript(
            "var forms=[].slice.call(document.querySelectorAll('form'))" +
            "  .filter(function(f){return f.querySelector('input[name=\"csrfToken\"]')" +
            "    && (f.querySelector('input[name=\"email\"]') || f.querySelector('input[name=\"companyName\"]')" +
            "        || f.querySelector('input[name=\"name\"]'));});" +
            "if(!forms.length){return false;}" +
            "forms.sort(function(a,b){return b.querySelectorAll('input,select,textarea').length" +
            "  - a.querySelectorAll('input,select,textarea').length;});" +
            "forms[0].submit(); return true;");
        if (Boolean.TRUE.equals(submitted)) {
            return;
        }
        java.util.List<WebElement> inMain = driver.findElements(By.cssSelector("main [type='submit']"));
        WebElement btn = !inMain.isEmpty() ? inMain.get(0)
                : driver.findElement(By.cssSelector("[type='submit']"));
        clickRobust(btn);
    }

    /**
     * Click an element robustly: scroll it into view (the fixed/sticky header can
     * overlap the bottom of long forms) and fall back to a JS click if the native
     * click is intercepted. Prevents flaky ElementClickInterceptedException.
     */
    protected void clickRobust(WebElement el) {
        JavascriptExecutor js = (JavascriptExecutor) driver;
        js.executeScript("arguments[0].scrollIntoView({block:'center'});", el);
        try {
            el.click();
        } catch (ElementClickInterceptedException | StaleElementReferenceException e) {
            js.executeScript("arguments[0].click();", el);
        }
    }

    // ── Upload helper ────────────────────────────────────────────────────────

    /**
     * Creates a temp CSV file and sends its path to a file input element.
     */
    protected void uploadCSV(String inputName, String content) throws IOException {
        File tmp = File.createTempFile("e2e_", ".csv");
        tmp.deleteOnExit();
        Files.write(tmp.toPath(), content.getBytes("UTF-8"));
        driver.findElement(By.name(inputName)).sendKeys(tmp.getAbsolutePath());
    }

    // ── Assertion helpers ────────────────────────────────────────────────────

    protected void assertPageContains(String text) {
        assertTrue("Page should contain: " + text, pageSource().contains(text));
    }

    protected void assertPageNotContains(String text) {
        assertFalse("Page should NOT contain: " + text, pageSource().contains(text));
    }

    protected void assertCurrentUrlContains(String fragment) {
        assertTrue("URL should contain '" + fragment + "' but was: " + currentUrl(),
                currentUrl().contains(fragment));
    }

    /**
     * Fail if the page is a server error. Covers BOTH Jetty's default error page
     * (HTTP ERROR 500/404) AND this app's CUSTOM error page, which returns HTTP 200
     * with friendly text — so a plain "HTTP ERROR 500" check would false-green on
     * exactly the failures we care about. Use this in place of the old check.
     */
    protected void assertNoServerError() {
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

    /**
     * Assert the page rendered the expected content AND is not an error page.
     */
    protected void assertRendered(String expectedFragment) {
        assertNoServerError();
        assertTrue("Expected page to contain '" + expectedFragment + "'. URL: " + currentUrl(),
                pageSource().contains(expectedFragment));
    }

    protected boolean isElementPresent(By locator) {
        return !driver.findElements(locator).isEmpty();
    }

    protected void assertElementPresent(By locator, String message) {
        assertTrue(message, isElementPresent(locator));
    }

    protected void assertElementAbsent(By locator, String message) {
        assertFalse(message, isElementPresent(locator));
    }

    /**
     * Returns text of a success or info alert/message div on the page.
     */
    protected boolean hasSuccessMessage() {
        List<WebElement> elements = driver.findElements(
                By.xpath("//*[contains(@class,'success') or contains(@class,'alert-success') or contains(@class,'bg-green')]"));
        return !elements.isEmpty();
    }

    protected boolean hasErrorMessage() {
        List<WebElement> elements = driver.findElements(
                By.xpath("//*[contains(@class,'error') or contains(@class,'alert-danger') or contains(@class,'bg-red')]"));
        return !elements.isEmpty();
    }

    /**
     * Waits for an element containing the given text to appear.
     */
    protected WebElement waitForText(String text) {
        return wait.until(ExpectedConditions.presenceOfElementLocated(
                By.xpath("//*[contains(text(),'" + text + "')]")));
    }

    /**
     * Waits for URL to change to contain the given fragment.
     */
    protected void waitForUrlContaining(String fragment) {
        wait.until(ExpectedConditions.urlContains(fragment));
    }

    /**
     * Returns count of table rows (excluding header row) in the first <table>.
     */
    protected int countTableRows() {
        List<WebElement> rows = driver.findElements(By.cssSelector("table tbody tr"));
        return rows.size();
    }
}
