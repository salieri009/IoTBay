<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>

<t:base title="Help Center - IoT Bay" description="Get help and support for IoT Bay products and services">
    <main class="py-12">
        <div class="container space-y-12">
            <!-- Hero Section -->
            <section class="text-center space-y-6">
                <p class="inline-flex items-center justify-center gap-2 text-xs font-semibold uppercase tracking-wide text-neutral-500">
                    <span class="inline-flex h-2 w-2 rounded-full bg-brand-primary"></span>
                    Expert support when you need it
                </p>
                <h1 class="text-display-xl font-extrabold text-neutral-900 leading-tight">
                    Help Center
                </h1>
                <p class="text-lg md:text-xl text-neutral-600 max-w-2xl mx-auto">
                    Find answers to common questions, troubleshooting guides, and expert support for all your IoT device needs.
                </p>
            </section>

            <!-- FAQ Section -->
            <section class="space-y-8">
                <h2 class="text-display-m font-bold text-neutral-900">Frequently Asked Questions</h2>
                
                <div class="grid gap-6 md:grid-cols-2">
                    <!-- FAQ Item 1 -->
                    <article class="rounded-2xl border border-neutral-200 bg-white p-6 shadow-sm">
                        <h3 class="text-lg font-semibold text-neutral-900 mb-2">How do I set up my IoT device?</h3>
                        <p class="text-neutral-600 text-sm leading-relaxed">
                            Most IoT devices come with a quick start guide. Connect your device to power, download the companion app, and follow the on-screen instructions. For detailed setup guides, visit our product pages.
                        </p>
                    </article>

                    <!-- FAQ Item 2 -->
                    <article class="rounded-2xl border border-neutral-200 bg-white p-6 shadow-sm">
                        <h3 class="text-lg font-semibold text-neutral-900 mb-2">What if my device isn't working?</h3>
                        <p class="text-neutral-600 text-sm leading-relaxed">
                            First, check the troubleshooting section in your device manual. Ensure all connections are secure and power is supplied. If issues persist, contact our technical support team for assistance.
                        </p>
                    </article>

                    <!-- FAQ Item 3 -->
                    <article class="rounded-2xl border border-neutral-200 bg-white p-6 shadow-sm">
                        <h3 class="text-lg font-semibold text-neutral-900 mb-2">Do you offer technical support?</h3>
                        <p class="text-neutral-600 text-sm leading-relaxed">
                            Yes! We offer 24/7 technical support via email and phone. Our expert team can help with device setup, integration, troubleshooting, and compatibility questions.
                        </p>
                    </article>

                    <!-- FAQ Item 4 -->
                    <article class="rounded-2xl border border-neutral-200 bg-white p-6 shadow-sm">
                        <h3 class="text-lg font-semibold text-neutral-900 mb-2">How do I return a product?</h3>
                        <p class="text-neutral-600 text-sm leading-relaxed">
                            Products can be returned within 30 days of purchase. Visit our <a href="${pageContext.request.contextPath}/returns" class="text-brand-primary hover:underline">Returns page</a> for detailed instructions and to initiate a return.
                        </p>
                    </article>

                    <!-- FAQ Item 5 -->
                    <article class="rounded-2xl border border-neutral-200 bg-white p-6 shadow-sm">
                        <h3 class="text-lg font-semibold text-neutral-900 mb-2">What payment methods do you accept?</h3>
                        <p class="text-neutral-600 text-sm leading-relaxed">
                            We accept credit cards, PayPal, and bank transfers. All payments are processed securely. For B2B customers, we also offer purchase orders and net payment terms.
                        </p>
                    </article>

                    <!-- FAQ Item 6 -->
                    <article class="rounded-2xl border border-neutral-200 bg-white p-6 shadow-sm">
                        <h3 class="text-lg font-semibold text-neutral-900 mb-2">How do I track my order?</h3>
                        <p class="text-neutral-600 text-sm leading-relaxed">
                            Once your order ships, you'll receive a tracking number via email. You can also track your order in your account dashboard or contact us for assistance.
                        </p>
                    </article>
                </div>
            </section>

            <!-- Support Options -->
            <section class="space-y-8">
                <h2 class="text-display-m font-bold text-neutral-900">Get Support</h2>
                
                <div class="grid gap-6 md:grid-cols-3">
                    <!-- Email Support -->
                    <article class="rounded-2xl border border-neutral-200 bg-white p-6 shadow-sm text-center">
                        <div class="inline-flex items-center justify-center w-12 h-12 rounded-full bg-brand-primary/10 text-brand-primary mb-4">
                            <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                <path d="M2.003 5.884L10 9.882l7.997-3.998A2 2 0 0016 4H4a2 2 0 00-1.997 1.884z"/>
                                <path d="M18 8.118l-8 4-8-4V14a2 2 0 002 2h12a2 2 0 002-2V8.118z"/>
                            </svg>
                        </div>
                        <h3 class="text-lg font-semibold text-neutral-900 mb-2">Email Support</h3>
                        <p class="text-neutral-600 text-sm mb-4">Get help via email</p>
                        <a href="mailto:support@iotbay.com" class="text-brand-primary hover:underline font-medium text-sm">
                            support@iotbay.com
                        </a>
                    </article>

                    <!-- Phone Support -->
                    <article class="rounded-2xl border border-neutral-200 bg-white p-6 shadow-sm text-center">
                        <div class="inline-flex items-center justify-center w-12 h-12 rounded-full bg-brand-secondary/10 text-brand-secondary mb-4">
                            <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                <path d="M2 3a1 1 0 011-1h2.153a1 1 0 01.986.836l.74 4.435a1 1 0 01-.54 1.06l-1.548.773a11.037 11.037 0 006.105 6.105l.774-1.548a1 1 0 011.059-.54l4.435.74a1 1 0 01.836.986V17a1 1 0 01-1 1h-2C7.82 18 2 12.18 2 5V3z"/>
                            </svg>
                        </div>
                        <h3 class="text-lg font-semibold text-neutral-900 mb-2">Phone Support</h3>
                        <p class="text-neutral-600 text-sm mb-4">Call us for immediate help</p>
                        <a href="tel:18004688324" class="text-brand-primary hover:underline font-medium text-sm">
                            1-800-IOT-TECH
                        </a>
                    </article>

                    <!-- Contact Form -->
                    <article class="rounded-2xl border border-neutral-200 bg-white p-6 shadow-sm text-center">
                        <div class="inline-flex items-center justify-center w-12 h-12 rounded-full bg-brand-accent/10 text-brand-accent mb-4">
                            <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clip-rule="evenodd"/>
                            </svg>
                        </div>
                        <h3 class="text-lg font-semibold text-neutral-900 mb-2">Contact Form</h3>
                        <p class="text-neutral-600 text-sm mb-4">Send us a message</p>
                        <a href="${pageContext.request.contextPath}/contact" class="btn btn--primary btn--sm">
                            Contact Us
                        </a>
                    </article>
                </div>
            </section>

            <!-- Resources Section -->
            <section class="space-y-8">
                <h2 class="text-display-m font-bold text-neutral-900">Resources</h2>
                
                <div class="grid gap-6 md:grid-cols-2 lg:grid-cols-4">
                    <a href="${pageContext.request.contextPath}/shipping" class="rounded-2xl border border-neutral-200 bg-white p-6 shadow-sm hover:shadow-md transition-shadow">
                        <h3 class="text-base font-semibold text-neutral-900 mb-2">Shipping Info</h3>
                        <p class="text-neutral-600 text-sm">Learn about shipping options and delivery times</p>
                    </a>
                    
                    <a href="${pageContext.request.contextPath}/returns" class="rounded-2xl border border-neutral-200 bg-white p-6 shadow-sm hover:shadow-md transition-shadow">
                        <h3 class="text-base font-semibold text-neutral-900 mb-2">Returns</h3>
                        <p class="text-neutral-600 text-sm">Return policy and instructions</p>
                    </a>
                    
                    <a href="${pageContext.request.contextPath}/terms" class="rounded-2xl border border-neutral-200 bg-white p-6 shadow-sm hover:shadow-md transition-shadow">
                        <h3 class="text-base font-semibold text-neutral-900 mb-2">Terms of Service</h3>
                        <p class="text-neutral-600 text-sm">Read our terms and conditions</p>
                    </a>
                    
                    <a href="${pageContext.request.contextPath}/privacy" class="rounded-2xl border border-neutral-200 bg-white p-6 shadow-sm hover:shadow-md transition-shadow">
                        <h3 class="text-base font-semibold text-neutral-900 mb-2">Privacy Policy</h3>
                        <p class="text-neutral-600 text-sm">How we protect your data</p>
                    </a>
                </div>
            </section>
        </div>
    </main>
</t:base>

