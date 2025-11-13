<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<footer class="footer bg-neutral-900 text-neutral-300 mt-auto">
    <div class="container">
        <!-- Main Footer Content -->
        <div class="footer__content py-8">
            <!-- Top Section: Brand + Essential Links -->
            <div class="footer-grid">
                <!-- Brand Section -->
                <div class="footer__brand">
                    <div class="footer__logo mb-4">
                        <img src="${pageContext.request.contextPath}/images/logo.png" alt="IoT Bay" class="h-8">
                    </div>
                    <p class="text-sm text-neutral-400 leading-relaxed">
                        Your premier destination for cutting-edge IoT devices and smart technology solutions.
                    </p>
                </div>
                
                <!-- Quick Links -->
                <div class="footer__section">
                    <h3 class="footer__title text-white font-semibold mb-4 text-base">Quick Links</h3>
                    <nav aria-label="Quick navigation links">
                        <ul class="footer__links space-y-3" role="list">
                            <li role="listitem"><a href="${pageContext.request.contextPath}/" class="footer__link text-sm hover:text-white transition-colors focus:outline-none focus:ring-2 focus:ring-brand-primary focus:ring-offset-2 focus:ring-offset-neutral-900 rounded">Home</a></li>
                            <li role="listitem"><a href="${pageContext.request.contextPath}/browse" class="footer__link text-sm hover:text-white transition-colors focus:outline-none focus:ring-2 focus:ring-brand-primary focus:ring-offset-2 focus:ring-offset-neutral-900 rounded">Browse Products</a></li>
                            <li role="listitem"><a href="${pageContext.request.contextPath}/categories" class="footer__link text-sm hover:text-white transition-colors focus:outline-none focus:ring-2 focus:ring-brand-primary focus:ring-offset-2 focus:ring-offset-neutral-900 rounded">Categories</a></li>
                            <li role="listitem"><a href="${pageContext.request.contextPath}/about" class="footer__link text-sm hover:text-white transition-colors focus:outline-none focus:ring-2 focus:ring-brand-primary focus:ring-offset-2 focus:ring-offset-neutral-900 rounded">About Us</a></li>
                        </ul>
                    </nav>
                </div>
                
                <!-- Support Links -->
                <div class="footer__section">
                    <h3 class="footer__title text-white font-semibold mb-4 text-base">Support</h3>
                    <nav aria-label="Support and help links">
                        <ul class="footer__links space-y-3" role="list">
                            <li role="listitem"><a href="${pageContext.request.contextPath}/contact" class="footer__link text-sm hover:text-white transition-colors focus:outline-none focus:ring-2 focus:ring-brand-primary focus:ring-offset-2 focus:ring-offset-neutral-900 rounded">Contact Us</a></li>
                            <li role="listitem"><a href="${pageContext.request.contextPath}/support" class="footer__link text-sm hover:text-white transition-colors focus:outline-none focus:ring-2 focus:ring-brand-primary focus:ring-offset-2 focus:ring-offset-neutral-900 rounded">Help Center</a></li>
                            <li role="listitem"><a href="${pageContext.request.contextPath}/shipping" class="footer__link text-sm hover:text-white transition-colors focus:outline-none focus:ring-2 focus:ring-brand-primary focus:ring-offset-2 focus:ring-offset-neutral-900 rounded">Shipping</a></li>
                            <li role="listitem"><a href="${pageContext.request.contextPath}/returns" class="footer__link text-sm hover:text-white transition-colors focus:outline-none focus:ring-2 focus:ring-brand-primary focus:ring-offset-2 focus:ring-offset-neutral-900 rounded">Returns</a></li>
                        </ul>
                    </nav>
                </div>
                
                <!-- Contact Info -->
                <div class="footer__section">
                    <h3 class="footer__title text-white font-semibold mb-4 text-base">Contact Info</h3>
                    <address class="space-y-3 not-italic">
                        <div class="flex items-center gap-2 text-sm">
                            <svg class="w-4 h-4 text-brand-primary flex-shrink-0" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                <path d="M2.003 5.884L10 9.882l7.997-3.998A2 2 0 0016 4H4a2 2 0 00-1.997 1.884z"/>
                                <path d="M18 8.118l-8 4-8-4V14a2 2 0 002 2h12a2 2 0 002-2V8.118z"/>
                            </svg>
                            <a href="mailto:support@iotbay.com" class="hover:text-white transition-colors focus:outline-none focus:ring-2 focus:ring-brand-primary focus:ring-offset-2 focus:ring-offset-neutral-900 rounded">support@iotbay.com</a>
                        </div>
                        <div class="flex items-center gap-2 text-sm">
                            <svg class="w-4 h-4 text-brand-primary flex-shrink-0" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                <path d="M2 3a1 1 0 011-1h2.153a1 1 0 01.986.836l.74 4.435a1 1 0 01-.54 1.06l-1.548.773a11.037 11.037 0 006.105 6.105l.774-1.548a1 1 0 011.059-.54l4.435.74a1 1 0 01.836.986V17a1 1 0 01-1 1h-2C7.82 18 2 12.18 2 5V3z"/>
                            </svg>
                            <a href="tel:18004688324" class="hover:text-white transition-colors focus:outline-none focus:ring-2 focus:ring-brand-primary focus:ring-offset-2 focus:ring-offset-neutral-900 rounded">1-800-IOT-TECH</a>
                        </div>
                    </address>
                </div>
            </div>
        </div>
        
        <!-- Footer Bottom -->
        <div class="footer__bottom border-t border-neutral-800 py-6">
            <div class="footer__bottom-content">
                <div class="footer__copyright text-sm text-neutral-400">
                    © 2025 IoT Bay. All rights reserved.
                </div>
                <nav aria-label="Legal links">
                    <ul class="footer__legal flex gap-6 text-sm" role="list">
                        <li role="listitem"><a href="${pageContext.request.contextPath}/privacy" class="footer__link hover:text-white transition-colors focus:outline-none focus:ring-2 focus:ring-brand-primary focus:ring-offset-2 focus:ring-offset-neutral-900 rounded">Privacy</a></li>
                        <li role="listitem"><a href="${pageContext.request.contextPath}/terms" class="footer__link hover:text-white transition-colors focus:outline-none focus:ring-2 focus:ring-brand-primary focus:ring-offset-2 focus:ring-offset-neutral-900 rounded">Terms</a></li>
                        <li role="listitem"><a href="${pageContext.request.contextPath}/cookies" class="footer__link hover:text-white transition-colors focus:outline-none focus:ring-2 focus:ring-brand-primary focus:ring-offset-2 focus:ring-offset-neutral-900 rounded">Cookies</a></li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
    
    <!-- Back to Top Button -->
    <button 
        id="backToTop" 
        class="fixed bottom-6 right-6 bg-brand-primary text-white p-3 rounded-full shadow-lg opacity-0 invisible transition-all duration-300 hover:bg-brand-primary-dark focus:outline-none focus:ring-2 focus:ring-brand-primary focus:ring-offset-2"
        aria-label="Back to top"
    >
        <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
            <path fill-rule="evenodd" d="M3.293 9.707a1 1 0 010-1.414l6-6a1 1 0 011.414 0l6 6a1 1 0 01-1.414 1.414L11 5.414V17a1 1 0 11-2 0V5.414L4.707 9.707a1 1 0 01-1.414 0z" clip-rule="evenodd"/>
        </svg>
    </button>
</footer>


<script>
// Back to top functionality
document.addEventListener('DOMContentLoaded', function() {
    const backToTopButton = document.getElementById('backToTop');
    
    if (!backToTopButton) return; // Safety check
    
    window.addEventListener('scroll', function() {
        if (window.pageYOffset > 300) {
            backToTopButton.classList.remove('opacity-0', 'invisible');
            backToTopButton.classList.add('opacity-100', 'visible');
        } else {
            backToTopButton.classList.add('opacity-0', 'invisible');
            backToTopButton.classList.remove('opacity-100', 'visible');
        }
    });
    
    backToTopButton.addEventListener('click', function() {
        window.scrollTo({
            top: 0,
            behavior: 'smooth'
        });
    });
});
</script>