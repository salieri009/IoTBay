# IoTBay — E2E Test Handover Document

> **Date:** 2026-05-23  
> **Branch base:** `main` @ `90e6937`  
> **Test framework:** Selenium 4 + JUnit 4 + WebDriverManager (ChromeDriver)

---

## 1. What Was Done

A full Selenium-based E2E test suite was written covering all 10 features (F01–F10) plus security boundary tests.  
The suite lives in `src/test/java/e2e/` and comprises **118 tests** across 11 test classes.

| Class | Feature | Tests |
|-------|---------|-------|
| `F01_AccessLogTest` | User Access Log | 6 |
| `F02_ProductCatalogTest` | Device/Product Catalogue | 10 |
| `F03_OrderManagementTest` | Order Management | 10 |
| `F04_PaymentTest` | Payment Management | 8 |
| `F05_ShipmentTest` | Shipment Management | 12 |
| `F06_UserManagementTest` | User Management (Admin) | 10 |
| `F07_CustomerManagementTest` | Customer Management (Admin) | 12 |
| `F08_StaffManagementTest` | Staff Management (Admin) | 12 |
| `F09_SupplierTest` | Supplier Management (Admin) | 10 |
| `F10_DataManagementTest` | Data Management (Import/Export) | 16 |
| `SecurityBoundaryTest` | Auth/Role Boundary Tests | 14 |

---

## 2. Test Infrastructure

### Prerequisites

1. **Java 21** — server runs on Java 21 (source compiled at Java 8/11 level)  
2. **Maven** at `C:\tools\maven\bin\mvn.cmd`  
3. **Chrome + ChromeDriver** — WebDriverManager auto-downloads the matching ChromeDriver  
4. **Jetty running on `localhost:8080`** — tests are NOT self-starting; Jetty must be up before running tests

### Starting the server

```bash
# Terminal 1 — start Jetty (keep this running)
cd D:\UTS\IoTBayPersonnel\IoTBay
C:\tools\maven\bin\mvn.cmd jetty:run
```

Wait for `[INFO] Started Jetty Server` before running tests.

### Running the tests

```bash
# Terminal 2 — run the full E2E suite
C:\tools\maven\bin\mvn.cmd test

# Run a single feature
C:\tools\maven\bin\mvn.cmd test -Dtest="e2e.F06_UserManagementTest"

# Run multiple features
C:\tools\maven\bin\mvn.cmd test -Dtest="e2e.F05_ShipmentTest,e2e.F06_UserManagementTest"

# Run everything except a slow feature
C:\tools\maven\bin\mvn.cmd test -Dtest="e2e.F01*,e2e.F02*,e2e.F03*,e2e.F04*"
```

Test reports are in `target/surefire-reports/`.

### Test Users (seeded by DatabaseInitializer)

| Role | Email | Password |
|------|-------|----------|
| Customer | `customer@iotbay.com` | `password123` |
| Staff | `staff@iotbay.com` | `staff123` |

All tests use these credentials. They are seeded automatically on first server start.

---

## 3. Pull Request Sequence (Merge Order Matters)

### Step 1 — Merge PR #9 first: `fix/app-bugs`

**URL:** https://github.com/salieri009/IoTBay/pull/9

**What it fixes:**

| File | Problem | Fix |
|------|---------|-----|
| `BrowsePageController.java` | `@WebServlet({"/browse", "/browse.jsp"})` + `forward("/browse.jsp")` → infinite servlet recursion → Jetty StackOverflowError | Remove `/browse.jsp` from `@WebServlet`, keep only `/browse` |
| `DatabaseInitializer.java` | `OrderDAOImpl` queries `orders` table (plural) but DB only had `"order"` (singular, quoted). Same mismatch for `access_logs`, `suppliers` | Add `createOrdersTable()`, `createSuppliersTable()`, `createAccessLogsTable()`, `seedOrdersTable()`, `seedSuppliersTable()`, `seedAccessLogsTable()` |

**Tests unblocked by this PR:**

