<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>

<t:base title="Help Center - IoT Bay" description="Get help and support for IoT Bay products and services">
    <main class="py-12">
        <div class="container max-w-6xl mx-auto px-4 sm:px-6 lg:px-8">
            <!-- Hero Section -->
            <section class="text-center mb-12">
                <h1 class="text-4xl md:text-5xl font-bold text-neutral-900 mb-4">Help Center</h1>
                <p class="text-lg text-neutral-600 max-w-2xl mx-auto">
                    Find answers to common questions and get support for your IoT devices
                </p>
            </section>

            <!-- Search Bar -->
            <div class="max-w-2xl mx-auto mb-12">
                <div class="relative">
                    <input type="search" 
                           placeholder="Search for help articles..." 
                           class="w-full px-4 py-3 pl-12 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-brand-primary focus:border-transparent">
                    <svg class="absolute left-4 top-1/2 transform -translate-y-1/2 w-5 h-5 text-neutral-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
                    </svg>
                </div>
            </div>

            <!-- Help Categories -->
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 mb-12">
                <!-- Getting Started -->
                <div class="bg-white rounded-lg border border-neutral-200 p-6 hover:shadow-lg transition-shadow">
                    <div class="w-12 h-12 bg-brand-primary/10 rounded-lg flex items-center justify-center mb-4">
                        <svg class="w-6 h-6 text-brand-primary" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z"></path>
                        </svg>
                    </div>
                    <h3 class="text-xl font-semibold text-neutral-900 mb-2">Getting Started</h3>
                    <p class="text-neutral-600 mb-4">Learn how to set up your IoT devices and get started with IoT Bay</p>
                    <a href="#getting-started" class="text-brand-primary hover:text-brand-primary-dark font-medium">View articles →</a>
                </div>

                <!-- Product Support -->
                <div class="bg-white rounded-lg border border-neutral-200 p-6 hover:shadow-lg transition-shadow">
                    <div class="w-12 h-12 bg-brand-primary/10 rounded-lg flex items-center justify-center mb-4">
                        <svg class="w-6 h-6 text-brand-primary" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                        </svg>
                    </div>
                    <h3 class="text-xl font-semibold text-neutral-900 mb-2">Product Support</h3>
                    <p class="text-neutral-600 mb-4">Troubleshooting guides and product-specific help</p>
                    <a href="#product-support" class="text-brand-primary hover:text-brand-primary-dark font-medium">View articles →</a>
                </div>

                <!-- Account & Orders -->
                <div class="bg-white rounded-lg border border-neutral-200 p-6 hover:shadow-lg transition-shadow">
                    <div class="w-12 h-12 bg-brand-primary/10 rounded-lg flex items-center justify-center mb-4">
                        <svg class="w-6 h-6 text-brand-primary" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                        </svg>
                    </div>
                    <h3 class="text-xl font-semibold text-neutral-900 mb-2">Account & Orders</h3>
                    <p class="text-neutral-600 mb-4">Manage your account, track orders, and view order history</p>
                    <a href="#account-orders" class="text-brand-primary hover:text-brand-primary-dark font-medium">View articles →</a>
                </div>

                <!-- Shipping & Returns -->
                <div class="bg-white rounded-lg border border-neutral-200 p-6 hover:shadow-lg transition-shadow">
                    <div class="w-12 h-12 bg-brand-primary/10 rounded-lg flex items-center justify-center mb-4">
                        <svg class="w-6 h-6 text-brand-primary" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4"></path>
                        </svg>
                    </div>
                    <h3 class="text-xl font-semibold text-neutral-900 mb-2">Shipping & Returns</h3>
                    <p class="text-neutral-600 mb-4">Information about shipping options and return policies</p>
                    <a href="${pageContext.request.contextPath}/shipping.jsp" class="text-brand-primary hover:text-brand-primary-dark font-medium">View articles →</a>
                </div>

                <!-- Warranty & Support -->
                <div class="bg-white rounded-lg border border-neutral-200 p-6 hover:shadow-lg transition-shadow">
                    <div class="w-12 h-12 bg-brand-primary/10 rounded-lg flex items-center justify-center mb-4">
                        <svg class="w-6 h-6 text-brand-primary" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"></path>
                        </svg>
                    </div>
                    <h3 class="text-xl font-semibold text-neutral-900 mb-2">Warranty & Support</h3>
                    <p class="text-neutral-600 mb-4">Warranty information and technical support options</p>
                    <a href="${pageContext.request.contextPath}/warranty.jsp" class="text-brand-primary hover:text-brand-primary-dark font-medium">View articles →</a>
                </div>

                <!-- Contact Support -->
                <div class="bg-white rounded-lg border border-neutral-200 p-6 hover:shadow-lg transition-shadow">
                    <div class="w-12 h-12 bg-brand-primary/10 rounded-lg flex items-center justify-center mb-4">
                        <svg class="w-6 h-6 text-brand-primary" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18.364 5.636l-3.536 3.536m0 5.656l3.536 3.536M9.172 9.172L5.636 5.636m3.536 9.192l-3.536 3.536M21 12a9 9 0 11-18 0 9 9 0 0118 0zm-5 0a4 4 0 11-8 0 4 4 0 018 0z"></path>
                        </svg>
                    </div>
                    <h3 class="text-xl font-semibold text-neutral-900 mb-2">Contact Support</h3>
                    <p class="text-neutral-600 mb-4">Still need help? Our support team is here for you</p>
                    <a href="${pageContext.request.contextPath}/contact.jsp" class="text-brand-primary hover:text-brand-primary-dark font-medium">Contact us →</a>
                </div>
            </div>

            <!-- Popular Articles -->
            <section class="mb-12">
                <h2 class="text-2xl font-bold text-neutral-900 mb-6">Popular Articles</h2>
                <div class="space-y-4">
                    <a href="#" class="block bg-white border border-neutral-200 rounded-lg p-6 hover:shadow-md transition-shadow">
                        <h3 class="text-lg font-semibold text-neutral-900 mb-2">How to set up your first IoT device</h3>
                        <p class="text-neutral-600">Step-by-step guide to getting started with IoT Bay products</p>
                    </a>
                    <a href="#" class="block bg-white border border-neutral-200 rounded-lg p-6 hover:shadow-md transition-shadow">
                        <h3 class="text-lg font-semibold text-neutral-900 mb-2">Troubleshooting connection issues</h3>
                        <p class="text-neutral-600">Common connectivity problems and how to resolve them</p>
                    </a>
                    <a href="#" class="block bg-white border border-neutral-200 rounded-lg p-6 hover:shadow-md transition-shadow">
                        <h3 class="text-lg font-semibold text-neutral-900 mb-2">Understanding device compatibility</h3>
                        <p class="text-neutral-600">Learn which devices work together and how to check compatibility</p>
                    </a>
                </div>
            </section>

            <!-- Contact CTA -->
            <section class="bg-brand-primary text-white rounded-lg p-8 md:p-12 text-center">
                <h2 class="text-2xl md:text-3xl font-bold mb-4">Still need help?</h2>
                <p class="text-lg mb-6 text-white/90">Our support team is available 24/7 to assist you</p>
                <a href="${pageContext.request.contextPath}/contact.jsp" class="inline-block bg-white text-brand-primary px-6 py-3 rounded-lg font-semibold hover:bg-neutral-100 transition-colors">
                    Contact Support
                </a>
            </section>
        </div>
    </main>
</t:base>

