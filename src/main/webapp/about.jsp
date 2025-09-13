<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en" data-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="About IoT Bay - Leading provider of innovative IoT solutions for smart homes, industry, and beyond">
    <title>About Us | IoT Bay - Smart Technology Store</title>
    
    <!-- CSS -->
    <link rel="stylesheet" href="<%= contextPath %>/css/modern-theme.css?v=2">
    
    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body class="antialiased bg-neutral-50 text-neutral-900 min-h-screen flex flex-col">
    
    <!-- Header -->
    <jsp:include page="components/header.jsp" />

    <!-- Hero Section -->
    <section class="hero-section relative overflow-hidden">
        <div class="absolute inset-0 bg-gradient-to-br from-brand-primary-50 via-neutral-50 to-brand-secondary-50"></div>
        <div class="absolute inset-0">
            <div class="absolute top-20 left-10 w-72 h-72 bg-brand-primary-200 rounded-full mix-blend-multiply filter blur-xl opacity-70 animate-pulse"></div>
            <div class="absolute top-40 right-10 w-72 h-72 bg-brand-secondary-200 rounded-full mix-blend-multiply filter blur-xl opacity-70 animate-pulse animation-delay-2000"></div>
            <div class="absolute -bottom-8 left-20 w-72 h-72 bg-accent-200 rounded-full mix-blend-multiply filter blur-xl opacity-70 animate-pulse animation-delay-4000"></div>
        </div>
        <div class="container relative z-10 py-20">
            <div class="max-w-4xl mx-auto text-center">
                <h1 class="text-4xl md:text-6xl font-bold tracking-tight text-neutral-900 mb-6">
                    About <span class="text-transparent bg-clip-text bg-gradient-to-r from-brand-primary to-brand-secondary">IoT Bay</span>
                </h1>
                <p class="text-lg md:text-xl text-neutral-600 mb-8 max-w-2xl mx-auto">
                    We're revolutionizing the IoT landscape with cutting-edge technology, 
                    elegant design, and unwavering commitment to quality.
                </p>
                <div class="flex flex-wrap gap-4 justify-center">
                    <a href="#our-story" class="btn btn--primary btn--lg">
                        Our Story
                    </a>
                    <a href="#our-team" class="btn btn--outline btn--lg">
                        Meet the Team
                    </a>
                </div>
            </div>
        </div>
    </section>

    <!-- Our Story Section -->
    <section id="our-story" class="py-20">
        <div class="container">
            <div class="grid-story">
                <div class="space-y-6">
                    <div class="inline-flex items-center px-4 py-2 rounded-full bg-brand-primary-100 text-brand-primary-800 text-sm font-medium">
                        <svg class="w-4 h-4 mr-2" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                        </svg>
                        Our Story
                    </div>
                    <h2 class="text-3xl md:text-4xl font-bold text-neutral-900">
                        Building the Future of Connected Living
                    </h2>
                    <p class="text-lg text-neutral-600 mb-6">
                        Founded in 2020, IoT Bay emerged from a simple yet powerful vision: to make 
                        smart technology accessible, reliable, and beautiful for everyone. We believe 
                        that the Internet of Things should enhance human life, not complicate it.
                    </p>
                    <p class="text-lg text-neutral-600 mb-8">
                        Our journey began when our founders, frustrated with the complexity and 
                        unreliability of existing IoT solutions, decided to create something better. 
                        Today, we're proud to serve over 50,000 customers worldwide with our 
                        innovative, user-friendly IoT ecosystem.
                    </p>
                    <div class="grid grid-cols-2 gap-6">
                        <div class="text-center">
                            <div class="text-3xl font-bold text-brand-primary mb-2">50K+</div>
                            <div class="text-sm text-neutral-600">Happy Customers</div>
                        </div>
                        <div class="text-center">
                            <div class="text-3xl font-bold text-brand-secondary mb-2">99.9%</div>
                            <div class="text-sm text-neutral-600">Uptime</div>
                        </div>
                    </div>
                </div>
                <div class="relative">
                    <div class="aspect-square rounded-2xl bg-gradient-to-br from-brand-primary-100 to-brand-secondary-100 p-8">
                        <img src="<%= contextPath %>/images/hero.png" 
                             alt="IoT Bay team working on innovative solutions" 
                             class="w-full h-full object-cover rounded-xl shadow-2xl">
                    </div>
                    <div class="absolute -bottom-6 -right-6 w-24 h-24 bg-accent-400 rounded-full flex items-center justify-center shadow-lg">
                        <svg class="w-12 h-12 text-white" fill="currentColor" viewBox="0 0 20 20">
                            <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path>
                        </svg>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Mission & Vision Section -->
    <section class="py-20 bg-neutral-900">
        <div class="container">
            <div class="text-center mb-16">
                <h2 class="text-3xl md:text-4xl font-bold text-white mb-4">
                    Mission & Vision
                </h2>
                <p class="text-lg text-neutral-300 max-w-3xl mx-auto">
                    Driving the future of connected technology with purpose and innovation
                </p>
            </div>
            
            <div class="grid-mission">
                <!-- Mission -->
                <div class="card bg-neutral-800 border-neutral-700">
                    <div class="flex items-start space-x-4">
                        <div class="flex-shrink-0 w-12 h-12 bg-brand-primary rounded-lg flex items-center justify-center">
                            <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                      d="M13 10V3L4 14h7v7l9-11h-7z"></path>
                            </svg>
                        </div>
                        <div>
                            <h3 class="text-xl font-semibold text-white mb-3">Our Mission</h3>
                            <p class="text-neutral-300">
                                To accelerate the adoption of IoT technology by providing innovative, 
                                reliable, and accessible solutions that enhance productivity, 
                                sustainability, and quality of life for individuals and organizations worldwide.
                            </p>
                        </div>
                    </div>
                </div>
                
                <!-- Vision -->
                <div class="card bg-neutral-800 border-neutral-700">
                    <div class="flex items-start space-x-4">
                        <div class="flex-shrink-0 w-12 h-12 bg-brand-secondary rounded-lg flex items-center justify-center">
                            <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                      d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path>
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                      d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path>
                            </svg>
                        </div>
                        <div>
                            <h3 class="text-xl font-semibold text-white mb-3">Our Vision</h3>
                            <p class="text-neutral-300">
                                To be the global leader in IoT technology distribution and innovation, 
                                creating a seamlessly connected world where smart technology empowers 
                                every person and organization to achieve their full potential.
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Values Section -->
    <section class="py-20">
        <div class="container">
            <div class="text-center mb-16">
                <h2 class="text-3xl md:text-4xl font-bold text-neutral-900 mb-4">
                    Our Core Values
                </h2>
                <p class="text-lg text-neutral-600 max-w-3xl mx-auto">
                    The principles that guide everything we do
                </p>
            </div>
            
            <div class="grid-values">
                <!-- Innovation -->
                <div class="card hover-lift text-center">
                    <div class="w-16 h-16 bg-gradient-to-br from-brand-primary to-brand-secondary rounded-2xl flex items-center justify-center mx-auto mb-6">
                        <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                  d="M9.663 17h4.673M12 3v1m6.364 1.636l-.707.707M21 12h-1M4 12H3m3.343-5.657l-.707-.707m2.828 9.9a5 5 0 117.072 0l-.548.547A3.374 3.374 0 0014 18.469V19a2 2 0 11-4 0v-.531c0-.895-.356-1.754-.988-2.386l-.548-.547z"></path>
                        </svg>
                    </div>
                    <h3 class="text-xl font-semibold text-neutral-900 mb-3">Innovation</h3>
                    <p class="text-neutral-600">
                        We constantly push the boundaries of what's possible, 
                        developing cutting-edge solutions that anticipate future needs.
                    </p>
                </div>

                <!-- Quality -->
                <div class="card hover-lift text-center">
                    <div class="w-16 h-16 bg-gradient-to-br from-success to-success-600 rounded-2xl flex items-center justify-center mx-auto mb-6">
                        <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                  d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                        </svg>
                    </div>
                    <h3 class="text-xl font-semibold text-neutral-900 mb-3">Quality</h3>
                    <p class="text-neutral-600">
                        Every product and service we deliver meets the highest standards 
                        of reliability, performance, and user experience.
                    </p>
                </div>

                <!-- Accessibility -->
                <div class="card hover-lift text-center">
                    <div class="w-16 h-16 bg-gradient-to-br from-warning to-warning-600 rounded-2xl flex items-center justify-center mx-auto mb-6">
                        <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                  d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"></path>
                        </svg>
                    </div>
                    <h3 class="text-xl font-semibold text-neutral-900 mb-3">Accessibility</h3>
                    <p class="text-neutral-600">
                        We believe technology should be inclusive, making advanced 
                        IoT solutions accessible to everyone, regardless of technical expertise.
                    </p>
                </div>
            </div>
        </div>
    </section>

    <!-- Team Section -->
    <section id="our-team" class="py-20 bg-neutral-900">
        <div class="container">
            <div class="text-center mb-16">
                <h2 class="text-3xl md:text-4xl font-bold text-white mb-4">
                    Meet Our Team
                </h2>
                <p class="text-lg text-neutral-300 max-w-3xl mx-auto">
                    The passionate individuals behind IoT Bay's success
                </p>
            </div>
            
            <div class="grid-team">
                <!-- Team Member 1 -->
                <div class="card bg-neutral-800 border-neutral-700 text-center">
                    <div class="w-32 h-32 bg-gradient-to-br from-brand-primary to-brand-secondary rounded-full mx-auto mb-6 flex items-center justify-center">
                        <img src="<%= contextPath %>/images/welcome.png" 
                             alt="Sarah Chen - CEO & Founder" 
                             class="w-28 h-28 rounded-full object-cover">
                    </div>
                    <h3 class="text-xl font-semibold text-white mb-2">Sarah Chen</h3>
                    <p class="text-brand-primary-400 mb-4">CEO & Founder</p>
                    <p class="text-neutral-300 text-sm">
                        Former IoT engineer at Microsoft with 15+ years experience in connected systems and product strategy.
                    </p>
                </div>

                <!-- Team Member 2 -->
                <div class="card bg-neutral-800 border-neutral-700 text-center">
                    <div class="w-32 h-32 bg-gradient-to-br from-success to-success-600 rounded-full mx-auto mb-6 flex items-center justify-center">
                        <img src="<%= contextPath %>/images/sample1.png" 
                             alt="Marcus Wong - CTO" 
                             class="w-28 h-28 rounded-full object-cover">
                    </div>
                    <h3 class="text-xl font-semibold text-white mb-2">Marcus Wong</h3>
                    <p class="text-success-400 mb-4">Chief Technology Officer</p>
                    <p class="text-neutral-300 text-sm">
                        Full-stack developer and IoT architect with expertise in cloud platforms and embedded systems.
                    </p>
                </div>

                <!-- Team Member 3 -->
                <div class="card bg-neutral-800 border-neutral-700 text-center">
                    <div class="w-32 h-32 bg-gradient-to-br from-warning to-warning-600 rounded-full mx-auto mb-6 flex items-center justify-center">
                        <img src="<%= contextPath %>/images/sample2.png" 
                             alt="Emily Rodriguez - Head of Sales" 
                             class="w-28 h-28 rounded-full object-cover">
                    </div>
                    <h3 class="text-xl font-semibold text-white mb-2">Emily Rodriguez</h3>
                    <p class="text-warning-400 mb-4">Head of Sales</p>
                    <p class="text-neutral-300 text-sm">
                        Sales strategist with 12+ years in technology, specializing in IoT solutions for enterprise clients.
                    </p>
                </div>

                <!-- Team Member 4 -->
                <div class="card bg-neutral-800 border-neutral-700 text-center">
                    <div class="w-32 h-32 bg-gradient-to-br from-accent to-accent-600 rounded-full mx-auto mb-6 flex items-center justify-center">
                        <img src="<%= contextPath %>/images/sample3.png" 
                             alt="David Kim - Head of Engineering" 
                             class="w-28 h-28 rounded-full object-cover">
                    </div>
                    <h3 class="text-xl font-semibold text-white mb-2">David Kim</h3>
                    <p class="text-accent-400 mb-4">Head of Engineering</p>
                    <p class="text-neutral-300 text-sm">
                        Hardware engineer with expertise in sensor design, wireless protocols, and product development.
                    </p>
                </div>

                <!-- Team Member 5 -->
                <div class="card bg-neutral-800 border-neutral-700 text-center">
                    <div class="w-32 h-32 bg-gradient-to-br from-info to-info-600 rounded-full mx-auto mb-6 flex items-center justify-center">
                        <img src="<%= contextPath %>/images/welcome.png" 
                             alt="Lisa Thompson - Customer Success Manager" 
                             class="w-28 h-28 rounded-full object-cover">
                    </div>
                    <h3 class="text-xl font-semibold text-white mb-2">Lisa Thompson</h3>
                    <p class="text-info-400 mb-4">Customer Success Manager</p>
                    <p class="text-neutral-300 text-sm">
                        Customer experience specialist focused on ensuring client satisfaction and successful IoT implementations.
                    </p>
                </div>

                <!-- Team Member 6 -->
                <div class="card bg-neutral-800 border-neutral-700 text-center">
                    <div class="w-32 h-32 bg-gradient-to-br from-brand-secondary to-brand-secondary-600 rounded-full mx-auto mb-6 flex items-center justify-center">
                        <img src="<%= contextPath %>/images/sample1.png" 
                             alt="Alex Patel - DevOps Engineer" 
                             class="w-28 h-28 rounded-full object-cover">
                    </div>
                    <h3 class="text-xl font-semibold text-white mb-2">Alex Patel</h3>
                    <p class="text-brand-secondary-400 mb-4">DevOps Engineer</p>
                    <p class="text-neutral-300 text-sm">
                        Infrastructure specialist ensuring scalable, secure, and reliable platform operations and deployments.
                    </p>
                </div>
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="py-20 bg-gradient-to-r from-brand-primary to-brand-secondary">
        <div class="container">
            <div class="text-center">
                <h2 class="text-3xl md:text-4xl font-bold text-white mb-4">
                    Ready to Transform Your World with IoT?
                </h2>
                <p class="text-lg text-brand-primary-100 mb-8">
                    Join thousands of customers who trust IoT Bay for their smart technology needs.
                </p>
                <div class="flex flex-wrap gap-4 justify-center">
                    <a href="<%= contextPath %>/browse.jsp" class="btn btn--white btn--lg">
                        Shop Products
                    </a>
                    <a href="<%= contextPath %>/contact.jsp" class="btn btn--outline-white btn--lg">
                        Contact Us
                    </a>
                </div>
            </div>
        </div>
    </section>
    
    <!-- Footer -->
    <jsp:include page="components/footer.jsp" />
    
    <!-- JavaScript -->
    <script src="<%= contextPath %>/js/main.js"></script>
    
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
</body>
</html>