- F01: `testAccessLogRequiresAuth`, `testAccessLogHasSearchForm` (access_logs table now exists)
- F02: `testBrowseAllProducts`, `testManageProductsHasDeleteOption` (browse no longer loops)
- F09: All 4 previously failing tests (suppliers table now exists)
- F10: Dashboard stats, import form, bulk delete section (orders table now exists → DataManagementController computes counts)
- SecurityBoundaryTest: Data management, user management redirects

### Step 2 — Merge PR #10: `fix/e2e-tests`

**URL:** https://github.com/salieri009/IoTBay/pull/10

**What it fixes:**

| File | Problem | Fix |
|------|---------|-----|
| `BaseE2ETest.java` | Default `PageLoadStrategy.NORMAL` waits for ALL sub-resources (CDN JS/CSS) → 300s timeout in headless Chrome on `/api/manage/products` | Set `PageLoadStrategy.EAGER` + 30s `pageLoadTimeout` |
| `F02_ProductCatalogTest.java` | `navigateTo("/browse.jsp")` bypasses `BrowsePageController` → JSP renders without `results` attribute → empty/error page | Change to `navigateTo("/browse")` |
| `F07_CustomerManagementTest.java` | `selectOption("customerType", "individual")` / `"company"` → `NoSuchElement` because Selenium's `selectByVisibleText` is case-sensitive and JSP option text is `"Individual"` / `"Company"` | Use Title Case |
| `F08_StaffManagementTest.java` | Same issue: `"salesperson"` / `"manager"` → must be `"Salesperson"` / `"Manager"` | Use Title Case |

**Tests fixed by this PR:**

- F02: `testBrowseAllProducts` (URL fix), `testStaffCanAccessManageProducts`, `testStaffCanAccessEditProductForm` (no more 300s timeout)
- F07: `testCreateIndividualCustomer`, `testCreateCompanyCustomer` (no more `NoSuchElement`)
- F08: `testCreateSalespersonStaff`, `testCreateManagerStaff` (no more `NoSuchElement`)

---

## 4. Known Remaining Issues (After Both PRs Merged)

After merging both PRs, the following tests may still require investigation:

### F04 — Payment Tests (4 tests)

**Root cause:** The `/payment/list` route and `PaymentDAOImpl` depend on a `payment` table.  
`DatabaseInitializer.seedPayments()` checks for the `payment` table but doesn't **create** it (no `createPaymentTable()` method). If the DB starts fresh, the table may not exist.

**Tests affected:**
- `testPaymentListPageRenders` — expects "Payment" or table on `/payment/list`
- `testPaymentListHasSearchForm` — expects a form on `/payment/list`
- `testCheckoutHasPaymentFields` — expects payment fields on `/checkout.jsp`
- `testPaymentListRequiresAuth` — expects redirect to login when unauthenticated

**Workaround:** If `iotbay.db` already has a `payment` table from a previous run, these tests pass. On a fresh DB, add `createPaymentTable()` to `DatabaseInitializer.initialize()`.

### F02 — Manage Products (2 tests — possibly resolved by EAGER fix)

If the product management page loads slowly due to Tailwind/CDN resources, the `testStaffCanAccessManageProducts` and `testStaffCanAccessEditProductForm` tests may still be slow (but should no longer timeout at 300s with EAGER strategy).

### F06 — testCustomerCannotAccessUserManagement

The test checks `!currentUrl().contains("manage")`. If the app shows a 403/error page **at the same URL** (without redirecting), `currentUrl()` still contains "manage" and this condition is `false`. The fallback `pageSource().contains("403")` must then match. Verify that the authorization filter returns a visible 403 or redirects to login.

---

## 5. Root-Cause Reference Map

