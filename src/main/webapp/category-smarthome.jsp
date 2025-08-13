<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.*" %>

<%
    List<Product> products = (List<Product>) request.getAttribute("products");
    String searchKeyword = (String) request.getParameter("search");
    if (products == null) {
        products = new ArrayList<>();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Smart Home Solutions - IoT Bay</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/modern-theme.css">
    <meta name="description" content="Create the perfect smart home with intelligent automation, security systems, and energy management solutions.">
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="components/header.jsp" />
    
    <!-- Include Navigation -->
    <nav class="nav__container">
        <div class="container">
            <ul class="nav__list">
                <li class="nav__item">
                    <a href="<%=request.getContextPath()%>/index.jsp" class="nav__link">Home</a>
                </li>
                <li class="nav__item">
                    <a href="<%=request.getContextPath()%>/browse" class="nav__link">Browse</a>
                </li>
                <li class="nav__item">
                    <a href="<%=request.getContextPath()%>/category-industrial.jsp" class="nav__link">Industrial</a>
                </li>
                <li class="nav__item">
                    <a href="<%=request.getContextPath()%>/category-warehouse.jsp" class="nav__link">Warehouse</a>
                </li>
                <li class="nav__item">
                    <a href="<%=request.getContextPath()%>/category-agriculture.jsp" class="nav__link">Agriculture</a>
                </li>
                <li class="nav__item">
                    <a href="<%=request.getContextPath()%>/category-smarthome.jsp" class="nav__link nav__link--active">Smart Home</a>
                </li>
            </ul>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero bg-gradient-to-r from-purple-50 to-pink-100">
        <div class="container">
            <div class="hero__content">
                <h1 class="hero__title">Smart Home Ecosystem</h1>
                <p class="hero__subtitle">
                    Transform your living space into an intelligent, connected environment that learns your preferences, 
                    enhances comfort, and provides peace of mind through advanced automation and security.
                </p>
                <div class="hero__actions">
                    <a href="#products" class="btn btn--primary btn--lg">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 7v10a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2H5a2 2 0 00-2-2H3v10z"/>
                        </svg>
                        Shop Smart Home
                    </a>
                    <a href="#ecosystem" class="btn btn--outline btn--lg">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9.663 17h4.673M12 3v1m6.364 1.636l-.707.707M21 12h-1M4 12H3m3.343-5.657l-.707-.707m2.828 9.9a5 5 0 117.072 0l-.548.547A3.374 3.374 0 0014 18.469V19a2 2 0 11-4 0v-.531c0-.895-.356-1.754-.988-2.386l-.548-.547z"/>
                        </svg>
                        Learn About Ecosystem
                    </a>
                </div>
            </div>
            <div class="hero__image">
                <img src="<%=request.getContextPath()%>/images/smarthome-hero.jpg" 
                     alt="Smart Home Technology" 
                     class="hero__image"
                     onerror="this.src='<%=request.getContextPath()%>/images/welcome.png'">
            </div>
        </div>
    </section>

    <!-- Main Content -->
    <main class="container py-16">
        <!-- Breadcrumb -->
        <nav class="mb-8">
            <ol class="flex items-center gap-2 text-sm text-neutral-600">
                <li><a href="<%=request.getContextPath()%>/index.jsp" class="hover:text-primary">Home</a></li>
                <li>/</li>
                <li><a href="<%=request.getContextPath()%>/browse" class="hover:text-primary">Categories</a></li>
                <li>/</li>
                <li class="text-neutral-900 font-medium">Smart Home</li>
            </ol>
        </nav>

        <!-- Smart Home Benefits -->
        <section class="mb-16">
            <div class="text-center mb-12">
                <h2 class="text-display-sm font-bold text-neutral-900 mb-4">Why Choose Smart Home Technology?</h2>
                <p class="text-lg text-neutral-600 max-w-3xl mx-auto">
                    Experience the convenience, security, and efficiency of a truly connected home that adapts to your lifestyle.
                </p>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                <div class="text-center">
                    <div class="w-16 h-16 bg-blue-100 rounded-full flex items-center justify-center mx-auto mb-4">
                        <svg class="w-8 h-8 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z"/>
                        </svg>
                    </div>
                    <h3 class="text-xl font-semibold text-neutral-900 mb-2">Energy Savings</h3>
                    <p class="text-neutral-600 text-sm">Reduce energy consumption by up to 23% with intelligent automation</p>
                </div>

                <div class="text-center">
                    <div class="w-16 h-16 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-4">
                        <svg class="w-8 h-8 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"/>
                        </svg>
                    </div>
                    <h3 class="text-xl font-semibold text-neutral-900 mb-2">Enhanced Security</h3>
                    <p class="text-neutral-600 text-sm">24/7 monitoring and instant alerts for complete peace of mind</p>
                </div>

                <div class="text-center">
                    <div class="w-16 h-16 bg-purple-100 rounded-full flex items-center justify-center mx-auto mb-4">
                        <svg class="w-8 h-8 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                    </div>
                    <h3 class="text-xl font-semibold text-neutral-900 mb-2">Time Saving</h3>
                    <p class="text-neutral-600 text-sm">Automate daily routines and control everything from one app</p>
                </div>

                <div class="text-center">
                    <div class="w-16 h-16 bg-orange-100 rounded-full flex items-center justify-center mx-auto mb-4">
                        <svg class="w-8 h-8 text-orange-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"/>
                        </svg>
                    </div>
                    <h3 class="text-xl font-semibold text-neutral-900 mb-2">Comfort & Convenience</h3>
                    <p class="text-neutral-600 text-sm">Personalized environments that adapt to your preferences</p>
                </div>
            </div>
        </section>

        <!-- Smart Home Ecosystem -->
        <section id="ecosystem" class="mb-16">
            <div class="text-center mb-12">
                <h2 class="text-display-sm font-bold text-neutral-900 mb-4">Complete Smart Home Ecosystem</h2>
                <p class="text-lg text-neutral-600 max-w-3xl mx-auto">
                    Build your perfect smart home with our comprehensive range of interconnected devices and systems.
                </p>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                <!-- Smart Lighting -->
                <div class="card card--interactive">
                    <div class="card__body">
                        <div class="w-12 h-12 bg-yellow-500 rounded-lg flex items-center justify-center mb-6">
                            <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9.663 17h4.673M12 3v1m6.364 1.636l-.707.707M21 12h-1M4 12H3m3.343-5.657l-.707-.707m2.828 9.9a5 5 0 117.072 0l-.548.547A3.374 3.374 0 0014 18.469V19a2 2 0 11-4 0v-.531c0-.895-.356-1.754-.988-2.386l-.548-.547z"/>
                            </svg>
                        </div>
                        <h3 class="text-xl font-semibold text-neutral-900 mb-3">Smart Lighting</h3>
                        <p class="text-neutral-600 mb-4">
                            Intelligent lighting systems that adjust brightness and color based on time of day, activities, and mood.
                        </p>
                        <ul class="space-y-2 text-sm text-neutral-700">
                            <li class="flex items-center gap-2">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                Voice & App Control
                            </li>
                            <li class="flex items-center gap-2">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                16 Million Colors
                            </li>
                            <li class="flex items-center gap-2">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                Schedule & Automation
                            </li>
                        </ul>
                    </div>
                </div>

                <!-- Security & Monitoring -->
                <div class="card card--interactive">
                    <div class="card__body">
                        <div class="w-12 h-12 bg-red-600 rounded-lg flex items-center justify-center mb-6">
                            <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 10l4.553-2.276A1 1 0 0121 8.618v6.764a1 1 0 01-1.447.894L15 14M5 18h8a2 2 0 002-2V8a2 2 0 00-2-2H5a2 2 0 00-2 2v8a2 2 0 002 2z"/>
                            </svg>
                        </div>
                        <h3 class="text-xl font-semibold text-neutral-900 mb-3">Security & Monitoring</h3>
                        <p class="text-neutral-600 mb-4">
                            Comprehensive security solutions with cameras, sensors, and smart locks for complete home protection.
                        </p>
                        <ul class="space-y-2 text-sm text-neutral-700">
                            <li class="flex items-center gap-2">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                HD Video Surveillance
                            </li>
                            <li class="flex items-center gap-2">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                Motion & Door Sensors
                            </li>
                            <li class="flex items-center gap-2">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                Instant Alerts
                            </li>
                        </ul>
                    </div>
                </div>

                <!-- Climate Control -->
                <div class="card card--interactive">
                    <div class="card__body">
                        <div class="w-12 h-12 bg-blue-600 rounded-lg flex items-center justify-center mb-6">
                            <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 15a4 4 0 004 4h9a5 5 0 10-.1-9.999 5.002 5.002 0 10-9.78 2.096A4.001 4.001 0 003 15z"/>
                            </svg>
                        </div>
                        <h3 class="text-xl font-semibold text-neutral-900 mb-3">Climate Control</h3>
                        <p class="text-neutral-600 mb-4">
                            Smart thermostats and HVAC control for optimal comfort and energy efficiency throughout your home.
                        </p>
                        <ul class="space-y-2 text-sm text-neutral-700">
                            <li class="flex items-center gap-2">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                Learning Algorithms
                            </li>
                            <li class="flex items-center gap-2">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                Remote Access
                            </li>
                            <li class="flex items-center gap-2">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                Energy Reports
                            </li>
                        </ul>
                    </div>
                </div>

                <!-- Entertainment Systems -->
                <div class="card card--interactive">
                    <div class="card__body">
                        <div class="w-12 h-12 bg-purple-600 rounded-lg flex items-center justify-center mb-6">
                            <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15.536 8.464a5 5 0 010 7.072m2.828-2.828a9 9 0 010-1.414M6.343 6.343a9 9 0 000 12.728m0-12.728A9 9 0 018.464 4.536"/>
                            </svg>
                        </div>
                        <h3 class="text-xl font-semibold text-neutral-900 mb-3">Entertainment Hub</h3>
                        <p class="text-neutral-600 mb-4">
                            Multi-room audio, smart TVs, and streaming integration for seamless entertainment throughout your home.
                        </p>
                        <ul class="space-y-2 text-sm text-neutral-700">
                            <li class="flex items-center gap-2">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                Multi-room Audio
                            </li>
                            <li class="flex items-center gap-2">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                Voice Control
                            </li>
                            <li class="flex items-center gap-2">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                Streaming Integration
                            </li>
                        </ul>
                    </div>
                </div>

                <!-- Kitchen & Appliances -->
                <div class="card card--interactive">
                    <div class="card__body">
                        <div class="w-12 h-12 bg-green-600 rounded-lg flex items-center justify-center mb-6">
                            <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"/>
                            </svg>
                        </div>
                        <h3 class="text-xl font-semibold text-neutral-900 mb-3">Smart Kitchen</h3>
                        <p class="text-neutral-600 mb-4">
                            Connected appliances and smart kitchen devices that make cooking and meal planning effortless.
                        </p>
                        <ul class="space-y-2 text-sm text-neutral-700">
                            <li class="flex items-center gap-2">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                Smart Appliances
                            </li>
                            <li class="flex items-center gap-2">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                Recipe Integration
                            </li>
                            <li class="flex items-center gap-2">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                Energy Monitoring
                            </li>
                        </ul>
                    </div>
                </div>

                <!-- Voice Assistants -->
                <div class="card card--interactive">
                    <div class="card__body">
                        <div class="w-12 h-12 bg-indigo-600 rounded-lg flex items-center justify-center mb-6">
                            <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 11a7 7 0 01-7 7m0 0a7 7 0 01-7-7m7 7v4m0 0H8m4 0h4m-4-8a3 3 0 01-3-3V5a3 3 0 116 0v6a3 3 0 01-3 3z"/>
                            </svg>
                        </div>
                        <h3 class="text-xl font-semibold text-neutral-900 mb-3">Voice Control</h3>
                        <p class="text-neutral-600 mb-4">
                            Hands-free control of your entire smart home ecosystem through advanced voice assistants and AI.
                        </p>
                        <ul class="space-y-2 text-sm text-neutral-700">
                            <li class="flex items-center gap-2">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                Natural Language
                            </li>
                            <li class="flex items-center gap-2">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                Multi-room Control
                            </li>
                            <li class="flex items-center gap-2">
                                <svg class="w-4 h-4 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                Custom Commands
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </section>

        <!-- Filter and Search Section -->
        <section id="products" class="mb-8">
            <div class="flex flex-col lg:flex-row lg:items-center lg:justify-between gap-6 mb-8">
                <div>
                    <h2 class="text-2xl font-bold text-neutral-900 mb-2">Smart Home Products</h2>
                    <p class="text-neutral-600">Build your perfect connected home with our premium smart devices</p>
                </div>
                
                <!-- Search and Filter Controls -->
                <div class="flex flex-col sm:flex-row gap-4">
                    <div class="relative">
                        <form action="<%=request.getContextPath()%>/category-smarthome.jsp" method="get" class="flex">
                            <input type="text" 
                                   name="search" 
                                   value="<%= searchKeyword != null ? searchKeyword : "" %>"
                                   placeholder="Search smart home products..." 
                                   class="form-input rounded-r-none w-64">
                            <button type="submit" class="btn btn--primary rounded-l-none">
                                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                                </svg>
                            </button>
                        </form>
                    </div>
                    
                    <select class="form-select" onchange="filterProducts(this.value)">
                        <option value="">All Categories</option>
                        <option value="lighting">Lighting</option>
                        <option value="security">Security</option>
                        <option value="climate">Climate</option>
                        <option value="entertainment">Entertainment</option>
                        <option value="kitchen">Kitchen</option>
                        <option value="voice">Voice Assistants</option>
                    </select>
                    
                    <select class="form-select" onchange="sortProducts(this.value)">
                        <option value="">Sort by</option>
                        <option value="name">Name A-Z</option>
                        <option value="price-low">Price: Low to High</option>
                        <option value="price-high">Price: High to Low</option>
                        <option value="rating">Highest Rated</option>
                    </select>
                </div>
            </div>
        </section>

        <!-- Products Grid -->
        <section class="product-grid mb-16" id="productsGrid">
            <!-- Demo smart home products -->
            <div class="product-card" data-category="lighting" data-price="49">
                <img src="<%=request.getContextPath()%>/images/sample1.png" 
                     alt="Smart LED Bulb" 
                     class="product-card__image">
                <div class="product-card__body">
                    <h3 class="product-card__title">Smart LED Bulb - Color Changing</h3>
                    <p class="product-card__description">
                        WiFi-enabled LED bulb with 16 million colors, dimming, and voice control compatibility.
                    </p>
                    <div class="product-card__price">$49.99</div>
                    <div class="product-card__actions">
                        <a href="<%=request.getContextPath()%>/productDetails.jsp?id=19" class="btn btn--outline btn--sm">
                            View Details
                        </a>
                        <button onclick="addToCart(19)" class="btn btn--primary btn--sm">
                            Add to Cart
                        </button>
                    </div>
                </div>
            </div>

            <div class="product-card" data-category="security" data-price="199">
                <img src="<%=request.getContextPath()%>/images/sample2.png" 
                     alt="Smart Security Camera" 
                     class="product-card__image">
                <div class="product-card__body">
                    <h3 class="product-card__title">Indoor Security Camera Pro</h3>
                    <p class="product-card__description">
                        4K HD camera with night vision, two-way audio, and AI-powered motion detection.
                    </p>
                    <div class="product-card__price">$199.99</div>
                    <div class="product-card__actions">
                        <a href="<%=request.getContextPath()%>/productDetails.jsp?id=20" class="btn btn--outline btn--sm">
                            View Details
                        </a>
                        <button onclick="addToCart(20)" class="btn btn--primary btn--sm">
                            Add to Cart
                        </button>
                    </div>
                </div>
            </div>

            <div class="product-card" data-category="climate" data-price="249">
                <img src="<%=request.getContextPath()%>/images/sample3.png" 
                     alt="Smart Thermostat" 
                     class="product-card__image">
                <div class="product-card__body">
                    <h3 class="product-card__title">Learning Smart Thermostat</h3>
                    <p class="product-card__description">
                        AI-powered thermostat that learns your schedule and preferences for optimal comfort and savings.
                    </p>
                    <div class="product-card__price">$249.99</div>
                    <div class="product-card__actions">
                        <a href="<%=request.getContextPath()%>/productDetails.jsp?id=21" class="btn btn--outline btn--sm">
                            View Details
                        </a>
                        <button onclick="addToCart(21)" class="btn btn--primary btn--sm">
                            Add to Cart
                        </button>
                    </div>
                </div>
            </div>

            <div class="product-card" data-category="entertainment" data-price="99">
                <img src="<%=request.getContextPath()%>/images/sample1.png" 
                     alt="Smart Speaker" 
                     class="product-card__image">
                <div class="product-card__body">
                    <h3 class="product-card__title">Smart Speaker with Voice Assistant</h3>
                    <p class="product-card__description">
                        High-quality audio speaker with built-in voice assistant and smart home hub capabilities.
                    </p>
                    <div class="product-card__price">$99.99</div>
                    <div class="product-card__actions">
                        <a href="<%=request.getContextPath()%>/productDetails.jsp?id=22" class="btn btn--outline btn--sm">
                            View Details
                        </a>
                        <button onclick="addToCart(22)" class="btn btn--primary btn--sm">
                            Add to Cart
                        </button>
                    </div>
                </div>
            </div>

            <div class="product-card" data-category="security" data-price="159">
                <img src="<%=request.getContextPath()%>/images/sample2.png" 
                     alt="Smart Door Lock" 
                     class="product-card__image">
                <div class="product-card__body">
                    <h3 class="product-card__title">Smart Door Lock with Keypad</h3>
                    <p class="product-card__description">
                        Keyless entry with smartphone app, temporary codes, and automatic locking features.
                    </p>
                    <div class="product-card__price">$159.99</div>
                    <div class="product-card__actions">
                        <a href="<%=request.getContextPath()%>/productDetails.jsp?id=23" class="btn btn--outline btn--sm">
                            View Details
                        </a>
                        <button onclick="addToCart(23)" class="btn btn--primary btn--sm">
                            Add to Cart
                        </button>
                    </div>
                </div>
            </div>

            <div class="product-card" data-category="kitchen" data-price="299">
                <img src="<%=request.getContextPath()%>/images/sample3.png" 
                     alt="Smart Coffee Maker" 
                     class="product-card__image">
                <div class="product-card__body">
                    <h3 class="product-card__title">Smart Coffee Maker Pro</h3>
                    <p class="product-card__description">
                        WiFi-enabled coffee maker with scheduling, strength control, and integration with voice assistants.
                    </p>
                    <div class="product-card__price">$299.99</div>
                    <div class="product-card__actions">
                        <a href="<%=request.getContextPath()%>/productDetails.jsp?id=24" class="btn btn--outline btn--sm">
                            View Details
                        </a>
                        <button onclick="addToCart(24)" class="btn btn--primary btn--sm">
                            Add to Cart
                        </button>
                    </div>
                </div>
            </div>
        </section>

        <!-- Smart Home Bundles -->
        <section class="mb-16">
            <div class="text-center mb-12">
                <h2 class="text-display-sm font-bold text-neutral-900 mb-4">Smart Home Starter Bundles</h2>
                <p class="text-lg text-neutral-600 max-w-3xl mx-auto">
                    Get started with complete smart home packages designed for different needs and budgets.
                </p>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                <div class="card card--elevated">
                    <div class="card__header text-center">
                        <h3 class="text-xl font-semibold text-neutral-900">Starter Bundle</h3>
                        <div class="text-3xl font-bold text-brand-primary mt-2">$299</div>
                        <p class="text-sm text-neutral-600 mt-1">Perfect for beginners</p>
                    </div>
                    <div class="card__body">
                        <ul class="space-y-3">
                            <li class="flex items-center gap-3">
                                <svg class="w-5 h-5 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                <span>2 Smart LED Bulbs</span>
                            </li>
                            <li class="flex items-center gap-3">
                                <svg class="w-5 h-5 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                <span>Smart Speaker</span>
                            </li>
                            <li class="flex items-center gap-3">
                                <svg class="w-5 h-5 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                <span>Smart Plug (2 pack)</span>
                            </li>
                            <li class="flex items-center gap-3">
                                <svg class="w-5 h-5 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                <span>Hub & App Setup</span>
                            </li>
                        </ul>
                    </div>
                    <div class="card__footer">
                        <button class="btn btn--outline btn--full">Choose Starter</button>
                    </div>
                </div>

                <div class="card card--elevated border-2 border-brand-primary">
                    <div class="card__header text-center">
                        <div class="bg-brand-primary text-white text-xs font-semibold px-3 py-1 rounded-full inline-block mb-2">MOST POPULAR</div>
                        <h3 class="text-xl font-semibold text-neutral-900">Essential Bundle</h3>
                        <div class="text-3xl font-bold text-brand-primary mt-2">$599</div>
                        <p class="text-sm text-neutral-600 mt-1">Complete basic coverage</p>
                    </div>
                    <div class="card__body">
                        <ul class="space-y-3">
                            <li class="flex items-center gap-3">
                                <svg class="w-5 h-5 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                <span>Everything in Starter</span>
                            </li>
                            <li class="flex items-center gap-3">
                                <svg class="w-5 h-5 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                <span>Smart Thermostat</span>
                            </li>
                            <li class="flex items-center gap-3">
                                <svg class="w-5 h-5 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                <span>Security Camera</span>
                            </li>
                            <li class="flex items-center gap-3">
                                <svg class="w-5 h-5 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                <span>Smart Door Lock</span>
                            </li>
                        </ul>
                    </div>
                    <div class="card__footer">
                        <button class="btn btn--primary btn--full">Choose Essential</button>
                    </div>
                </div>

                <div class="card card--elevated">
                    <div class="card__header text-center">
                        <h3 class="text-xl font-semibold text-neutral-900">Premium Bundle</h3>
                        <div class="text-3xl font-bold text-brand-primary mt-2">$999</div>
                        <p class="text-sm text-neutral-600 mt-1">Complete smart home</p>
                    </div>
                    <div class="card__body">
                        <ul class="space-y-3">
                            <li class="flex items-center gap-3">
                                <svg class="w-5 h-5 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                <span>Everything in Essential</span>
                            </li>
                            <li class="flex items-center gap-3">
                                <svg class="w-5 h-5 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                <span>Multiple Room Sensors</span>
                            </li>
                            <li class="flex items-center gap-3">
                                <svg class="w-5 h-5 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                <span>Smart Kitchen Appliances</span>
                            </li>
                            <li class="flex items-center gap-3">
                                <svg class="w-5 h-5 text-success" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                                <span>Professional Installation</span>
                            </li>
                        </ul>
                    </div>
                    <div class="card__footer">
                        <button class="btn btn--outline btn--full">Choose Premium</button>
                    </div>
                </div>
            </div>
        </section>

        <!-- Call to Action -->
        <section class="card bg-gradient-to-r from-purple-600 to-pink-600 text-white">
            <div class="card__body text-center py-16">
                <h2 class="text-3xl font-bold mb-4">Start Your Smart Home Journey Today</h2>
                <p class="text-xl mb-8 opacity-90">
                    Join over 2 million homeowners who have already transformed their living spaces with smart technology. 
                    Get personalized recommendations and expert installation support.
                </p>
                <div class="flex flex-col sm:flex-row gap-4 justify-center">
                    <a href="<%=request.getContextPath()%>/contact.jsp" class="btn btn--secondary btn--lg">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z"/>
                        </svg>
                        Free Smart Home Consultation
                    </a>
                    <a href="<%=request.getContextPath()%>/browse" class="btn btn--outline btn--lg border-white text-white hover:bg-white hover:text-purple-600">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 7v10a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2H5a2 2 0 00-2-2H3v10z"/>
                        </svg>
                        Browse All Smart Devices
                    </a>
                </div>
            </div>
        </section>
    </main>

    <!-- Include Footer -->
    <jsp:include page="components/footer.jsp" />

    <!-- JavaScript -->
    <script src="<%=request.getContextPath()%>/js/main.js"></script>
    <script>
        // Product filtering and sorting functionality
        function filterProducts(category) {
            const products = document.querySelectorAll('.product-card');
            products.forEach(product => {
                if (!category || product.dataset.category === category) {
                    product.style.display = 'block';
                } else {
                    product.style.display = 'none';
                }
            });
        }

        function sortProducts(sortBy) {
            const grid = document.getElementById('productsGrid');
            const products = Array.from(grid.querySelectorAll('.product-card'));
            
            products.sort((a, b) => {
                switch(sortBy) {
                    case 'name':
                        return a.querySelector('.product-card__title').textContent.localeCompare(
                            b.querySelector('.product-card__title').textContent
                        );
                    case 'price-low':
                        return parseFloat(a.dataset.price) - parseFloat(b.dataset.price);
                    case 'price-high':
                        return parseFloat(b.dataset.price) - parseFloat(a.dataset.price);
                    default:
                        return 0;
                }
            });
            
            products.forEach(product => grid.appendChild(product));
        }

        function addToCart(productId) {
            // Add loading state
            const button = event.target;
            const originalText = button.textContent;
            button.innerHTML = '<div class="loading mr-2"></div> Adding...';
            button.disabled = true;
            
            // Simulate API call
            setTimeout(() => {
                button.textContent = originalText;
                button.disabled = false;
                showToast('Product added to cart successfully!', 'success');
            }, 1000);
        }

        // Smooth scrolling for anchor links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });

        // Bundle selection interactivity
        document.querySelectorAll('.card button').forEach(button => {
            if (button.textContent.includes('Choose')) {
                button.addEventListener('click', function() {
                    const bundleName = this.textContent.replace('Choose ', '');
                    showToast(`${bundleName} Bundle selected! Redirecting to checkout...`, 'success');
                    
                    // Simulate bundle selection
                    setTimeout(() => {
                        window.location.href = '<%=request.getContextPath()%>/checkout.jsp?bundle=' + bundleName.toLowerCase();
                    }, 1500);
                });
            }
        });

        // Initialize page animations
        document.addEventListener('DOMContentLoaded', function() {
            // Animate cards on scroll
            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.style.opacity = '1';
                        entry.target.style.transform = 'translateY(0)';
                    }
                });
            });

            document.querySelectorAll('.card').forEach(card => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(20px)';
                card.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
                observer.observe(card);
            });
        });
    </script>
</body>
</html>
