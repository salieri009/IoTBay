# UX Scenarios: User Management Features

## Document Information
**Feature Category**: User Management  
**Last Updated**: 2025-01-20  
**Related Features**: Registration, Authentication, Profile Management, Role-Based Access Control

---

## 1. User Registration Scenario

### 1.1 Scenario: New Customer Registration

**User Persona**: First-time visitor, wants to purchase IoT devices  
**Goal**: Create a new account to access full e-commerce features  
**Context**: User arrives at homepage, clicks "Register" or "Sign Up"

#### Step-by-Step Flow

1. **Entry Point**
   - User clicks "Register" button in header (or "Sign Up" link)
   - Redirected to `/register.jsp`
   - Page displays registration form with clear heading "Create Your Account"

2. **Form Display**
   - Form shows required fields with visual indicators (*)
   - Real-time validation feedback as user types
   - Password strength indicator visible below password field
   - Terms & Conditions and Privacy Policy checkboxes at bottom

3. **User Input Process**
   - **First Name**: User types name, sees green checkmark when valid
   - **Last Name**: User types surname, validation confirms
   - **Email**: User enters email, system checks format and uniqueness
     - If email exists: Red error message "This email is already registered"
     - If invalid format: Red error "Please enter a valid email address"
   - **Password**: User types password
     - Strength indicator updates in real-time (Weak → Medium → Strong)
     - Visual feedback: Red (weak), Yellow (medium), Green (strong)
     - Requirements shown: "8+ characters, uppercase, lowercase, number"
   - **Confirm Password**: User re-enters password
     - If mismatch: Red error "Passwords do not match"
     - If match: Green checkmark appears
   - **Phone Number** (Optional): User enters phone, auto-formats as they type
   - **Terms & Conditions**: User must check box to proceed
   - **Privacy Policy**: User must check box to proceed

4. **Form Submission**
   - User clicks "Create Account" button
   - Button shows loading state (spinner, "Creating account...")
   - Form validation runs (client-side)
   - If validation passes: Form submits to server
   - If validation fails: Error messages appear above form

5. **Success Path**
   - Server processes registration
   - Success message: "Account created successfully!"
   - Redirect to `/welcome.jsp`
   - Welcome page shows personalized greeting
   - User sees quick navigation links (Browse Products, View Profile)

6. **Error Handling**
   - If server error: Generic error message "Something went wrong. Please try again."
   - Form retains user input (except password fields)
   - Error message appears at top of form with red background
   - User can correct and resubmit

#### UX Considerations
- **Accessibility**: All form fields have proper labels and ARIA attributes
- **Mobile**: Form is responsive, touch-friendly inputs
- **Loading States**: Clear feedback during submission
- **Error Recovery**: User-friendly error messages with suggestions
- **Progress Indicator**: Visual progress bar for multi-step (if implemented)

---

### 1.2 Scenario: Business User Registration

**User Persona**: B2B customer, needs bulk purchasing  
**Goal**: Register as business customer with business email  
**Context**: User has business email domain

#### Flow Differences
- Business email validation (e.g., @company.com)
- Additional fields may appear (Company Name, Business Address)
- Different terms & conditions for B2B
- Account approval may be required (if implemented)

---

## 2. User Login Scenario

### 2.1 Scenario: Returning Customer Login

**User Persona**: Registered customer, returning to make purchase  
**Goal**: Access account to view orders, manage profile, checkout  
**Context**: User clicks "Login" in header

#### Step-by-Step Flow

1. **Entry Point**
   - User clicks "Login" button in header
   - Redirected to `/login.jsp`
   - Page shows login form with heading "Welcome Back"

2. **Form Display**
   - Email input field (autofocus)
   - Password input field
   - "Remember Me" checkbox
   - "Forgot Password?" link
   - "Don't have an account? Register" link

3. **User Input**
   - User enters email address
   - User enters password
   - User optionally checks "Remember Me"
   - User clicks "Sign In" button

