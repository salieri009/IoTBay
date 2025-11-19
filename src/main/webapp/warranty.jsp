<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>

<t:base title="Warranty Information - IoT Bay" description="Warranty coverage and support information for IoT Bay products">
    <main class="py-12">
        <div class="container max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
            <!-- Hero Section -->
            <section class="text-center mb-12">
                <h1 class="text-4xl md:text-5xl font-bold text-neutral-900 mb-4">Warranty Information</h1>
                <p class="text-lg text-neutral-600 max-w-2xl mx-auto">
                    Comprehensive warranty coverage for all IoT Bay products
                </p>
            </section>

            <!-- Warranty Overview -->
            <section class="bg-white rounded-lg border border-neutral-200 p-8 mb-8">
                <h2 class="text-2xl font-bold text-neutral-900 mb-4">Standard Warranty Coverage</h2>
                <div class="space-y-4 text-neutral-600">
                    <p>
                        All IoT Bay products come with a comprehensive warranty that covers manufacturing defects and component failures. Our warranty ensures your peace of mind when investing in IoT technology.
                    </p>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mt-6">
                        <div class="flex items-start gap-3">
                            <svg class="w-6 h-6 text-brand-primary flex-shrink-0 mt-1" fill="currentColor" viewBox="0 0 20 20">
                                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                            </svg>
                            <div>
                                <h3 class="font-semibold text-neutral-900 mb-1">1-2 Year Warranty</h3>
                                <p class="text-sm">Standard coverage for most IoT devices and sensors</p>
                            </div>
                        </div>
                        <div class="flex items-start gap-3">
                            <svg class="w-6 h-6 text-brand-primary flex-shrink-0 mt-1" fill="currentColor" viewBox="0 0 20 20">
                                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                            </svg>
                            <div>
                                <h3 class="font-semibold text-neutral-900 mb-1">Free Replacement</h3>
                                <p class="text-sm">Defective products replaced at no cost during warranty period</p>
                            </div>
                        </div>
                        <div class="flex items-start gap-3">
                            <svg class="w-6 h-6 text-brand-primary flex-shrink-0 mt-1" fill="currentColor" viewBox="0 0 20 20">
                                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                            </svg>
                            <div>
                                <h3 class="font-semibold text-neutral-900 mb-1">Technical Support</h3>
                                <p class="text-sm">Free technical assistance for warranty-covered issues</p>
                            </div>
                        </div>
                        <div class="flex items-start gap-3">
                            <svg class="w-6 h-6 text-brand-primary flex-shrink-0 mt-1" fill="currentColor" viewBox="0 0 20 20">
                                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                            </svg>
                            <div>
                                <h3 class="font-semibold text-neutral-900 mb-1">Extended Options</h3>
                                <p class="text-sm">Optional extended warranty plans available at checkout</p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Warranty Terms -->
            <section class="mb-8">
                <h2 class="text-2xl font-bold text-neutral-900 mb-6">Warranty Terms & Conditions</h2>
                <div class="space-y-6">
                    <div class="bg-white rounded-lg border border-neutral-200 p-6">
                        <h3 class="text-xl font-semibold text-neutral-900 mb-3">What's Covered</h3>
                        <ul class="space-y-2 text-neutral-600">
                            <li class="flex items-start gap-2">
                                <span class="text-brand-primary mt-1">•</span>
                                <span>Manufacturing defects in materials and workmanship</span>
                            </li>
                            <li class="flex items-start gap-2">
                                <span class="text-brand-primary mt-1">•</span>
                                <span>Component failures under normal use conditions</span>
                            </li>
                            <li class="flex items-start gap-2">
                                <span class="text-brand-primary mt-1">•</span>
                                <span>Software bugs and firmware issues</span>
                            </li>
                            <li class="flex items-start gap-2">
                                <span class="text-brand-primary mt-1">•</span>
                                <span>Battery defects (if applicable) within first 6 months</span>
                            </li>
                        </ul>
                    </div>

                    <div class="bg-white rounded-lg border border-neutral-200 p-6">
                        <h3 class="text-xl font-semibold text-neutral-900 mb-3">What's Not Covered</h3>
                        <ul class="space-y-2 text-neutral-600">
                            <li class="flex items-start gap-2">
                                <span class="text-red-500 mt-1">•</span>
                                <span>Damage from misuse, abuse, or accidents</span>
                            </li>
                            <li class="flex items-start gap-2">
                                <span class="text-red-500 mt-1">•</span>
                                <span>Unauthorized modifications or repairs</span>
                            </li>
                            <li class="flex items-start gap-2">
                                <span class="text-red-500 mt-1">•</span>
                                <span>Normal wear and tear or cosmetic damage</span>
                            </li>
                            <li class="flex items-start gap-2">
                                <span class="text-red-500 mt-1">•</span>
                                <span>Damage from exposure to extreme conditions</span>
                            </li>
                            <li class="flex items-start gap-2">
                                <span class="text-red-500 mt-1">•</span>
                                <span>Loss of data or software (backup recommended)</span>
                            </li>
                        </ul>
                    </div>
                </div>
            </section>

            <!-- Warranty Claim Process -->
            <section class="mb-8">
                <h2 class="text-2xl font-bold text-neutral-900 mb-6">How to Make a Warranty Claim</h2>
                <div class="bg-white rounded-lg border border-neutral-200 p-6">
                    <ol class="space-y-4">
                        <li class="flex gap-4">
                            <span class="flex-shrink-0 w-8 h-8 bg-brand-primary text-white rounded-full flex items-center justify-center font-bold">1</span>
                            <div>
                                <h4 class="font-semibold text-neutral-900 mb-1">Contact Support</h4>
                                <p class="text-neutral-600">Reach out to our support team via email or phone with your order number and issue description</p>
                            </div>
                        </li>
                        <li class="flex gap-4">
                            <span class="flex-shrink-0 w-8 h-8 bg-brand-primary text-white rounded-full flex items-center justify-center font-bold">2</span>
                            <div>
                                <h4 class="font-semibold text-neutral-900 mb-1">Provide Documentation</h4>
                                <p class="text-neutral-600">Submit photos of the defect and your original purchase receipt or order confirmation</p>
                            </div>
                        </li>
                        <li class="flex gap-4">
                            <span class="flex-shrink-0 w-8 h-8 bg-brand-primary text-white rounded-full flex items-center justify-center font-bold">3</span>
                            <div>
                                <h4 class="font-semibold text-neutral-900 mb-1">Review & Approval</h4>
                                <p class="text-neutral-600">Our team will review your claim within 2-3 business days</p>
                            </div>
                        </li>
                        <li class="flex gap-4">
                            <span class="flex-shrink-0 w-8 h-8 bg-brand-primary text-white rounded-full flex items-center justify-center font-bold">4</span>
                            <div>
                                <h4 class="font-semibold text-neutral-900 mb-1">Replacement or Repair</h4>
                                <p class="text-neutral-600">Upon approval, we'll ship a replacement or provide repair instructions</p>
                            </div>
                        </li>
                    </ol>
                </div>
            </section>

            <!-- Contact CTA -->
            <section class="bg-brand-primary text-white rounded-lg p-8 text-center">
                <h2 class="text-2xl font-bold mb-4">Need Warranty Support?</h2>
                <p class="text-lg mb-6 text-white/90">Contact our support team for assistance with warranty claims</p>
                <div class="flex flex-col sm:flex-row gap-4 justify-center">
                    <a href="${pageContext.request.contextPath}/contact.jsp" class="inline-block bg-white text-brand-primary px-6 py-3 rounded-lg font-semibold hover:bg-neutral-100 transition-colors">
                        Contact Support
                    </a>
                    <a href="mailto:support@iotbay.com" class="inline-block bg-transparent border-2 border-white text-white px-6 py-3 rounded-lg font-semibold hover:bg-white/10 transition-colors">
                        Email: support@iotbay.com
                    </a>
                </div>
            </section>
        </div>
    </main>
</t:base>

