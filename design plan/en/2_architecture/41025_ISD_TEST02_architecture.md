# 41025 ISD Assignment 2 – Architecture Test Case 02

| Field | Details |
|-------|---------|
| **Test Name** | API_Catalog_Pagination_Contract |
| **Objective** | Ensure `/api/catalog` pagination parameters conform to specification |
| **Preconditions** | API server running locally (`/api/catalog` seeded with ≥50 products) |
| **Steps** | 1. Send `GET /api/catalog?page=2&pageSize=20&sort=price`<br>2. Verify response payload structure matches `API_DOCUMENTATION.en.md` section 4.2<br>3. Confirm `items.length == 20` and `meta.currentPage == 2` |
| **Expected Result** | HTTP 200 with valid JSON schema, correct pagination metadata |
| **Notes** | Reference `API_DOCUMENTATION.en.md` section 4 and `DATABASE_DESIGN.en.md` entity `Product` |