4. **Authentication Process**
   - Button shows loading state ("Signing in...")
   - Client-side validation (email format)
   - Server validates credentials
   - Session created on success

5. **Success Path**
   - Redirect based on role:
     - **Customer**: `/welcome.jsp` or previous page
     - **Staff**: `/admin-dashboard.jsp`
     - **Admin**: `/admin-dashboard.jsp`
   - Header updates to show user menu
   - Cart count badge appears (if items in cart)

6. **Error Handling**
   - **Invalid Credentials**: "Email or password is incorrect"
   - **Account Inactive**: "Your account has been deactivated. Please contact support."
   - **Account Locked**: "Too many failed attempts. Please try again in 15 minutes."
   - Form retains email (not password)
   - Error message appears above form

#### UX Considerations
- **Security**: No specific error about which field is wrong
- **Rate Limiting**: Prevents brute force attacks
- **Session Management**: Secure session creation
- **CSRF Protection**: Token included in form

---

### 2.2 Scenario: Staff Login

**User Persona**: Staff member, needs to access admin features  
**Goal**: Access staff dashboard for order processing, user management  
**Context**: Staff member logs in with staff credentials

#### Flow Differences
- After login, redirect to `/admin-dashboard.jsp`
- Header shows "Admin Dashboard" link in user menu
- Access to staff-only features (order management, access logs)
- Different navigation menu (admin sidebar)

---

## 3. User Profile Management Scenario

### 3.1 Scenario: View and Edit Profile

**User Persona**: Registered customer, wants to update personal information  
**Goal**: View profile information and make updates  
**Context**: User clicks on profile in header menu

#### Step-by-Step Flow

1. **Entry Point**
   - User clicks on user avatar/name in header
   - Dropdown menu appears
   - User clicks "Profile" option
   - Redirected to `/profile.jsp`

2. **Profile Display**
   - Page shows user information in sections:
     - **Personal Information**: Name, Email, Phone, Date of Birth
     - **Addresses**: List of saved addresses with "Set as Default" option
     - **Payment Methods**: Saved payment methods (if implemented)
     - **Account Settings**: Password change, account deletion
   - Each section has "Edit" button

3. **Edit Personal Information**
   - User clicks "Edit" on Personal Information section
   - Form appears with current values pre-filled
   - User makes changes (e.g., updates phone number)
   - User clicks "Save Changes"
   - Loading state shows "Saving..."
   - Success message: "Profile updated successfully"
   - Form closes, updated information displayed

4. **Add New Address**
   - User clicks "Add New Address" button
   - Address form appears (modal or inline)
   - User fills in:
     - Recipient Name
     - Street Address
     - City, State, Postal Code
     - Country
     - Phone Number
     - "Set as Default" checkbox
   - User clicks "Save Address"
   - New address appears in addresses list

5. **Change Password**
   - User clicks "Change Password" in Account Settings
   - Password change form appears
   - User enters:
     - Current Password
     - New Password (with strength indicator)
     - Confirm New Password
   - User clicks "Update Password"
   - Success message: "Password updated successfully"
   - User must re-login (if implemented)

6. **View Order History**
   - User clicks "Orders" link in profile or header menu
   - Redirected to `/orderList.jsp`
   - List of orders displayed with:
     - Order Number
     - Order Date
     - Status
     - Total Amount
     - "View Details" button
   - User can filter by status or date range

#### UX Considerations
- **Data Persistence**: Changes saved immediately
- **Validation**: Real-time validation on all fields
- **Confirmation**: Important actions (password change, account deletion) require confirmation
- **Feedback**: Clear success/error messages
- **Accessibility**: Keyboard navigation, screen reader support

---

### 3.2 Scenario: Account Deletion

**User Persona**: Customer wants to close account  
**Goal**: Permanently delete account  
**Context**: User in profile settings

#### Step-by-Step Flow

