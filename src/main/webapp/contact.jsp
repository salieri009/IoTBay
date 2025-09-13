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
    <meta name="description" content="Contact IoT Bay for support, sales inquiries, and technical assistance. Get help from our expert team.">
    <title>Contact Us | IoT Bay - Smart Technology Store</title>
    
    <!-- CSS -->
    <link rel="stylesheet" href="<%= contextPath %>/css/modern-theme.css">
    
    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body class="antialiased bg-neutral-50 text-neutral-900 min-h-screen flex flex-col">
    
    <!-- Header -->
    <jsp:include page="components/header.jsp" />
    
    <main class="flex-1">
        <!-- Hero Section -->
        <section class="hero py-16 bg-gradient-to-br from-blue-50 via-white to-purple-50">
            <div class="container text-center">
                <h1 class="text-display-lg text-neutral-900 mb-4">
                    Get in <span class="text-transparent bg-clip-text bg-gradient-to-r from-brand-primary to-brand-secondary">Touch</span>
                </h1>
                <p class="text-lg text-neutral-600 max-w-2xl mx-auto mb-8">
                    Have questions about IoT solutions? Our expert team is here to help you find the perfect technology for your needs.
                </p>
            </div>
        </section>
        
        <!-- Contact Section -->
        <section class="py-16">
            <div class="container">
                <div class="grid grid-cols-1 lg:grid-cols-2 gap-12">
                    
                    <!-- Contact Form -->
                    <div class="card p-8">
                        <h2 class="text-2xl font-semibold text-neutral-900 mb-6">Send Us a Message</h2>
                        
                        <form action="<%= contextPath %>/contact" method="post" class="space-y-6">
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                <div class="form__group">
                                    <label for="fullName" class="form__label">Full Name</label>
                                    <input type="text" 
                                           id="fullName" 
                                           name="fullName" 
                                           class="form__input" 
                                           required 
                                           autocomplete="name"
                                           placeholder="Enter your full name">
                                </div>
                                
                                <div class="form__group">
                                    <label for="email" class="form__label">Email Address</label>
                                    <input type="email" 
                                           id="email" 
                                           name="email" 
                                           class="form__input" 
                                           required 
                                           autocomplete="email"
                                           placeholder="Enter your email address">
                                </div>
                            </div>
                            
                            <div class="form__group">
                                <label for="phone" class="form__label">Phone Number</label>
                                <input type="tel" 
                                       id="phone" 
                                       name="phone" 
                                       class="form__input" 
                                       autocomplete="tel"
                                       placeholder="Enter your phone number">
                            </div>
                            
                            <div class="form__group">
                                <label for="subject" class="form__label">Subject</label>
                                <select id="subject" name="subject" class="form__select" required>
                                    <option value="">Select a subject</option>
                                    <option value="general">General Inquiry</option>
                                    <option value="technical">Technical Support</option>
                                    <option value="sales">Sales Question</option>
                                    <option value="partnership">Partnership Opportunity</option>
                                    <option value="feedback">Feedback</option>
                                    <option value="other">Other</option>
                                </select>
                            </div>
                            
                            <div class="form__group">
                                <label for="message" class="form__label">Message</label>
                                <textarea id="message" 
                                          name="message" 
                                          class="form__input" 
                                          rows="6" 
                                          required 
                                          placeholder="Tell us how we can help you..."></textarea>
                            </div>
                            
                            <div class="form__group">
                                <label class="checkbox">
                                    <input type="checkbox" name="privacy" required>
                                    <span class="checkbox__label">
                                        I agree to the <a href="<%= contextPath %>/privacy" class="text-brand-primary hover:text-brand-primary-700">Privacy Policy</a> 
                                        and <a href="<%= contextPath %>/terms" class="text-brand-primary hover:text-brand-primary-700">Terms of Service</a>
                                    </span>
                                </label>
                            </div>
                            
                            <button type="submit" class="btn btn--primary btn--lg w-full">
                                Send Message
                            </button>
                        </form>
                    </div>
                    
                    <!-- Contact Information -->
                    <div class="space-y-6">
                        <!-- Contact Cards -->
                        <div class="space-y-6">
                            <!-- Office Location -->
                            <div class="card p-6">
                                <div class="flex items-start gap-4">
                                    <div class="w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center flex-shrink-0">
                                        <svg class="w-6 h-6 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                                  d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"></path>
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                                  d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"></path>
                                        </svg>
                                    </div>
                                    <div>
                                        <h3 class="text-lg font-semibold text-neutral-900 mb-2">Visit Our Office</h3>
                                        <p class="text-neutral-600 mb-3">
                                            123 Technology Boulevard<br>
                                            Innovation District<br>
                                            Sydney, NSW 2000<br>
                                            Australia
                                        </p>
                                        <a href="https://maps.google.com/?q=123+Technology+Boulevard+Sydney" 
                                           target="_blank" 
                                           class="text-brand-primary hover:text-brand-primary-700 font-medium">
                                            Get Directions →
                                        </a>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Phone Support -->
                            <div class="card p-6">
                                <div class="flex items-start gap-4">
                                    <div class="w-12 h-12 bg-green-100 rounded-lg flex items-center justify-center flex-shrink-0">
                                        <svg class="w-6 h-6 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                                  d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z"></path>
                                        </svg>
                                    </div>
                                    <div>
                                        <h3 class="text-lg font-semibold text-neutral-900 mb-2">Call Us</h3>
                                        <div class="space-y-2">
                                            <p class="text-neutral-600">
                                                <span class="font-medium">Sales:</span> 
                                                <a href="tel:+61-2-9000-1234" class="text-brand-primary hover:text-brand-primary-700">+61 2 9000 1234</a>
                                            </p>
                                            <p class="text-neutral-600">
                                                <span class="font-medium">Support:</span> 
                                                <a href="tel:+61-2-9000-5678" class="text-brand-primary hover:text-brand-primary-700">+61 2 9000 5678</a>
                                            </p>
                                            <p class="text-sm text-neutral-500">Mon-Fri: 9AM-6PM AEST</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Email Support -->
                            <div class="card p-6">
                                <div class="flex items-start gap-4">
                                    <div class="w-12 h-12 bg-purple-100 rounded-lg flex items-center justify-center flex-shrink-0">
                                        <svg class="w-6 h-6 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                                  d="M3 8l7.89 4.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"></path>
                                        </svg>
                                    </div>
                                    <div>
                                        <h3 class="text-lg font-semibold text-neutral-900 mb-2">Email Us</h3>
                                        <div class="space-y-2">
                                            <p class="text-neutral-600">
                                                <span class="font-medium">Sales:</span> 
                                                <a href="mailto:sales@iotbay.com" class="text-brand-primary hover:text-brand-primary-700">sales@iotbay.com</a>
                                            </p>
                                            <p class="text-neutral-600">
                                                <span class="font-medium">Support:</span> 
                                                <a href="mailto:support@iotbay.com" class="text-brand-primary hover:text-brand-primary-700">support@iotbay.com</a>
                                            </p>
                                            <p class="text-neutral-600">
                                                <span class="font-medium">General:</span> 
                                                <a href="mailto:info@iotbay.com" class="text-brand-primary hover:text-brand-primary-700">info@iotbay.com</a>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Live Chat -->
                            <div class="card p-6">
                                <div class="flex items-start gap-4">
                                    <div class="w-12 h-12 bg-orange-100 rounded-lg flex items-center justify-center flex-shrink-0">
                                        <svg class="w-6 h-6 text-orange-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                                  d="M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z"></path>
                                        </svg>
                                    </div>
                                    <div>
                                        <h3 class="text-lg font-semibold text-neutral-900 mb-2">Live Chat</h3>
                                        <p class="text-neutral-600 mb-3">
                                            Get instant help from our support team.
                                        </p>
                                        <p class="text-sm text-neutral-500 mb-4">Mon-Fri: 9AM-6PM AEST</p>
                                        <button class="btn btn--secondary" onclick="openLiveChat()">Start Chat</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Social Media -->
                        <div class="card p-6">
                            <h3 class="text-lg font-semibold text-neutral-900 mb-4">Follow Us</h3>
                            <p class="text-neutral-600 mb-6">
                                Stay connected for the latest IoT news, product updates, and industry insights.
                            </p>
                            <div class="flex gap-4">
                                <a href="#" class="w-10 h-10 bg-neutral-100 rounded-lg flex items-center justify-center hover:bg-brand-primary-100 transition-colors" aria-label="LinkedIn">
                                    <svg class="w-5 h-5 text-neutral-600" fill="currentColor" viewBox="0 0 20 20">
                                        <path fill-rule="evenodd" d="M16.338 16.338H13.67V12.16c0-.995-.017-2.277-1.387-2.277-1.39 0-1.601 1.086-1.601 2.207v4.248H8.014v-8.59h2.559v1.174h.037c.356-.675 1.227-1.387 2.526-1.387 2.703 0 3.203 1.778 3.203 4.092v4.711zM5.005 6.575a1.548 1.548 0 11-.003-3.096 1.548 1.548 0 01.003 3.096zm-1.337 9.763H6.34v-8.59H3.667v8.59zM17.668 1H2.328C1.595 1 1 1.581 1 2.298v15.403C1 18.418 1.595 19 2.328 19h15.34c.734 0 1.332-.582 1.332-1.299V2.298C19 1.581 18.402 1 17.668 1z" clip-rule="evenodd"></path>
                                    </svg>
                                </a>
                                <a href="#" class="w-10 h-10 bg-neutral-100 rounded-lg flex items-center justify-center hover:bg-brand-primary-100 transition-colors" aria-label="Twitter">
                                    <svg class="w-5 h-5 text-neutral-600" fill="currentColor" viewBox="0 0 20 20">
                                        <path d="M6.29 18.251c7.547 0 11.675-6.253 11.675-11.675 0-.178 0-.355-.012-.53A8.348 8.348 0 0020 3.92a8.19 8.19 0 01-2.357.646 4.118 4.118 0 001.804-2.27 8.224 8.224 0 01-2.605.996 4.107 4.107 0 00-6.993 3.743 11.65 11.65 0 01-8.457-4.287 4.106 4.106 0 001.27 5.477A4.073 4.073 0 01.8 7.713v.052a4.105 4.105 0 003.292 4.022 4.095 4.095 0 01-1.853.07 4.108 4.108 0 003.834 2.85A8.233 8.233 0 010 16.407a11.616 11.616 0 006.29 1.84"></path>
                                    </svg>
                                </a>
                                <a href="#" class="w-10 h-10 bg-neutral-100 rounded-lg flex items-center justify-center hover:bg-brand-primary-100 transition-colors" aria-label="Facebook">
                                    <svg class="w-5 h-5 text-neutral-600" fill="currentColor" viewBox="0 0 20 20">
                                        <path fill-rule="evenodd" d="M20 10C20 4.477 15.523 0 10 0S0 4.477 0 10c0 4.991 3.657 9.128 8.438 9.878v-6.987h-2.54V10h2.54V7.797c0-2.506 1.492-3.89 3.777-3.89 1.094 0 2.238.195 2.238.195v2.46h-1.26c-1.243 0-1.63.771-1.63 1.562V10h2.773l-.443 2.89h-2.33v6.988C16.343 19.128 20 14.991 20 10z" clip-rule="evenodd"></path>
                                    </svg>
                                </a>
                                <a href="#" class="w-10 h-10 bg-neutral-100 rounded-lg flex items-center justify-center hover:bg-brand-primary-100 transition-colors" aria-label="YouTube">
                                    <svg class="w-5 h-5 text-neutral-600" fill="currentColor" viewBox="0 0 20 20">
                                        <path fill-rule="evenodd" d="M2 3a1 1 0 011-1h2.153a1 1 0 01.986.836l.74 4.435a1 1 0 01-.54 1.06l-1.548.773a11.037 11.037 0 006.105 6.105l.774-1.548a1 1 0 011.059-.54l4.435.74a1 1 0 01.836.986V17a1 1 0 01-1 1h-2C7.82 18 2 12.18 2 5V3z" clip-rule="evenodd"></path>
                                    </svg>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        
        <!-- FAQ Section -->
        <section class="py-16 bg-neutral-100">
            <div class="container">
                <div class="max-w-4xl mx-auto">
                    <div class="text-center mb-12">
                        <h2 class="text-3xl font-bold text-neutral-900 mb-4">Frequently Asked Questions</h2>
                        <p class="text-lg text-neutral-600">
                            Find quick answers to common questions about our IoT products and services
                        </p>
                    </div>
                    
                    <div class="space-y-4">
                        <!-- FAQ Items -->
                        <div class="card p-6">
                            <button class="faq-question w-full text-left flex items-center justify-between" aria-expanded="false">
                                <span class="text-lg font-medium text-neutral-900">What kind of technical support do you provide?</span>
                                <svg class="w-5 h-5 text-neutral-500 transform transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                                </svg>
                            </button>
                            <div class="faq-answer mt-4 text-neutral-600">
                                <p>We provide comprehensive technical support including installation guidance, troubleshooting, firmware updates, and integration assistance. Our support team is available via phone, email, and live chat during business hours.</p>
                            </div>
                        </div>
                        
                        <div class="card p-6">
                            <button class="faq-question w-full text-left flex items-center justify-between" aria-expanded="false">
                                <span class="text-lg font-medium text-neutral-900">Do you offer bulk pricing for enterprise customers?</span>
                                <svg class="w-5 h-5 text-neutral-500 transform transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                                </svg>
                            </button>
                            <div class="faq-answer mt-4 text-neutral-600">
                                <p>Yes, we offer competitive bulk pricing and volume discounts for enterprise customers. Contact our sales team for custom quotes based on your specific requirements and order volume.</p>
                            </div>
                        </div>
                        
                        <div class="card p-6">
                            <button class="faq-question w-full text-left flex items-center justify-between" aria-expanded="false">
                                <span class="text-lg font-medium text-neutral-900">What is your return and warranty policy?</span>
                                <svg class="w-5 h-5 text-neutral-500 transform transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                                </svg>
                            </button>
                            <div class="faq-answer mt-4 text-neutral-600">
                                <p>We offer a 30-day return policy for all products in original condition. Most products come with manufacturer warranties ranging from 1-3 years. Extended warranty options are available for purchase.</p>
                            </div>
                        </div>
                        
                        <div class="card p-6">
                            <button class="faq-question w-full text-left flex items-center justify-between" aria-expanded="false">
                                <span class="text-lg font-medium text-neutral-900">How quickly can you process and ship orders?</span>
                                <svg class="w-5 h-5 text-neutral-500 transform transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                                </svg>
                            </button>
                            <div class="faq-answer mt-4 text-neutral-600">
                                <p>Standard orders are processed within 1-2 business days. Shipping times vary by location: 2-3 days for metro areas, 3-5 days for regional areas. Express shipping options are available for urgent orders.</p>
                            </div>
                        </div>
                        
                        <div class="card p-6">
                            <button class="faq-question w-full text-left flex items-center justify-between" aria-expanded="false">
                                <span class="text-lg font-medium text-neutral-900">Do you provide custom IoT solutions development?</span>
                                <svg class="w-5 h-5 text-neutral-500 transform transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                                </svg>
                            </button>
                            <div class="faq-answer mt-4 text-neutral-600">
                                <p>Yes, our engineering team can develop custom IoT solutions tailored to your specific requirements. We offer consulting, prototyping, and full development services for unique applications.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>
    
    <!-- Footer -->
    <jsp:include page="components/footer.jsp" />
    
    <!-- JavaScript -->
    <script src="<%= contextPath %>/js/main.js"></script>
    
    <script>
        // FAQ functionality
        document.addEventListener('DOMContentLoaded', function() {
            const faqItems = document.querySelectorAll('.faq-question');
            
            faqItems.forEach(question => {
                question.addEventListener('click', () => {
                    const isExpanded = question.getAttribute('aria-expanded') === 'true';
                    const answer = question.nextElementSibling;
                    const icon = question.querySelector('svg');
                    
                    // Close all other FAQ items
                    faqItems.forEach(otherQuestion => {
                        if (otherQuestion !== question) {
                            otherQuestion.setAttribute('aria-expanded', 'false');
                            otherQuestion.nextElementSibling.style.maxHeight = '0';
                            otherQuestion.querySelector('svg').style.transform = 'rotate(0deg)';
                        }
                    });
                    
                    // Toggle current item
                    if (isExpanded) {
                        question.setAttribute('aria-expanded', 'false');
                        answer.style.maxHeight = '0';
                        icon.style.transform = 'rotate(0deg)';
                    } else {
                        question.setAttribute('aria-expanded', 'true');
                        answer.style.maxHeight = answer.scrollHeight + 'px';
                        icon.style.transform = 'rotate(180deg)';
                    }
                });
            });
        });
        
        // Live chat function
        function openLiveChat() {
            if (window.showToast) {
                window.showToast('Live chat will be available soon!', 'info');
            } else {
                alert('Live chat will be available soon!');
            }
        }
    </script>
</body>
</html>