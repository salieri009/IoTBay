<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>

<t:base title="Privacy Policy - IoT Bay" description="Privacy policy and data protection information for IoT Bay">
    <main class="py-12">
        <div class="container space-y-12 max-w-4xl">
            <!-- Hero Section -->
            <section class="text-center space-y-6">
                <p class="inline-flex items-center justify-center gap-2 text-xs font-semibold uppercase tracking-wide text-neutral-500">
                    <span class="inline-flex h-2 w-2 rounded-full bg-brand-primary"></span>
                    Your privacy matters
                </p>
                <h1 class="text-display-xl font-extrabold text-neutral-900 leading-tight">
                    Privacy Policy
                </h1>
                <p class="text-lg md:text-xl text-neutral-600 max-w-2xl mx-auto">
                    Last updated: January 2025
                </p>
            </section>

            <!-- Privacy Policy Content -->
            <article class="prose prose-neutral max-w-none space-y-8">
                <section class="space-y-4">
                    <h2 class="text-display-m font-bold text-neutral-900">Introduction</h2>
                    <p class="text-neutral-600 leading-relaxed">
                        IoT Bay ("we," "our," or "us") is committed to protecting your privacy. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you visit our website and use our services.
                    </p>
                </section>

                <section class="space-y-4">
                    <h2 class="text-display-m font-bold text-neutral-900">Information We Collect</h2>
                    <h3 class="text-lg font-semibold text-neutral-900">Personal Information</h3>
                    <p class="text-neutral-600 leading-relaxed">
                        We collect information that you provide directly to us, including:
                    </p>
                    <ul class="space-y-2 text-neutral-600 list-disc list-inside">
                        <li>Name, email address, and phone number</li>
                        <li>Shipping and billing addresses</li>
                        <li>Payment information (processed securely through third-party providers)</li>
                        <li>Account credentials and preferences</li>
                        <li>Order history and purchase information</li>
                    </ul>

                    <h3 class="text-lg font-semibold text-neutral-900 mt-6">Automatically Collected Information</h3>
                    <p class="text-neutral-600 leading-relaxed">
                        When you visit our website, we automatically collect certain information, including:
                    </p>
                    <ul class="space-y-2 text-neutral-600 list-disc list-inside">
                        <li>IP address and device information</li>
                        <li>Browser type and version</li>
                        <li>Pages visited and time spent on pages</li>
                        <li>Referring website addresses</li>
                        <li>Cookies and similar tracking technologies</li>
                    </ul>
                </section>

                <section class="space-y-4">
                    <h2 class="text-display-m font-bold text-neutral-900">How We Use Your Information</h2>
                    <p class="text-neutral-600 leading-relaxed">
                        We use the information we collect to:
                    </p>
                    <ul class="space-y-2 text-neutral-600 list-disc list-inside">
                        <li>Process and fulfill your orders</li>
                        <li>Communicate with you about your orders and account</li>
                        <li>Send you marketing communications (with your consent)</li>
                        <li>Improve our website and services</li>
                        <li>Detect and prevent fraud</li>
                        <li>Comply with legal obligations</li>
                    </ul>
                </section>

                <section class="space-y-4">
                    <h2 class="text-display-m font-bold text-neutral-900">Data Sharing</h2>
                    <p class="text-neutral-600 leading-relaxed">
                        We do not sell your personal information. We may share your information with:
                    </p>
                    <ul class="space-y-2 text-neutral-600 list-disc list-inside">
                        <li>Service providers who assist in operating our website and processing payments</li>
                        <li>Shipping companies to fulfill your orders</li>
                        <li>Legal authorities when required by law</li>
                        <li>Business partners with your explicit consent</li>
                    </ul>
                </section>

                <section class="space-y-4">
                    <h2 class="text-display-m font-bold text-neutral-900">Data Security</h2>
                    <p class="text-neutral-600 leading-relaxed">
                        We implement appropriate technical and organizational measures to protect your personal information against unauthorized access, alteration, disclosure, or destruction. However, no method of transmission over the Internet is 100% secure.
                    </p>
                </section>

                <section class="space-y-4">
                    <h2 class="text-display-m font-bold text-neutral-900">Your Rights</h2>
                    <p class="text-neutral-600 leading-relaxed">
                        You have the right to:
                    </p>
                    <ul class="space-y-2 text-neutral-600 list-disc list-inside">
                        <li>Access your personal information</li>
                        <li>Correct inaccurate information</li>
                        <li>Request deletion of your information</li>
                        <li>Opt-out of marketing communications</li>
                        <li>Request a copy of your data</li>
                    </ul>
                </section>

                <section class="space-y-4">
                    <h2 class="text-display-m font-bold text-neutral-900">Cookies</h2>
                    <p class="text-neutral-600 leading-relaxed">
                        We use cookies to enhance your browsing experience. For more information, please see our <a href="${pageContext.request.contextPath}/cookies" class="text-brand-primary hover:underline">Cookie Policy</a>.
                    </p>
                </section>

                <section class="space-y-4">
                    <h2 class="text-display-m font-bold text-neutral-900">Contact Us</h2>
                    <p class="text-neutral-600 leading-relaxed">
                        If you have questions about this Privacy Policy, please contact us at:
                    </p>
                    <address class="not-italic text-neutral-600">
                        <p>Email: <a href="mailto:privacy@iotbay.com" class="text-brand-primary hover:underline">privacy@iotbay.com</a></p>
                        <p>Phone: 1-800-IOT-TECH</p>
                    </address>
                </section>
            </article>
        </div>
    </main>
</t:base>

