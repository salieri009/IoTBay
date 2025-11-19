<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>

<t:base title="Frequently Asked Questions - IoT Bay" description="Common questions and answers about IoT Bay products, services, and policies">
    <main class="py-12">
        <div class="container max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
            <!-- Hero Section -->
            <section class="text-center mb-12">
                <h1 class="text-4xl md:text-5xl font-bold text-neutral-900 mb-4">Frequently Asked Questions</h1>
                <p class="text-lg text-neutral-600 max-w-2xl mx-auto">
                    Find answers to the most common questions about IoT Bay
                </p>
            </section>

            <!-- FAQ Categories -->
            <div class="mb-8">
                <div class="flex flex-wrap gap-2 justify-center">
                    <button class="px-4 py-2 bg-brand-primary text-white rounded-lg font-medium">All</button>
                    <button class="px-4 py-2 bg-neutral-100 text-neutral-700 rounded-lg font-medium hover:bg-neutral-200">Products</button>
                    <button class="px-4 py-2 bg-neutral-100 text-neutral-700 rounded-lg font-medium hover:bg-neutral-200">Orders</button>
                    <button class="px-4 py-2 bg-neutral-100 text-neutral-700 rounded-lg font-medium hover:bg-neutral-200">Shipping</button>
                    <button class="px-4 py-2 bg-neutral-100 text-neutral-700 rounded-lg font-medium hover:bg-neutral-200">Returns</button>
                    <button class="px-4 py-2 bg-neutral-100 text-neutral-700 rounded-lg font-medium hover:bg-neutral-200">Account</button>
                </div>
            </div>

            <!-- FAQ Items -->
            <div class="space-y-4">
                <!-- Product Questions -->
                <section class="mb-8">
                    <h2 class="text-2xl font-bold text-neutral-900 mb-6">Product Questions</h2>
                    <div class="space-y-4">
                        <details class="bg-white border border-neutral-200 rounded-lg p-6">
                            <summary class="font-semibold text-neutral-900 cursor-pointer flex items-center justify-between">
                                <span>What types of IoT devices do you sell?</span>
                                <svg class="w-5 h-5 text-neutral-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                                </svg>
                            </summary>
                            <p class="mt-4 text-neutral-600">
                                We offer a wide range of IoT devices including smart home automation systems, industrial sensors, agricultural monitoring equipment, warehouse management solutions, healthcare devices, and transportation tracking systems. Browse our categories to see our full product range.
                            </p>
                        </details>

                        <details class="bg-white border border-neutral-200 rounded-lg p-6">
                            <summary class="font-semibold text-neutral-900 cursor-pointer flex items-center justify-between">
                                <span>Are your devices compatible with popular smart home platforms?</span>
                                <svg class="w-5 h-5 text-neutral-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                                </svg>
                            </summary>
                            <p class="mt-4 text-neutral-600">
                                Yes! Most of our smart home devices are compatible with popular platforms including Amazon Alexa, Google Home, Apple HomeKit, and Samsung SmartThings. Check individual product pages for specific compatibility information.
                            </p>
                        </details>

                        <details class="bg-white border border-neutral-200 rounded-lg p-6">
                            <summary class="font-semibold text-neutral-900 cursor-pointer flex items-center justify-between">
                                <span>Do I need technical expertise to use IoT devices?</span>
                                <svg class="w-5 h-5 text-neutral-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                                </svg>
                            </summary>
                            <p class="mt-4 text-neutral-600">
                                Not at all! Our devices are designed with user-friendliness in mind. Most products include step-by-step setup guides, mobile apps, and our support team is available to help with installation and configuration.
                            </p>
                        </details>
                    </div>
                </section>

                <!-- Order Questions -->
                <section class="mb-8">
                    <h2 class="text-2xl font-bold text-neutral-900 mb-6">Order Questions</h2>
                    <div class="space-y-4">
                        <details class="bg-white border border-neutral-200 rounded-lg p-6">
                            <summary class="font-semibold text-neutral-900 cursor-pointer flex items-center justify-between">
                                <span>How do I track my order?</span>
                                <svg class="w-5 h-5 text-neutral-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                                </svg>
                            </summary>
                            <p class="mt-4 text-neutral-600">
                                Once your order ships, you'll receive a tracking number via email. You can also log into your account and view order status in the "Order History" section. Click on any order to see detailed tracking information.
                            </p>
                        </details>

                        <details class="bg-white border border-neutral-200 rounded-lg p-6">
                            <summary class="font-semibold text-neutral-900 cursor-pointer flex items-center justify-between">
                                <span>Can I cancel or modify my order?</span>
                                <svg class="w-5 h-5 text-neutral-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                                </svg>
                            </summary>
                            <p class="mt-4 text-neutral-600">
                                Orders can be cancelled or modified within 1 hour of placement, provided they haven't been processed for shipping. Contact our support team immediately if you need to make changes to your order.
                            </p>
                        </details>

                        <details class="bg-white border border-neutral-200 rounded-lg p-6">
                            <summary class="font-semibold text-neutral-900 cursor-pointer flex items-center justify-between">
                                <span>What payment methods do you accept?</span>
                                <svg class="w-5 h-5 text-neutral-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                                </svg>
                            </summary>
                            <p class="mt-4 text-neutral-600">
                                We accept all major credit cards (Visa, Mastercard, American Express), PayPal, and bank transfers for business orders. All payments are processed securely through encrypted channels.
                            </p>
                        </details>
                    </div>
                </section>

                <!-- Shipping Questions -->
                <section class="mb-8">
                    <h2 class="text-2xl font-bold text-neutral-900 mb-6">Shipping Questions</h2>
                    <div class="space-y-4">
                        <details class="bg-white border border-neutral-200 rounded-lg p-6">
                            <summary class="font-semibold text-neutral-900 cursor-pointer flex items-center justify-between">
                                <span>How long does shipping take?</span>
                                <svg class="w-5 h-5 text-neutral-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                                </svg>
                            </summary>
                            <p class="mt-4 text-neutral-600">
                                Standard shipping typically takes 5-7 business days within Australia. Express shipping options (2-3 business days) are available at checkout. International shipping times vary by destination.
                            </p>
                        </details>

                        <details class="bg-white border border-neutral-200 rounded-lg p-6">
                            <summary class="font-semibold text-neutral-900 cursor-pointer flex items-center justify-between">
                                <span>Do you ship internationally?</span>
                                <svg class="w-5 h-5 text-neutral-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                                </svg>
                            </summary>
                            <p class="mt-4 text-neutral-600">
                                Yes, we ship to most countries worldwide. Shipping costs and delivery times vary by location. Check the shipping page for detailed information about international shipping options and restrictions.
                            </p>
                        </details>
                    </div>
                </section>

                <!-- Returns Questions -->
                <section class="mb-8">
                    <h2 class="text-2xl font-bold text-neutral-900 mb-6">Returns & Warranty</h2>
                    <div class="space-y-4">
                        <details class="bg-white border border-neutral-200 rounded-lg p-6">
                            <summary class="font-semibold text-neutral-900 cursor-pointer flex items-center justify-between">
                                <span>What is your return policy?</span>
                                <svg class="w-5 h-5 text-neutral-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                                </svg>
                            </summary>
                            <p class="mt-4 text-neutral-600">
                                We offer a 30-day return policy for unopened items in original packaging. Items must be in new, unused condition. For defective products, please refer to our warranty policy. See our shipping page for complete return details.
                            </p>
                        </details>

                        <details class="bg-white border border-neutral-200 rounded-lg p-6">
                            <summary class="font-semibold text-neutral-900 cursor-pointer flex items-center justify-between">
                                <span>What warranty do products come with?</span>
                                <svg class="w-5 h-5 text-neutral-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                                </svg>
                            </summary>
                            <p class="mt-4 text-neutral-600">
                                Most products come with a 1-2 year manufacturer's warranty covering defects in materials and workmanship. Extended warranty options are available at checkout. Visit our warranty page for detailed information.
                            </p>
                        </details>
                    </div>
                </section>
            </div>

            <!-- Contact CTA -->
            <section class="bg-brand-primary text-white rounded-lg p-8 text-center mt-12">
                <h2 class="text-2xl font-bold mb-4">Still have questions?</h2>
                <p class="text-lg mb-6 text-white/90">Our support team is here to help</p>
                <a href="${pageContext.request.contextPath}/contact.jsp" class="inline-block bg-white text-brand-primary px-6 py-3 rounded-lg font-semibold hover:bg-neutral-100 transition-colors">
                    Contact Support
                </a>
            </section>
        </div>
    </main>
</t:base>