1. **Initiation**
   - User navigates to Account Settings in profile
   - User clicks "Delete Account" button
   - Warning modal appears

2. **Confirmation Dialog**
   - Modal shows:
     - Warning message: "Are you sure you want to delete your account?"
     - Consequences listed:
       - All order history will be archived
       - Saved addresses will be deleted
       - Account cannot be recovered
     - Checkbox: "I understand this action cannot be undone"
     - "Cancel" and "Delete Account" buttons

3. **Deletion Process**
   - User checks confirmation checkbox
   - User clicks "Delete Account" (button turns red)
   - Loading state: "Deleting account..."
   - Server processes soft delete
   - Session invalidated

4. **Completion**
   - Redirect to `/goodbye.jsp`
   - Thank you message displayed
   - Link to return to homepage

#### UX Considerations
- **Safety**: Multiple confirmation steps
- **Reversibility**: Soft delete allows data recovery (if needed)
- **Transparency**: Clear explanation of consequences
- **Finality**: Clear indication that action is permanent

---

## 4. Password Reset Scenario

### 4.1 Scenario: Forgot Password

**User Persona**: Customer forgot password, needs to reset  
**Goal**: Reset password to regain account access  
**Context**: User on login page, clicks "Forgot Password?"

#### Step-by-Step Flow

1. **Initiation**
   - User on `/login.jsp`
   - User clicks "Forgot Password?" link
   - Redirected to password reset page

2. **Email Entry**
   - Form asks for email address
   - User enters registered email
   - User clicks "Send Reset Link" (or answers security question)

3. **Security Question (if implemented)**
   - System shows security question
   - User enters answer
   - If correct: Password reset form appears
   - If incorrect: Error message, retry option

4. **Password Reset**
   - User enters new password
   - Password strength indicator shows
   - User confirms new password
   - User clicks "Reset Password"

5. **Completion**
   - Success message: "Password reset successfully"
   - Redirect to login page
   - User can now login with new password

#### UX Considerations
- **Security**: Secure reset process (questions or email link)
- **Feedback**: Clear instructions at each step
- **Error Handling**: Helpful error messages

---

## 5. Role-Based Access Control Scenarios

### 5.1 Scenario: Customer Access

**User Persona**: Regular customer  
**Goal**: Access customer-only features  
**Context**: Customer logged in

#### Available Features
- Browse products
- Add to cart
- Place orders
- View own order history
- Manage profile
- Submit product reviews
- View own reviews

#### Restricted Features
- Cannot access `/admin-dashboard.jsp` (redirected to homepage)
- Cannot access `/manage-users.jsp` (403 error)
- Cannot access `/manage-products.jsp` (403 error)
- Cannot view other users' information

#### UX Flow
- Customer attempts to access admin page
- System checks role
- If not authorized: Redirect to homepage with message "You don't have permission to access this page"
- Header shows customer menu (Profile, Orders, Logout)

---

### 5.2 Scenario: Staff Access

**User Persona**: Staff member  
**Goal**: Access staff features for order processing  
**Context**: Staff member logged in

#### Available Features
- All customer features
- View all orders
- Process orders
- View shipment information
- Access customer information
- View access logs
- Moderate product reviews
- Export data (CSV)

#### UX Flow
- Staff logs in
- Redirected to `/admin-dashboard.jsp`
- Dashboard shows:
  - Order statistics
  - Recent orders
  - Quick actions (Process Orders, View Access Logs)
- Header shows "Admin Dashboard" link
- Sidebar navigation for admin features

---

### 5.3 Scenario: Admin Access

**User Persona**: System administrator  
**Goal**: Full system access for management  
**Context**: Admin logged in

#### Available Features
- All staff features
- User management (CRUD)
- Product management (CRUD)
- System configuration
- Access log management
- Analytics and reporting
- Supplier management
- Data export and import

