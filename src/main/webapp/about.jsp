<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>

<%
    String contextPath = request.getContextPath();
%>

<t:base title="About Us" description="About IoT Bay - Leading provider of innovative IoT solutions for smart homes, industry, and beyond">
    <!-- Hero Section -->
    <section class="py-16 md:py-24 bg-neutral-900 text-white">
        <div class="container">
            <!-- Optimized for 1920x1080 -->
            <div class="grid gap-12 lg:grid-cols-[minmax(0,1fr)_minmax(0,480px)] xl:grid-cols-[minmax(0,1fr)_minmax(0,560px)] items-center">
                <div class="space-y-6 text-center lg:text-left">
                    <p class="inline-flex items-center justify-center lg:justify-start gap-2 text-xs font-semibold uppercase tracking-wide text-white/80">
                        <span class="inline-flex h-2 w-2 rounded-full bg-brand-secondary"></span>
                        Trusted by engineers and teams worldwide
                    </p>
                    <h1 class="text-display-xl font-extrabold leading-tight">
                        About IoT Bay
                    </h1>
                    <p class="text-lg md:text-xl text-neutral-200 max-w-2xl mx-auto lg:mx-0">
                        We're revolutionizing the IoT landscape with cutting-edge technology, elegant design, and unwavering commitment to quality.
                    </p>
                    <div class="flex flex-col sm:flex-row sm:justify-start gap-3 sm:gap-4 max-w-xl mx-auto lg:mx-0">
                        <a href="#our-story" class="btn btn--primary btn--lg sm:flex-1" aria-label="Read our story">
                            Our Story
                        </a>
                        <a href="#our-team" class="btn btn--secondary btn--lg sm:flex-1" aria-label="Meet our team">
                            Meet the Team
                        </a>
                    </div>
                </div>
                <figure class="relative">
                    <img src="${pageContext.request.contextPath}/images/hero.png" 
                         alt="IoT Bay team collaborating on innovative IoT solutions"
                         class="w-full h-auto rounded-2xl shadow-xl object-cover">
                    <figcaption class="sr-only">Photo of the IoT Bay team working together on innovative solutions.</figcaption>
                </figure>
            </div>
        </div>
    </section>

    <!-- Our Story Section -->
    <section id="our-story" class="py-16 md:py-24">
        <div class="container">
            <!-- Optimized for 1920x1080 -->
            <div class="grid gap-12 lg:grid-cols-[minmax(0,1fr)_minmax(0,480px)] xl:grid-cols-[minmax(0,1fr)_minmax(0,560px)] items-center">
                <div class="space-y-6">
                    <span class="inline-flex items-center gap-2 rounded-full bg-brand-primary-100 px-3 py-1 text-sm font-semibold text-brand-primary-800">
                        <span class="inline-flex h-2 w-2 rounded-full bg-brand-primary"></span>
                        Our Story
                    </span>
                    <h2 class="text-display-l font-bold text-neutral-900 leading-tight">
                        Building the future of connected living
                    </h2>
                    <div class="space-y-4 text-lg text-neutral-600">
                        <p>
                            Founded in 2020, IoT Bay emerged from a simple yet powerful vision: to make 
                            smart technology accessible, reliable, and beautiful for everyone. We believe 
                            that the Internet of Things should enhance human life, not complicate it.
                        </p>
                        <p>
                            Our journey began when our founders, frustrated with the complexity and 
                            unreliability of existing IoT solutions, decided to create something better. 
                            Today, we're proud to serve over 50,000 customers worldwide with our 
                            innovative, user-friendly IoT ecosystem.
                        </p>
                    </div>
                    <dl class="grid grid-cols-2 gap-6 pt-4">
                        <div class="rounded-2xl border border-neutral-200 bg-white p-6 text-center" role="group" aria-label="Customer count">
                            <dt class="text-3xl font-bold text-brand-primary mb-2">50K+</dt>
                            <dd class="text-sm text-neutral-600">Happy Customers</dd>
                        </div>
                        <div class="rounded-2xl border border-neutral-200 bg-white p-6 text-center" role="group" aria-label="Uptime reliability">
                            <dt class="text-3xl font-bold text-brand-secondary mb-2">99.9%</dt>
                            <dd class="text-sm text-neutral-600">Uptime</dd>
                        </div>
                    </dl>
                </div>
                <figure class="relative">
                    <img src="${pageContext.request.contextPath}/images/hero.png" 
                         alt="IoT Bay team collaborating on innovative solutions in a modern workspace"
                         class="w-full h-auto rounded-2xl shadow-xl object-cover">
                    <figcaption class="sr-only">Photo of the IoT Bay team working together on innovative solutions.</figcaption>
                </figure>
            </div>
        </div>
    </section>

    <!-- Mission & Vision Section -->
    <section class="py-16 md:py-24 bg-neutral-900 text-white">
        <div class="container">
            <header class="text-center mb-12 space-y-4">
                <h2 class="text-display-l font-bold text-white">
                    Mission & Vision
                </h2>
                <p class="text-lg text-neutral-300 max-w-3xl mx-auto">
                    Driving the future of connected technology with purpose and innovation
                </p>
            </header>
            
            <div class="grid gap-8 md:grid-cols-2">
                <!-- Mission -->
                <article class="rounded-2xl border border-neutral-700 bg-neutral-800 p-8" role="group" aria-label="Our mission">
                    <div class="flex items-start gap-4">
                        <div class="flex-shrink-0 w-12 h-12 bg-brand-primary rounded-lg flex items-center justify-center" aria-hidden="true">
                            <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z"></path>
                            </svg>
                        </div>
                        <div class="space-y-3">
                            <h3 class="text-xl font-semibold text-white">Our Mission</h3>
                            <p class="text-neutral-300 leading-relaxed">
                                To accelerate the adoption of IoT technology by providing innovative, 
                                reliable, and accessible solutions that enhance productivity, 
                                sustainability, and quality of life for individuals and organizations worldwide.
                            </p>
                        </div>
                    </div>
                </article>
                
                <!-- Vision -->
                <article class="rounded-2xl border border-neutral-700 bg-neutral-800 p-8" role="group" aria-label="Our vision">
                    <div class="flex items-start gap-4">
                        <div class="flex-shrink-0 w-12 h-12 bg-brand-secondary rounded-lg flex items-center justify-center" aria-hidden="true">
                            <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path>
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path>
                            </svg>
                        </div>
                        <div class="space-y-3">
                            <h3 class="text-xl font-semibold text-white">Our Vision</h3>
                            <p class="text-neutral-300 leading-relaxed">
                                To be the global leader in IoT technology distribution and innovation, 
                                creating a seamlessly connected world where smart technology empowers 
                                every person and organization to achieve their full potential.
                            </p>
                        </div>
                    </div>
                </article>
            </div>
        </div>
    </section>

    <!-- Values Section -->
    <section class="py-16 md:py-24">
        <div class="container">
            <header class="text-center mb-12 space-y-4">
                <h2 class="text-display-l font-bold text-neutral-900">
                    Our Core Values
                </h2>
                <p class="text-lg text-neutral-600 max-w-3xl mx-auto">
                    The principles that guide everything we do
                </p>
            </header>
            
            <ul class="grid gap-8 md:grid-cols-3" role="list">
                <!-- Innovation -->
                <li class="rounded-2xl border border-neutral-200 bg-white p-8 text-center shadow-sm" role="group" aria-label="Innovation value">
                    <div class="w-16 h-16 bg-gradient-to-br from-brand-primary to-brand-secondary rounded-2xl flex items-center justify-center mx-auto mb-6" aria-hidden="true">
                        <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9.663 17h4.673M12 3v1m6.364 1.636l-.707.707M21 12h-1M4 12H3m3.343-5.657l-.707-.707m2.828 9.9a5 5 0 117.072 0l-.548.547A3.374 3.374 0 0014 18.469V19a2 2 0 11-4 0v-.531c0-.895-.356-1.754-.988-2.386l-.548-.547z"></path>
                        </svg>
                    </div>
                    <h3 class="text-xl font-semibold text-neutral-900 mb-3">Innovation</h3>
                    <p class="text-neutral-600 leading-relaxed">
                        We constantly push the boundaries of what's possible, 
                        developing cutting-edge solutions that anticipate future needs.
                    </p>
                </li>

                <!-- Quality -->
                <li class="rounded-2xl border border-neutral-200 bg-white p-8 text-center shadow-sm" role="group" aria-label="Quality value">
                    <div class="w-16 h-16 bg-gradient-to-br from-success to-success-600 rounded-2xl flex items-center justify-center mx-auto mb-6" aria-hidden="true">
                        <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                        </svg>
                    </div>
                    <h3 class="text-xl font-semibold text-neutral-900 mb-3">Quality</h3>
                    <p class="text-neutral-600 leading-relaxed">
                        Every product and service we deliver meets the highest standards 
                        of reliability, performance, and user experience.
                    </p>
                </li>

                <!-- Accessibility -->
                <li class="rounded-2xl border border-neutral-200 bg-white p-8 text-center shadow-sm" role="group" aria-label="Accessibility value">
                    <div class="w-16 h-16 bg-gradient-to-br from-warning to-warning-600 rounded-2xl flex items-center justify-center mx-auto mb-6" aria-hidden="true">
                        <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"></path>
                        </svg>
                    </div>
                    <h3 class="text-xl font-semibold text-neutral-900 mb-3">Accessibility</h3>
                    <p class="text-neutral-600 leading-relaxed">
                        We believe technology should be inclusive, making advanced 
                        IoT solutions accessible to everyone, regardless of technical expertise.
                    </p>
                </li>
            </ul>
        </div>
    </section>

    <!-- Team Section -->
    <section id="our-team" class="py-16 md:py-24 bg-neutral-900 text-white">
        <div class="container">
            <header class="text-center mb-12 space-y-4">
                <h2 class="text-display-l font-bold text-white">
                    Meet Our Team
                </h2>
                <p class="text-lg text-neutral-300 max-w-3xl mx-auto">
                    The passionate individuals behind IoT Bay's success
                </p>
            </header>
            
            <ul class="grid gap-8 md:grid-cols-2 lg:grid-cols-3" role="list">
                <!-- Team Member 1 -->
                <li class="rounded-2xl border border-neutral-700 bg-neutral-800 p-8 text-center" role="group" aria-label="Team member: Sarah Chen">
                    <figure class="mb-6">
                        <div class="w-32 h-32 bg-gradient-to-br from-brand-primary to-brand-secondary rounded-full mx-auto flex items-center justify-center">
                            <img src="${pageContext.request.contextPath}/images/welcome.png" 
                                 alt="Sarah Chen, CEO & Founder" 
                                 class="w-28 h-28 rounded-full object-cover">
                        </div>
                        <figcaption class="sr-only">Sarah Chen, CEO & Founder</figcaption>
                    </figure>
                    <h3 class="text-xl font-semibold text-white mb-2">Sarah Chen</h3>
                    <p class="text-brand-primary-400 mb-4 font-medium">CEO & Founder</p>
                    <p class="text-neutral-300 text-sm leading-relaxed">
                        Former IoT engineer at Microsoft with 15+ years experience in connected systems and product strategy.
                    </p>
                </li>

                <!-- Team Member 2 -->
                <li class="rounded-2xl border border-neutral-700 bg-neutral-800 p-8 text-center" role="group" aria-label="Team member: Marcus Wong">
                    <figure class="mb-6">
                        <div class="w-32 h-32 bg-gradient-to-br from-success to-success-600 rounded-full mx-auto flex items-center justify-center">
                            <img src="${pageContext.request.contextPath}/images/sample1.png" 
                                 alt="Marcus Wong, Chief Technology Officer" 
                                 class="w-28 h-28 rounded-full object-cover">
                        </div>
                        <figcaption class="sr-only">Marcus Wong, Chief Technology Officer</figcaption>
                    </figure>
                    <h3 class="text-xl font-semibold text-white mb-2">Marcus Wong</h3>
                    <p class="text-success-400 mb-4 font-medium">Chief Technology Officer</p>
                    <p class="text-neutral-300 text-sm leading-relaxed">
                        Full-stack developer and IoT architect with expertise in cloud platforms and embedded systems.
                    </p>
                </li>

                <!-- Team Member 3 -->
                <li class="rounded-2xl border border-neutral-700 bg-neutral-800 p-8 text-center" role="group" aria-label="Team member: Emily Rodriguez">
                    <figure class="mb-6">
                        <div class="w-32 h-32 bg-gradient-to-br from-warning to-warning-600 rounded-full mx-auto flex items-center justify-center">
                            <img src="${pageContext.request.contextPath}/images/sample2.png" 
                                 alt="Emily Rodriguez, Head of Sales" 
                                 class="w-28 h-28 rounded-full object-cover">
                        </div>
                        <figcaption class="sr-only">Emily Rodriguez, Head of Sales</figcaption>
                    </figure>
                    <h3 class="text-xl font-semibold text-white mb-2">Emily Rodriguez</h3>
                    <p class="text-warning-400 mb-4 font-medium">Head of Sales</p>
                    <p class="text-neutral-300 text-sm leading-relaxed">
                        Sales strategist with 12+ years in technology, specializing in IoT solutions for enterprise clients.
                    </p>
                </li>

                <!-- Team Member 4 -->
                <li class="rounded-2xl border border-neutral-700 bg-neutral-800 p-8 text-center" role="group" aria-label="Team member: David Kim">
                    <figure class="mb-6">
                        <div class="w-32 h-32 bg-gradient-to-br from-accent to-accent-600 rounded-full mx-auto flex items-center justify-center">
                            <img src="${pageContext.request.contextPath}/images/sample3.png" 
                                 alt="David Kim, Head of Engineering" 
                                 class="w-28 h-28 rounded-full object-cover">
                        </div>
                        <figcaption class="sr-only">David Kim, Head of Engineering</figcaption>
                    </figure>
                    <h3 class="text-xl font-semibold text-white mb-2">David Kim</h3>
                    <p class="text-accent-400 mb-4 font-medium">Head of Engineering</p>
                    <p class="text-neutral-300 text-sm leading-relaxed">
                        Hardware engineer with expertise in sensor design, wireless protocols, and product development.
                    </p>
                </li>

                <!-- Team Member 5 -->
                <li class="rounded-2xl border border-neutral-700 bg-neutral-800 p-8 text-center" role="group" aria-label="Team member: Lisa Thompson">
                    <figure class="mb-6">
                        <div class="w-32 h-32 bg-gradient-to-br from-info to-info-600 rounded-full mx-auto flex items-center justify-center">
                            <img src="${pageContext.request.contextPath}/images/welcome.png" 
                                 alt="Lisa Thompson, Customer Success Manager" 
                                 class="w-28 h-28 rounded-full object-cover">
                        </div>
                        <figcaption class="sr-only">Lisa Thompson, Customer Success Manager</figcaption>
                    </figure>
                    <h3 class="text-xl font-semibold text-white mb-2">Lisa Thompson</h3>
                    <p class="text-info-400 mb-4 font-medium">Customer Success Manager</p>
                    <p class="text-neutral-300 text-sm leading-relaxed">
                        Customer experience specialist focused on ensuring client satisfaction and successful IoT implementations.
                    </p>
                </li>

                <!-- Team Member 6 -->
                <li class="rounded-2xl border border-neutral-700 bg-neutral-800 p-8 text-center" role="group" aria-label="Team member: Alex Patel">
                    <figure class="mb-6">
                        <div class="w-32 h-32 bg-gradient-to-br from-brand-secondary to-brand-secondary-600 rounded-full mx-auto flex items-center justify-center">
                            <img src="${pageContext.request.contextPath}/images/sample1.png" 
                                 alt="Alex Patel, DevOps Engineer" 
                                 class="w-28 h-28 rounded-full object-cover">
                        </div>
                        <figcaption class="sr-only">Alex Patel, DevOps Engineer</figcaption>
                    </figure>
                    <h3 class="text-xl font-semibold text-white mb-2">Alex Patel</h3>
                    <p class="text-brand-secondary-400 mb-4 font-medium">DevOps Engineer</p>
                    <p class="text-neutral-300 text-sm leading-relaxed">
                        Infrastructure specialist ensuring scalable, secure, and reliable platform operations and deployments.
                    </p>
                </li>
            </ul>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="py-16 md:py-24 bg-gradient-to-r from-brand-primary to-brand-secondary text-white">
        <div class="container">
            <div class="max-w-3xl mx-auto text-center space-y-8">
                <h2 class="text-display-l font-bold text-white">
                    Ready to transform your world with IoT?
                </h2>
                <p class="text-lg text-white/90">
                    Join thousands of customers who trust IoT Bay for their smart technology needs.
                </p>
                <div class="flex flex-col sm:flex-row gap-4 justify-center">
                    <a href="${pageContext.request.contextPath}/browse.jsp" class="btn btn--white btn--lg" aria-label="Browse our products">
                        Shop Products
                    </a>
                    <a href="${pageContext.request.contextPath}/contact.jsp" class="btn btn--outline-white btn--lg" aria-label="Contact our team">
                        Contact Us
                    </a>
                </div>
            </div>
        </div>
    </section>
</t:base>

<script>
    // Smooth scrolling for anchor links
    document.addEventListener('DOMContentLoaded', function() {
        const anchorLinks = document.querySelectorAll('a[href^="#"]');
        
        anchorLinks.forEach(link => {
            link.addEventListener('click', function(e) {
                e.preventDefault();
                
                const targetId = this.getAttribute('href').substring(1);
                const targetElement = document.getElementById(targetId);
                
                if (targetElement) {
                    targetElement.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });
    });
</script>
