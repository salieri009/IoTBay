<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.User" %>

<% User sessionUser=(User) session.getAttribute("user");
   if (sessionUser==null || (!"staff".equalsIgnoreCase(sessionUser.getRole()) && !"admin".equalsIgnoreCase(sessionUser.getRole()))) {
       response.sendRedirect(request.getContextPath() + "/login.jsp"); return;
   }
   String csrfToken = utils.SecurityUtil.generateCSRFToken(request);
   User staffMember = (User) request.getAttribute("staffMember");
   if (staffMember == null) { response.sendError(404); return; }
   pageContext.setAttribute("csrfToken", csrfToken);
   pageContext.setAttribute("position", staffMember.getPosition() != null ? staffMember.getPosition() : "staff");
%>

<t:base title="Staff Details | IoT Bay">
    <section class="py-12 bg-gradient-to-br from-blue-50 via-white to-purple-50">
        <div class="container">
            <div class="max-w-3xl mx-auto">
                <a href="<c:url value='/admin/staff/'/>" class="text-neutral-500 hover:text-neutral-900 flex items-center gap-2 mb-4 text-sm">
                    &larr; Back to Staff
                </a>
                <div class="flex items-center justify-between">
                    <h1 class="text-display-md text-neutral-900">
                        Staff <span class="text-transparent bg-clip-text bg-gradient-to-r from-brand-primary to-brand-secondary">#${staffMember.id}</span>
                    </h1>
                    <a href="<c:url value='/admin/staff/edit/${staffMember.id}'/>" class="btn btn--primary">Edit</a>
                </div>
            </div>
        </div>
    </section>

    <section class="py-8">
        <div class="l-container">
            <div class="max-w-3xl mx-auto space-y-6">

                <!-- Staff Details -->
                <div class="bg-white rounded-xl shadow-sm border border-neutral-200 p-6">
                    <h2 class="text-lg font-semibold text-neutral-900 mb-4">Staff Details</h2>
                    <dl class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <dt class="text-sm text-neutral-500">Full Name</dt>
                            <dd class="text-sm font-medium text-neutral-900">${staffMember.firstName} ${staffMember.lastName}</dd>
                        </div>
                        <div>
                            <dt class="text-sm text-neutral-500">Email</dt>
                            <dd class="text-sm font-medium text-neutral-900">${staffMember.email}</dd>
                        </div>
                        <div>
                            <dt class="text-sm text-neutral-500">Phone</dt>
                            <dd class="text-sm font-medium text-neutral-900"><c:out value="${staffMember.phone}" default="—"/></dd>
                        </div>
                        <div>
                            <dt class="text-xs font-medium uppercase tracking-wide text-neutral-500 mb-0.5">Position</dt>
                            <dd>
                                <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-purple-100 text-purple-800">
                                    ${position}
                                </span>
                            </dd>
                        </div>
                        <div>
                            <dt class="text-xs font-medium uppercase tracking-wide text-neutral-500 mb-0.5">Status</dt>
                            <dd>
                                <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium ${staffMember.active ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'}">
                                    ${staffMember.active ? 'Active' : 'Inactive'}
                                </span>
                            </dd>
                        </div>
                        <div>
                            <dt class="text-sm text-neutral-500">Date of Birth</dt>
                            <dd class="text-sm font-medium text-neutral-900"><c:out value="${staffMember.dateOfBirth}" default="—"/></dd>
                        </div>
                        <div>
                            <dt class="text-xs font-medium uppercase tracking-wide text-neutral-500 mb-0.5">Address</dt>
                            <dd class="text-sm font-medium text-neutral-900">
                                <c:out value="${staffMember.addressLine1}"/>
                                <c:out value="${staffMember.addressLine2}"/>
                            </dd>
                        </div>
                        <div>
                            <dt class="text-sm text-neutral-500">Joined</dt>
                            <dd class="text-sm font-medium text-neutral-900"><c:out value="${staffMember.createdAt}" default="—"/></dd>
                        </div>
                    </dl>
                </div>

                <!-- Delete Action -->
                <div class="bg-white rounded-xl shadow-sm border border-red-200 p-6">
                    <h2 class="text-lg font-semibold text-red-700 mb-2">Danger Zone</h2>
                    <p class="text-sm text-neutral-600 mb-4">Deleting a staff member will cancel all their orders and remove their account permanently.</p>
                    <form action="<c:url value='/admin/staff/delete'/>" method="post"
                          onsubmit="return confirm('Permanently delete this staff member?');">
                        <input type="hidden" name="csrfToken" value="${csrfToken}">
                        <input type="hidden" name="user_id" value="${staffMember.id}">
                        <button type="submit" class="btn btn--error">Delete Staff Member</button>
                    </form>
                </div>
            </div>
        </div>
    </section>
</t:admin-base>
