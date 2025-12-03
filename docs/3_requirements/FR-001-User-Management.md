# FR-001: User Management Features

## Document Information
**Feature ID**: FR-001  
**Feature Name**: User Management  
**Document Version**: 1.0  
**Last Updated**: 2025-11-20  
**Status**: Implemented  
**Priority**: High

---

## Overview

User Management features provide comprehensive user account lifecycle management including registration, authentication, profile management, and role-based access control. This feature set ensures secure user access and personalized experiences across the IoTBay platform.

---

## Functional Requirements

### FR-001.1: User Registration

#### FR-001.1.1: Registration Form
- **REQ-001.1.1.1**: System SHALL provide a user registration form (`register.jsp`)
- **REQ-001.1.1.2**: Form SHALL include the following required fields:
  - First name (text input, required)
  - Last name (text input, required)
  - Email address (email input, required, unique)
  - Password (password input, required, minimum 8 characters)
  - Password confirmation (password input, required, must match password)
- **REQ-001.1.1.3**: Form SHALL include the following optional fields:
  - Phone number (text input, optional, with auto-formatting)
- **REQ-001.1.1.4**: Form SHALL include required checkboxes:
  - Terms and Conditions acceptance (required)
  - Privacy Policy acceptance (required)

#### FR-001.1.2: Registration Validation
- **REQ-001.1.2.1**: System SHALL perform real-time client-side validation on all form fields
- **REQ-001.1.2.2**: System SHALL validate email format and uniqueness
- **REQ-001.1.2.3**: System SHALL display password strength indicator (weak, medium, strong)
- **REQ-001.1.2.4**: System SHALL validate password confirmation matches password
- **REQ-001.1.2.5**: System SHALL perform server-side validation and sanitization
- **REQ-001.1.2.6**: System SHALL display clear error messages for validation failures
- **REQ-001.1.2.7**: System SHALL prevent duplicate email registrations

#### FR-001.1.3: Registration Processing
- **REQ-001.1.3.1**: System SHALL hash passwords using SHA-256 with salt before storage
- **REQ-001.1.3.2**: System SHALL create user account with default role "customer"
- **REQ-001.1.3.3**: System SHALL set account status to "active" by default
- **REQ-001.1.3.4**: System SHALL record registration timestamp
- **REQ-001.1.3.5**: System SHALL redirect to welcome page upon successful registration
- **REQ-001.1.3.6**: System SHALL display success message after registration

### FR-001.2: User Authentication

#### FR-001.2.1: Login System
- **REQ-001.2.1.1**: System SHALL provide a login form (`login.jsp`)
- **REQ-001.2.1.2**: Login form SHALL accept email address and password
- **REQ-001.2.1.3**: System SHALL validate credentials against stored user data
- **REQ-001.2.1.4**: System SHALL support "Remember Me" functionality for session persistence
- **REQ-001.2.1.5**: System SHALL create secure session upon successful authentication
- **REQ-001.2.1.6**: System SHALL redirect users based on role:
  - Customer → Welcome page or previous page
  - Staff → Admin Dashboard
  - Admin → Admin Dashboard

#### FR-001.2.2: Authentication Security
- **REQ-001.2.2.1**: System SHALL prevent brute force attacks with rate limiting
- **REQ-001.2.2.2**: System SHALL display generic error message for invalid credentials
- **REQ-001.2.2.3**: System SHALL check account status before allowing login
- **REQ-001.2.2.4**: System SHALL prevent login for inactive accounts
- **REQ-001.2.2.5**: System SHALL implement CSRF protection for login form
- **REQ-001.2.2.6**: System SHALL log all login attempts in access logs

#### FR-001.2.3: Logout Functionality
- **REQ-001.2.3.1**: System SHALL provide logout functionality (`logout.jsp`)
- **REQ-001.2.3.2**: System SHALL invalidate user session upon logout
- **REQ-001.2.3.3**: System SHALL redirect to goodbye page after logout
- **REQ-001.2.3.4**: System SHALL clear session data securely

### FR-001.3: Password Management

#### FR-001.3.1: Password Security
- **REQ-001.3.1.1**: System SHALL hash passwords using SHA-256 with unique salt per user
- **REQ-001.3.1.2**: System SHALL enforce password strength requirements:
  - Minimum 8 characters
  - At least one uppercase letter
  - At least one lowercase letter
  - At least one number
- **REQ-001.3.1.3**: System SHALL display password strength indicator during registration
- **REQ-001.3.1.4**: System SHALL never store plain-text passwords

#### FR-001.3.2: Password Reset
- **REQ-001.3.2.1**: System SHALL provide password reset functionality via security questions
- **REQ-001.3.2.2**: System SHALL store reset questions with hashed answers
- **REQ-001.3.2.3**: System SHALL allow users to change password from profile page
- **REQ-001.3.2.4**: System SHALL require current password for password changes

### FR-001.4: User Profile Management

#### FR-001.4.1: Profile Viewing
- **REQ-001.4.1.1**: System SHALL provide profile page (`profile.jsp`)
- **REQ-001.4.1.2**: Profile page SHALL display user information:
  - Personal information (name, email, phone)
  - Address information (multiple addresses supported)
  - Account settings
  - Order history link
  - Review history link
- **REQ-001.4.1.3**: System SHALL allow users to view only their own profile

