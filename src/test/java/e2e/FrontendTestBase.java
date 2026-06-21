package e2e;

import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.OutputType;
import org.openqa.selenium.TakesScreenshot;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.ui.ExpectedCondition;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.io.File;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.time.Duration;
import java.util.List;
import java.util.Map;
import java.util.Scanner;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.fail;

/**
 * Base for FRONTEND verification tests (dark theme + WCAG contrast).
 *
 * Extends the functional {@link BaseE2ETest} (same headless Chrome on :8080) and
 * adds visual audits the functional suite never checked: that the fixed dark
 * "night" theme is actually applied (no light-background leaks) and that text
 * meets WCAG AA contrast (body >= 4.5:1, large/UI >= 3:1).
 *
 * Run in REPORT mode first to baseline real offenders without failing:
 *   mvn test -Dtest=FE01_*,FE02_* -Dfe.report=true
 * then flip to assert mode (default) once thresholds/selectors are tuned.
 */
public abstract class FrontendTestBase extends BaseE2ETest {

    /** -Dfe.report=true collects + prints offenders without failing the build. */
    protected static final boolean REPORT_ONLY =
            Boolean.parseBoolean(System.getProperty("fe.report", "false"));

    /** App background in the night theme = #0f172a. */
    private static final String DARK_BODY_BG = "rgb(15,23,42)";

    /** Representative text selectors audited for contrast on every page. */
    protected static final String TEXT_SELECTORS =
            "h1,h2,h3,h4,h5,p,a,button,label,li,td,th,.btn,.badge," +
            ".text-neutral-400,.text-neutral-500,.text-neutral-600";

    private static final String AUDIT_JS = loadAuditJs();

    private static String loadAuditJs() {
        try (InputStream in = FrontendTestBase.class.getResourceAsStream("/fe-audit.js")) {
            if (in == null) throw new IllegalStateException("fe-audit.js not found on test classpath");
            try (Scanner s = new Scanner(in, StandardCharsets.UTF_8.name())) {
                return s.useDelimiter("\\A").hasNext() ? s.next() : "";
            }
        } catch (Exception e) {
            throw new RuntimeException("Failed to load fe-audit.js", e);
        }
    }

    private JavascriptExecutor js() {
        return (JavascriptExecutor) driver;
    }

    /** (Re)inject the audit helpers into the current page. */
    protected void injectAudit() {
        js().executeScript(AUDIT_JS);
    }

    /**
     * Wait until Tailwind's Play CDN has applied the dark theme (the body
     * background resolves to #0f172a). EAGER page-load fires at DOM-ready, before
     * the CDN injects styles — auditing earlier would read unstyled (light) DOM.
     */
    protected void waitForThemeApplied() {
        try {
            new WebDriverWait(driver, Duration.ofSeconds(12)).until(
                (ExpectedCondition<Boolean>) d -> {
                    Object bg = ((JavascriptExecutor) d).executeScript(
                        "return getComputedStyle(document.body).backgroundColor;");
                    return bg != null && bg.toString().replace(" ", "").equals(DARK_BODY_BG);
                });
        } catch (Exception e) {
            Object bg = js().executeScript("return getComputedStyle(document.body).backgroundColor;");
            fail("Dark theme not applied (Tailwind CDN may have stalled). body bg = " + bg
                    + " at " + currentUrl());
        }
    }

    @SuppressWarnings("unchecked")
    protected void assertDarkThemeApplied(String page) {
        injectAudit();
        Map<String, Object> r = (Map<String, Object>) js().executeScript("return window.__themeAudit();");
        List<Map<String, Object>> leaks = (List<Map<String, Object>>) r.get("leaks");
        assertEquals("[" + page + "] <html data-theme> should be 'dark'", "dark", r.get("theme"));
        if (leaks != null && !leaks.isEmpty()) {
            String msg = "[" + page + "] dark-theme LIGHT-LEAK offenders (" + leaks.size() + "): " + leaks;
            if (REPORT_ONLY) System.out.println("FE-REPORT " + msg);
            else fail(msg);
        }
    }

    @SuppressWarnings("unchecked")
    protected void assertContrastAA(String page) {
        injectAudit();
        Map<String, Object> r = (Map<String, Object>) js().executeScript(
                "return window.__a11yAudit(arguments[0], 400);", TEXT_SELECTORS);
        List<Map<String, Object>> fails = (List<Map<String, Object>>) r.get("fails");
        if (fails != null && !fails.isEmpty()) {
            String msg = "[" + page + "] WCAG AA contrast failures (" + fails.size()
                    + " of " + r.get("checked") + " checked): " + fails;
            if (REPORT_ONLY) System.out.println("FE-REPORT " + msg);
            else fail(msg);
        }
    }

    /** Save a full-page screenshot artifact under target/fe-screenshots/. */
    protected void screenshot(String name) {
        try {
            File src = ((TakesScreenshot) driver).getScreenshotAs(OutputType.FILE);
            Path dir = Paths.get("target", "fe-screenshots");
            Files.createDirectories(dir);
            Files.copy(src.toPath(), dir.resolve(name.replaceAll("[^a-zA-Z0-9._-]", "_") + ".png"),
                    StandardCopyOption.REPLACE_EXISTING);
        } catch (Exception ignored) {
            // screenshots are a best-effort artifact; never fail the test for them
        }
    }

    /**
     * Navigate to {@code path}, wait for the theme, and run all audits + screenshot.
     * {@code page} is a short label used in messages and the screenshot filename.
     */
    protected void auditPage(String page, String path) {
        navigateTo(path);
        waitForThemeApplied();
        assertNoServerError();
        assertDarkThemeApplied(page);
        assertContrastAA(page);
        screenshot(page);
    }
}
