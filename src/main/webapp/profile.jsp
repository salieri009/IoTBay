<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
            <%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>

                <c:if test="${empty sessionScope.user}">
                    <c:redirect url="login.jsp" />
                </c:if>

                <% // Generate CSRF token for form submissions String
                    csrfToken=utils.SecurityUtil.generateCSRFToken(request); pageContext.setAttribute("csrfToken",
                    csrfToken); %>

                    <t:base title="My Account - IoT Bay"
                        description="Manage your IoT Bay profile settings and account information">

                        <main class="py-12 bg-neutral-50 min-h-screen">
                            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                                <!-- Profile Header -->
                                <div
                                    class="bg-white rounded-2xl shadow-sm border border-neutral-200 p-6 mb-8 flex flex-col md:flex-row items-center gap-6">
                                    <div class="relative">
                                        <div
                                            class="w-24 h-24 rounded-full bg-brand-primary-100 flex items-center justify-center text-2xl font-bold text-brand-primary border-4 border-white shadow-sm">
                                            ${fn:toUpperCase(fn:substring(user.firstName, 0,
                                            1))}${fn:toUpperCase(fn:substring(user.lastName, 0, 1))}
                                        </div>
                                        <div class="absolute bottom-0 right-0 w-6 h-6 bg-success rounded-full border-2 border-white"
                                            title="Active"></div>
                                    </div>
                                    <div class="text-center md:text-left flex-1">
                                        <h1 class="text-2xl font-bold text-neutral-900">${user.firstName}
                                            ${user.lastName}</h1>
                                        <p class="text-neutral-600">${user.email}</p>
                                        <div
                                            class="flex flex-wrap items-center justify-center md:justify-start gap-3 mt-3">
                                            <span
                                                class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-neutral-100 text-neutral-800">
                                                Member since ${not empty user.createdAt ? user.createdAt : '2024'}
                                            </span>
                                            <c:if test="${user.role == 'staff'}">
                                                <span
                                                    class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-brand-secondary-100 text-brand-secondary-800">
                                                    <svg class="w-3 h-3 mr-1" fill="currentColor" viewBox="0 0 20 20">
                                                        <path fill-rule="evenodd"
                                                            d="M6 6V5a3 3 0 013-3h2a3 3 0 013 3v1h2a2 2 0 012 2v3.57A22.952 22.952 0 0110 13a22.95 22.95 0 01-8-1.43V8a2 2 0 012-2h2zm2-1a1 1 0 011-1h2a1 1 0 011 1v1H8V5zm1 5a1 1 0 011-1h.01a1 1 0 110 2H10a1 1 0 01-1-1z"
                                                            clip-rule="evenodd"></path>
                                                    </svg>
                                                    Staff Member
                                                </span>
                                            </c:if>
                                        </div>
                                    </div>
                                    <div class="flex gap-3">
                                        <jsp:include page="/components/atoms/button/button.jsp">
                                            <jsp:param name="type" value="outline" />
                                            <jsp:param name="text" value="Log Out" />
                                            <jsp:param name="onclick" value="window.location.href='logout.jsp'" />
                                        </jsp:include>
                                    </div>
                                </div>

                                <div class="grid grid-cols-1 lg:grid-cols-4 gap-8">
                                    <!-- Profile Sidebar -->
                                    <div class="lg:col-span-1">
                                        <nav class="space-y-1" aria-label="Sidebar">
                                            <a href="#profile-info" onclick="showSection('profile-info', event)"
                                                class="profile-nav-link active group flex items-center px-3 py-2 text-sm font-medium rounded-md bg-brand-primary-50 text-brand-primary hover:text-brand-primary hover:bg-brand-primary-50 transition-colors">
                                                <svg class="flex-shrink-0 -ml-1 mr-3 h-6 w-6 text-brand-primary"
                                                    fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2"
                                                        d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                                                </svg>
                                                <span class="truncate">Personal Information</span>
                                            </a>

                                            <a href="#account-settings" onclick="showSection('account-settings', event)"
                                                class="profile-nav-link group flex items-center px-3 py-2 text-sm font-medium rounded-md text-neutral-600 hover:bg-neutral-50 hover:text-neutral-900 transition-colors">
                                                <svg class="flex-shrink-0 -ml-1 mr-3 h-6 w-6 text-neutral-400 group-hover:text-neutral-500"
                                                    fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2"
                                                        d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z" />
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                                                </svg>
                                                <span class="truncate">Account Settings</span>
                                            </a>

                                            <a href="#order-history" onclick="showSection('order-history', event)"
                                                class="profile-nav-link group flex items-center px-3 py-2 text-sm font-medium rounded-md text-neutral-600 hover:bg-neutral-50 hover:text-neutral-900 transition-colors">
                                                <svg class="flex-shrink-0 -ml-1 mr-3 h-6 w-6 text-neutral-400 group-hover:text-neutral-500"
                                                    fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2"
                                                        d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10" />
                                                </svg>
                                                <span class="truncate">Order History</span>
                                            </a>

                                            <a href="#security" onclick="showSection('security', event)"
                                                class="profile-nav-link group flex items-center px-3 py-2 text-sm font-medium rounded-md text-neutral-600 hover:bg-neutral-50 hover:text-neutral-900 transition-colors">
                                                <svg class="flex-shrink-0 -ml-1 mr-3 h-6 w-6 text-neutral-400 group-hover:text-neutral-500"
                                                    fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2"
                                                        d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" />
                                                </svg>
                                                <span class="truncate">Security</span>
                                            </a>

                                            <c:if test="${user.role == 'staff'}">
                                                <div class="pt-4 mt-4 border-t border-neutral-200">
                                                    <p
                                                        class="px-3 text-xs font-semibold text-neutral-500 uppercase tracking-wider mb-2">
                                                        Staff</p>
                                                    <a href="#staff-tools" onclick="showSection('staff-tools', event)"
                                                        class="profile-nav-link group flex items-center px-3 py-2 text-sm font-medium rounded-md text-neutral-600 hover:bg-neutral-50 hover:text-neutral-900 transition-colors">
                                                        <svg class="flex-shrink-0 -ml-1 mr-3 h-6 w-6 text-neutral-400 group-hover:text-neutral-500"
                                                            fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                            <path stroke-linecap="round" stroke-linejoin="round"
                                                                stroke-width="2"
                                                                d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2" />
                                                        </svg>
                                                        <span class="truncate">Staff Tools</span>
                                                    </a>
                                                </div>
                                            </c:if>
                                        </nav>
                                    </div>

                                    <!-- Profile Content -->
                                    <div class="lg:col-span-3 space-y-6">
                                        <!-- Personal Information Section -->
                                        <div id="profile-info" class="profile-section block">
                                            <div
                                                class="bg-white rounded-2xl shadow-sm border border-neutral-200 overflow-hidden">
                                                <div class="p-6 border-b border-neutral-200">
                                                    <h2 class="text-lg font-medium text-neutral-900">Personal
                                                        Information</h2>
                                                    <p class="mt-1 text-sm text-neutral-500">Manage your personal
                                                        details and contact information</p>
                                                </div>

                                                <div class="p-6">
                                                    <form action="updateProfile" method="post"
                                                        class="profile-form space-y-6">
                                                        <input type="hidden" name="csrfToken" value="${csrfToken}" />
                                                        <div class="grid grid-cols-1 gap-y-6 gap-x-4 sm:grid-cols-2">
                                                            <div class="sm:col-span-1">
                                                                <jsp:include
                                                                    page="/components/molecules/form-field/form-field.jsp">
                                                                    <jsp:param name="label" value="First Name" />
                                                                    <jsp:param name="name" value="firstName" />
                                                                    <jsp:param name="value" value="${user.firstName}" />
                                                                    <jsp:param name="required" value="true" />
                                                                </jsp:include>
                                                            </div>
                                                            <div class="sm:col-span-1">
                                                                <jsp:include
                                                                    page="/components/molecules/form-field/form-field.jsp">
                                                                    <jsp:param name="label" value="Last Name" />
                                                                    <jsp:param name="name" value="lastName" />
                                                                    <jsp:param name="value" value="${user.lastName}" />
                                                                    <jsp:param name="required" value="true" />
                                                                </jsp:include>
                                                            </div>

                                                            <div class="sm:col-span-2">
                                                                <jsp:include
                                                                    page="/components/molecules/form-field/form-field.jsp">
                                                                    <jsp:param name="label" value="Email Address" />
                                                                    <jsp:param name="type" value="email" />
                                                                    <jsp:param name="name" value="email" />
                                                                    <jsp:param name="value" value="${user.email}" />
                                                                    <jsp:param name="required" value="true" />
                                                                    <jsp:param name="readonly" value="true" />
                                                                    <jsp:param name="helpText"
                                                                        value="Contact support to change your email address" />
                                                                </jsp:include>
                                                            </div>

                                                            <div class="sm:col-span-1">
                                                                <jsp:include
                                                                    page="/components/molecules/form-field/form-field.jsp">
                                                                    <jsp:param name="label" value="Phone Number" />
                                                                    <jsp:param name="type" value="tel" />
                                                                    <jsp:param name="name" value="phone" />
                                                                    <jsp:param name="value"
                                                                        value="${empty user.phone ? '' : user.phone}" />
                                                                </jsp:include>
                                                            </div>

                                                            <div class="sm:col-span-1">
                                                                <jsp:include
                                                                    page="/components/molecules/form-field/form-field.jsp">
                                                                    <jsp:param name="label" value="Date of Birth" />
                                                                    <jsp:param name="type" value="date" />
                                                                    <jsp:param name="name" value="dateOfBirth" />
                                                                    <jsp:param name="value"
                                                                        value="${empty user.dateOfBirth ? '' : user.dateOfBirth}" />
                                                                </jsp:include>
                                                            </div>
                                                        </div>

                                                        <div class="pt-6 border-t border-neutral-200">
                                                            <h3 class="text-base font-medium text-neutral-900 mb-4">
                                                                Address Information</h3>
                                                            <div
                                                                class="grid grid-cols-1 gap-y-6 gap-x-4 sm:grid-cols-2">
                                                                <div class="sm:col-span-2">
                                                                    <jsp:include
                                                                        page="/components/molecules/form-field/form-field.jsp">
                                                                        <jsp:param name="label"
                                                                            value="Address Line 1" />
                                                                        <jsp:param name="name" value="addressLine1" />
                                                                        <jsp:param name="value"
                                                                            value="${empty user.addressLine1 ? '' : user.addressLine1}" />
                                                                    </jsp:include>
                                                                </div>
                                                                <div class="sm:col-span-2">
                                                                    <jsp:include
                                                                        page="/components/molecules/form-field/form-field.jsp">
                                                                        <jsp:param name="label"
                                                                            value="Address Line 2" />
                                                                        <jsp:param name="name" value="addressLine2" />
                                                                        <jsp:param name="value"
                                                                            value="${empty user.addressLine2 ? '' : user.addressLine2}" />
                                                                    </jsp:include>
                                                                </div>
                                                                <div class="sm:col-span-1">
                                                                    <jsp:include
                                                                        page="/components/molecules/form-field/form-field.jsp">
                                                                        <jsp:param name="label" value="Postal Code" />
                                                                        <jsp:param name="name" value="postalCode" />
                                                                        <jsp:param name="value"
                                                                            value="${empty user.postalCode ? '' : user.postalCode}" />
                                                                    </jsp:include>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="flex justify-end gap-3 pt-4">
                                                            <jsp:include page="/components/atoms/button/button.jsp">
                                                                <jsp:param name="type" value="outline" />
                                                                <jsp:param name="text" value="Reset" />
                                                                <jsp:param name="onclick" value="resetForm()" />
                                                            </jsp:include>
                                                            <jsp:include page="/components/atoms/button/button.jsp">
                                                                <jsp:param name="type" value="primary" />
                                                                <jsp:param name="htmlType" value="submit" />
                                                                <jsp:param name="text" value="Save Changes" />
                                                            </jsp:include>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Account Settings Section -->
                                        <div id="account-settings" class="profile-section hidden">
                                            <div
                                                class="bg-white rounded-2xl shadow-sm border border-neutral-200 overflow-hidden mb-6">
                                                <div class="p-6 border-b border-neutral-200">
                                                    <h2 class="text-lg font-medium text-neutral-900">Payment Method</h2>
                                                    <p class="mt-1 text-sm text-neutral-500">Manage your preferred
                                                        payment method</p>
                                                </div>
                                                <div class="p-6">
                                                    <form action="updatePayment" method="post" class="space-y-4">
                                                        <input type="hidden" name="csrfToken" value="${csrfToken}" />
                                                        <div class="max-w-md">
                                                            <label for="paymentMethod"
                                                                class="block text-sm font-medium text-neutral-700 mb-1">Preferred
                                                                Payment Method</label>
                                                            <select id="paymentMethod" name="paymentMethod"
                                                                class="block w-full rounded-md border-neutral-300 shadow-sm focus:border-brand-primary focus:ring-brand-primary sm:text-sm">
                                                                <option value="CreditCard"
                                                                    ${user.paymentMethod=='CreditCard' ? 'selected' : ''
                                                                    }>Credit Card</option>
                                                                <option value="PayPal" ${user.paymentMethod=='PayPal'
                                                                    ? 'selected' : '' }>PayPal</option>
                                                                <option value="BankTransfer"
                                                                    ${user.paymentMethod=='BankTransfer' ? 'selected'
                                                                    : '' }>Bank Transfer</option>
                                                            </select>
                                                        </div>
                                                        <div class="flex justify-end">
                                                            <jsp:include page="/components/atoms/button/button.jsp">
                                                                <jsp:param name="type" value="primary" />
                                                                <jsp:param name="size" value="small" />
                                                                <jsp:param name="htmlType" value="submit" />
                                                                <jsp:param name="text" value="Update Payment Method" />
                                                            </jsp:include>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>

                                            <div
                                                class="bg-white rounded-2xl shadow-sm border border-neutral-200 overflow-hidden">
                                                <div class="p-6 border-b border-neutral-200">
                                                    <h2 class="text-lg font-medium text-neutral-900">Preferences</h2>
                                                    <p class="mt-1 text-sm text-neutral-500">Manage your notification
                                                        and privacy settings</p>
                                                </div>
                                                <div class="p-6 space-y-6">
                                                    <div>
                                                        <h3 class="text-sm font-medium text-neutral-900 mb-3">Email
                                                            Notifications</h3>
                                                        <div class="space-y-3">
                                                            <label class="flex items-center">
                                                                <input type="checkbox"
                                                                    class="h-4 w-4 text-brand-primary focus:ring-brand-primary border-neutral-300 rounded"
                                                                    checked>
                                                                <span class="ml-2 text-sm text-neutral-700">Order
                                                                    updates</span>
                                                            </label>
                                                            <label class="flex items-center">
                                                                <input type="checkbox"
                                                                    class="h-4 w-4 text-brand-primary focus:ring-brand-primary border-neutral-300 rounded"
                                                                    checked>
                                                                <span class="ml-2 text-sm text-neutral-700">Product
                                                                    recommendations</span>
                                                            </label>
                                                            <label class="flex items-center">
                                                                <input type="checkbox"
                                                                    class="h-4 w-4 text-brand-primary focus:ring-brand-primary border-neutral-300 rounded">
                                                                <span class="ml-2 text-sm text-neutral-700">Marketing
                                                                    emails</span>
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Order History Section -->
                                        <div id="order-history" class="profile-section hidden">
                                            <div
                                                class="bg-white rounded-2xl shadow-sm border border-neutral-200 overflow-hidden">
                                                <div class="p-6 border-b border-neutral-200">
                                                    <h2 class="text-lg font-medium text-neutral-900">Order History</h2>
                                                    <p class="mt-1 text-sm text-neutral-500">View your past orders and
                                                        their status</p>
                                                </div>
                                                <div class="p-12 text-center">
                                                    <div class="mx-auto h-12 w-12 text-neutral-400">
                                                        <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                            <path stroke-linecap="round" stroke-linejoin="round"
                                                                stroke-width="2"
                                                                d="M16 11V7a4 4 0 00-8 0v4M5 9h14l-1 12H6L5 9z" />
                                                        </svg>
                                                    </div>
                                                    <h3 class="mt-2 text-sm font-medium text-neutral-900">No orders yet
                                                    </h3>
                                                    <p class="mt-1 text-sm text-neutral-500">When you place your first
                                                        order, it will appear here.</p>
                                                    <div class="mt-6">
                                                        <a href="${pageContext.request.contextPath}/browse.jsp"
                                                            class="inline-flex items-center px-4 py-2 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-brand-primary hover:bg-brand-primary-600 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-brand-primary">
                                                            Start Shopping
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Security Section -->
                                        <div id="security" class="profile-section hidden">
                                            <div
                                                class="bg-white rounded-2xl shadow-sm border border-neutral-200 overflow-hidden mb-6">
                                                <div class="p-6 border-b border-neutral-200">
                                                    <h2 class="text-lg font-medium text-neutral-900">Change Password
                                                    </h2>
                                                    <p class="mt-1 text-sm text-neutral-500">Update your password
                                                        regularly for better security</p>
                                                </div>
                                                <div class="p-6">
                                                    <form action="changePassword" method="post"
                                                        class="space-y-4 max-w-md">
                                                        <input type="hidden" name="csrfToken" value="${csrfToken}" />
                                                        <jsp:include
                                                            page="/components/molecules/form-field/form-field.jsp">
                                                            <jsp:param name="label" value="Current Password" />
                                                            <jsp:param name="type" value="password" />
                                                            <jsp:param name="name" value="currentPassword" />
                                                            <jsp:param name="required" value="true" />
                                                        </jsp:include>
                                                        <jsp:include
                                                            page="/components/molecules/form-field/form-field.jsp">
                                                            <jsp:param name="label" value="New Password" />
                                                            <jsp:param name="type" value="password" />
                                                            <jsp:param name="name" value="newPassword" />
                                                            <jsp:param name="required" value="true" />
                                                        </jsp:include>
                                                        <jsp:include
                                                            page="/components/molecules/form-field/form-field.jsp">
                                                            <jsp:param name="label" value="Confirm New Password" />
                                                            <jsp:param name="type" value="password" />
                                                            <jsp:param name="name" value="confirmPassword" />
                                                            <jsp:param name="required" value="true" />
                                                        </jsp:include>
                                                        <div class="flex justify-end">
                                                            <jsp:include page="/components/atoms/button/button.jsp">
                                                                <jsp:param name="type" value="primary" />
                                                                <jsp:param name="htmlType" value="submit" />
                                                                <jsp:param name="text" value="Change Password" />
                                                            </jsp:include>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>

                                            <div
                                                class="bg-red-50 rounded-2xl shadow-sm border border-red-200 overflow-hidden">
                                                <div class="p-6 border-b border-red-200">
                                                    <h2 class="text-lg font-medium text-red-900">Delete Account</h2>
                                                    <p class="mt-1 text-sm text-red-700">Permanently delete your account
                                                        and all data</p>
                                                </div>
                                                <div class="p-6">
                                                    <p class="text-sm text-red-600 mb-4">This action cannot be undone.
                                                        All your data will be permanently deleted.</p>
                                                    <button type="button" onclick="confirmDeleteAccount()"
                                                        class="inline-flex items-center px-4 py-2 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-red-600 hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500">
                                                        Delete Account
                                                    </button>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Staff Tools Section -->
                                        <c:if test="${user.role == 'staff'}">
                                            <div id="staff-tools" class="profile-section hidden">
                                                <div
                                                    class="bg-white rounded-2xl shadow-sm border border-neutral-200 overflow-hidden">
                                                    <div class="p-6 border-b border-neutral-200">
                                                        <h2 class="text-lg font-medium text-neutral-900">Staff Tools
                                                        </h2>
                                                        <p class="mt-1 text-sm text-neutral-500">Quick access to
                                                            management functions</p>
                                                    </div>
                                                    <div class="p-6">
                                                        <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                                                            <a href="${pageContext.request.contextPath}/reports-dashboard.jsp"
                                                                class="block p-4 border border-neutral-200 rounded-lg hover:border-brand-primary hover:bg-brand-primary-50 transition-colors group">
                                                                <div class="flex items-center">
                                                                    <div
                                                                        class="flex-shrink-0 bg-brand-primary-100 rounded-md p-3 group-hover:bg-white transition-colors">
                                                                        <svg class="h-6 w-6 text-brand-primary"
                                                                            fill="none" stroke="currentColor"
                                                                            viewBox="0 0 24 24">
                                                                            <path stroke-linecap="round"
                                                                                stroke-linejoin="round" stroke-width="2"
                                                                                d="M9 17v-2m3 2v-4m3 4v-6m2 10H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                                                                        </svg>
                                                                    </div>
                                                                    <div class="ml-4">
                                                                        <h3
                                                                            class="text-lg font-medium text-neutral-900 group-hover:text-brand-primary">
                                                                            Reports</h3>
                                                                        <p class="mt-1 text-sm text-neutral-500">View
                                                                            sales and inventory reports</p>
                                                                    </div>
                                                                </div>
                                                            </a>

                                                            <a href="${pageContext.request.contextPath}/orderhistory"
                                                                class="block p-4 border border-neutral-200 rounded-lg hover:border-brand-primary hover:bg-brand-primary-50 transition-colors group">
                                                                <div class="flex items-center">
                                                                    <div
                                                                        class="flex-shrink-0 bg-brand-primary-100 rounded-md p-3 group-hover:bg-white transition-colors">
                                                                        <svg class="h-6 w-6 text-brand-primary"
                                                                            fill="none" stroke="currentColor"
                                                                            viewBox="0 0 24 24">
                                                                            <path stroke-linecap="round"
                                                                                stroke-linejoin="round" stroke-width="2"
                                                                                d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2" />
                                                                        </svg>
                                                                    </div>
                                                                    <div class="ml-4">
                                                                        <h3
                                                                            class="text-lg font-medium text-neutral-900 group-hover:text-brand-primary">
                                                                            Orders</h3>
                                                                        <p class="mt-1 text-sm text-neutral-500">Manage
                                                                            customer orders</p>
                                                                    </div>
                                                                </div>
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </main>

                        <script>
                            function showSection(sectionId, event) {
                                if (event) event.preventDefault();

                                // Hide all sections
                                document.querySelectorAll('.profile-section').forEach(section => {
                                    section.classList.add('hidden');
                                    section.classList.remove('block');
                                });

                                // Remove active class from all nav links
                                document.querySelectorAll('.profile-nav-link').forEach(link => {
                                    link.classList.remove('active', 'bg-brand-primary-50', 'text-brand-primary');
                                    link.classList.add('text-neutral-600', 'hover:bg-neutral-50', 'hover:text-neutral-900');

                                    // Reset icon colors
                                    const icon = link.querySelector('svg');
                                    if (icon) {
                                        icon.classList.remove('text-brand-primary');
                                        icon.classList.add('text-neutral-400', 'group-hover:text-neutral-500');
                                    }
                                });

                                // Show selected section
                                const selectedSection = document.getElementById(sectionId);
                                if (selectedSection) {
                                    selectedSection.classList.remove('hidden');
                                    selectedSection.classList.add('block');
                                }

                                // Add active class to clicked nav link
                                const activeLink = document.querySelector(`a[href="#${sectionId}"]`);
                                if (activeLink) {
                                    activeLink.classList.add('active', 'bg-brand-primary-50', 'text-brand-primary');
                                    activeLink.classList.remove('text-neutral-600', 'hover:bg-neutral-50', 'hover:text-neutral-900');

                                    // Set icon color
                                    const icon = activeLink.querySelector('svg');
                                    if (icon) {
                                        icon.classList.add('text-brand-primary');
                                        icon.classList.remove('text-neutral-400', 'group-hover:text-neutral-500');
                                    }
                                }
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

                            // Handle hash in URL for direct linking to sections
                            document.addEventListener('DOMContentLoaded', function () {
                                const hash = window.location.hash.substring(1);
                                if (hash && document.getElementById(hash)) {
                                    showSection(hash);
                                }
                            });
                        </script>
                    </t:base>