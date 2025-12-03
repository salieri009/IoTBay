<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>

                <t:base title="Reports & Analytics Dashboard" description="Business Intelligence and system insights">
                    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

                    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
                        <!-- Dashboard Header -->
                        <div class="md:flex md:items-center md:justify-between mb-8">
                            <div class="flex-1 min-w-0">
                                <h1 class="text-3xl font-bold text-neutral-900">Reports & Analytics Dashboard</h1>
                                <p class="mt-2 text-lg text-neutral-600">Business Intelligence and system insights</p>
                            </div>
                            <div class="mt-4 flex md:mt-0 md:ml-4 space-x-3">
                                <button onclick="location.reload()"
                                    class="inline-flex items-center px-4 py-2 border border-neutral-300 shadow-sm text-sm font-medium rounded-md text-neutral-700 bg-white hover:bg-neutral-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-brand-primary">
                                    <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15">
                                        </path>
                                    </svg>
                                    Refresh
                                </button>
                                <button onclick="alert('Export feature coming soon')"
                                    class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-brand-primary hover:bg-brand-secondary focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-brand-primary">
                                    <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M12 10v6m0 0l-3-3m3 3l3-3m2 8H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z">
                                        </path>
                                    </svg>
                                    Export Report
                                </button>
                            </div>
                        </div>

                        <!-- Error Messages -->
                        <c:if test="${not empty error}">
                            <div class="rounded-md bg-red-50 p-4 mb-6">
                                <div class="flex">
                                    <div class="flex-shrink-0">
                                        <svg class="h-5 w-5 text-red-400" viewBox="0 0 20 20" fill="currentColor">
                                            <path fill-rule="evenodd"
                                                d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z"
                                                clip-rule="evenodd" />
                                        </svg>
                                    </div>
                                    <div class="ml-3">
                                        <h3 class="text-sm font-medium text-red-800">Error</h3>
                                        <div class="mt-2 text-sm text-red-700">
                                            <p>
                                                <c:out value="${error}" />
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:if>

                        <!-- Dashboard Metrics -->
                        <div class="grid grid-cols-1 gap-5 sm:grid-cols-2 lg:grid-cols-4 mb-8">
                            <!-- Total Users -->
                            <div class="bg-white overflow-hidden shadow rounded-lg">
                                <div class="p-5">
                                    <div class="flex items-center">
                                        <div class="flex-shrink-0">
                                            <div class="rounded-md bg-blue-500 p-3">
                                                <svg class="h-6 w-6 text-white" fill="none" stroke="currentColor"
                                                    viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2"
                                                        d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197m13.5-9a2.5 2.5 0 11-5 0 2.5 2.5 0 015 0z">
                                                    </path>
                                                </svg>
                                            </div>
                                        </div>
                                        <div class="ml-5 w-0 flex-1">
                                            <dl>
                                                <dt class="text-sm font-medium text-neutral-500 truncate">Total Users
                                                </dt>
                                                <dd class="text-3xl font-semibold text-neutral-900">
                                                    <c:out value="${totalUsers}" />
                                                </dd>
                                            </dl>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Total Products -->
                            <div class="bg-white overflow-hidden shadow rounded-lg">
                                <div class="p-5">
                                    <div class="flex items-center">
                                        <div class="flex-shrink-0">
                                            <div class="rounded-md bg-green-500 p-3">
                                                <svg class="h-6 w-6 text-white" fill="none" stroke="currentColor"
                                                    viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2"
                                                        d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4">
                                                    </path>
                                                </svg>
                                            </div>
                                        </div>
                                        <div class="ml-5 w-0 flex-1">
                                            <dl>
                                                <dt class="text-sm font-medium text-neutral-500 truncate">Total Products
                                                </dt>
                                                <dd class="text-3xl font-semibold text-neutral-900">
                                                    <c:out value="${totalProducts}" />
                                                </dd>
                                            </dl>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Total Orders -->
                            <div class="bg-white overflow-hidden shadow rounded-lg">
                                <div class="p-5">
                                    <div class="flex items-center">
                                        <div class="flex-shrink-0">
                                            <div class="rounded-md bg-purple-500 p-3">
                                                <svg class="h-6 w-6 text-white" fill="none" stroke="currentColor"
                                                    viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2" d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z">
                                                    </path>
                                                </svg>
                                            </div>
                                        </div>
                                        <div class="ml-5 w-0 flex-1">
                                            <dl>
                                                <dt class="text-sm font-medium text-neutral-500 truncate">Total Orders
                                                </dt>
                                                <dd class="text-3xl font-semibold text-neutral-900">
                                                    <c:out value="${totalOrders}" />
                                                </dd>
                                            </dl>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Total Revenue -->
                            <div class="bg-white overflow-hidden shadow rounded-lg">
                                <div class="p-5">
                                    <div class="flex items-center">
                                        <div class="flex-shrink-0">
                                            <div class="rounded-md bg-yellow-500 p-3">
                                                <svg class="h-6 w-6 text-white" fill="none" stroke="currentColor"
                                                    viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2"
                                                        d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z">
                                                    </path>
                                                </svg>
                                            </div>
                                        </div>
                                        <div class="ml-5 w-0 flex-1">
                                            <dl>
                                                <dt class="text-sm font-medium text-neutral-500 truncate">Total Revenue
                                                </dt>
                                                <dd class="text-3xl font-semibold text-neutral-900">
                                                    $
                                                    <fmt:formatNumber value="${totalRevenue}" pattern="#,##0.00" />
                                                </dd>
                                            </dl>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Quick Actions -->
                        <div class="grid grid-cols-1 gap-5 sm:grid-cols-2 lg:grid-cols-5 mb-8">
                            <a href="${pageContext.request.contextPath}/api/manage/users"
                                class="bg-white overflow-hidden shadow rounded-lg p-6 hover:shadow-lg transition-shadow duration-200 group">
                                <div class="flex items-center">
                                    <div class="flex-shrink-0">
                                        <svg class="h-8 w-8 text-neutral-400 group-hover:text-brand-primary transition-colors duration-200"
                                            fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197m13.5-9a2.5 2.5 0 11-5 0 2.5 2.5 0 015 0z">
                                            </path>
                                        </svg>
                                    </div>
                                    <div class="ml-4">
                                        <h3
                                            class="text-lg font-medium text-neutral-900 group-hover:text-brand-primary transition-colors duration-200">
                                            Manage Users</h3>
                                        <p class="mt-1 text-sm text-neutral-500">User administration</p>
                                    </div>
                                </div>
                            </a>

                            <a href="${pageContext.request.contextPath}/api/manage/products"
                                class="bg-white overflow-hidden shadow rounded-lg p-6 hover:shadow-lg transition-shadow duration-200 group">
                                <div class="flex items-center">
                                    <div class="flex-shrink-0">
                                        <svg class="h-8 w-8 text-neutral-400 group-hover:text-brand-primary transition-colors duration-200"
                                            fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4">
                                            </path>
                                        </svg>
                                    </div>
                                    <div class="ml-4">
                                        <h3
                                            class="text-lg font-medium text-neutral-900 group-hover:text-brand-primary transition-colors duration-200">
                                            Manage Products</h3>
                                        <p class="mt-1 text-sm text-neutral-500">Product catalog</p>
                                    </div>
                                </div>
                            </a>

                            <a href="${pageContext.request.contextPath}/manage/orders"
                                class="bg-white overflow-hidden shadow rounded-lg p-6 hover:shadow-lg transition-shadow duration-200 group">
                                <div class="flex items-center">
                                    <div class="flex-shrink-0">
                                        <svg class="h-8 w-8 text-neutral-400 group-hover:text-brand-primary transition-colors duration-200"
                                            fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z"></path>
                                        </svg>
                                    </div>
                                    <div class="ml-4">
                                        <h3
                                            class="text-lg font-medium text-neutral-900 group-hover:text-brand-primary transition-colors duration-200">
                                            Manage Orders</h3>
                                        <p class="mt-1 text-sm text-neutral-500">Order processing</p>
                                    </div>
                                </div>
                            </a>

                            <a href="${pageContext.request.contextPath}/admin/supplier/"
                                class="bg-white overflow-hidden shadow rounded-lg p-6 hover:shadow-lg transition-shadow duration-200 group">
                                <div class="flex items-center">
                                    <div class="flex-shrink-0">
                                        <svg class="h-8 w-8 text-neutral-400 group-hover:text-brand-primary transition-colors duration-200"
                                            fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4">
                                            </path>
                                        </svg>
                                    </div>
                                    <div class="ml-4">
                                        <h3
                                            class="text-lg font-medium text-neutral-900 group-hover:text-brand-primary transition-colors duration-200">
                                            Manage Suppliers</h3>
                                        <p class="mt-1 text-sm text-neutral-500">Supplier network</p>
                                    </div>
                                </div>
                            </a>

                            <a href="${pageContext.request.contextPath}/api/dataManagement/dashboard"
                                class="bg-white overflow-hidden shadow rounded-lg p-6 hover:shadow-lg transition-shadow duration-200 group">
                                <div class="flex items-center">
                                    <div class="flex-shrink-0">
                                        <svg class="h-8 w-8 text-neutral-400 group-hover:text-brand-primary transition-colors duration-200"
                                            fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M9 19l3 3m0 0l3-3m-3 3V10">
                                            </path>
                                        </svg>
                                    </div>
                                    <div class="ml-4">
                                        <h3
                                            class="text-lg font-medium text-neutral-900 group-hover:text-brand-primary transition-colors duration-200">
                                            Data Management</h3>
                                        <p class="mt-1 text-sm text-neutral-500">Import/Export data</p>
                                    </div>
                                </div>
                            </a>
                        </div>

                        <!-- Charts Section -->
                        <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
                            <!-- Distribution Chart -->
                            <div class="bg-white shadow rounded-lg p-6">
                                <h3 class="text-lg leading-6 font-medium text-neutral-900 mb-4">System Overview</h3>
                                <div class="relative h-64">
                                    <canvas id="distributionChart"></canvas>
                                </div>
                            </div>

                            <!-- Placeholder for another chart -->
                            <div class="bg-white shadow rounded-lg p-6">
                                <h3 class="text-lg leading-6 font-medium text-neutral-900 mb-4">Activity Trends</h3>
                                <div
                                    class="flex items-center justify-center h-64 bg-neutral-50 rounded-lg border-2 border-dashed border-neutral-300">
                                    <p class="text-neutral-500">Activity trend chart coming soon</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <script>
                        document.addEventListener('DOMContentLoaded', function () {
                            const ctx = document.getElementById('distributionChart').getContext('2d');
                            new Chart(ctx, {
                                type: 'doughnut',
                                data: {
                                    labels: ['Users', 'Products', 'Orders'],
                                    datasets: [{
                                        data: [
                                            ${ totalUsers != null ? totalUsers : 0},
                                        ${ totalProducts != null ? totalProducts : 0},
                                ${ totalOrders != null ? totalOrders : 0}
                        ],
                            backgroundColor: [
                            '#3B82F6', // Blue-500
                            '#10B981', // Green-500
                            '#8B5CF6'  // Purple-500
                        ]
                    }]
                },
                            options: {
                            responsive: true,
                            maintainAspectRatio: false,
                            plugins: {
                                legend: {
                                    position: 'bottom'
                                }
                            }
                        }
            });
        });
                    </script>
                </t:base>