#### UX Flow
- Admin logs in
- Redirected to `/admin-dashboard.jsp`
- Dashboard shows comprehensive statistics
- Full admin menu available
- Can access all management pages
- Can perform all CRUD operations

---

## 6. Session Management Scenarios

### 6.1 Scenario: Session Timeout

**User Persona**: Any logged-in user  
**Goal**: Maintain security with session timeout  
**Context**: User inactive for extended period

#### Flow
1. User logged in, working on site
2. User becomes inactive (no activity for 30 minutes)
3. Session expires
4. User attempts action (e.g., add to cart)
5. System detects expired session
6. Redirect to login page with message: "Your session has expired. Please log in again."
7. User logs in, redirected back to previous page (if possible)

#### UX Considerations
- **Warning**: Optional warning before timeout (e.g., "Your session will expire in 2 minutes")
- **Recovery**: Preserve user's work (e.g., cart items, form data)
- **Transparency**: Clear message about session expiration

---

### 6.2 Scenario: Logout

**User Persona**: Any logged-in user  
**Goal**: Securely log out of account  
**Context**: User wants to end session

#### Flow
1. User clicks user menu in header
2. User clicks "Logout" option
3. Confirmation (optional): "Are you sure you want to log out?"
4. User confirms
5. Session invalidated
6. Redirect to `/goodbye.jsp`
7. Thank you message displayed
8. Link to return to homepage

#### UX Considerations
- **Security**: Complete session invalidation
- **Feedback**: Clear confirmation of logout
- **Navigation**: Easy return to homepage

---

## 7. Error Scenarios

### 7.1 Scenario: Registration Email Already Exists

**Flow**:
1. User enters email that's already registered
2. Real-time validation (if implemented) or on submit
3. Error message: "This email is already registered. Would you like to log in instead?"
4. Link to login page provided
5. Form retains other fields (except password)

### 7.2 Scenario: Login with Wrong Password

**Flow**:
1. User enters correct email, wrong password
2. User clicks "Sign In"
3. Error message: "Email or password is incorrect"
4. Password field cleared
5. Email field retained
6. "Forgot Password?" link highlighted

### 7.3 Scenario: Session Expired During Checkout

**Flow**:
1. User in checkout process
2. Session expires
3. User attempts to place order
4. Redirect to login with message: "Your session expired. Please log in to complete your order."
5. After login, redirect back to checkout
6. Cart items preserved (if possible)

---

## 8. Accessibility Considerations

### 8.1 Keyboard Navigation
- All forms navigable with Tab key
- Focus indicators visible
- Skip links for main content
- Keyboard shortcuts (if implemented)

### 8.2 Screen Reader Support
- All form fields have proper labels
- ARIA attributes for error messages
- ARIA live regions for dynamic content
- Semantic HTML structure

### 8.3 Visual Accessibility
- High contrast ratios (WCAG AA)
- Clear focus indicators
- Error messages with icons
- Loading states clearly visible

---

## 9. Mobile UX Considerations

### 9.1 Registration on Mobile
- Single column layout
- Large touch targets
- Auto-capitalization disabled for email
- Numeric keyboard for phone
- Smooth scrolling
- Sticky submit button

### 9.2 Login on Mobile
- Simplified form
- "Remember Me" easily accessible
- Quick access to "Forgot Password"
- Auto-fill support

### 9.3 Profile Management on Mobile
- Collapsible sections
- Swipe gestures for actions (if implemented)
- Bottom sheet for modals
- Sticky navigation

---

## 10. Performance Considerations

### 10.1 Registration
- Client-side validation for immediate feedback
- Server validation for security
- Optimistic UI updates
- Minimal page reloads

### 10.2 Login
- Fast authentication response
- Cached credentials (if "Remember Me")
- Quick redirect after login
- Minimal loading time

### 10.3 Profile Management
- Lazy loading of sections
- Incremental saves
- Optimistic updates
- Background sync

---

**End of User Management UX Scenarios**


