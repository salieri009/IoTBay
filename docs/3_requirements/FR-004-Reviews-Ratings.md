# FR-004: Product Reviews & Ratings Features

## Document Information
**Feature ID**: FR-004  
**Feature Name**: Product Reviews & Ratings  
**Document Version**: 1.0  
**Last Updated**: 2025-11-20  
**Status**: Implemented  
**Priority**: High

---

## Overview

Product Reviews & Ratings features enable customers to share their experiences with products through ratings and written reviews. This feature set includes review submission, moderation, display, and management capabilities to help customers make informed purchasing decisions.

---

## Functional Requirements

### FR-004.1: Review Submission

#### FR-004.1.1: Create Review
- **REQ-004.1.1.1**: System SHALL provide review submission functionality (`/review/create`)
- **REQ-004.1.1.2**: Review form SHALL include:
  - Product selection (pre-filled if from product page)
  - Rating selector (1-5 stars, required)
  - Review title (text input, required, max 200 characters)
  - Review text (textarea, required, max 1000 characters)
  - Image upload (optional, if implemented)
  - Terms acceptance checkbox (if required)
- **REQ-004.1.1.3**: System SHALL validate all review fields
- **REQ-004.1.1.4**: System SHALL prevent duplicate reviews (one review per product per user)
- **REQ-004.1.1.5**: System SHALL link review to order if review is from order history
- **REQ-004.1.1.6**: System SHALL submit review to moderation queue (if moderation enabled)

#### FR-004.1.2: Review Validation
- **REQ-004.1.2.1**: System SHALL require rating (1-5 stars)
- **REQ-004.1.2.2**: System SHALL require review title (minimum length)
- **REQ-004.1.2.3**: System SHALL require review text (minimum length)
- **REQ-004.1.2.4**: System SHALL validate character limits
- **REQ-004.1.2.5**: System SHALL display validation errors clearly

### FR-004.2: Review Management

#### FR-004.2.1: View Reviews
- **REQ-004.2.1.1**: System SHALL provide review listing (`/review`)
- **REQ-004.2.1.2**: System SHALL display product reviews (`/review/product/{productId}`)
- **REQ-004.2.1.3**: System SHALL display user reviews (`/review/user/{userId}`)
- **REQ-004.2.1.4**: System SHALL display single review details (`/review/view/{reviewId}`)
- **REQ-004.2.1.5**: System SHALL calculate and display average rating
- **REQ-004.2.1.6**: System SHALL display review count

#### FR-004.2.2: Review Operations
- **REQ-004.2.2.1**: System SHALL allow users to update their own reviews (`/review/update`)
- **REQ-004.2.2.2**: System SHALL allow staff to edit any review
- **REQ-004.2.2.3**: System SHALL require re-verification after customer update (if moderation enabled)
- **REQ-004.2.2.4**: System SHALL allow users to delete their own reviews (`/review/delete`)
- **REQ-004.2.2.5**: System SHALL allow staff to delete any review
- **REQ-004.2.2.6**: System SHALL require confirmation dialog before deletion

### FR-004.3: Review Display

#### FR-004.3.1: Product Review Section
- **REQ-004.3.1.1**: System SHALL display reviews on product detail page
- **REQ-004.3.1.2**: Review section SHALL display:
  - Average rating (prominently displayed)
  - Rating distribution chart
  - Review list with pagination
  - Review submission link
- **REQ-004.3.1.3**: Each review SHALL display:
  - Reviewer name (or "Verified Customer")
  - Rating (stars)
  - Review title
  - Review text (truncated if long, "Read more" link)
  - Review date
  - Verified purchase badge (if from order)
  - Helpful count (if implemented)
  - "Helpful" button (if implemented)
  - Images (if uploaded)
- **REQ-004.3.1.4**: System SHALL support review sorting:
  - Most recent (default)
  - Highest rated
  - Lowest rated
  - Most helpful (if implemented)

#### FR-004.3.2: Review Filtering
- **REQ-004.3.2.1**: System SHALL allow filtering reviews by rating (1-5 stars)
- **REQ-004.3.2.2**: System SHALL display active filters
- **REQ-004.3.2.3**: System SHALL provide "Clear Filters" option

### FR-004.4: Review Moderation (Staff/Admin)

#### FR-004.4.1: Review Verification
- **REQ-004.4.1.1**: System SHALL provide review moderation queue
- **REQ-004.4.1.2**: System SHALL allow staff to approve/reject reviews
- **REQ-004.4.1.3**: System SHALL allow marking reviews as verified
- **REQ-004.4.1.4**: System SHALL provide review management interface
- **REQ-004.4.1.5**: System SHALL track moderation actions
- **REQ-004.4.1.6**: System SHALL notify reviewers of moderation decisions (if implemented)

#### FR-004.4.2: Moderation Workflow
- **REQ-004.4.2.1**: New reviews SHALL be submitted to moderation queue (if enabled)
- **REQ-004.4.2.2**: Staff SHALL be able to view pending reviews
- **REQ-004.4.2.3**: Staff SHALL be able to approve reviews
- **REQ-004.4.2.4**: Staff SHALL be able to reject reviews with reason
- **REQ-004.4.2.5**: Approved reviews SHALL appear on product page
- **REQ-004.4.2.6**: Rejected reviews SHALL be hidden from public view

---

## Acceptance Criteria

### AC-004.1: Review Submission
- Users can submit reviews for products
- Duplicate reviews are prevented
- All required fields are validated
- Reviews are submitted to moderation queue

### AC-004.2: Review Display
- Reviews display correctly on product pages
- Average rating is calculated accurately
- Rating distribution is shown
- Reviews can be sorted and filtered

### AC-004.3: Review Management
- Users can edit/delete their own reviews
- Staff can manage all reviews
- Moderation workflow functions correctly

---

## Dependencies

- **Database**: Reviews table with product_id, user_id, order_id, rating, title, comment, is_verified, is_approved
- **FR-001**: User Management (for user identification)
- **FR-002**: Product Catalog (for product information)
- **FR-003**: E-commerce (for order-linked reviews)

---

## Related Features

- **FR-001**: User Management (user identification, profile)
- **FR-002**: Product Catalog (product detail page, reviews section)
- **FR-003**: E-commerce (order-linked reviews)
- **FR-005**: Administrative Features (review moderation)

---

## API Endpoints

- `GET /review` - List all reviews
- `GET /review/product/{productId}` - Get product reviews
- `GET /review/user/{userId}` - Get user reviews
- `GET /review/view/{reviewId}` - Get review details
- `POST /review/create` - Create review
- `POST /review/update` - Update review
- `POST /review/delete` - Delete review

---

## Implementation Files

- `src/main/java/controller/ReviewController.java`
- `src/main/java/dao/ReviewDAO.java`
- `src/main/java/model/Review.java`

---

**End of FR-004: Product Reviews & Ratings Features**



---

**Audience**: Developers, Stakeholders
**Maintained By**: IoT Bay Documentation Team
