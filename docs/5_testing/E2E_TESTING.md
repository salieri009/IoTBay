# End-to-End (E2E) Testing Guide

**Document Version**: 1.0.0  
**Status**: Published  
**Last Updated**: December 3, 2025  
**Audience**: QA, Developers  
**Maintained By**: IoT Bay Documentation Team

---

## Overview

E2E tests simulate real user scenarios from the browser to the database, ensuring the entire application flow works as expected.

## Tools
- **Selenium WebDriver**: Browser automation
- **Cypress**: Modern E2E testing framework (recommended for future)

## Key Scenarios
1.  **User Registration & Login**: Verify successful signup and authentication.
2.  **Product Purchase**: Browse -> Add to Cart -> Checkout.
3.  **Admin Management**: Create product -> Edit product -> Delete product.

## Running Tests
```bash
# Run Selenium tests
mvn test -Dtest=E2ETestSuite
```