## Document Information
**Feature Category**: User Management  
**Last Updated**: 2025-01-20  
**Related Features**: Registration, Authentication, Profile Management, Role-Based Access Control

---

## 1. User Registration Scenario

### 1.1 Scenario: New Customer Registration

**User Persona**: First-time visitor, wants to purchase IoT devices  
**Goal**: Create a new account to access full e-commerce features  
**Context**: User arrives at homepage, clicks "Register" or "Sign Up"

#### Step-by-Step Flow

1. **Entry Point**
   - User clicks "Register" button in header (or "Sign Up" link)
   - Redirected to `/register.jsp`
   - Page displays registration form with clear heading "Create Your Account"

2. **Form Display**
   - Form shows required fields with visual indicators (*)
   - Real-time validation feedback as user types
   - Password strength indicator visible below password field
   - Terms & Conditions and Privacy Policy checkboxes at bottom

3. **User Input Process**
   - **First Name**: User types name, sees green checkmark when valid
   - **Last Name**: User types surname, validation confirms
   - **Email**: User enters email, system checks format and uniqueness
     - If email exists: Red error message "This email is already registered"
     - If invalid format: Red error "Please enter a valid email address"
   - **Password**: User types password
     - Strength indicator updates in real-time (Weak → Medium → Strong)
     - Visual feedback: Red (weak), Yellow (medium), Green (strong)
     - Requirements shown: "8+ characters, uppercase, lowercase, number"
   - **Confirm Password**: User re-enters password
     - If mismatch: Red error "Passwords do not match"
     - If match: Green checkmark appears
   - **Phone Number** (Optional): User enters phone, auto-formats as they type
   - **Terms & Conditions**: User must check box to proceed
   - **Privacy Policy**: User must check box to proceed

4. **Form Submission**
   - User clicks "Create Account" button
   - Button shows loading state (spinner, "Creating account...")
   - Form validation runs (client-side)
   - If validation passes: Form submits to server
   - If validation fails: Error messages appear above form

5. **Success Path**
   - Server processes registration
   - Success message: "Account created successfully!"
   - Redirect to `/welcome.jsp`
   - Welcome page shows personalized greeting
   - User sees quick navigation links (Browse Products, View Profile)

6. **Error Handling**
   - If server error: Generic error message "Something went wrong. Please try again."
   - Form retains user input (except password fields)
   - Error message appears at top of form with red background
   - User can correct and resubmit

#### UX Considerations
- **Accessibility**: All form fields have proper labels and ARIA attributes
- **Mobile**: Form is responsive, touch-friendly inputs
- **Loading States**: Clear feedback during submission
- **Error Recovery**: User-friendly error messages with suggestions
- **Progress Indicator**: Visual progress bar for multi-step (if implemented)

---

### 1.2 Scenario: Business User Registration

**User Persona**: B2B customer, needs bulk purchasing  
**Goal**: Register as business customer with business email  
**Context**: User has business email domain

#### Flow Differences
- Business email validation (e.g., @company.com)
- Additional fields may appear (Company Name, Business Address)
- Different terms & conditions for B2B
- Account approval may be required (if implemented)

---

## 2. User Login Scenario

### 2.1 Scenario: Returning Customer Login

**User Persona**: Registered customer, returning to make purchase  
**Goal**: Access account to view orders, manage profile, checkout  
**Context**: User clicks "Login" in header

#### Step-by-Step Flow

1. **Entry Point**
   - User clicks "Login" button in header
   - Redirected to `/login.jsp`
   - Page shows login form with heading "Welcome Back"

2. **Form Display**
   - Email input field (autofocus)
   - Password input field
   - "Remember Me" checkbox
   - "Forgot Password?" link
   - "Don't have an account? Register" link

3. **User Input**
   - User enters email address
   - User enters password
   - User optionally checks "Remember Me"
   - User clicks "Sign In" button

4. **Authentication Process**
   - Button shows loading state ("Signing in...")
   - Client-side validation (email format)
   - Server validates credentials
   - Session created on success

