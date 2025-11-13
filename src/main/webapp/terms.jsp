<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>

<t:base title="Terms of Service - IoT Bay" description="Terms and conditions for using IoT Bay services">
    <main class="py-12">
        <div class="container space-y-12 max-w-4xl">
            <!-- Hero Section -->
            <section class="text-center space-y-6">
                <p class="inline-flex items-center justify-center gap-2 text-xs font-semibold uppercase tracking-wide text-neutral-500">
                    <span class="inline-flex h-2 w-2 rounded-full bg-brand-primary"></span>
                    Terms and conditions
                </p>
                <h1 class="text-display-xl font-extrabold text-neutral-900 leading-tight">
                    Terms of Service
                </h1>
                <p class="text-lg md:text-xl text-neutral-600 max-w-2xl mx-auto">
                    Last updated: January 2025
                </p>
            </section>

            <!-- Terms Content -->
            <article class="prose prose-neutral max-w-none space-y-8">
                <section class="space-y-4">
                    <h2 class="text-display-m font-bold text-neutral-900">Agreement to Terms</h2>
                    <p class="text-neutral-600 leading-relaxed">
                        By accessing or using IoT Bay's website and services, you agree to be bound by these Terms of Service. If you disagree with any part of these terms, you may not access our services.
                    </p>
                </section>

                <section class="space-y-4">
                    <h2 class="text-display-m font-bold text-neutral-900">Use of Services</h2>
                    <p class="text-neutral-600 leading-relaxed">
                        You agree to use our services only for lawful purposes and in accordance with these Terms. You agree not to:
                    </p>
                    <ul class="space-y-2 text-neutral-600 list-disc list-inside">
                        <li>Violate any applicable laws or regulations</li>
                        <li>Infringe upon the rights of others</li>
                        <li>Transmit any harmful or malicious code</li>
                        <li>Attempt to gain unauthorized access to our systems</li>
                        <li>Interfere with or disrupt our services</li>
                    </ul>
                </section>

                <section class="space-y-4">
                    <h2 class="text-display-m font-bold text-neutral-900">Product Information</h2>
                    <p class="text-neutral-600 leading-relaxed">
                        We strive to provide accurate product information, but we do not warrant that product descriptions, prices, or other content on our website is accurate, complete, or current. We reserve the right to correct any errors and to update information at any time.
                    </p>
                </section>

                <section class="space-y-4">
                    <h2 class="text-display-m font-bold text-neutral-900">Pricing and Payment</h2>
                    <p class="text-neutral-600 leading-relaxed">
                        All prices are in Australian Dollars (AUD) unless otherwise stated. We reserve the right to change prices at any time. Payment must be made at the time of purchase using accepted payment methods.
                    </p>
                </section>

                <section class="space-y-4">
                    <h2 class="text-display-m font-bold text-neutral-900">Shipping and Delivery</h2>
                    <p class="text-neutral-600 leading-relaxed">
                        Shipping terms, delivery times, and costs are specified at checkout. We are not responsible for delays caused by shipping carriers or customs. Risk of loss passes to you upon delivery.
                    </p>
                </section>

                <section class="space-y-4">
                    <h2 class="text-display-m font-bold text-neutral-900">Returns and Refunds</h2>
                    <p class="text-neutral-600 leading-relaxed">
                        Our return and refund policy is detailed on our <a href="${pageContext.request.contextPath}/returns" class="text-brand-primary hover:underline">Returns page</a>. Returns must be made within 30 days of delivery in original condition.
                    </p>
                </section>

                <section class="space-y-4">
                    <h2 class="text-display-m font-bold text-neutral-900">Intellectual Property</h2>
                    <p class="text-neutral-600 leading-relaxed">
                        All content on this website, including text, graphics, logos, and software, is the property of IoT Bay or its content suppliers and is protected by copyright and other intellectual property laws.
                    </p>
                </section>

                <section class="space-y-4">
                    <h2 class="text-display-m font-bold text-neutral-900">Limitation of Liability</h2>
                    <p class="text-neutral-600 leading-relaxed">
                        To the maximum extent permitted by law, IoT Bay shall not be liable for any indirect, incidental, special, or consequential damages arising from your use of our services.
                    </p>
                </section>

                <section class="space-y-4">
                    <h2 class="text-display-m font-bold text-neutral-900">Governing Law</h2>
                    <p class="text-neutral-600 leading-relaxed">
                        These Terms shall be governed by and construed in accordance with the laws of New South Wales, Australia, without regard to its conflict of law provisions.
                    </p>
                </section>

                <section class="space-y-4">
                    <h2 class="text-display-m font-bold text-neutral-900">Changes to Terms</h2>
                    <p class="text-neutral-600 leading-relaxed">
                        We reserve the right to modify these Terms at any time. Changes will be effective immediately upon posting. Your continued use of our services constitutes acceptance of the modified Terms.
                    </p>
                </section>

                <section class="space-y-4">
                    <h2 class="text-display-m font-bold text-neutral-900">Contact Us</h2>
                    <p class="text-neutral-600 leading-relaxed">
                        If you have questions about these Terms, please contact us at:
                    </p>
                    <address class="not-italic text-neutral-600">
                        <p>Email: <a href="mailto:legal@iotbay.com" class="text-brand-primary hover:underline">legal@iotbay.com</a></p>
                        <p>Phone: 1-800-IOT-TECH</p>
                    </address>
                </section>
            </article>
        </div>
    </main>
</t:base>

