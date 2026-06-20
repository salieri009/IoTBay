<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.User" %>

<% User sessionUser=(User) session.getAttribute("user");
   if (sessionUser==null || (!"staff".equalsIgnoreCase(sessionUser.getRole()) && !"admin".equalsIgnoreCase(sessionUser.getRole()))) {
       response.sendRedirect(request.getContextPath() + "/login.jsp"); return;
   }
   String csrfToken = utils.SecurityUtil.generateCSRFToken(request);
   User customer = (User) request.getAttribute("customer");
   if (customer == null) { response.sendError(404); return; }
%>

<t:admin-base title="Customer: <%= customer.getFirstName() %> <%= customer.getLastName() %> | IoT Bay" activeNav="users">
    <section class="py-8 bg-white border-b-2 border-brand-primary">
        <div class="l-container">
            <div class="max-w-3xl mx-auto">
                <a href="<c:url value='/admin/customer/'/>" class="text-neutral-500 hover:text-neutral-900 flex items-center gap-2 mb-4 text-sm">
                    &larr; Back to Customers
                </a>
                <div class="flex items-center justify-between">
                    <h1 class="text-display-md text-neutral-900">
                        Customer <span class="text-transparent bg-clip-text bg-gradient-to-r from-brand-primary to-brand-secondary">#<%= customer.getId() %></span>
                    </h1>
                    <a href="<c:url value='/admin/customer/edit/${customer.id}'/>" class="btn btn--primary">Edit</a>
                </div>
            </div>
        </div>
    </section>

    <section class="py-8">
        <div class="l-container">
            <div class="max-w-3xl mx-auto space-y-6">

                <!-- Customer Details -->
                <div class="bg-white rounded-xl shadow-sm border border-neutral-200 p-6">
                    <h2 class="text-lg font-semibold text-neutral-900 mb-4">Customer Details</h2>
                    <dl class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <dt class="text-sm text-neutral-500">Full Name</dt>
                            <dd class="text-sm font-medium text-neutral-900"><%= customer.getFirstName() %> <%= customer.getLastName() %></dd>
                        </div>
                        <div>
                            <dt class="text-sm text-neutral-500">Email</dt>
                            <dd class="text-sm font-medium text-neutral-900"><%= customer.getEmail() %></dd>
                        </div>
                        <div>
                            <dt class="text-sm text-neutral-500">Phone</dt>
                            <dd class="text-sm font-medium text-neutral-900"><%= customer.getPhone() != null ? customer.getPhone() : "—" %></dd>
                        </div>
                        <div>
                            <dt class="text-sm text-neutral-500">Customer Type</dt>
                            <dd>
                                <% String ctype = customer.getCustomerType() != null ? customer.getCustomerType() : "individual"; %>
                                <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium <%= "company".equals(ctype) ? "bg-blue-100 text-blue-800" : "bg-neutral-100 text-neutral-700" %>">
                                    <%= ctype %>
                                </span>
                            </dd>
                        </div>
                        <div>
                            <dt class="text-sm text-neutral-500">Status</dt>
                            <dd>
                                <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium <%= customer.isActive() ? "bg-green-100 text-green-800" : "bg-red-100 text-red-800" %>">
                                    <%= customer.isActive() ? "Active" : "Inactive" %>
                                </span>
                            </dd>
                        </div>
                        <div>
                            <dt class="text-sm text-neutral-500">Date of Birth</dt>
                            <dd class="text-sm font-medium text-neutral-900"><%= customer.getDateOfBirth() != null ? customer.getDateOfBirth().toString() : "—" %></dd>
                        </div>
                        <div>
                            <dt class="text-sm text-neutral-500">Postal Code</dt>
                            <dd class="text-sm font-medium text-neutral-900"><%= customer.getPostalCode() != null ? customer.getPostalCode() : "—" %></dd>
                        </div>
                        <div>
                            <dt class="text-sm text-neutral-500">Address</dt>
                            <dd class="text-sm font-medium text-neutral-900">
                                <%= customer.getAddressLine1() != null ? customer.getAddressLine1() : "" %>
                                <%= customer.getAddressLine2() != null ? " " + customer.getAddressLine2() : "" %>
                            </dd>
                        </div>
                        <div>
                            <dt class="text-sm text-neutral-500">Joined</dt>
                            <dd class="text-sm font-medium text-neutral-900"><%= customer.getCreatedAt() != null ? customer.getCreatedAt() : "—" %></dd>
                        </div>
                    </dl>
                </div>

                <!-- Delete Action -->
                <div class="bg-white rounded-xl shadow-sm border border-red-200 p-6">
                    <h2 class="text-lg font-semibold text-red-700 mb-2">Danger Zone</h2>
                    <p class="text-sm text-neutral-600 mb-4">Deleting a customer will cancel all their orders and remove their account permanently.</p>
                    <form action="<c:url value='/admin/customer/delete'/>" method="post"
                          onsubmit="return confirm('Permanently delete this customer? This cannot be undone.');">
                        <input type="hidden" name="csrfToken" value="<%= csrfToken %>">
                        <input type="hidden" name="user_id" value="<%= customer.getId() %>">
                        <button type="submit" class="btn btn--error">Delete Customer</button>
                    </form>
                </div>
            </div>
        </div>
    </section>
</t:admin-base>