5. **Success Path**
   - Redirect based on role:
     - **Customer**: `/welcome.jsp` or previous page
     - **Staff**: `/admin-dashboard.jsp`
     - **Admin**: `/admin-dashboard.jsp`
   - Header updates to show user menu
   - Cart count badge appears (if items in cart)

6. **Error Handling**
   - **Invalid Credentials**: "Email or password is incorrect"
   - **Account Inactive**: "Your account has been deactivated. Please contact support."
   - **Account Locked**: "Too many failed attempts. Please try again in 15 minutes."
   - Form retains email (not password)
   - Error message appears above form

#### UX Considerations
- **Security**: No specific error about which field is wrong
- **Rate Limiting**: Prevents brute force attacks
- **Session Management**: Secure session creation
- **CSRF Protection**: Token included in form

---

### 2.2 Scenario: Staff Login

**User Persona**: Staff member, needs to access admin features  
**Goal**: Access staff dashboard for order processing, user management  
**Context**: Staff member logs in with staff credentials

#### Flow Differences
- After login, redirect to `/admin-dashboard.jsp`
- Header shows "Admin Dashboard" link in user menu
- Access to staff-only features (order management, access logs)
- Different navigation menu (admin sidebar)

---

## 3. User Profile Management Scenario

### 3.1 Scenario: View and Edit Profile

**User Persona**: Registered customer, wants to update personal information  
**Goal**: View profile information and make updates  
**Context**: User clicks on profile in header menu

#### Step-by-Step Flow

1. **Entry Point**
   - User clicks on user avatar/name in header
   - Dropdown menu appears
   - User clicks "Profile" option
   - Redirected to `/profile.jsp`

2. **Profile Display**
   - Page shows user information in sections:
     - **Personal Information**: Name, Email, Phone, Date of Birth
     - **Addresses**: List of saved addresses with "Set as Default" option
     - **Payment Methods**: Saved payment methods (if implemented)
     - **Account Settings**: Password change, account deletion
   - Each section has "Edit" button

3. **Edit Personal Information**
   - User clicks "Edit" on Personal Information section
   - Form appears with current values pre-filled
   - User makes changes (e.g., updates phone number)
   - User clicks "Save Changes"
   - Loading state shows "Saving..."
   - Success message: "Profile updated successfully"
   - Form closes, updated information displayed

4. **Add New Address**
   - User clicks "Add New Address" button
   - Address form appears (modal or inline)
   - User fills in:
     - Recipient Name
     - Street Address
     - City, State, Postal Code
     - Country
     - Phone Number
     - "Set as Default" checkbox
   - User clicks "Save Address"
   - New address appears in addresses list

5. **Change Password**
   - User clicks "Change Password" in Account Settings
   - Password change form appears
   - User enters:
     - Current Password
     - New Password (with strength indicator)
     - Confirm New Password
   - User clicks "Update Password"
   - Success message: "Password updated successfully"
   - User must re-login (if implemented)

6. **View Order History**
   - User clicks "Orders" link in profile or header menu
   - Redirected to `/orderList.jsp`
   - List of orders displayed with:
     - Order Number
     - Order Date
     - Status
     - Total Amount
     - "View Details" button
   - User can filter by status or date range

#### UX Considerations
- **Data Persistence**: Changes saved immediately
- **Validation**: Real-time validation on all fields
- **Confirmation**: Important actions (password change, account deletion) require confirmation
- **Feedback**: Clear success/error messages
- **Accessibility**: Keyboard navigation, screen reader support

---

### 3.2 Scenario: Account Deletion

**User Persona**: Customer wants to close account  
**Goal**: Permanently delete account  
**Context**: User in profile settings

#### Step-by-Step Flow

1. **Initiation**
   - User navigates to Account Settings in profile
   - User clicks "Delete Account" button
   - Warning modal appears

