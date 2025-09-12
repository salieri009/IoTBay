<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="model.User" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<t:base title="My Account - IoT Bay" description="Manage your profile settings and history">
    <main class="profile-page">
        <div class="container">
            <!-- Profile Header -->
            <div class="profile-header">
                <div class="profile-avatar">
                    <div class="avatar-placeholder">
                        ${fn:toUpperCase(user.firstName.substring(0,1))}${fn:toUpperCase(user.lastName.substring(0,1))}
                    </div>
                </div>
                <div class="profile-info">
                    <h1 class="profile-name">${user.firstName} ${user.lastName}</h1>
                    <p class="profile-email">${user.email}</p>
                    <span class="profile-badge">Member since ${user.createdAt != null ? user.createdAt : '2024'}</span>
                </div>
            </div>
            
            <!-- Profile Navigation -->
            <div class="profile-layout">
                <div class="profile-sidebar">
                    <nav class="profile-nav">
                        <a href="#profile-info" class="profile-nav__link active" onclick="showSection('profile-info')">
                            <svg class="profile-nav__icon" fill="currentColor" viewBox="0 0 20 20">
                                <path fill-rule="evenodd" d="M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z" clip-rule="evenodd"></path>
                            </svg>
                            Personal Information
                        </a>
                        <a href="#account-settings" class="profile-nav__link" onclick="showSection('account-settings')">
                            <svg class="profile-nav__icon" fill="currentColor" viewBox="0 0 20 20">
                                <path fill-rule="evenodd" d="M11.49 3.17c-.38-1.56-2.6-1.56-2.98 0a1.532 1.532 0 01-2.286.948c-1.372-.836-2.942.734-2.106 2.106.54.886.061 2.042-.947 2.287-1.561.379-1.561 2.6 0 2.978a1.532 1.532 0 01.947 2.287c-.836 1.372.734 2.942 2.106 2.106a1.532 1.532 0 012.287.947c.379 1.561 2.6 1.561 2.978 0a1.533 1.533 0 012.287-.947c1.372.836 2.942-.734 2.106-2.106a1.533 1.533 0 01.947-2.287c1.561-.379 1.561-2.6 0-2.978a1.532 1.532 0 01-.947-2.287c.836-1.372-.734-2.942-2.106-2.106a1.532 1.532 0 01-2.287-.947zM10 13a3 3 0 100-6 3 3 0 000 6z" clip-rule="evenodd"></path>
                            </svg>
                            Account Settings
                        </a>
                        <a href="#order-history" class="profile-nav__link" onclick="showSection('order-history')">
                            <svg class="profile-nav__icon" fill="currentColor" viewBox="0 0 20 20">
                                <path d="M3 4a1 1 0 011-1h12a1 1 0 011 1v2a1 1 0 01-1 1H4a1 1 0 01-1-1V4zM3 10a1 1 0 011-1h6a1 1 0 011 1v6a1 1 0 01-1 1H4a1 1 0 01-1-1v-6zM14 9a1 1 0 00-1 1v6a1 1 0 001 1h2a1 1 0 001-1v-6a1 1 0 00-1-1h-2z"></path>
                            </svg>
                            Order History
                        </a>
                        <a href="#security" class="profile-nav__link" onclick="showSection('security')">
                            <svg class="profile-nav__icon" fill="currentColor" viewBox="0 0 20 20">
                                <path fill-rule="evenodd" d="M2.166 4.999A11.954 11.954 0 0010 1.944 11.954 11.954 0 0017.834 5c.11.65.166 1.32.166 2.001 0 5.225-3.34 9.67-8 11.317C5.34 16.67 2 12.225 2 7c0-.682.057-1.35.166-2.001zm11.541 3.708a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                            </svg>
                            Security
                        </a>
                    </nav>
                </div>
                
                <div class="profile-content">
                    <!-- Personal Information Section -->
                    <div id="profile-info" class="profile-section active">
                        <div class="section-header">
                            <h2 class="section-title">Personal Information</h2>
                            <p class="section-description">Manage your personal details and contact information</p>
                        </div>
                        
                        <form action="updateProfile" method="post" class="profile-form">
                            <div class="form__row">
                                <div class="form__group">
                                    <label for="firstName" class="form__label">First Name</label>
                                    <input type="text" id="firstName" name="firstName" class="form__input" 
                                           value="${user.firstName}" required>
                                </div>
                                <div class="form__group">
                                    <label for="lastName" class="form__label">Last Name</label>
                                    <input type="text" id="lastName" name="lastName" class="form__input" 
                                           value="${user.lastName}" required>
                                </div>
                            </div>
                            
                            <div class="form__group">
                                <label for="email" class="form__label">Email Address</label>
                                <input type="email" id="email" name="email" class="form__input" 
                                       value="${user.email}" required>
                            </div>
                            
                            <div class="form__group">
                                <label for="phone" class="form__label">Phone Number</label>
                                <input type="tel" id="phone" name="phone" class="form__input" 
                                       value="${empty user.phone ? '' : user.phone}">
                            </div>
                            
                            <div class="form__group">
                                <label for="dateOfBirth" class="form__label">Date of Birth</label>
                                <input type="date" id="dateOfBirth" name="dateOfBirth" class="form__input" 
                                       value="${empty user.dateOfBirth ? '' : user.dateOfBirth}">
                            </div>
                            
                            <div class="form__section">
                                <h3 class="form__section-title">Address Information</h3>
                                <div class="form__group">
                                    <label for="addressLine1" class="form__label">Address Line 1</label>
                                    <input type="text" id="addressLine1" name="addressLine1" class="form__input" 
                                           value="${empty user.addressLine1 ? '' : user.addressLine1}">
                                </div>
                                <div class="form__group">
                                    <label for="addressLine2" class="form__label">Address Line 2</label>
                                    <input type="text" id="addressLine2" name="addressLine2" class="form__input" 
                                           value="${empty user.addressLine2 ? '' : user.addressLine2}">
                                </div>
                                <div class="form__group">
                                    <label for="postalCode" class="form__label">Postal Code</label>
                                    <input type="text" id="postalCode" name="postalCode" class="form__input" 
                                           value="${empty user.postalCode ? '' : user.postalCode}">
                                </div>
                            </div>
                            
                            <div class="form__actions">
                                <button type="submit" class="btn btn--primary">Update Profile</button>
                                <button type="button" class="btn btn--outline" onclick="resetForm()">Reset</button>
                            </div>
                        </form>
                    </div>
                    
                    <!-- Account Settings Section -->
                    <div id="account-settings" class="profile-section">
                        <div class="section-header">
                            <h2 class="section-title">Account Settings</h2>
                            <p class="section-description">Manage your account preferences</p>
                        </div>
                        
                        <div class="settings-grid">
                            <div class="setting-card">
                                <div class="setting-card__header">
                                    <h3 class="setting-card__title">Payment Method</h3>
                                    <p class="setting-card__description">Manage your preferred payment method</p>
                                </div>
                                <div class="setting-card__content">
                                    <form action="updatePayment" method="post">
                                        <div class="form__group">
                                            <label for="paymentMethod" class="form__label">Preferred Payment Method</label>
                                            <select id="paymentMethod" name="paymentMethod" class="form__select">
                                                <option value="CreditCard" ${user.paymentMethod == 'CreditCard' ? 'selected' : ''}>Credit Card</option>
                                                <option value="PayPal" ${user.paymentMethod == 'PayPal' ? 'selected' : ''}>PayPal</option>
                                                <option value="BankTransfer" ${user.paymentMethod == 'BankTransfer' ? 'selected' : ''}>Bank Transfer</option>
                                            </select>
                                        </div>
                                        <button type="submit" class="btn btn--primary btn--sm">Update Payment Method</button>
                                    </form>
                                </div>
                            </div>
                            
                            <div class="setting-card">
                                <div class="setting-card__header">
                                    <h3 class="setting-card__title">Email Preferences</h3>
                                    <p class="setting-card__description">Choose what emails you want to receive</p>
                                </div>
                                <div class="setting-card__content">
                                    <div class="checkbox-group">
                                        <label class="checkbox">
                                            <input type="checkbox" checked>
                                            <span class="checkbox__mark"></span>
                                            <span class="checkbox__label">Order updates</span>
                                        </label>
                                        <label class="checkbox">
                                            <input type="checkbox" checked>
                                            <span class="checkbox__mark"></span>
                                            <span class="checkbox__label">Product recommendations</span>
                                        </label>
                                        <label class="checkbox">
                                            <input type="checkbox">
                                            <span class="checkbox__mark"></span>
                                            <span class="checkbox__label">Marketing emails</span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Order History Section -->
                    <div id="order-history" class="profile-section">
                        <div class="section-header">
                            <h2 class="section-title">Order History</h2>
                            <p class="section-description">View your past orders and their status</p>
                        </div>
                        
                        <div class="orders-container">
                            <div class="empty-state">
                                <div class="empty-state__icon">
                                    <svg fill="currentColor" viewBox="0 0 20 20">
                                        <path d="M3 4a1 1 0 011-1h12a1 1 0 011 1v2a1 1 0 01-1 1H4a1 1 0 01-1-1V4zM3 10a1 1 0 011-1h6a1 1 0 011 1v6a1 1 0 01-1 1H4a1 1 0 01-1-1v-6zM14 9a1 1 0 00-1 1v6a1 1 0 001 1h2a1 1 0 001-1v-6a1 1 0 00-1-1h-2z"></path>
                                    </svg>
                                </div>
                                <h3 class="empty-state__title">No orders yet</h3>
                                <p class="empty-state__description">
                                    When you place your first order, it will appear here.
                                </p>
                                <a href="search" class="btn btn--primary">Start Shopping</a>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Security Section -->
                    <div id="security" class="profile-section">
                        <div class="section-header">
                            <h2 class="section-title">Security</h2>
                            <p class="section-description">Manage your account security settings</p>
                        </div>
                        
                        <div class="security-cards">
                            <div class="setting-card">
                                <div class="setting-card__header">
                                    <h3 class="setting-card__title">Change Password</h3>
                                    <p class="setting-card__description">Update your password regularly for better security</p>
                                </div>
                                <div class="setting-card__content">
                                    <form action="changePassword" method="post">
                                        <div class="form__group">
                                            <label for="currentPassword" class="form__label">Current Password</label>
                                            <input type="password" id="currentPassword" name="currentPassword" class="form__input" required>
                                        </div>
                                        <div class="form__group">
                                            <label for="newPassword" class="form__label">New Password</label>
                                            <input type="password" id="newPassword" name="newPassword" class="form__input" required>
                                        </div>
                                        <div class="form__group">
                                            <label for="confirmPassword" class="form__label">Confirm New Password</label>
                                            <input type="password" id="confirmPassword" name="confirmPassword" class="form__input" required>
                                        </div>
                                        <button type="submit" class="btn btn--primary">Change Password</button>
                                    </form>
                                </div>
                            </div>
                            
                            <div class="setting-card setting-card--danger">
                                <div class="setting-card__header">
                                    <h3 class="setting-card__title">Delete Account</h3>
                                    <p class="setting-card__description">Permanently delete your account and all data</p>
                                </div>
                                <div class="setting-card__content">
                                    <p class="text-danger">This action cannot be undone. All your data will be permanently deleted.</p>
                                    <button type="button" class="btn btn--danger" onclick="confirmDeleteAccount()">
                                        Delete Account
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
    
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    <script>
        function showSection(sectionId) {
            // Hide all sections
            document.querySelectorAll('.profile-section').forEach(section => {
                section.classList.remove('active');
            });
            
            // Remove active class from all nav links
            document.querySelectorAll('.profile-nav__link').forEach(link => {
                link.classList.remove('active');
            });
            
            // Show selected section
            document.getElementById(sectionId).classList.add('active');
            
            // Add active class to clicked nav link
            event.target.closest('.profile-nav__link').classList.add('active');
        }
        
        function resetForm() {
            if (confirm('Are you sure you want to reset all changes?')) {
                document.querySelector('.profile-form').reset();
            }
        }
        
        function confirmDeleteAccount() {
            if (confirm('Are you sure you want to delete your account? This action cannot be undone.')) {
                if (confirm('This will permanently delete all your data. Are you absolutely sure?')) {
                    window.location.href = 'deleteaccount.jsp';
                }
            }
        }
        
        // Form submissions with AJAX
        document.querySelector('.profile-form')?.addEventListener('submit', function(e) {
            e.preventDefault();
            const formData = new FormData(this);
            const submitBtn = this.querySelector('button[type="submit"]');
            const originalText = submitBtn.textContent;
            
            submitBtn.textContent = 'Updating...';
            submitBtn.disabled = true;
            
            fetch(this.action, {
                method: 'POST',
                body: formData
            })
            .then(response => {
                if (response.ok) {
                    if (window.showToast) {
                        window.showToast('Profile updated successfully!', 'success');
                    }
                    submitBtn.textContent = 'Updated!';
                    setTimeout(() => {
                        submitBtn.textContent = originalText;
                        submitBtn.disabled = false;
                    }, 2000);
                } else {
                    throw new Error('Failed to update profile');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                if (window.showToast) {
                    window.showToast('Failed to update profile. Please try again.', 'error');
                }
                submitBtn.textContent = originalText;
                submitBtn.disabled = false;
            });
        });
    </script>
</t:base>
