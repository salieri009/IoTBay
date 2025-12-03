<jsp:body>
    <!-- Page Header -->
    <section class="py-12 bg-gradient-to-br from-blue-50 via-white to-purple-50">
        <div class="container">
            <div class="max-w-6xl mx-auto">
                <div class="flex items-center justify-between">
                    <div>
                        <h1 class="text-display-lg text-neutral-900 mb-2">
                            Manage <span
                                class="text-transparent bg-clip-text bg-gradient-to-r from-brand-primary to-brand-secondary">Suppliers</span>
                        </h1>
                        <p class="text-lg text-neutral-600">Manage supplier
                            relationships and contacts</p>
                    </div>
                    <div class="flex items-center gap-3">
                        <jsp:include page="/components/atoms/button/button.jsp">
                            <jsp:param name="text" value="Export Suppliers" />
                            <jsp:param name="type" value="secondary" />
                        </jsp:include>
                        <jsp:include page="/components/atoms/button/button.jsp">
                            <jsp:param name="text" value="Add Supplier" />
                            <jsp:param name="type" value="primary" />
                        </jsp:include>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Search and Filter -->
    <section class="py-12">
        <div class="container">
            <div class="max-w-6xl mx-auto">
                <div class="card p-6 mb-8">
                    <div class="flex flex-col md:flex-row gap-4 items-center">
                        <div class="flex-1">
                            <input type="text" placeholder="Search suppliers..." class="form-input">
                        </div>
                        <div class="flex items-center gap-3">
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

                <!-- Suppliers Table -->
                <div class="card overflow-hidden">
                    <div class="overflow-x-auto">
                        <table class="w-full">
                            <thead class="bg-neutral-50">
                                <tr>
                                    <th class="text-left py-4 px-6 font-medium text-neutral-700">
                                        Supplier</th>
                                    <th class="text-left py-4 px-6 font-medium text-neutral-700">
                                        Contact</th>
                                    <th class="text-left py-4 px-6 font-medium text-neutral-700">
                                        Phone</th>
                                    <th class="text-left py-4 px-6 font-medium text-neutral-700">
                                        Status</th>
                                    <th class="text-left py-4 px-6 font-medium text-neutral-700">
                                        Products</th>
                                    <th class="text-left py-4 px-6 font-medium text-neutral-700">
                                        Actions</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-neutral-200">
                                <c:forEach var="supplier" items="<%= suppliers %>" varStatus="status">
                                    <tr class="hover:bg-neutral-50">
                                        <td class="py-4 px-6">
                                            <div class="flex items-center gap-3">
                                                <div
                                                    class="w-10 h-10 bg-gradient-to-br from-blue-500 to-purple-500 rounded-full flex items-center justify-center text-white font-semibold text-sm">
                                                    ${fn:substring(supplier[0],
                                                    0, 2)}
                                                </div>
                                                <div>
                                                    <p class="font-medium text-neutral-900">
                                                        ${supplier[0]}</p>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="py-4 px-6">
                                            <p class="text-neutral-900">
                                                ${supplier[1]}</p>
                                        </td>
                                        <td class="py-4 px-6">
                                            <p class="text-neutral-900">
                                                ${supplier[2]}</p>
                                        </td>
                                        <td class="py-4 px-6">
                                            <jsp:include page="/components/atoms/badge/badge.jsp">
                                                <jsp:param name="text" value="${supplier[3]}" />
                                                <jsp:param name="type"
                                                    value="${supplier[3] == 'Active' ? 'success' : 'warning'}" />
                                            </jsp:include>
                                        </td>
                                        <td class="py-4 px-6">
                                            <p class="text-neutral-900">
                                                ${supplier[4]}</p>
                                        </td>
                                        <td class="py-4 px-6">
                                            <div class="flex items-center gap-2">
                                                <jsp:include page="/components/atoms/button/button.jsp">
                                                    <jsp:param name="text" value="Edit" />
                                                    <jsp:param name="type" value="ghost" />
                                                    <jsp:param name="size" value="small" />
                                                </jsp:include>
                                                <jsp:include page="/components/atoms/button/button.jsp">
                                                    <jsp:param name="text" value="View" />
                                                    <jsp:param name="type" value="ghost" />
                                                    <jsp:param name="size" value="small" />
                                                </jsp:include>
                                                <jsp:include page="/components/atoms/button/button.jsp">
                                                    <jsp:param name="text" value="Delete" />
                                                    <jsp:param name="type" value="danger" />
                                                    <jsp:param name="size" value="small" />
                                                </jsp:include>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </section>
</jsp:body>
</t:base>