2. **Confirmation Dialog**
   - Modal shows:
     - Warning message: "Are you sure you want to delete your account?"
     - Consequences listed:
       - All order history will be archived
       - Saved addresses will be deleted
       - Account cannot be recovered
     - Checkbox: "I understand this action cannot be undone"
     - "Cancel" and "Delete Account" buttons

3. **Deletion Process**
   - User checks confirmation checkbox
   - User clicks "Delete Account" (button turns red)
   - Loading state: "Deleting account..."
   - Server processes soft delete
   - Session invalidated

4. **Completion**
   - Redirect to `/goodbye.jsp`
   - Thank you message displayed
   - Link to return to homepage

#### UX Considerations
- **Safety**: Multiple confirmation steps
- **Reversibility**: Soft delete allows data recovery (if needed)
- **Transparency**: Clear explanation of consequences
- **Finality**: Clear indication that action is permanent

---

## 4. Password Reset Scenario

### 4.1 Scenario: Forgot Password

**User Persona**: Customer forgot password, needs to reset  
**Goal**: Reset password to regain account access  
**Context**: User on login page, clicks "Forgot Password?"

#### Step-by-Step Flow

1. **Initiation**
   - User on `/login.jsp`
   - User clicks "Forgot Password?" link
   - Redirected to password reset page

2. **Email Entry**
   - Form asks for email address
   - User enters registered email
   - User clicks "Send Reset Link" (or answers security question)

3. **Security Question (if implemented)**
   - System shows security question
   - User enters answer
   - If correct: Password reset form appears
   - If incorrect: Error message, retry option

4. **Password Reset**
   - User enters new password
   - Password strength indicator shows
   - User confirms new password
   - User clicks "Reset Password"

5. **Completion**
   - Success message: "Password reset successfully"
   - Redirect to login page
   - User can now login with new password

#### UX Considerations
- **Security**: Secure reset process (questions or email link)
- **Feedback**: Clear instructions at each step
- **Error Handling**: Helpful error messages

---

## 5. Role-Based Access Control Scenarios

### 5.1 Scenario: Customer Access

**User Persona**: Regular customer  
**Goal**: Access customer-only features  
**Context**: Customer logged in

#### Available Features
- Browse products
- Add to cart
- Place orders
- View own order history
- Manage profile
- Submit product reviews
- View own reviews

#### Restricted Features
- Cannot access `/admin-dashboard.jsp` (redirected to homepage)
- Cannot access `/manage-users.jsp` (403 error)
- Cannot access `/manage-products.jsp` (403 error)
- Cannot view other users' information

#### UX Flow
- Customer attempts to access admin page
- System checks role
- If not authorized: Redirect to homepage with message "You don't have permission to access this page"
- Header shows customer menu (Profile, Orders, Logout)

---

### 5.2 Scenario: Staff Access

**User Persona**: Staff member  
**Goal**: Access staff features for order processing  
**Context**: Staff member logged in

#### Available Features
- All customer features
- View all orders
- Process orders
- View shipment information
- Access customer information
- View access logs
- Moderate product reviews
- Export data (CSV)

#### UX Flow
- Staff logs in
- Redirected to `/admin-dashboard.jsp`
- Dashboard shows:
  - Order statistics
  - Recent orders
  - Quick actions (Process Orders, View Access Logs)
- Header shows "Admin Dashboard" link
- Sidebar navigation for admin features

---

### 5.3 Scenario: Admin Access

**User Persona**: System administrator  
**Goal**: Full system access for management  
**Context**: Admin logged in

#### Available Features
- All staff features
- User management (CRUD)
- Product management (CRUD)
- System configuration
- Access log management
- Analytics and reporting
- Supplier management
- Data export and import

#### UX Flow
- Admin logs in
- Redirected to `/admin-dashboard.jsp`
- Dashboard shows comprehensive statistics
- Full admin menu available
- Can access all management pages
- Can perform all CRUD operations

