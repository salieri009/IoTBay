<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
    <%@ page import="java.util.*, model.*" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
                    <%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>

                        <% // Defensive coding: Initialize empty collections instead of redirecting to prevent infinite
                            loop List<Product> products = (List<Product>) request.getAttribute("products");
                                model.Category category = (model.Category) request.getAttribute("category");

                                // If products/category is null, initialize with empty/default values instead of
                                redirecting
                                // This prevents infinite redirect loop when category doesn't exist in database
                                if (products == null) {
                                products = new ArrayList<>();
                                    }
                                    if (category == null) {
                                    // Create a fallback category for display purposes
                                    category = new model.Category(0, "Smart Home", "Smart Home Automation Solutions");
                                    }

                                    String searchKeyword = (String) request.getParameter("search");
                                    // Expose to EL
                                    request.setAttribute("products", products);
                                    request.setAttribute("category", category);
                                    %>

                                    <t:base title="Smart Home Solutions - IoT Bay"
                                        description="Smart home automation, security, and energy management.">

                                        <!-- Hero Section -->
                                        <section class="hero bg-gradient-to-r from-purple-50 to-pink-100">
                                            <div class="container">
                                                <div class="hero__content">
                                                    <h1 class="hero__title">Smart Home Ecosystem</h1>
                                                    <p class="hero__subtitle">
                                                        Transform your living space into an intelligent, connected
                                                        environment that learns your preferences,
                                                        enhances comfort, and provides peace of mind through advanced
                                                        automation and security.
                                                    </p>
                                                    <div class="hero__actions">
                                                        <a href="#products" class="btn btn--primary btn--lg">
                                                            <svg class="w-5 h-5" fill="none" stroke="currentColor"
                                                                viewBox="0 0 24 24">
                                                                <path stroke-linecap="round" stroke-linejoin="round"
                                                                    stroke-width="2"
                                                                    d="M3 7v10a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2H5a2 2 0 00-2-2H3v10z" />
                                                            </svg>
                                                            Shop Smart Home
                                                        </a>
                                                        <a href="#ecosystem" class="btn btn--outline btn--lg">
                                                            <svg class="w-5 h-5" fill="none" stroke="currentColor"
                                                                viewBox="0 0 24 24">
                                                                <path stroke-linecap="round" stroke-linejoin="round"
                                                                    stroke-width="2"
                                                                    d="M9.663 17h4.673M12 3v1m6.364 1.636l-.707.707M21 12h-1M4 12H3m3.343-5.657l-.707-.707m2.828 9.9a5 5 0 117.072 0l-.548.547A3.374 3.374 0 0014 18.469V19a2 2 0 11-4 0v-.531c0-.895-.356-1.754-.988-2.386l-.548-.547z" />
                                                            </svg>
                                                            Learn About Ecosystem
                                                        </a>
                                                    </div>
                                                </div>
                                                <div class="hero__image">
                                                    <img src="${pageContext.request.contextPath}/images/smarthome-hero.jpg"
                                                        alt="Smart Home Technology" class="hero__image"
                                                        onerror="this.src='${pageContext.request.contextPath}/images/welcome.png'">
                                                </div>
                                            </div>
                                        </section>

                                        <!-- Main Content -->
                                        <main class="container py-12">
                                            <!-- Breadcrumb -->
                                            <nav class="mb-6">
                                                <ol class="flex items-center gap-2 text-sm text-neutral-600">
                                                    <li><a href="${pageContext.request.contextPath}/index.jsp"
                                                            class="hover:text-primary">Home</a></li>
                                                    <li>/</li>
                                                    <li><a href="${pageContext.request.contextPath}/browse"
                                                            class="hover:text-primary">Categories</a></li>
                                                    <li>/</li>
                                                    <li class="text-neutral-900 font-medium">Smart Home</li>
                                                </ol>
                                            </nav>

                                            <!-- Smart Home Benefits -->
                                            <section class="mb-12">
                                                <div class="text-center mb-8">
                                                    <h2 class="text-display-sm font-bold text-neutral-900 mb-4">Why
                                                        Choose Smart Home Technology?</h2>
                                                    <p class="text-lg text-neutral-600 max-w-3xl mx-auto">
                                                        Experience the convenience, security, and efficiency of a truly
                                                        connected home that adapts to your lifestyle.
                                                    </p>
                                                </div>

                                                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                                                    <div class="text-center">
                                                        <div
                                                            class="w-12 h-12 bg-blue-100 rounded-full flex items-center justify-center mx-auto mb-3">
                                                            <svg class="w-6 h-6 text-blue-600" fill="none"
                                                                stroke="currentColor" viewBox="0 0 24 24">
                                                                <path stroke-linecap="round" stroke-linejoin="round"
                                                                    stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z" />
                                                            </svg>
                                                        </div>
                                                        <h3 class="text-xl font-semibold text-neutral-900 mb-2">Energy
                                                            Savings</h3>
                                                        <p class="text-neutral-600 text-sm">Reduce energy consumption by
                                                            up to 23% with intelligent automation</p>
                                                    </div>

                                                    <div class="text-center">
                                                        <div
                                                            class="w-16 h-16 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-4">
                                                            <svg class="w-8 h-8 text-green-600" fill="none"
                                                                stroke="currentColor" viewBox="0 0 24 24">
                                                                <path stroke-linecap="round" stroke-linejoin="round"
                                                                    stroke-width="2"
                                                                    d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z" />
                                                            </svg>
                                                        </div>
                                                        <h3 class="text-xl font-semibold text-neutral-900 mb-2">Enhanced
                                                            Security</h3>
                                                        <p class="text-neutral-600 text-sm">24/7 monitoring and instant
                                                            alerts for complete peace of mind</p>
                                                    </div>

                                                    <div class="text-center">
                                                        <div
                                                            class="w-16 h-16 bg-purple-100 rounded-full flex items-center justify-center mx-auto mb-4">
                                                            <svg class="w-8 h-8 text-purple-600" fill="none"
                                                                stroke="currentColor" viewBox="0 0 24 24">
                                                                <path stroke-linecap="round" stroke-linejoin="round"
                                                                    stroke-width="2"
                                                                    d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
                                                            </svg>
                                                        </div>
                                                        <h3 class="text-xl font-semibold text-neutral-900 mb-2">Time
                                                            Saving</h3>
                                                        <p class="text-neutral-600 text-sm">Automate daily routines and
                                                            control everything from one app</p>
                                                    </div>

                                                    <div class="text-center">
                                                        <div
                                                            class="w-16 h-16 bg-orange-100 rounded-full flex items-center justify-center mx-auto mb-4">
                                                            <svg class="w-8 h-8 text-orange-600" fill="none"
                                                                stroke="currentColor" viewBox="0 0 24 24">
                                                                <path stroke-linecap="round" stroke-linejoin="round"
                                                                    stroke-width="2"
                                                                    d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z" />
                                                            </svg>
                                                        </div>
                                                        <h3 class="text-xl font-semibold text-neutral-900 mb-2">Comfort
                                                            & Convenience</h3>
                                                        <p class="text-neutral-600 text-sm">Personalized environments
                                                            that adapt to your preferences</p>
                                                    </div>
                                                </div>
                                            </section>

                                            <!-- Smart Home Ecosystem -->
                                            <section id="ecosystem" class="mb-16">
                                                <div class="text-center mb-12">
                                                    <h2 class="text-display-sm font-bold text-neutral-900 mb-4">Complete
                                                        Smart Home Ecosystem</h2>
                                                    <p class="text-lg text-neutral-600 max-w-3xl mx-auto">
                                                        Build your perfect smart home with our comprehensive range of
                                                        interconnected devices and systems.
                                                    </p>
                                                </div>

                                                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                                                    <!-- Smart Lighting -->
                                                    <div class="card card--interactive">
                                                        <div class="card__body">
                                                            <div
                                                                class="w-12 h-12 bg-yellow-500 rounded-lg flex items-center justify-center mb-6">
                                                                <svg class="w-6 h-6 text-white" fill="none"
                                                                    stroke="currentColor" viewBox="0 0 24 24">
                                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                                        stroke-width="2"
                                                                        d="M9.663 17h4.673M12 3v1m6.364 1.636l-.707.707M21 12h-1M4 12H3m3.343-5.657l-.707-.707m2.828 9.9a5 5 0 117.072 0l-.548.547A3.374 3.374 0 0014 18.469V19a2 2 0 11-4 0v-.531c0-.895-.356-1.754-.988-2.386l-.548-.547z" />
                                                                </svg>
                                                            </div>
                                                            <h3 class="text-xl font-semibold text-neutral-900 mb-3">
                                                                Smart Lighting</h3>
                                                            <p class="text-neutral-600 mb-4">
                                                                Intelligent lighting systems that adjust brightness and
                                                                color based on time of day, activities, and mood.
                                                            </p>
                                                            <ul class="space-y-2 text-sm text-neutral-700">
                                                                <li class="flex items-center gap-2">
                                                                    <svg class="w-4 h-4 text-success"
                                                                        fill="currentColor" viewBox="0 0 20 20">
                                                                        <path fill-rule="evenodd"
                                                                            d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                                                                            clip-rule="evenodd" />
                                                                    </svg>
                                                                    Voice & App Control
                                                                </li>
                                                                <li class="flex items-center gap-2">
                                                                    <svg class="w-4 h-4 text-success"
                                                                        fill="currentColor" viewBox="0 0 20 20">
                                                                        <path fill-rule="evenodd"
                                                                            d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                                                                            clip-rule="evenodd" />
                                                                    </svg>
                                                                    16 Million Colors
                                                                </li>
                                                                <li class="flex items-center gap-2">
                                                                    <svg class="w-4 h-4 text-success"
                                                                        fill="currentColor" viewBox="0 0 20 20">
                                                                        <path fill-rule="evenodd"
                                                                            d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                                                                            clip-rule="evenodd" />
                                                                    </svg>
                                                                    Schedule & Automation
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </div>

                                                    <!-- Security & Monitoring -->
                                                    <div class="card card--interactive">
                                                        <div class="card__body">
                                                            <div
                                                                class="w-12 h-12 bg-red-600 rounded-lg flex items-center justify-center mb-6">
                                                                <svg class="w-6 h-6 text-white" fill="none"
                                                                    stroke="currentColor" viewBox="0 0 24 24">
                                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                                        stroke-width="2"
                                                                        d="M15 10l4.553-2.276A1 1 0 0121 8.618v6.764a1 1 0 01-1.447.894L15 14M5 18h8a2 2 0 002-2V8a2 2 0 00-2-2H5a2 2 0 00-2 2v8a2 2 0 002 2z" />
                                                                </svg>
                                                            </div>
                                                            <h3 class="text-xl font-semibold text-neutral-900 mb-3">
                                                                Security & Monitoring</h3>
                                                            <p class="text-neutral-600 mb-4">
                                                                Comprehensive security solutions with cameras, sensors,
                                                                and smart locks for complete home protection.
                                                            </p>
                                                            <ul class="space-y-2 text-sm text-neutral-700">
                                                                <li class="flex items-center gap-2">
                                                                    <svg class="w-4 h-4 text-success"
                                                                        fill="currentColor" viewBox="0 0 20 20">
                                                                        <path fill-rule="evenodd"
                                                                            d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                                                                            clip-rule="evenodd" />
                                                                    </svg>
                                                                    HD Video Surveillance
                                                                </li>
                                                                <li class="flex items-center gap-2">
                                                                    <svg class="w-4 h-4 text-success"
                                                                        fill="currentColor" viewBox="0 0 20 20">
                                                                        <path fill-rule="evenodd"
                                                                            d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                                                                            clip-rule="evenodd" />
                                                                    </svg>
                                                                    Motion & Door Sensors
                                                                </li>
                                                                <li class="flex items-center gap-2">
                                                                    <svg class="w-4 h-4 text-success"
                                                                        fill="currentColor" viewBox="0 0 20 20">
                                                                        <path fill-rule="evenodd"
                                                                            d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                                                                            clip-rule="evenodd" />
                                                                    </svg>
                                                                    Instant Alerts
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </div>

                                                    <!-- Climate Control -->
                                                    <div class="card card--interactive">
                                                        <div class="card__body">
                                                            <div
                                                                class="w-12 h-12 bg-blue-600 rounded-lg flex items-center justify-center mb-6">
                                                                <svg class="w-6 h-6 text-white" fill="none"
                                                                    stroke="currentColor" viewBox="0 0 24 24">
                                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                                        stroke-width="2"
                                                                        d="M3 15a4 4 0 004 4h9a5 5 0 10-.1-9.999 5.002 5.002 0 10-9.78 2.096A4.001 4.001 0 003 15z" />
                                                                </svg>
                                                            </div>
                                                            <h3 class="text-xl font-semibold text-neutral-900 mb-3">
                                                                Climate Control</h3>
                                                            <p class="text-neutral-600 mb-4">
                                                                Smart thermostats and HVAC control for optimal comfort
                                                                and energy efficiency throughout your home.
                                                            </p>
                                                            <ul class="space-y-2 text-sm text-neutral-700">
                                                                <li class="flex items-center gap-2">
                                                                    <svg class="w-4 h-4 text-success"
                                                                        fill="currentColor" viewBox="0 0 20 20">
                                                                        <path fill-rule="evenodd"
                                                                            d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                                                                            clip-rule="evenodd" />
                                                                    </svg>
                                                                    Learning Algorithms
                                                                </li>
                                                                <li class="flex items-center gap-2">
                                                                    <svg class="w-4 h-4 text-success"
                                                                        fill="currentColor" viewBox="0 0 20 20">
                                                                        <path fill-rule="evenodd"
                                                                            d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                                                                            clip-rule="evenodd" />
                                                                    </svg>
                                                                    Remote Access
                                                                </li>
                                                                <li class="flex items-center gap-2">
                                                                    <svg class="w-4 h-4 text-success"
                                                                        fill="currentColor" viewBox="0 0 20 20">
                                                                        <path fill-rule="evenodd"
                                                                            d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                                                                            clip-rule="evenodd" />
                                                                    </svg>
                                                                    Energy Reports
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </div>

                                                    <!-- Entertainment Systems -->
                                                    <div class="card card--interactive">
                                                        <div class="card__body">
                                                            <div
                                                                class="w-12 h-12 bg-purple-600 rounded-lg flex items-center justify-center mb-6">
                                                                <svg class="w-6 h-6 text-white" fill="none"
                                                                    stroke="currentColor" viewBox="0 0 24 24">
                                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                                        stroke-width="2"
                                                                        d="M15.536 8.464a5 5 0 010 7.072m2.828-2.828a9 9 0 010-1.414M6.343 6.343a9 9 0 000 12.728m0-12.728A9 9 0 018.464 4.536" />
                                                                </svg>
                                                            </div>
                                                            <h3 class="text-xl font-semibold text-neutral-900 mb-3">
                                                                Entertainment Hub</h3>
                                                            <p class="text-neutral-600 mb-4">
                                                                Multi-room audio, smart TVs, and streaming integration
                                                                for seamless entertainment throughout your home.
                                                            </p>
                                                            <ul class="space-y-2 text-sm text-neutral-700">
                                                                <li class="flex items-center gap-2">
                                                                    <svg class="w-4 h-4 text-success"
                                                                        fill="currentColor" viewBox="0 0 20 20">
                                                                        <path fill-rule="evenodd"
                                                                            d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                                                                            clip-rule="evenodd" />
                                                                    </svg>
                                                                    Multi-room Audio
                                                                </li>
                                                                <li class="flex items-center gap-2">
                                                                    <svg class="w-4 h-4 text-success"
                                                                        fill="currentColor" viewBox="0 0 20 20">
                                                                        <path fill-rule="evenodd"
                                                                            d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                                                                            clip-rule="evenodd" />
                                                                    </svg>
                                                                    Voice Control
                                                                </li>
                                                                <li class="flex items-center gap-2">
                                                                    <svg class="w-4 h-4 text-success"
                                                                        fill="currentColor" viewBox="0 0 20 20">
                                                                        <path fill-rule="evenodd"
                                                                            d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                                                                            clip-rule="evenodd" />
                                                                    </svg>
                                                                    Streaming Integration
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </div>

                                                    <!-- Kitchen & Appliances -->
                                                    <div class="card card--interactive">
                                                        <div class="card__body">
                                                            <div
                                                                class="w-12 h-12 bg-green-600 rounded-lg flex items-center justify-center mb-6">
                                                                <svg class="w-6 h-6 text-white" fill="none"
                                                                    stroke="currentColor" viewBox="0 0 24 24">
                                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                                        stroke-width="2"
                                                                        d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                                                                </svg>
                                                            </div>
                                                            <h3 class="text-xl font-semibold text-neutral-900 mb-3">
                                                                Smart Kitchen</h3>
                                                            <p class="text-neutral-600 mb-4">
                                                                Connected appliances and smart kitchen devices that make
                                                                cooking and meal planning effortless.
                                                            </p>
                                                            <ul class="space-y-2 text-sm text-neutral-700">
                                                                <li class="flex items-center gap-2">
                                                                    <svg class="w-4 h-4 text-success"
                                                                        fill="currentColor" viewBox="0 0 20 20">
                                                                        <path fill-rule="evenodd"
                                                                            d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                                                                            clip-rule="evenodd" />
                                                                    </svg>
                                                                    Smart Appliances
                                                                </li>
                                                                <li class="flex items-center gap-2">
                                                                    <svg class="w-4 h-4 text-success"
                                                                        fill="currentColor" viewBox="0 0 20 20">
                                                                        <path fill-rule="evenodd"
                                                                            d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                                                                            clip-rule="evenodd" />
                                                                    </svg>
                                                                    Recipe Integration
                                                                </li>
                                                                <li class="flex items-center gap-2">
                                                                    <svg class="w-4 h-4 text-success"
                                                                        fill="currentColor" viewBox="0 0 20 20">
                                                                        <path fill-rule="evenodd"
                                                                            d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                                                                            clip-rule="evenodd" />
                                                                    </svg>
                                                                    Energy Monitoring
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </div>

                                                    <!-- Voice Assistants -->
                                                    <div class="card card--interactive">
                                                        <div class="card__body">
                                                            <div
                                                                class="w-12 h-12 bg-indigo-600 rounded-lg flex items-center justify-center mb-6">
                                                                <svg class="w-6 h-6 text-white" fill="none"
                                                                    stroke="currentColor" viewBox="0 0 24 24">
                                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                                        stroke-width="2"
                                                                        d="M19 11a7 7 0 01-7 7m0 0a7 7 0 01-7-7m7 7v4m0 0H8m4 0h4m-4-8a3 3 0 01-3-3V5a3 3 0 116 0v6a3 3 0 01-3 3z" />
                                                                </svg>
                                                            </div>
                                                            <h3 class="text-xl font-semibold text-neutral-900 mb-3">
                                                                Voice Control</h3>
                                                            <p class="text-neutral-600 mb-4">
                                                                Hands-free control of your entire smart home ecosystem
                                                                through advanced voice assistants and AI.
                                                            </p>
                                                            <ul class="space-y-2 text-sm text-neutral-700">
                                                                <li class="flex items-center gap-2">
                                                                    <svg class="w-4 h-4 text-success"
                                                                        fill="currentColor" viewBox="0 0 20 20">
                                                                        <path fill-rule="evenodd"
                                                                            d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                                                                            clip-rule="evenodd" />
                                                                    </svg>
                                                                    Natural Language
                                                                </li>
                                                                <li class="flex items-center gap-2">
                                                                    <svg class="w-4 h-4 text-success"
                                                                        fill="currentColor" viewBox="0 0 20 20">
                                                                        <path fill-rule="evenodd"
                                                                            d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                                                                            clip-rule="evenodd" />
                                                                    </svg>
                                                                    Multi-room Control
                                                                </li>
                                                                <li class="flex items-center gap-2">
                                                                    <svg class="w-4 h-4 text-success"
                                                                        fill="currentColor" viewBox="0 0 20 20">
                                                                        <path fill-rule="evenodd"
                                                                            d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                                                                            clip-rule="evenodd" />
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
                                                <div
                                                    class="flex flex-col lg:flex-row lg:items-center lg:justify-between gap-6 mb-8">
                                                    <div>
                                                        <h2 class="text-2xl font-bold text-neutral-900 mb-2">Smart Home
                                                            Products</h2>
                                                        <p class="text-neutral-600">Build your perfect connected home
                                                            with our premium smart devices</p>
                                                    </div>

                                                    <!-- Search and Filter Controls -->
                                                    <div class="flex flex-col sm:flex-row gap-4">
                                                        <div class="relative">
                                                            <form
                                                                action="${pageContext.request.contextPath}/category-smarthome.jsp"
                                                                method="get" class="flex">
                                                                <input type="text" name="search"
                                                                    value="${fn:escapeXml(param.search)}"
                                                                    placeholder="Search smart home products..."
                                                                    class="form-input rounded-r-none w-64">
                                                                <button type="submit"
                                                                    class="btn btn--primary rounded-l-none">
                                                                    <svg class="w-4 h-4" fill="none"
                                                                        stroke="currentColor" viewBox="0 0 24 24">
                                                                        <path stroke-linecap="round"
                                                                            stroke-linejoin="round" stroke-width="2"
                                                                            d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                                                                    </svg>
                                                                </button>
                                                            </form>
                                                        </div>

                                                        <select class="form-select"
                                                            onchange="filterProducts(this.value)">
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

                                            <!-- Products Grid Section (Section 1.1 - Hierarchical Product Information) -->
                                            <section id="products" class="py-8">
                                                <div class="container">
                                                    <!-- Skeleton Loading State (Section 3.2) -->
                                                    <div id="products-skeleton" class="product-grid hidden">
                                                        <c:forEach begin="1" end="8" varStatus="loop">
                                                            <div class="skeleton-card">
                                                                <div class="skeleton skeleton-image"></div>
                                                                <div
                                                                    class="skeleton skeleton-text skeleton-text--title">
                                                                </div>
                                                                <div class="skeleton skeleton-text"></div>
                                                                <div
                                                                    class="skeleton skeleton-text skeleton-text--short">
                                                                </div>
                                                            </div>
                                                        </c:forEach>
                                                    </div>

                                                    <div class="mb-8">
                                                        <h2 class="text-display-sm font-bold text-neutral-900 mb-2">
                                                            Smart Home Products</h2>
                                                        <p class="text-lg text-neutral-600">Transform your home with our
                                                            comprehensive range of smart home devices and automation
                                                            solutions</p>
                                                    </div>

                                                    <c:choose>
                                                        <c:when test="${products != null && !empty products}">
                                                            <div class="product-grid" id="products-grid">
                                                                <c:forEach var="p" items="${products}">
                                                                    <div class="product-card" data-product-id="${p.id}"
                                                                        data-price="${p.price}"
                                                                        data-name="${fn:toLowerCase(p.name)}"
                                                                        data-category="smarthome" tabindex="0"
                                                                        role="article" aria-label="Product: ${p.name}">
                                                                        <div class="product-card__image-container">
                                                                            <img class="product-card__image"
                                                                                src="${p.imageUrl != null && !empty p.imageUrl ? p.imageUrl : 'images/default-product.png'}"
                                                                                alt="${p.name}" loading="lazy"
                                                                                width="300" height="300"
                                                                                onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/images/default-product.png';" />
                                                                            <!-- Stock Badge (Visibility of System Status - Nielsen's Heuristic 1) -->
                                                                            <c:if
                                                                                test="${p.stockQuantity > 0 && p.stockQuantity < 5}">
                                                                                <span
                                                                                    class="product-card__badge product-card__badge--warning"
                                                                                    aria-label="Low stock: ${p.stockQuantity} remaining">
                                                                                    Low Stock
                                                                                </span>
                                                                            </c:if>
                                                                            <c:if test="${p.stockQuantity == 0}">
                                                                                <span
                                                                                    class="product-card__badge product-card__badge--error"
                                                                                    aria-label="Out of stock">
                                                                                    Out of Stock
                                                                                </span>
                                                                            </c:if>
                                                                        </div>
                                                                        <div class="product-card__body">
                                                                            <div class="product-card__header">
                                                                                <h3 class="product-card__title">
                                                                                    ${p.name}</h3>
                                                                                <!-- Key Spec Badge (Section 1.1 - Recognition rather than recall) -->
                                                                                <span class="product-card__spec-badge"
                                                                                    title="Communication Protocol">WiFi</span>
                                                                            </div>
                                                                            <p class="product-card__description">
                                                                                <c:choose>
                                                                                    <c:when
                                                                                        test="${fn:length(p.description) > 100}">
                                                                                        ${fn:substring(p.description, 0,
                                                                                        100)}...
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                        ${p.description}
                                                                                    </c:otherwise>
                                                                                </c:choose>
                                                                            </p>
                                                                            <div class="product-card__footer">
                                                                                <div class="product-card__price-info">
                                                                                    <div class="product-card__price">$
                                                                                        <fmt:formatNumber
                                                                                            value="${p.price}"
                                                                                            pattern="#.00" />
                                                                                    </div>
                                                                                    <div
                                                                                        class="product-card__stock-status">
                                                                                        <c:choose>
                                                                                            <c:when
                                                                                                test="${p.stockQuantity > 0}">
                                                                                                <span
                                                                                                    class="text-success text-sm">??In
                                                                                                    Stock</span>
                                                                                            </c:when>
                                                                                            <c:otherwise>
                                                                                                <span
                                                                                                    class="text-error text-sm">??Out
                                                                                                    of Stock</span>
                                                                                            </c:otherwise>
                                                                                        </c:choose>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="product-card__actions">
                                                                                    <a href="${pageContext.request.contextPath}/product?id=${p.id}"
                                                                                        class="btn btn--outline btn--sm"
                                                                                        aria-label="View details for ${p.name}">
                                                                                        View Details
                                                                                    </a>
                                                                                    <button type="button"
                                                                                        onclick="if(typeof addToCart === 'function') { addToCart(${p.id}, 1); } else { window.location.href='${pageContext.request.contextPath}/product?id=${p.id}'; }"
                                                                                        class="btn btn--primary btn--sm"
                                                                                        aria-label="Add ${p.name} to cart"
                                                                                        <c:if
                                                                                        test="${p.stockQuantity == 0}">disabled
                                                                                        </c:if>>
                                                                                        <c:choose>
                                                                                            <c:when
                                                                                                test="${p.stockQuantity > 0}">
                                                                                                Add to Cart</c:when>
                                                                                            <c:otherwise>Out of Stock
                                                                                            </c:otherwise>
                                                                                        </c:choose>
                                                                                    </button>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </c:forEach>
                                                            </div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <!-- Empty State (Section 3.2) -->
                                                            <div class="empty-state text-center py-16">
                                                                <div class="empty-state__icon mb-6">
                                                                    <svg class="w-24 h-24 mx-auto text-neutral-400"
                                                                        fill="currentColor" viewBox="0 0 20 20"
                                                                        aria-hidden="true">
                                                                        <path fill-rule="evenodd"
                                                                            d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z"
                                                                            clip-rule="evenodd"></path>
                                                                    </svg>
                                                                </div>
                                                                <h3 class="text-2xl font-bold text-neutral-900 mb-4">No
                                                                    smart home products found</h3>
                                                                <p
                                                                    class="text-lg text-neutral-600 mb-8 max-w-md mx-auto">
                                                                    <c:choose>
                                                                        <c:when
                                                                            test="${param.search != null && !empty param.search}">
                                                                            We couldn't find any smart home products
                                                                            matching "${fn:escapeXml(param.search)}".
                                                                            Try adjusting
                                                                            your search terms.
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            There are no smart home products available
                                                                            at this time. Please check back later.
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </p>
                                                                <a href="${pageContext.request.contextPath}/browse"
                                                                    class="btn btn--primary">
                                                                    Browse All Products
                                                                </a>
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </section>

                                            <!-- Smart Home Bundles -->
                                            <section class="mb-16">
                                                <div class="text-center mb-12">
                                                    <h2 class="text-display-sm font-bold text-neutral-900 mb-4">Smart
                                                        Home Starter Bundles</h2>
                                                    <p class="text-lg text-neutral-600 max-w-3xl mx-auto">
                                                        Get started with complete smart home packages designed for
                                                        different needs and budgets.
                                                    </p>
                                                </div>

                                                <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                                                    <div class="card card--elevated">
                                                        <div class="card__header text-center">
                                                            <h3 class="text-xl font-semibold text-neutral-900">Starter
                                                                Bundle</h3>
                                                            <div class="text-3xl font-bold text-brand-primary mt-2">$299
                                                            </div>
                                                            <p class="text-sm text-neutral-600 mt-1">Perfect for
                                                                beginners</p>
                                                        </div>
                                                        <div class="card__body">
                                                            <ul class="space-y-3">
                                                                <li class="flex items-center gap-3">
                                                                    <svg class="w-5 h-5 text-success"
                                                                        fill="currentColor" viewBox="0 0 20 20">
                                                                        <path fill-rule="evenodd"
                                                                            d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                                                                            clip-rule="evenodd" />
                                                                    </svg>
                                                                    <span>2 Smart LED Bulbs</span>
                                                                </li>
                                                                <li class="flex items-center gap-3">
                                                                    <svg class="w-5 h-5 text-success"
                                                                        fill="currentColor" viewBox="0 0 20 20">
                                                                        <path fill-rule="evenodd"
                                                                            d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                                                                            clip-rule="evenodd" />
                                                                    </svg>
                                                                    <span>Smart Speaker</span>
                                                                </li>
                                                                <li class="flex items-center gap-3">
                                                                    <svg class="w-5 h-5 text-success"
                                                                        fill="currentColor" viewBox="0 0 20 20">
                                                                        <path fill-rule="evenodd"
                                                                            d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                                                                            clip-rule="evenodd" />
                                                                    </svg>
                                                                    <span>Smart Plug (2 pack)</span>
                                                                </li>
                                                                <li class="flex items-center gap-3">
                                                                    <svg class="w-5 h-5 text-success"
                                                                        fill="currentColor" viewBox="0 0 20 20">
                                                                        <path fill-rule="evenodd"
                                                                            d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                                                                            clip-rule="evenodd" />
                                                                    </svg>
                                                                    <span>Hub & App Setup</span>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                        <div class="card__footer">
                                                            <button class="btn btn--outline btn--full">Choose
                                                                Starter</button>
                                                        </div>
                                                    </div>

                                                    <div class="card card--elevated border-2 border-brand-primary">
                                                        <div class="card__header text-center">
                                                            <div
                                                                class="bg-brand-primary text-white text-xs font-semibold px-3 py-1 rounded-full inline-block mb-2">
                                                                MOST POPULAR</div>
                                                            <h3 class="text-xl font-semibold text-neutral-900">Essential
                                                                Bundle</h3>
                                                            <div class="text-3xl font-bold text-brand-primary mt-2">$599
                                                            </div>
                                                            <p class="text-sm text-neutral-600 mt-1">Complete basic
                                                                coverage</p>
                                                        </div>
                                                        <div class="card__body">
                                                            <ul class="space-y-3">
                                                                <li class="flex items-center gap-3">
                                                                    <svg class="w-5 h-5 text-success"
                                                                        fill="currentColor" viewBox="0 0 20 20">
                                                                        <path fill-rule="evenodd"
                                                                            d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                                                                            clip-rule="evenodd" />
                                                                    </svg>
                                                                    <span>Everything in Starter</span>
                                                                </li>
                                                                <li class="flex items-center gap-3">
                                                                    <svg class="w-5 h-5 text-success"
                                                                        fill="currentColor" viewBox="0 0 20 20">
                                                                        <path fill-rule="evenodd"
                                                                            d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                                                                            clip-rule="evenodd" />
                                                                    </svg>
                                                                    <span>Smart Thermostat</span>
                                                                </li>
                                                                <li class="flex items-center gap-3">
                                                                    <svg class="w-5 h-5 text-success"
                                                                        fill="currentColor" viewBox="0 0 20 20">
                                                                        <path fill-rule="evenodd"
                                                                            d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                                                                            clip-rule="evenodd" />
                                                                    </svg>
                                                                    <span>Security Camera</span>
                                                                </li>
                                                                <li class="flex items-center gap-3">
                                                                    <svg class="w-5 h-5 text-success"
                                                                        fill="currentColor" viewBox="0 0 20 20">
                                                                        <path fill-rule="evenodd"
                                                                            d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                                                                            clip-rule="evenodd" />
                                                                    </svg>
                                                                    <span>Smart Door Lock</span>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                        <div class="card__footer">
                                                            <button class="btn btn--primary btn--full">Choose
                                                                Essential</button>
                                                        </div>
                                                    </div>

                                                    <div class="card card--elevated">
                                                        <div class="card__header text-center">
                                                            <h3 class="text-xl font-semibold text-neutral-900">Premium
                                                                Bundle</h3>
                                                            <div class="text-3xl font-bold text-brand-primary mt-2">$999
                                                            </div>
                                                            <p class="text-sm text-neutral-600 mt-1">Complete smart home
                                                            </p>
                                                        </div>
                                                        <div class="card__body">
                                                            <ul class="space-y-3">
                                                                <li class="flex items-center gap-3">
                                                                    <svg class="w-5 h-5 text-success"
                                                                        fill="currentColor" viewBox="0 0 20 20">
                                                                        <path fill-rule="evenodd"
                                                                            d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                                                                            clip-rule="evenodd" />
                                                                    </svg>
                                                                    <span>Everything in Essential</span>
                                                                </li>
                                                                <li class="flex items-center gap-3">
                                                                    <svg class="w-5 h-5 text-success"
                                                                        fill="currentColor" viewBox="0 0 20 20">
                                                                        <path fill-rule="evenodd"
                                                                            d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                                                                            clip-rule="evenodd" />
                                                                    </svg>
                                                                    <span>Multiple Room Sensors</span>
                                                                </li>
                                                                <li class="flex items-center gap-3">
                                                                    <svg class="w-5 h-5 text-success"
                                                                        fill="currentColor" viewBox="0 0 20 20">
                                                                        <path fill-rule="evenodd"
                                                                            d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                                                                            clip-rule="evenodd" />
                                                                    </svg>
                                                                    <span>Smart Kitchen Appliances</span>
                                                                </li>
                                                                <li class="flex items-center gap-3">
                                                                    <svg class="w-5 h-5 text-success"
                                                                        fill="currentColor" viewBox="0 0 20 20">
                                                                        <path fill-rule="evenodd"
                                                                            d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                                                                            clip-rule="evenodd" />
                                                                    </svg>
                                                                    <span>Professional Installation</span>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                        <div class="card__footer">
                                                            <button class="btn btn--outline btn--full">Choose
                                                                Premium</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </section>

                                            <!-- Call to Action -->
                                            <section
                                                class="card bg-gradient-to-r from-purple-600 to-pink-600 text-white">
                                                <div class="card__body text-center py-16">
                                                    <h2 class="text-3xl font-bold mb-4">Start Your Smart Home Journey
                                                        Today</h2>
                                                    <p class="text-xl mb-8 opacity-90">
                                                        Join over 2 million homeowners who have already transformed
                                                        their living spaces with smart technology.
                                                        Get personalized recommendations and expert installation
                                                        support.
                                                    </p>
                                                    <div class="flex flex-col sm:flex-row gap-4 justify-center">
                                                        <a href="${pageContext.request.contextPath}/contact.jsp"
                                                            class="btn btn--secondary btn--lg">
                                                            <svg class="w-5 h-5" fill="none" stroke="currentColor"
                                                                viewBox="0 0 24 24">
                                                                <path stroke-linecap="round" stroke-linejoin="round"
                                                                    stroke-width="2"
                                                                    d="M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z" />
                                                            </svg>
                                                            Free Smart Home Consultation
                                                        </a>
                                                        <a href="${pageContext.request.contextPath}/browse"
                                                            class="btn btn--outline btn--lg border-white text-white hover:bg-white hover:text-purple-600">
                                                            <svg class="w-5 h-5" fill="none" stroke="currentColor"
                                                                viewBox="0 0 24 24">
                                                                <path stroke-linecap="round" stroke-linejoin="round"
                                                                    stroke-width="2"
                                                                    d="M3 7v10a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2H5a2 2 0 00-2-2H3v10z" />
                                                            </svg>
                                                            Browse All Smart Devices
                                                        </a>
                                                    </div>
                                                </div>
                                            </section>
                                        </main>

                                        <!-- Include Footer -->

                                        <!-- JavaScript -->
                                        <script src="${pageContext.request.contextPath}/js/main.js"></script>
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
                                                const grid = document.getElementById('products-grid');
                                                if (!grid) return;

                                                const products = Array.from(grid.querySelectorAll('.product-card'));

                                                products.sort((a, b) => {
                                                    switch (sortBy) {
                                                        case 'name':
                                                            const titleA = a.querySelector('.product-card__title')?.textContent || '';
                                                            const titleB = b.querySelector('.product-card__title')?.textContent || '';
                                                            return titleA.localeCompare(titleB);
                                                        case 'price-low':
                                                            return parseFloat(a.dataset.price || 0) - parseFloat(b.dataset.price || 0);
                                                        case 'price-high':
                                                            return parseFloat(b.dataset.price || 0) - parseFloat(a.dataset.price || 0);
                                                        default:
                                                            return 0;
                                                    }
                                                });

                                                products.forEach(product => grid.appendChild(product));
                                            }

                                            // Initialize page
                                            document.addEventListener('DOMContentLoaded', function () {
                                                // Show skeleton loading if products are being loaded
                                                const productsGrid = document.getElementById('products-grid');
                                                const skeleton = document.getElementById('products-skeleton');

                                                if (productsGrid && productsGrid.children.length === 0 && skeleton) {
                                                    skeleton.classList.remove('hidden');
                                                } else if (skeleton) {
                                                    skeleton.classList.add('hidden');
                                                }
                                            });

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
                                                    button.addEventListener('click', function () {
                                                        const bundleName = this.textContent.replace('Choose ', '');
                                                        showToast(`${bundleName} Bundle selected! Redirecting to checkout...`, 'success');

                                                        // Simulate bundle selection
                                                        setTimeout(() => {
                                                            window.location.href = '${pageContext.request.contextPath}/checkout.jsp?bundle=' + bundleName.toLowerCase();
                                                        }, 1500);
                                                    });
                                                }
                                            });

                                            // Initialize page animations
                                            document.addEventListener('DOMContentLoaded', function () {
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
                                    </t:base>