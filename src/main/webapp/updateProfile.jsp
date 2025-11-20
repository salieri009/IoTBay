<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>

<t:base title="Update Profile - IoT Bay" description="Update your profile information">
    <main class="py-12 bg-neutral-50 min-h-screen">
        <div class="max-w-2xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="bg-white rounded-2xl shadow-sm border border-neutral-200 overflow-hidden">
                <div class="p-6 border-b border-neutral-200 flex justify-between items-center">
                    <div>
                        <h1 class="text-xl font-bold text-neutral-900">Update Profile</h1>
                        <p class="mt-1 text-sm text-neutral-500">Update your personal details</p>
                    </div>
                    <a href="profile.jsp" class="text-sm text-brand-primary hover:text-brand-primary-700 font-medium">
                        Back to Profile
                    </a>
                </div>
                
                <div class="p-6">
                    <c:if test="${not empty error}">
                        <div class="mb-6 bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded relative" role="alert">
                            <span class="block sm:inline">${error}</span>
                        </div>
                    </c:if>
                    
                    <c:if test="${not empty success}">
                        <div class="mb-6 bg-green-50 border border-green-200 text-green-700 px-4 py-3 rounded relative" role="alert">
                            <span class="block sm:inline">${success}</span>
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/api/Profiles" method="post" class="space-y-6">
                        <div class="grid grid-cols-1 gap-y-6 gap-x-4 sm:grid-cols-2">
                            <div class="sm:col-span-2">
                                <jsp:include page="/components/molecules/form-field/form-field.jsp">
                                    <jsp:param name="label" value="Email Address" />
                                    <jsp:param name="type" value="email" />
                                    <jsp:param name="name" value="email" />
                                    <jsp:param name="value" value="${user.email}" />
                                    <jsp:param name="disabled" value="true" />
                                    <jsp:param name="helpText" value="Email address cannot be changed" />
                                </jsp:include>
                            </div>

                            <div class="sm:col-span-1">
                                <jsp:include page="/components/molecules/form-field/form-field.jsp">
                                    <jsp:param name="label" value="First Name" />
                                    <jsp:param name="name" value="firstName" />
                                    <jsp:param name="value" value="${user.firstName}" />
                                    <jsp:param name="required" value="true" />
                                </jsp:include>
                            </div>

                            <div class="sm:col-span-1">
                                <jsp:include page="/components/molecules/form-field/form-field.jsp">
                                    <jsp:param name="label" value="Last Name" />
                                    <jsp:param name="name" value="lastName" />
                                    <jsp:param name="value" value="${user.lastName}" />
                                    <jsp:param name="required" value="true" />
                                </jsp:include>
                            </div>

                            <div class="sm:col-span-1">
                                <jsp:include page="/components/molecules/form-field/form-field.jsp">
                                    <jsp:param name="label" value="Phone Number" />
                                    <jsp:param name="type" value="tel" />
                                    <jsp:param name="name" value="phone" />
                                    <jsp:param name="value" value="${user.phone}" />
                                    <jsp:param name="required" value="true" />
                                </jsp:include>
                            </div>

                            <div class="sm:col-span-1">
                                <jsp:include page="/components/molecules/form-field/form-field.jsp">
                                    <jsp:param name="label" value="Date of Birth" />
                                    <jsp:param name="type" value="date" />
                                    <jsp:param name="name" value="dateOfBirth" />
                                    <jsp:param name="value" value="${user.dateOfBirth}" />
                                </jsp:include>
                            </div>

                            <div class="sm:col-span-2">
                                <jsp:include page="/components/molecules/form-field/form-field.jsp">
                                    <jsp:param name="label" value="Address Line 1" />
                                    <jsp:param name="name" value="addressLine1" />
                                    <jsp:param name="value" value="${user.addressLine1}" />
                                    <jsp:param name="required" value="true" />
                                </jsp:include>
                            </div>

                            <div class="sm:col-span-2">
                                <jsp:include page="/components/molecules/form-field/form-field.jsp">
                                    <jsp:param name="label" value="Address Line 2" />
                                    <jsp:param name="name" value="addressLine2" />
                                    <jsp:param name="value" value="${user.addressLine2}" />
                                </jsp:include>
                            </div>

                            <div class="sm:col-span-1">
                                <jsp:include page="/components/molecules/form-field/form-field.jsp">
                                    <jsp:param name="label" value="Postal Code" />
                                    <jsp:param name="name" value="postalCode" />
                                    <jsp:param name="value" value="${user.postalCode}" />
                                    <jsp:param name="required" value="true" />
                                </jsp:include>
                            </div>

                            <div class="sm:col-span-1">
                                <label for="paymentMethod" class="block text-sm font-medium text-neutral-700 mb-1">Payment Method</label>
                                <select id="paymentMethod" name="paymentMethod" class="block w-full rounded-md border-neutral-300 shadow-sm focus:border-brand-primary focus:ring-brand-primary sm:text-sm h-[42px]">
                                    <option value="">Select Method</option>
                                    <option value="CreditCard" ${user.paymentMethod == 'CreditCard' ? 'selected' : ''}>Credit Card</option>
                                    <option value="PayPal" ${user.paymentMethod == 'PayPal' ? 'selected' : ''}>PayPal</option>
                                    <option value="BankTransfer" ${user.paymentMethod == 'BankTransfer' ? 'selected' : ''}>Bank Transfer</option>
                                </select>
                            </div>
                        </div>

                        <div class="flex justify-end pt-4 border-t border-neutral-200">
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
    </main>
</t:base>