---

## 6. Session Management Scenarios

### 6.1 Scenario: Session Timeout

**User Persona**: Any logged-in user  
**Goal**: Maintain security with session timeout  
**Context**: User inactive for extended period

#### Flow
1. User logged in, working on site
2. User becomes inactive (no activity for 30 minutes)
3. Session expires
4. User attempts action (e.g., add to cart)
5. System detects expired session
6. Redirect to login page with message: "Your session has expired. Please log in again."
7. User logs in, redirected back to previous page (if possible)

#### UX Considerations
- **Warning**: Optional warning before timeout (e.g., "Your session will expire in 2 minutes")
- **Recovery**: Preserve user's work (e.g., cart items, form data)
- **Transparency**: Clear message about session expiration

---

### 6.2 Scenario: Logout

**User Persona**: Any logged-in user  
**Goal**: Securely log out of account  
**Context**: User wants to end session

#### Flow
1. User clicks user menu in header
2. User clicks "Logout" option
3. Confirmation (optional): "Are you sure you want to log out?"
4. User confirms
5. Session invalidated
6. Redirect to `/goodbye.jsp`
7. Thank you message displayed
8. Link to return to homepage

#### UX Considerations
- **Security**: Complete session invalidation
- **Feedback**: Clear confirmation of logout
- **Navigation**: Easy return to homepage

---

## 7. Error Scenarios

### 7.1 Scenario: Registration Email Already Exists

**Flow**:
1. User enters email that's already registered
2. Real-time validation (if implemented) or on submit
3. Error message: "This email is already registered. Would you like to log in instead?"
4. Link to login page provided
5. Form retains other fields (except password)

### 7.2 Scenario: Login with Wrong Password

**Flow**:
1. User enters correct email, wrong password
2. User clicks "Sign In"
3. Error message: "Email or password is incorrect"
4. Password field cleared
5. Email field retained
6. "Forgot Password?" link highlighted

### 7.3 Scenario: Session Expired During Checkout

**Flow**:
1. User in checkout process
2. Session expires
3. User attempts to place order
4. Redirect to login with message: "Your session expired. Please log in to complete your order."
5. After login, redirect back to checkout
6. Cart items preserved (if possible)

---

## 8. Accessibility Considerations

### 8.1 Keyboard Navigation
- All forms navigable with Tab key
- Focus indicators visible
- Skip links for main content
- Keyboard shortcuts (if implemented)

### 8.2 Screen Reader Support
- All form fields have proper labels
- ARIA attributes for error messages
- ARIA live regions for dynamic content
- Semantic HTML structure

### 8.3 Visual Accessibility
- High contrast ratios (WCAG AA)
- Clear focus indicators
- Error messages with icons
- Loading states clearly visible

---

## 9. Mobile UX Considerations

### 9.1 Registration on Mobile
- Single column layout
- Large touch targets
- Auto-capitalization disabled for email
- Numeric keyboard for phone
- Smooth scrolling
- Sticky submit button

### 9.2 Login on Mobile
- Simplified form
- "Remember Me" easily accessible
- Quick access to "Forgot Password"
- Auto-fill support

### 9.3 Profile Management on Mobile
- Collapsible sections
- Swipe gestures for actions (if implemented)
- Bottom sheet for modals
- Sticky navigation

---

## 10. Performance Considerations

### 10.1 Registration
- Client-side validation for immediate feedback
- Server validation for security
- Optimistic UI updates
- Minimal page reloads

### 10.2 Login
- Fast authentication response
- Cached credentials (if "Remember Me")
- Quick redirect after login
- Minimal loading time

### 10.3 Profile Management
- Lazy loading of sections
- Incremental saves
- Optimistic updates
- Background sync

---

**End of User Management UX Scenarios**



---

**Document Version**: 1.0.0
**Status**: Published
**Audience**: Developers, Stakeholders
**Maintained By**: IoT Bay Documentation Team