#### FR-001.4.2: Profile Editing
- **REQ-001.4.2.1**: System SHALL allow users to edit their profile information
- **REQ-001.4.2.2**: System SHALL validate all profile updates
- **REQ-001.4.2.3**: System SHALL support multiple address management
- **REQ-001.4.2.4**: System SHALL allow setting default address
- **REQ-001.4.2.5**: System SHALL update profile modification timestamp
- **REQ-001.4.2.6**: System SHALL display success message after profile update

#### FR-001.4.3: Account Deletion
- **REQ-001.4.3.1**: System SHALL provide account deletion functionality (`deleteaccount.jsp`)
- **REQ-001.4.3.2**: System SHALL require confirmation dialog before deletion
- **REQ-001.4.3.3**: System SHALL perform soft delete (mark as inactive)
- **REQ-001.4.3.4**: System SHALL retain order history for deleted accounts
- **REQ-001.4.3.5**: System SHALL redirect to goodbye page after deletion

### FR-001.5: Role-Based Access Control

#### FR-001.5.1: User Roles
- **REQ-001.5.1.1**: System SHALL support three user roles:
  - Customer (default)
  - Staff
  - Admin
- **REQ-001.5.1.2**: System SHALL assign role during registration (default: customer)
- **REQ-001.5.1.3**: Only Admin SHALL be able to change user roles

#### FR-001.5.2: Customer Permissions
- **REQ-001.5.2.1**: Customer SHALL be able to:
  - Browse products
  - Add to cart
  - Place orders
  - View own order history
  - Manage own profile
  - View product details
  - Submit product reviews
  - View own reviews
- **REQ-001.5.2.2**: Customer SHALL NOT be able to:
  - Access admin dashboard
  - View other users' information
  - Manage products
  - View access logs

#### FR-001.5.3: Staff Permissions
- **REQ-001.5.3.1**: Staff SHALL have all customer permissions
- **REQ-001.5.3.2**: Staff SHALL additionally be able to:
  - View all orders
  - Process orders
  - View shipment information
  - Access customer information
  - View access logs
  - Moderate product reviews
  - Export data (CSV)
- **REQ-001.5.3.3**: Staff SHALL NOT be able to:
  - Manage users (CRUD)
  - Manage products (CRUD)
  - System configuration

#### FR-001.5.4: Admin Permissions
- **REQ-001.5.4.1**: Admin SHALL have all staff permissions
- **REQ-001.5.4.2**: Admin SHALL additionally be able to:
  - User management (CRUD operations)
  - Product management (CRUD operations)
  - System configuration
  - Access log management
  - Analytics and reporting
  - Supplier management
  - Data export and import

### FR-001.6: Session Management

#### FR-001.6.1: Session Creation
- **REQ-001.6.1.1**: System SHALL create secure session upon successful login
- **REQ-001.6.1.2**: System SHALL store user information in session
- **REQ-001.6.1.3**: System SHALL support guest sessions for cart persistence
- **REQ-001.6.1.4**: System SHALL implement CSRF protection tokens in sessions

#### FR-001.6.2: Session Timeout
- **REQ-001.6.2.1**: System SHALL implement session timeout (30 minutes inactivity)
- **REQ-001.6.2.2**: System SHALL redirect to login page when session expires
- **REQ-001.6.2.3**: System SHALL preserve user's intended destination for post-login redirect

#### FR-001.6.3: Session Security
- **REQ-001.6.3.1**: System SHALL invalidate session on logout
- **REQ-001.6.3.2**: System SHALL prevent session hijacking
- **REQ-001.6.3.3**: System SHALL track session activity in access logs

---

## Acceptance Criteria

### AC-001.1: Registration
- User can successfully register with valid information
- System prevents duplicate email registration
- Password strength indicator works correctly
- User is redirected to welcome page after registration

### AC-001.2: Authentication
- User can login with valid credentials
- System prevents login with invalid credentials
- Role-based redirect works correctly
- Session is created securely

### AC-001.3: Profile Management
- User can view and edit own profile
- Multiple addresses can be managed
- Profile updates are saved correctly
- Account deletion works with confirmation

### AC-001.4: Access Control
- Customers cannot access admin features
- Staff can access order management but not user management
- Admins have full system access
- Unauthorized access attempts are logged

---

## Dependencies

- **Database**: User table with password_hash, salt, role, isActive fields
- **Security**: PasswordUtil for password hashing
- **Session**: Servlet session management
- **Validation**: InputValidator for form validation

---

## Related Features

- **FR-002**: Product Catalog (browsing permissions)
- **FR-003**: E-commerce (cart, orders)
- **FR-005**: Administrative Features (user management)
- **FR-007**: Security Features (authentication, authorization)

---

## API Endpoints

- `POST /register` - User registration
- `POST /login` - User authentication
- `GET /api/me` - Get current user information
- `POST /logout` - User logout
- `GET /profile` - View profile
- `POST /updateProfile` - Update profile
- `POST /deleteaccount` - Delete account

---

## Implementation Files

- `src/main/webapp/register.jsp`
- `src/main/webapp/login.jsp`
- `src/main/webapp/logout.jsp`
- `src/main/webapp/profile.jsp`
- `src/main/webapp/deleteaccount.jsp`
- `src/main/java/controller/RegisterController.java`
- `src/main/java/controller/LoginController.java`
- `src/main/java/controller/LogoutController.java`
- `src/main/java/controller/UserProfileController.java`
- `src/main/java/service/UserService.java`
- `src/main/java/utils/PasswordUtil.java`

---

**End of FR-001: User Management Features**

