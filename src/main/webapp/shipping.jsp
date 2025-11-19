<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>

<t:base title="Shipping Information - IoT Bay" description="Shipping options, delivery times, and tracking information for IoT Bay orders">
    <main class="py-12">
        <div class="container space-y-12">
            <!-- Hero Section -->
            <section class="text-center space-y-6">
                <p class="inline-flex items-center justify-center gap-2 text-xs font-semibold uppercase tracking-wide text-neutral-500">
                    <span class="inline-flex h-2 w-2 rounded-full bg-brand-primary"></span>
                    Fast and reliable delivery
                </p>
                <h1 class="text-display-xl font-extrabold text-neutral-900 leading-tight">
                    Shipping Information
                </h1>
                <p class="text-lg md:text-xl text-neutral-600 max-w-2xl mx-auto">
                    We offer multiple shipping options to get your IoT devices to you quickly and safely, with full tracking and insurance coverage.
                </p>
            </section>

            <!-- Shipping Options -->
            <section class="space-y-8">
                <h2 class="text-display-m font-bold text-neutral-900">Shipping Options</h2>
                
                <div class="grid gap-6 md:grid-cols-3">
                    <!-- Standard Shipping -->
                    <article class="rounded-2xl border border-neutral-200 bg-white p-6 shadow-sm">
                        <div class="flex items-center gap-3 mb-4">
                            <div class="inline-flex items-center justify-center w-10 h-10 rounded-full bg-brand-primary/10 text-brand-primary">
                                <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                    <path d="M8 16.5a1.5 1.5 0 11-3 0 1.5 1.5 0 013 0zM15 16.5a1.5 1.5 0 11-3 0 1.5 1.5 0 013 0z"/>
                                    <path d="M3 4a1 1 0 00-1 1v10a1 1 0 001 1h1.05a2.5 2.5 0 014.9 0H10a1 1 0 001-1V5a1 1 0 00-1-1H3zM14 7a1 1 0 00-1 1v6.05A2.5 2.5 0 0115.95 16H17a1 1 0 001-1v-5a1 1 0 00-.293-.707l-2-2A1 1 0 0015 7h-1z"/>
                                </svg>
                            </div>
                            <h3 class="text-lg font-semibold text-neutral-900">Standard Shipping</h3>
                        </div>
                        <dl class="space-y-2 text-sm">
                            <div>
                                <dt class="font-medium text-neutral-700">Delivery Time</dt>
                                <dd class="text-neutral-600">5-7 business days</dd>
                            </div>
                            <div>
                                <dt class="font-medium text-neutral-700">Cost</dt>
                                <dd class="text-neutral-600">$9.95 (Free over $100)</dd>
                            </div>
                            <div>
                                <dt class="font-medium text-neutral-700">Tracking</dt>
                                <dd class="text-neutral-600">Full tracking included</dd>
                            </div>
                        </dl>
                    </article>

                    <!-- Express Shipping -->
                    <article class="rounded-2xl border border-neutral-200 bg-white p-6 shadow-sm">
                        <div class="flex items-center gap-3 mb-4">
                            <div class="inline-flex items-center justify-center w-10 h-10 rounded-full bg-brand-secondary/10 text-brand-secondary">
                                <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                    <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm1-12a1 1 0 10-2 0v4a1 1 0 00.293.707l2.828 2.829a1 1 0 101.415-1.415L11 9.586V6z" clip-rule="evenodd"/>
                                </svg>
                            </div>
                            <h3 class="text-lg font-semibold text-neutral-900">Express Shipping</h3>
                        </div>
                        <dl class="space-y-2 text-sm">
                            <div>
                                <dt class="font-medium text-neutral-700">Delivery Time</dt>
                                <dd class="text-neutral-600">2-3 business days</dd>
                            </div>
                            <div>
                                <dt class="font-medium text-neutral-700">Cost</dt>
                                <dd class="text-neutral-600">$19.95</dd>
                            </div>
                            <div>
                                <dt class="font-medium text-neutral-700">Tracking</dt>
                                <dd class="text-neutral-600">Priority tracking included</dd>
                            </div>
                        </dl>
                    </article>

                    <!-- Overnight Shipping -->
                    <article class="rounded-2xl border border-neutral-200 bg-white p-6 shadow-sm">
                        <div class="flex items-center gap-3 mb-4">
                            <div class="inline-flex items-center justify-center w-10 h-10 rounded-full bg-brand-accent/10 text-brand-accent">
                                <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                    <path fill-rule="evenodd" d="M10 2a1 1 0 011 1v1.323l3.954 1.582 1.599-.8a1 1 0 01.894 1.79l-1.233.616 1.738 5.42a1 1 0 01-.285 1.05A3.989 3.989 0 0115 15a3.989 3.989 0 01-2.667-1.019 1 1 0 01-.285-1.05l1.715-5.349L11 6.477V16h2a1 1 0 110 2H7a1 1 0 110-2h2V6.477L6.237 7.582l1.715 5.349a1 1 0 01-.285 1.05A3.989 3.989 0 015 15a3.989 3.989 0 01-2.667-1.019 1 1 0 01-.285-1.05l1.738-5.42-1.233-.617a1 1 0 01.894-1.788l1.599.799L9 4.323V3a1 1 0 011-1z" clip-rule="evenodd"/>
                                </svg>
                            </div>
                            <h3 class="text-lg font-semibold text-neutral-900">Overnight Shipping</h3>
                        </div>
                        <dl class="space-y-2 text-sm">
                            <div>
                                <dt class="font-medium text-neutral-700">Delivery Time</dt>
                                <dd class="text-neutral-600">Next business day</dd>
                            </div>
                            <div>
                                <dt class="font-medium text-neutral-700">Cost</dt>
                                <dd class="text-neutral-600">$39.95</dd>
                            </div>
                            <div>
                                <dt class="font-medium text-neutral-700">Tracking</dt>
                                <dd class="text-neutral-600">Real-time tracking included</dd>
                            </div>
                        </dl>
                    </article>
                </div>
            </section>

            <!-- Shipping Details -->
            <section class="space-y-8">
                <h2 class="text-display-m font-bold text-neutral-900">Shipping Details</h2>
                
                <div class="grid gap-8 md:grid-cols-2">
                    <!-- Processing Time -->
                    <article class="rounded-2xl border border-neutral-200 bg-white p-6 shadow-sm">
                        <h3 class="text-lg font-semibold text-neutral-900 mb-4">Processing Time</h3>
                        <p class="text-neutral-600 text-sm leading-relaxed mb-4">
                            Orders are typically processed within 1-2 business days. Orders placed before 2 PM AEST on weekdays are usually shipped the same day.
                        </p>
                        <ul class="space-y-2 text-sm text-neutral-600">
                            <li class="flex items-start gap-2">
                                <span class="text-brand-primary mt-1">??/span>
                                <span>In-stock items: 1-2 business days</span>
                            </li>
                            <li class="flex items-start gap-2">
                                <span class="text-brand-primary mt-1">??/span>
                                <span>Backordered items: 5-10 business days</span>
                            </li>
                            <li class="flex items-start gap-2">
                                <span class="text-brand-primary mt-1">??/span>
                                <span>Custom orders: 2-3 weeks</span>
                            </li>
                        </ul>
                    </article>

                    <!-- Tracking & Insurance -->
                    <article class="rounded-2xl border border-neutral-200 bg-white p-6 shadow-sm">
                        <h3 class="text-lg font-semibold text-neutral-900 mb-4">Tracking & Insurance</h3>
                        <p class="text-neutral-600 text-sm leading-relaxed mb-4">
                            All orders include full tracking and insurance coverage. You'll receive a tracking number via email once your order ships.
                        </p>
                        <ul class="space-y-2 text-sm text-neutral-600">
                            <li class="flex items-start gap-2">
                                <span class="text-brand-primary mt-1">??/span>
                                <span>Real-time tracking updates</span>
                            </li>
                            <li class="flex items-start gap-2">
                                <span class="text-brand-primary mt-1">??/span>
                                <span>Full insurance coverage included</span>
                            </li>
                            <li class="flex items-start gap-2">
                                <span class="text-brand-primary mt-1">??/span>
                                <span>Email notifications at each stage</span>
                            </li>
                        </ul>
                    </article>

                    <!-- International Shipping -->
                    <article class="rounded-2xl border border-neutral-200 bg-white p-6 shadow-sm">
                        <h3 class="text-lg font-semibold text-neutral-900 mb-4">International Shipping</h3>
                        <p class="text-neutral-600 text-sm leading-relaxed mb-4">
                            We ship to most countries worldwide. International shipping times and costs vary by destination. Customs fees may apply.
                        </p>
                        <ul class="space-y-2 text-sm text-neutral-600">
                            <li class="flex items-start gap-2">
                                <span class="text-brand-primary mt-1">??/span>
                                <span>International standard: 10-15 business days</span>
                            </li>
                            <li class="flex items-start gap-2">
                                <span class="text-brand-primary mt-1">??/span>
                                <span>International express: 5-7 business days</span>
                            </li>
                            <li class="flex items-start gap-2">
                                <span class="text-brand-primary mt-1">??/span>
                                <span>Customs fees are the customer's responsibility</span>
                            </li>
                        </ul>
                    </article>

                    <!-- Delivery Issues -->
                    <article class="rounded-2xl border border-neutral-200 bg-white p-6 shadow-sm">
                        <h3 class="text-lg font-semibold text-neutral-900 mb-4">Delivery Issues</h3>
                        <p class="text-neutral-600 text-sm leading-relaxed mb-4">
                            If you experience any issues with delivery, please contact us immediately. We'll work with the carrier to resolve the issue quickly.
                        </p>
                        <ul class="space-y-2 text-sm text-neutral-600">
                            <li class="flex items-start gap-2">
                                <span class="text-brand-primary mt-1">??/span>
                                <span>Damaged packages: Contact us within 48 hours</span>
                            </li>
                            <li class="flex items-start gap-2">
                                <span class="text-brand-primary mt-1">??/span>
                                <span>Lost packages: We'll investigate and reship if needed</span>
                            </li>
                            <li class="flex items-start gap-2">
                                <span class="text-brand-primary mt-1">??/span>
                                <span>Wrong address: Update your address before shipping</span>
                            </li>
                        </ul>
                    </article>
                </div>
            </section>

            <!-- Free Shipping -->
            <section class="rounded-2xl border border-brand-primary bg-brand-primary/5 p-8 text-center">
                <h2 class="text-display-m font-bold text-neutral-900 mb-4">Free Standard Shipping</h2>
                <p class="text-lg text-neutral-600 mb-6 max-w-2xl mx-auto">
                    Orders over $100 qualify for free standard shipping. No code needed?”discount applies automatically at checkout.
                </p>
                <a href="/browse.jsp" class="btn btn--primary btn--lg">
                    Shop Now
                </a>
            </section>
        </div>
    </main>
</t:base>

