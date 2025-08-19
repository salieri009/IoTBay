<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en" data-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="About IoT Bay - Leading provider of innovative IoT solutions for smart homes, industry, and beyond">
    <title>About Us | IoT Bay - Smart Technology Store</title>
    
    <!-- CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/modern-theme.css">
    
    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body class="antialiased bg-neutral-50 text-neutral-900 min-h-screen flex flex-col">
    
    <!-- Header -->
    <jsp:include page="components/header.jsp" />

    <!-- Masthead (global hero under header) -->
    <jsp:include page="components/masthead.jsp">
        <jsp:param name="title" value="About IoT Bay" />
        <jsp:param name="subtitle" value="Connecting the future with elegant, reliable IoT solutions for everyone" />
        <jsp:param name="image" value="${pageContext.request.contextPath}/images/hero.png" />
        <jsp:param name="size" value="md" />
        <jsp:param name="align" value="left" />
    </jsp:include>

    <!-- Page-specific CTAs under masthead -->
    <section class="py-6">
        <div class="container">
            <div class="flex flex-wrap gap-3">
                <a href="#our-story" class="btn btn--primary btn--md">
                    Our Story
                </a>
                <a href="#our-team" class="btn btn--outline btn--md">
                    Meet the Team
                </a>
            </div>
        </div>
    </section>
    
    <!-- Main Content -->
    <main class="flex-1">
    <!-- Page content starts after masthead -->
        
        <!-- Our Story Section -->
        <section id="our-story" class="story-section py-20">
            <div class="container">
                <div class="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
                    <div class="order-2 lg:order-1">
                        <div class="prose prose-lg">
                            <h2 class="text-3xl md:text-4xl font-bold text-neutral-900 mb-6">
                                Our Story
                            </h2>
                            <p class="text-lg text-neutral-600 mb-6">
                                Founded in 2018, IoT Bay emerged from a simple vision: to democratize access to 
                                cutting-edge Internet of Things technology. What started as a small team of 
                                passionate engineers has grown into a leading provider of IoT solutions across 
                                Australia and beyond.
                            </p>
                            <p class="text-lg text-neutral-600 mb-6">
                                We recognized that while IoT technology had immense potential, it remained 
                                fragmented and often inaccessible to everyday users and small businesses. 
                                Our mission became clear: create a comprehensive platform where anyone could 
                                find, understand, and implement IoT solutions.
                            </p>
                            <p class="text-lg text-neutral-600">
                                Today, we serve thousands of customers worldwide, from smart home enthusiasts 
                                to large-scale industrial operations, providing not just products but complete 
                                ecosystems that transform how people work and live.
                            </p>
                        </div>
                    </div>
                    <div class="order-1 lg:order-2">
                        <div class="relative">
                            <img src="${pageContext.request.contextPath}/images/about/our-story.jpg" 
                                 alt="IoT Bay team working on innovative solutions" 
                                 class="w-full rounded-lg shadow-xl">
                            <div class="absolute inset-0 bg-gradient-to-t from-black/20 to-transparent rounded-lg"></div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        
        <!-- Mission & Vision Section -->
        <section class="mission-section bg-neutral-100 py-20">
            <div class="container">
                <div class="text-center mb-16">
                    <h2 class="text-3xl md:text-4xl font-bold text-neutral-900 mb-4">
                        Mission & Vision
                    </h2>
                    <p class="text-lg text-neutral-600 max-w-3xl mx-auto">
                        Driving the future of connected technology with purpose and innovation
                    </p>
                </div>
                
                <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                    <!-- Mission -->
                    <div class="mission-card">
                        <div class="mission-card__icon">
                            <svg class="w-8 h-8 text-brand-primary" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                      d="M13 10V3L4 14h7v7l9-11h-7z"></path>
                            </svg>
                        </div>
                        <div class="mission-card__content">
                            <h3 class="mission-card__title">Our Mission</h3>
                            <p class="mission-card__text">
                                To accelerate the adoption of IoT technology by providing innovative, 
                                reliable, and accessible solutions that enhance productivity, 
                                sustainability, and quality of life for individuals and organizations worldwide.
                            </p>
                        </div>
                    </div>
                    
                    <!-- Vision -->
                    <div class="mission-card">
                        <div class="mission-card__icon">
                            <svg class="w-8 h-8 text-brand-primary" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                      d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path>
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                      d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path>
                            </svg>
                        </div>
                        <div class="mission-card__content">
                            <h3 class="mission-card__title">Our Vision</h3>
                            <p class="mission-card__text">
                                To be the global leader in IoT technology distribution and innovation, 
                                creating a seamlessly connected world where smart technology empowers 
                                every person and organization to achieve their full potential.
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        
        <!-- Values Section -->
        <section class="values-section py-20">
            <div class="container">
                <div class="text-center mb-16">
                    <h2 class="text-3xl md:text-4xl font-bold text-neutral-900 mb-4">
                        Our Values
                    </h2>
                    <p class="text-lg text-neutral-600 max-w-3xl mx-auto">
                        The principles that guide everything we do
                    </p>
                </div>
                
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
                    <!-- Innovation -->
                    <div class="value-card">
                        <div class="value-card__icon">
                            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                      d="M9.663 17h4.673M12 3v1m6.364 1.636l-.707.707M21 12h-1M4 12H3m3.343-5.657l-.707-.707m2.828 9.9a5 5 0 117.072 0l-.548.547A3.374 3.374 0 0014 18.469V19a2 2 0 11-4 0v-.531c0-.895-.356-1.754-.988-2.386l-.548-.547z"></path>
                            </svg>
                        </div>
                        <h3 class="value-card__title">Innovation</h3>
                        <p class="value-card__text">
                            Continuously pushing boundaries to bring cutting-edge IoT solutions to market.
                        </p>
                    </div>
                    
                    <!-- Quality -->
                    <div class="value-card">
                        <div class="value-card__icon">
                            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                      d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                            </svg>
                        </div>
                        <h3 class="value-card__title">Quality</h3>
                        <p class="value-card__text">
                            Delivering reliable, tested, and high-performance products that exceed expectations.
                        </p>
                    </div>
                    
                    <!-- Accessibility -->
                    <div class="value-card">
                        <div class="value-card__icon">
                            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                      d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197m13.5-9a2.5 2.5 0 11-5 0 2.5 2.5 0 015 0z"></path>
                            </svg>
                        </div>
                        <h3 class="value-card__title">Accessibility</h3>
                        <p class="value-card__text">
                            Making advanced technology understandable and accessible to everyone.
                        </p>
                    </div>
                    
                    <!-- Sustainability -->
                    <div class="value-card">
                        <div class="value-card__icon">
                            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                      d="M5 3v4M3 5h4M6 17v4m-2-2h4m5-16l2.286 6.857L21 12l-5.714 2.143L13 21l-2.286-6.857L5 12l5.714-2.143L13 3z"></path>
                            </svg>
                        </div>
                        <h3 class="value-card__title">Sustainability</h3>
                        <p class="value-card__text">
                            Promoting energy-efficient solutions that benefit both users and the environment.
                        </p>
                    </div>
                </div>
            </div>
        </section>
        
        <!-- Stats Section -->
        <section class="stats-section bg-brand-primary text-white py-12">
            <div class="container">
                <div class="grid grid-cols-2 md:grid-cols-4 gap-8">
                    <div class="stat-item text-center">
                        <div class="stat-number">10,000+</div>
                        <div class="stat-label">Happy Customers</div>
                    </div>
                    <div class="stat-item text-center">
                        <div class="stat-number">500+</div>
                        <div class="stat-label">IoT Products</div>
                    </div>
                    <div class="stat-item text-center">
                        <div class="stat-number">50+</div>
                        <div class="stat-label">Countries Served</div>
                    </div>
                    <div class="stat-item text-center">
                        <div class="stat-number">99.9%</div>
                        <div class="stat-label">Uptime</div>
                    </div>
                </div>
            </div>
        </section>
        
        <!-- Team Section -->
        <section id="our-team" class="team-section py-20">
            <div class="container">
                <div class="text-center mb-16">
                    <h2 class="text-3xl md:text-4xl font-bold text-neutral-900 mb-4">
                        Meet Our Team
                    </h2>
                    <p class="text-lg text-neutral-600 max-w-3xl mx-auto">
                        The passionate professionals driving innovation in IoT technology
                    </p>
                </div>
                
                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
                    <!-- Team Member 1 -->
                    <div class="team-card">
                        <div class="team-card__image">
                            <img src="${pageContext.request.contextPath}/images/team/sarah-chen.jpg" 
                                 alt="Sarah Chen - CEO & Founder" 
                                 class="w-full h-64 object-cover">
                        </div>
                        <div class="team-card__content">
                            <h3 class="team-card__name">Sarah Chen</h3>
                            <p class="team-card__role">CEO & Founder</p>
                            <p class="team-card__bio">
                                Former IoT engineer at Microsoft with 15+ years experience in connected systems and product strategy.
                            </p>
                            <div class="team-card__social">
                                <a href="#" class="team-social-link" aria-label="Sarah's LinkedIn">
                                    <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                                        <path fill-rule="evenodd" d="M16.338 16.338H13.67V12.16c0-.995-.017-2.277-1.387-2.277-1.39 0-1.601 1.086-1.601 2.207v4.248H8.014v-8.59h2.559v1.174h.037c.356-.675 1.227-1.387 2.526-1.387 2.703 0 3.203 1.778 3.203 4.092v4.711zM5.005 6.575a1.548 1.548 0 11-.003-3.096 1.548 1.548 0 01.003 3.096zm-1.337 9.763H6.34v-8.59H3.667v8.59zM17.668 1H2.328C1.595 1 1 1.581 1 2.298v15.403C1 18.418 1.595 19 2.328 19h15.34c.734 0 1.332-.582 1.332-1.299V2.298C19 1.581 18.402 1 17.668 1z" clip-rule="evenodd"></path>
                                    </svg>
                                </a>
                                <a href="#" class="team-social-link" aria-label="Sarah's Twitter">
                                    <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                                        <path d="M6.29 18.251c7.547 0 11.675-6.253 11.675-11.675 0-.178 0-.355-.012-.53A8.348 8.348 0 0020 3.92a8.19 8.19 0 01-2.357.646 4.118 4.118 0 001.804-2.27 8.224 8.224 0 01-2.605.996 4.107 4.107 0 00-6.993 3.743 11.65 11.65 0 01-8.457-4.287 4.106 4.106 0 001.27 5.477A4.073 4.073 0 01.8 7.713v.052a4.105 4.105 0 003.292 4.022 4.095 4.095 0 01-1.853.07 4.108 4.108 0 003.834 2.85A8.233 8.233 0 010 16.407a11.616 11.616 0 006.29 1.84"></path>
                                    </svg>
                                </a>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Team Member 2 -->
                    <div class="team-card">
                        <div class="team-card__image">
                            <img src="${pageContext.request.contextPath}/images/team/marcus-wong.jpg" 
                                 alt="Marcus Wong - CTO" 
                                 class="w-full h-64 object-cover">
                        </div>
                        <div class="team-card__content">
                            <h3 class="team-card__name">Marcus Wong</h3>
                            <p class="team-card__role">Chief Technology Officer</p>
                            <p class="team-card__bio">
                                Full-stack developer and IoT architect with expertise in cloud platforms and embedded systems.
                            </p>
                            <div class="team-card__social">
                                <a href="#" class="team-social-link" aria-label="Marcus's LinkedIn">
                                    <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                                        <path fill-rule="evenodd" d="M16.338 16.338H13.67V12.16c0-.995-.017-2.277-1.387-2.277-1.39 0-1.601 1.086-1.601 2.207v4.248H8.014v-8.59h2.559v1.174h.037c.356-.675 1.227-1.387 2.526-1.387 2.703 0 3.203 1.778 3.203 4.092v4.711zM5.005 6.575a1.548 1.548 0 11-.003-3.096 1.548 1.548 0 01.003 3.096zm-1.337 9.763H6.34v-8.59H3.667v8.59zM17.668 1H2.328C1.595 1 1 1.581 1 2.298v15.403C1 18.418 1.595 19 2.328 19h15.34c.734 0 1.332-.582 1.332-1.299V2.298C19 1.581 18.402 1 17.668 1z" clip-rule="evenodd"></path>
                                    </svg>
                                </a>
                                <a href="#" class="team-social-link" aria-label="Marcus's GitHub">
                                    <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                                        <path fill-rule="evenodd" d="M10 0C4.477 0 0 4.484 0 10.017c0 4.425 2.865 8.18 6.839 9.504.5.092.682-.217.682-.483 0-.237-.008-.868-.013-1.703-2.782.605-3.369-1.343-3.369-1.343-.454-1.158-1.11-1.466-1.11-1.466-.908-.62.069-.608.069-.608 1.003.07 1.531 1.032 1.531 1.032.892 1.53 2.341 1.088 2.91.832.092-.647.35-1.088.636-1.338-2.22-.253-4.555-1.113-4.555-4.951 0-1.093.39-1.988 1.029-2.688-.103-.253-.446-1.272.098-2.65 0 0 .84-.27 2.75 1.026A9.564 9.564 0 0110 4.844c.85.004 1.705.115 2.504.337 1.909-1.296 2.747-1.027 2.747-1.027.546 1.379.203 2.398.1 2.651.64.7 1.028 1.595 1.028 2.688 0 3.848-2.339 4.695-4.566 4.942.359.31.678.921.678 1.856 0 1.338-.012 2.419-.012 2.747 0 .268.18.58.688.482A10.019 10.019 0 0020 10.017C20 4.484 15.522 0 10 0z" clip-rule="evenodd"></path>
                                    </svg>
                                </a>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Team Member 3 -->
                    <div class="team-card">
                        <div class="team-card__image">
                            <img src="${pageContext.request.contextPath}/images/team/emily-rodriguez.jpg" 
                                 alt="Emily Rodriguez - Head of Sales" 
                                 class="w-full h-64 object-cover">
                        </div>
                        <div class="team-card__content">
                            <h3 class="team-card__name">Emily Rodriguez</h3>
                            <p class="team-card__role">Head of Sales</p>
                            <p class="team-card__bio">
                                Sales strategist with 12+ years in technology, specializing in IoT solutions for enterprise clients.
                            </p>
                            <div class="team-card__social">
                                <a href="#" class="team-social-link" aria-label="Emily's LinkedIn">
                                    <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                                        <path fill-rule="evenodd" d="M16.338 16.338H13.67V12.16c0-.995-.017-2.277-1.387-2.277-1.39 0-1.601 1.086-1.601 2.207v4.248H8.014v-8.59h2.559v1.174h.037c.356-.675 1.227-1.387 2.526-1.387 2.703 0 3.203 1.778 3.203 4.092v4.711zM5.005 6.575a1.548 1.548 0 11-.003-3.096 1.548 1.548 0 01.003 3.096zm-1.337 9.763H6.34v-8.59H3.667v8.59zM17.668 1H2.328C1.595 1 1 1.581 1 2.298v15.403C1 18.418 1.595 19 2.328 19h15.34c.734 0 1.332-.582 1.332-1.299V2.298C19 1.581 18.402 1 17.668 1z" clip-rule="evenodd"></path>
                                    </svg>
                                </a>
                                <a href="#" class="team-social-link" aria-label="Emily's Twitter">
                                    <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                                        <path d="M6.29 18.251c7.547 0 11.675-6.253 11.675-11.675 0-.178 0-.355-.012-.53A8.348 8.348 0 0020 3.92a8.19 8.19 0 01-2.357.646 4.118 4.118 0 001.804-2.27 8.224 8.224 0 01-2.605.996 4.107 4.107 0 00-6.993 3.743 11.65 11.65 0 01-8.457-4.287 4.106 4.106 0 001.27 5.477A4.073 4.073 0 01.8 7.713v.052a4.105 4.105 0 003.292 4.022 4.095 4.095 0 01-1.853.07 4.108 4.108 0 003.834 2.85A8.233 8.233 0 010 16.407a11.616 11.616 0 006.29 1.84"></path>
                                    </svg>
                                </a>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Team Member 4 -->
                    <div class="team-card">
                        <div class="team-card__image">
                            <img src="${pageContext.request.contextPath}/images/team/david-kim.jpg" 
                                 alt="David Kim - Head of Engineering" 
                                 class="w-full h-64 object-cover">
                        </div>
                        <div class="team-card__content">
                            <h3 class="team-card__name">David Kim</h3>
                            <p class="team-card__role">Head of Engineering</p>
                            <p class="team-card__bio">
                                Hardware engineer with expertise in sensor design, wireless protocols, and product development.
                            </p>
                            <div class="team-card__social">
                                <a href="#" class="team-social-link" aria-label="David's LinkedIn">
                                    <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                                        <path fill-rule="evenodd" d="M16.338 16.338H13.67V12.16c0-.995-.017-2.277-1.387-2.277-1.39 0-1.601 1.086-1.601 2.207v4.248H8.014v-8.59h2.559v1.174h.037c.356-.675 1.227-1.387 2.526-1.387 2.703 0 3.203 1.778 3.203 4.092v4.711zM5.005 6.575a1.548 1.548 0 11-.003-3.096 1.548 1.548 0 01.003 3.096zm-1.337 9.763H6.34v-8.59H3.667v8.59zM17.668 1H2.328C1.595 1 1 1.581 1 2.298v15.403C1 18.418 1.595 19 2.328 19h15.34c.734 0 1.332-.582 1.332-1.299V2.298C19 1.581 18.402 1 17.668 1z" clip-rule="evenodd"></path>
                                    </svg>
                                </a>
                                <a href="#" class="team-social-link" aria-label="David's GitHub">
                                    <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                                        <path fill-rule="evenodd" d="M10 0C4.477 0 0 4.484 0 10.017c0 4.425 2.865 8.18 6.839 9.504.5.092.682-.217.682-.483 0-.237-.008-.868-.013-1.703-2.782.605-3.369-1.343-3.369-1.343-.454-1.158-1.11-1.466-1.11-1.466-.908-.62.069-.608.069-.608 1.003.07 1.531 1.032 1.531 1.032.892 1.53 2.341 1.088 2.91.832.092-.647.35-1.088.636-1.338-2.22-.253-4.555-1.113-4.555-4.951 0-1.093.39-1.988 1.029-2.688-.103-.253-.446-1.272.098-2.65 0 0 .84-.27 2.75 1.026A9.564 9.564 0 0110 4.844c.85.004 1.705.115 2.504.337 1.909-1.296 2.747-1.027 2.747-1.027.546 1.379.203 2.398.1 2.651.64.7 1.028 1.595 1.028 2.688 0 3.848-2.339 4.695-4.566 4.942.359.31.678.921.678 1.856 0 1.338-.012 2.419-.012 2.747 0 .268.18.58.688.482A10.019 10.019 0 0020 10.017C20 4.484 15.522 0 10 0z" clip-rule="evenodd"></path>
                                    </svg>
                                </a>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Team Member 5 -->
                    <div class="team-card">
                        <div class="team-card__image">
                            <img src="${pageContext.request.contextPath}/images/team/lisa-thompson.jpg" 
                                 alt="Lisa Thompson - Customer Success Manager" 
                                 class="w-full h-64 object-cover">
                        </div>
                        <div class="team-card__content">
                            <h3 class="team-card__name">Lisa Thompson</h3>
                            <p class="team-card__role">Customer Success Manager</p>
                            <p class="team-card__bio">
                                Customer experience specialist focused on ensuring client satisfaction and successful IoT implementations.
                            </p>
                            <div class="team-card__social">
                                <a href="#" class="team-social-link" aria-label="Lisa's LinkedIn">
                                    <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                                        <path fill-rule="evenodd" d="M16.338 16.338H13.67V12.16c0-.995-.017-2.277-1.387-2.277-1.39 0-1.601 1.086-1.601 2.207v4.248H8.014v-8.59h2.559v1.174h.037c.356-.675 1.227-1.387 2.526-1.387 2.703 0 3.203 1.778 3.203 4.092v4.711zM5.005 6.575a1.548 1.548 0 11-.003-3.096 1.548 1.548 0 01.003 3.096zm-1.337 9.763H6.34v-8.59H3.667v8.59zM17.668 1H2.328C1.595 1 1 1.581 1 2.298v15.403C1 18.418 1.595 19 2.328 19h15.34c.734 0 1.332-.582 1.332-1.299V2.298C19 1.581 18.402 1 17.668 1z" clip-rule="evenodd"></path>
                                    </svg>
                                </a>
                                <a href="#" class="team-social-link" aria-label="Lisa's Twitter">
                                    <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                                        <path d="M6.29 18.251c7.547 0 11.675-6.253 11.675-11.675 0-.178 0-.355-.012-.53A8.348 8.348 0 0020 3.92a8.19 8.19 0 01-2.357.646 4.118 4.118 0 001.804-2.27 8.224 8.224 0 01-2.605.996 4.107 4.107 0 00-6.993 3.743 11.65 11.65 0 01-8.457-4.287 4.106 4.106 0 001.27 5.477A4.073 4.073 0 01.8 7.713v.052a4.105 4.105 0 003.292 4.022 4.095 4.095 0 01-1.853.07 4.108 4.108 0 003.834 2.85A8.233 8.233 0 010 16.407a11.616 11.616 0 006.29 1.84"></path>
                                    </svg>
                                </a>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Team Member 6 -->
                    <div class="team-card">
                        <div class="team-card__image">
                            <img src="${pageContext.request.contextPath}/images/team/alex-patel.jpg" 
                                 alt="Alex Patel - DevOps Engineer" 
                                 class="w-full h-64 object-cover">
                        </div>
                        <div class="team-card__content">
                            <h3 class="team-card__name">Alex Patel</h3>
                            <p class="team-card__role">DevOps Engineer</p>
                            <p class="team-card__bio">
                                Infrastructure specialist ensuring scalable, secure, and reliable platform operations and deployments.
                            </p>
                            <div class="team-card__social">
                                <a href="#" class="team-social-link" aria-label="Alex's LinkedIn">
                                    <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                                        <path fill-rule="evenodd" d="M16.338 16.338H13.67V12.16c0-.995-.017-2.277-1.387-2.277-1.39 0-1.601 1.086-1.601 2.207v4.248H8.014v-8.59h2.559v1.174h.037c.356-.675 1.227-1.387 2.526-1.387 2.703 0 3.203 1.778 3.203 4.092v4.711zM5.005 6.575a1.548 1.548 0 11-.003-3.096 1.548 1.548 0 01.003 3.096zm-1.337 9.763H6.34v-8.59H3.667v8.59zM17.668 1H2.328C1.595 1 1 1.581 1 2.298v15.403C1 18.418 1.595 19 2.328 19h15.34c.734 0 1.332-.582 1.332-1.299V2.298C19 1.581 18.402 1 17.668 1z" clip-rule="evenodd"></path>
                                    </svg>
                                </a>
                                <a href="#" class="team-social-link" aria-label="Alex's GitHub">
                                    <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                                        <path fill-rule="evenodd" d="M10 0C4.477 0 0 4.484 0 10.017c0 4.425 2.865 8.18 6.839 9.504.5.092.682-.217.682-.483 0-.237-.008-.868-.013-1.703-2.782.605-3.369-1.343-3.369-1.343-.454-1.158-1.11-1.466-1.11-1.466-.908-.62.069-.608.069-.608 1.003.07 1.531 1.032 1.531 1.032.892 1.53 2.341 1.088 2.91.832.092-.647.35-1.088.636-1.338-2.22-.253-4.555-1.113-4.555-4.951 0-1.093.39-1.988 1.029-2.688-.103-.253-.446-1.272.098-2.65 0 0 .84-.27 2.75 1.026A9.564 9.564 0 0110 4.844c.85.004 1.705.115 2.504.337 1.909-1.296 2.747-1.027 2.747-1.027.546 1.379.203 2.398.1 2.651.64.7 1.028 1.595 1.028 2.688 0 3.848-2.339 4.695-4.566 4.942.359.31.678.921.678 1.856 0 1.338-.012 2.419-.012 2.747 0 .268.18.58.688.482A10.019 10.019 0 0020 10.017C20 4.484 15.522 0 10 0z" clip-rule="evenodd"></path>
                                    </svg>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        
        <!-- CTA Section -->
        <section class="cta-section bg-gradient-to-r from-brand-primary to-brand-secondary text-white py-12">
            <div class="container">
                <div class="max-w-3xl mx-auto text-center">
                    <h2 class="text-3xl md:text-4xl font-bold mb-6">
                        Ready to Transform Your World with IoT?
                    </h2>
                    <p class="text-xl text-blue-100 mb-8">
                        Join thousands of customers who trust IoT Bay for their smart technology needs.
                    </p>
                    <div class="flex flex-wrap gap-4 justify-center">
                        <a href="${pageContext.request.contextPath}/browse" class="btn btn--white btn--lg">
                            Shop Products
                        </a>
                        <a href="${pageContext.request.contextPath}/contact" class="btn btn--outline-white btn--lg">
                            Contact Us
                        </a>
                    </div>
                </div>
            </div>
        </section>
        
    </main>
    
    <!-- Footer -->
    <jsp:include page="components/footer.jsp" />
    
    <!-- JavaScript -->
    <script src="${pageContext.request.contextPath}/js/core.js"></script>
    
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
            
            // Animate stats on scroll
            const statsSection = document.querySelector('.stats-section');
            const statNumbers = document.querySelectorAll('.stat-number');
            
            const animateStats = () => {
                statNumbers.forEach(stat => {
                    const finalValue = stat.textContent.replace(/[^\d]/g, '');
                    const suffix = stat.textContent.replace(/[\d]/g, '');
                    
                    let currentValue = 0;
                    const increment = finalValue / 50;
                    const timer = setInterval(() => {
                        currentValue += increment;
                        if (currentValue >= finalValue) {
                            stat.textContent = finalValue + suffix;
                            clearInterval(timer);
                        } else {
                            stat.textContent = Math.floor(currentValue) + suffix;
                        }
                    }, 40);
                });
            };
            
            // Intersection observer for stats animation
            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        animateStats();
                        observer.unobserve(entry.target);
                    }
                });
            });
            
            if (statsSection) {
                observer.observe(statsSection);
            }
            
            // Team card hover effects
            const teamCards = document.querySelectorAll('.team-card');
            
            teamCards.forEach(card => {
                card.addEventListener('mouseenter', function() {
                    this.style.transform = 'translateY(-8px)';
                    this.style.boxShadow = '0 20px 40px rgba(0, 0, 0, 0.1)';
                });
                
                card.addEventListener('mouseleave', function() {
                    this.style.transform = 'translateY(0)';
                    this.style.boxShadow = '0 4px 6px rgba(0, 0, 0, 0.05)';
                });
            });
        });
    </script>
</body>
</html>
