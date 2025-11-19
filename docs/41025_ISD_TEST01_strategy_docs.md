# 41025 ISD Assignment 2 – Strategy Test Case 01

| Field | Details |
|-------|---------|
| **Test Name** | Checkout_UX_Smoke_Test |
| **Objective** | Validate multi-step checkout UI after atomic refactor |
| **Preconditions** | User logged in as guest; cart contains ≥1 item |
| **Steps** | 1. Navigate to `/checkout.jsp`<br>2. Fill Step 1 (Shipping) with valid data<br>3. Proceed to Step 2 (Payment)<br>4. Submit order |
| **Expected Result** | Inline validation shows no errors; success toast triggered; order confirmation modal displayed |
| **Notes** | Reference `FRONTEND_REFACTORING_SESSION_SUMMARY.en.md` section 3.2 |