| Symptom | Root Cause | Fixed In |
|---------|-----------|---------|
| `/browse` returns error page | `BrowsePageController` mapped to both `/browse` and `/browse.jsp` → infinite forward loop | PR #9 |
| `/api/dataManagement/dashboard` 500 | `OrderDAOImpl.getTotalOrderCount()` queries `orders` table (doesn't exist) | PR #9 |
| `/admin/supplier/` 500 | `SupplierDAOImpl` queries `suppliers` table (doesn't exist) | PR #9 |
| `/api/accessLog` 500 (when logged in) | `AccessLogDAOImpl` queries `access_logs` table (doesn't exist) | PR #9 |
| `manage-users.jsp` 500 | `${userItem.isActive}` — EL looks for `getIsActive()` (doesn't exist); must be `${userItem.active}` (maps to `isActive()`) | Committed directly to main @ `90e6937` |
| `staff-form.jsp` 500 | `<% %>` scriptlets inside `<t:base body-content="scriptless">` → JasperException | Committed directly to main @ `93570d1` |
| `customer-form.jsp` 500 | Same as above | Committed directly to main @ `93570d1` |
| 300s timeout on `/api/manage/products` | Selenium `pageLoadStrategy: normal` waits for all CDN sub-resources | PR #10 |
| `NoSuchElement: "individual"/"company"` | `selectByVisibleText` is case-sensitive; JSP renders `"Individual"/"Company"` | PR #10 |
| `NoSuchElement: "salesperson"/"manager"` | Same as above; JSP renders `"Salesperson"/"Manager"` | PR #10 |
| Test navigates to `/browse.jsp` | Test used raw JSP path, bypassing controller and leaving `results` null | PR #10 |

---

## 6. What Was Already Fixed on `main`

Before these PRs, the following bugs were identified and committed directly to `main`:

| Commit | File | Fix |
|--------|------|-----|
| `90e6937` | `manage-users.jsp` | `${userItem.isActive}` → `${userItem.active}` |
| `93570d1` | `staff-form.jsp`, `customer-form.jsp` | Rewrote JSTL/EL — removed scriptlets from `<t:base>` body |
| `2b355bf` | `BaseE2ETest.java` | JS-based login (bypass HTML5 validation), fixed logout URL |
| `9e9bf00` | 9 JSP files | Fixed inline scriptlet comment bug |

---

## 7. How to Verify the Fix Was Successful

After merging both PRs and restarting Jetty:

```bash
# Expected: ~110+ passes out of 118
C:\tools\maven\bin\mvn.cmd test 2>&1 | grep -E "Tests run:|FAIL|ERROR|BUILD"
```

Target: **≥ 110 passing** (94%+). Remaining failures should only be payment-related (F04 missing `createPaymentTable()`) or edge cases requiring real data.

To check a specific previously-failing test:
```bash
# Should now pass (was timing out)
C:\tools\maven\bin\mvn.cmd test -Dtest="e2e.F02_ProductCatalogTest#testStaffCanAccessManageProducts"

# Should now pass (was NoSuchElement)
C:\tools\maven\bin\mvn.cmd test -Dtest="e2e.F07_CustomerManagementTest#testCreateIndividualCustomer"

# Should now pass (browse URL fix)
C:\tools\maven\bin\mvn.cmd test -Dtest="e2e.F02_ProductCatalogTest#testBrowseAllProducts"
```

---

## 8. File Structure

```
src/test/java/
├── e2e/
│   ├── BaseE2ETest.java          # Shared WebDriver setup, login helpers, assertions
│   ├── F01_AccessLogTest.java    # 6 tests — access log page, auth redirect
│   ├── F02_ProductCatalogTest.java # 10 tests — browse, search, staff CRUD
│   ├── F03_OrderManagementTest.java # 10 tests — cart, order history, edit/cancel
│   ├── F04_PaymentTest.java      # 8 tests — payment list, checkout fields
│   ├── F05_ShipmentTest.java     # 12 tests — shipment CRUD, search, auth
│   ├── F06_UserManagementTest.java # 10 tests — user list, search, edit, auth
│   ├── F07_CustomerManagementTest.java # 12 tests — customer CRUD, type filter
│   ├── F08_StaffManagementTest.java # 12 tests — staff CRUD, position filter
│   ├── F09_SupplierTest.java     # 10 tests — supplier CRUD, search
│   ├── F10_DataManagementTest.java # 16 tests — dashboard, export, import, bulk-delete
│   └── SecurityBoundaryTest.java # 14 tests — unauthenticated + customer role blocks
└── utils/
    ├── PasswordUtilTest.java     # Unit tests (pre-existing)
    ├── DatabaseTest.java         # Unit tests (pre-existing)
    └── UserServiceTest.java      # Unit tests (pre-existing)
```
