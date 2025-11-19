# UX/UI Review and Execution Plan

## 1. Executive Summary
This document evaluates the current state of the IoTBay platform's key pages (`index.jsp`, `cart.jsp`, `login.jsp`, `register.jsp`) from a UX/UI expert perspective. It highlights usability issues, accessibility gaps, and technical debt that impacts the user experience. Following the review, a set of immediate execution tasks is defined and implemented.

## 2. Page Evaluations

### 2.1 Home Page (`index.jsp`)
*   **Primary Purpose**: Brand introduction, navigation hub, and showcasing featured products.
*   **UX Evaluation**:
    *   **Strengths**: Uses a clear Hero Banner and Category Grid. The layout is responsive.
    *   **Weaknesses**: The "Featured Products" section has a fallback state that is inconsistent with the dynamic state. If no products are loaded, the fallback card uses raw HTML instead of the standardized `product-card` component. This leads to visual inconsistencies and maintenance burden.
    *   **Accessibility**: The skeleton loader is present but manually toggled. Ensure `aria-busy` states are used during loading.
*   **Actionable Recommendation**: Standardize the "Featured Products" fallback to use the `product-card` component.

### 2.2 Shopping Cart (`cart.jsp`)
*   **Primary Purpose**: Review selected items, adjust quantities, and proceed to checkout.
*   **UX Evaluation**:
    *   **Strengths**: Clear breakdown of costs (Subtotal, Tax, Shipping). Includes a "Compatibility Warnings" section, which is excellent for IoT context.
    *   **Weaknesses**: The page relies heavily on legacy Java Scriptlets (`<% ... %>`) for logic (calculating totals, formatting currency). This makes the code brittle and hard to read. The "Free Shipping" progress indicator is calculated in Java but could be more dynamic.
    *   **Technical Debt**: The mixing of business logic (tax calculation) with presentation logic in the JSP is a violation of MVC principles.
*   **Actionable Recommendation**: Refactor the page to use JSTL (`<c:set>`, `<fmt:formatNumber>`) and EL for all logic and formatting. Remove scriptlets.

### 2.3 Authentication Pages (`login.jsp`, `register.jsp`)
*   **Primary Purpose**: User identification and onboarding.
*   **UX Evaluation**:
    *   **Status**: Recently refactored.
    *   **Strengths**: Clean, split-screen design (Register). Clear error messaging. Uses Atomic Design components (`form-field`).
    *   **Improvements**: Ensure the "Benefits" sidebar in Registration resonates emotionally (e.g., "Join the Innovators").

## 3. Execution Plan

### Task 1: Standardize `index.jsp`
*   **Objective**: Ensure the fallback "Featured Product" uses the shared `product-card` component.
*   **Benefit**: Visual consistency and reduced code duplication.

### Task 2: Modernize `cart.jsp`
*   **Objective**: Remove the ~50 lines of Java scriptlets at the top of the file.
*   **Implementation**:
    *   Use `<c:set>` to calculate totals (or assume the Controller passes them, but for now, replicate logic in JSTL if Controller isn't ready).
    *   Use `<fmt:formatNumber>` for currency display.
    *   Use EL for conditional rendering of "Free Shipping".

### Task 3: Accessibility Audit (Ongoing)
*   **Objective**: Verify `aria-labels` on all form inputs and buttons.
