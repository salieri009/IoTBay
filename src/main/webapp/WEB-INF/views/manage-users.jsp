<jsp:body>
    <!-- Page Header -->
    <section class="py-12 bg-gradient-to-br from-blue-50 via-white to-purple-50">
        <div class="container">
            <div class="max-w-6xl mx-auto">
                <div class="flex items-center justify-between">
                    <div>
                        <h1 class="text-display-lg text-neutral-900 mb-2">
                            Manage <span
                                class="text-transparent bg-clip-text bg-gradient-to-r from-brand-primary to-brand-secondary">Users</span>
                        </h1>
                        <p class="text-lg text-neutral-600">
                            Manage customer accounts and user
                            permissions
                        </p>
                    </div>
                    <div class="flex items-center gap-3">
                        <jsp:include page="/components/atoms/button/button.jsp">
                            <jsp:param name="text" value="Export Users" />
                            <jsp:param name="type" value="secondary" />
                            <jsp:param name="icon" value="download" />
                            <jsp:param name="onclick"
                                value="window.location.href='${pageContext.request.contextPath}/api/dataManagement/exportUsers'" />
                        </jsp:include>

                        <jsp:include page="/components/atoms/button/button.jsp">
                            <jsp:param name="text" value="Add User" />
                            <jsp:param name="type" value="primary" />
                            <jsp:param name="icon" value="plus" />
                            <jsp:param name="href" value="${pageContext.request.contextPath}/api/manage/users/form" />
                        </jsp:include>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Users Management -->
    <section class="py-12">
        <div class="container">
            <div class="max-w-6xl mx-auto">
                <!-- Filters and Search -->
                <div class="card p-6 mb-8">
                    <div class="flex flex-col md:flex-row gap-4 items-center">
                        <div class="flex-1">
                            <div class="relative">
                                <input type="text" placeholder="Search users..." class="form-input pr-10">
                                <svg class="absolute right-3 top-1/2 transform -translate-y-1/2 w-4 h-4 text-neutral-500"
                                    fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z">
                                    </path>
                                </svg>
                            </div>
                        </div>
                        <div class="flex items-center gap-3">
                            <select class="form-select">
                                <option>All Roles</option>
                                <option>Customer</option>
                                <option>Staff</option>
                            </select>
                            <select class="form-select">
                                <option>All Status</option>
                                <option>Active</option>
                                <option>Inactive</option>
                            </select>
                            <jsp:include page="/components/atoms/button/button.jsp">
                                <jsp:param name="text" value="Filter" />
                                <jsp:param name="type" value="outline" />
                            </jsp:include>
                        </div>
                    </div>
                </div>

                <!-- Users Table -->
                <div class="card overflow-hidden">
                    <div class="overflow-x-auto">
                        <table class="w-full">
                            <thead class="bg-neutral-50">
                                <tr>
                                    <th class="text-left py-4 px-6 font-medium text-neutral-700">
                                        <input type="checkbox" class="rounded border-neutral-300">
                                    </th>
                                    <th class="text-left py-4 px-6 font-medium text-neutral-700">
                                        User</th>
                                    <th class="text-left py-4 px-6 font-medium text-neutral-700">
                                        Email</th>
                                    <th class="text-left py-4 px-6 font-medium text-neutral-700">
                                        Role</th>
                                    <th class="text-left py-4 px-6 font-medium text-neutral-700">
                                        Status</th>
                                    <th class="text-left py-4 px-6 font-medium text-neutral-700">
                                        Joined</th>
                                    <th class="text-left py-4 px-6 font-medium text-neutral-700">
                                        Actions</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-neutral-200">
                                <c:choose>
                                    <c:when test="${not empty users}">
                                        <c:forEach var="userItem" items="${users}">
                                            <tr class="hover:bg-neutral-50">
                                                <td class="py-4 px-6">
                                                    <input type="checkbox" class="rounded border-neutral-300">
                                                </td>
                                                <td class="py-4 px-6">
                                                    <div class="flex items-center gap-3">
                                                        <div
                                                            class="w-10 h-10 bg-gradient-to-br from-blue-500 to-purple-500 rounded-full flex items-center justify-center text-white font-semibold text-sm">
                                                            <c:choose>
                                                                <c:when
                                                                    test="${not empty userItem.firstName && not empty userItem.lastName}">
                                                                    ${fn:toUpperCase(fn:substring(userItem.firstName,
                                                                    0,
                                                                    1))}${fn:toUpperCase(fn:substring(userItem.lastName,
                                                                    0,
                                                                    1))}
                                                                </c:when>
                                                                <c:when test="${not empty userItem.firstName}">
                                                                    ${fn:toUpperCase(fn:substring(userItem.firstName,
                                                                    0,
                                                                    1))}
                                                                </c:when>
                                                                <c:otherwise>
                                                                    U
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                        <div>
                                                            <p class="font-medium text-neutral-900">
                                                                ${userItem.firstName
                                                                != null
                                                                ?
                                                                userItem.firstName
                                                                : ''}
                                                                ${userItem.lastName
                                                                != null
                                                                ?
                                                                userItem.lastName
                                                                : ''}
                                                            </p>
                                                            <p class="text-sm text-neutral-600">
                                                                ID:
                                                                ${userItem.id}
                                                            </p>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td class="py-4 px-6">
                                                    <p class="text-neutral-900">
                                                        ${userItem.email}
                                                    </p>
                                                    <p class="text-sm text-neutral-600">
                                                        ${userItem.phoneNumber
                                                        != null ?
                                                        userItem.phoneNumber
                                                        : 'N/A'}</p>
                                                </td>
                                                <td class="py-4 px-6">
                                                    <jsp:include page="/components/atoms/badge/badge.jsp">
                                                        <jsp:param name="text" value="${userItem.role}" />
                                                        <jsp:param name="type"
                                                            value="${userItem.role eq 'staff' || userItem.role eq 'admin' ? 'info' : 'neutral'}" />
                                                    </jsp:include>
                                                </td>
                                                <td class="py-4 px-6">
                                                    <jsp:include page="/components/atoms/badge/badge.jsp">
                                                        <jsp:param name="text"
                                                            value="${userItem.isActive ? 'Active' : 'Inactive'}" />
                                                        <jsp:param name="type"
                                                            value="${userItem.isActive ? 'success' : 'warning'}" />
                                                    </jsp:include>
                                                </td>
                                                <td class="py-4 px-6">
                                                    <p class="text-neutral-900">
                                                        <c:if test="${userItem.createdAt != null}">
                                                            <fmt:formatDate value="${userItem.createdAt}"
                                                                pattern="MMM dd, yyyy" />
                                                        </c:if>
                                                        <c:if test="${userItem.createdAt == null}">
                                                            N/A</c:if>
                                                    </p>
                                                </td>
                                                <td class="py-4 px-6">
                                                    <div class="flex items-center gap-2">
                                                        <jsp:include page="/components/atoms/button/button.jsp">
                                                            <jsp:param name="type" value="ghost" />
                                                            <jsp:param name="size" value="small" />
                                                            <jsp:param name="icon" value="pencil" />
                                                            <jsp:param name="href"
                                                                value="${pageContext.request.contextPath}/manage/users/update?id=${userItem.id}" />
                                                            <jsp:param name="ariaLabel" value="Edit User" />
                                                        </jsp:include>

                                                        <jsp:include page="/components/atoms/button/button.jsp">
                                                            <jsp:param name="type" value="ghost" />
                                                            <jsp:param name="size" value="small" />
                                                            <jsp:param name="icon" value="eye" />
                                                            <jsp:param name="href"
                                                                value="${pageContext.request.contextPath}/profile.jsp?id=${userItem.id}" />
                                                            <jsp:param name="ariaLabel" value="View User" />
                                                        </jsp:include>

                                                        <jsp:include page="/components/atoms/button/button.jsp">
                                                            <jsp:param name="type" value="ghost" />
                                                            <jsp:param name="size" value="small" />
                                                            <jsp:param name="icon" value="trash" />
                                                            <jsp:param name="href"
                                                                value="${pageContext.request.contextPath}/manage/users/delete?id=${userItem.id}" />
                                                            <jsp:param name="ariaLabel" value="Delete User" />
                                                            <jsp:param name="extraClass"
                                                                value="text-red-600 hover:text-red-700 hover:bg-red-50" />
                                                            <jsp:param name="onclick"
                                                                value="return confirm('Are you sure you want to delete this user?');" />
                                                        </jsp:include>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="7" class="py-8 px-6 text-center text-neutral-600">
                                                No users found.
                                            </td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>

                    <!-- Pagination -->
                    <jsp:include page="/components/molecules/pagination/pagination.jsp">
                        <jsp:param name="currentPage" value="1" />
                        <jsp:param name="totalPages" value="1" />
                    </jsp:include>
                </div>
            </div>
        </div>
    </section>
</jsp:body>
</t:base>