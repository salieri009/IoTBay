<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<footer class="footer bg-neutral-900 text-neutral-300 mt-auto">
    <div class="footer-container" style="
        width: 100%;
        max-width: 1200px;
        margin: 0 auto;
        padding: 0 1rem;
    ">
        <!-- Main Footer Content -->
        <div class="footer__content py-8">
            <!-- Top Section: Brand + Essential Links -->
            <div class="footer-grid" style="
                display: grid; 
                grid-template-columns: 1fr; 
                gap: 2rem; 
                margin-bottom: 2rem;
            ">
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
                    <ul class="footer__links space-y-3">
                        <li><a href="${pageContext.request.contextPath}/" class="footer__link text-sm hover:text-white transition-colors">Home</a></li>
                        <li><a href="${pageContext.request.contextPath}/browse" class="footer__link text-sm hover:text-white transition-colors">Browse Products</a></li>
                        <li><a href="${pageContext.request.contextPath}/categories" class="footer__link text-sm hover:text-white transition-colors">Categories</a></li>
                        <li><a href="${pageContext.request.contextPath}/about" class="footer__link text-sm hover:text-white transition-colors">About Us</a></li>
                    </ul>
                </div>
                
                <!-- Support Links -->
                <div class="footer__section">
                    <h3 class="footer__title text-white font-semibold mb-4 text-base">Support</h3>
                    <ul class="footer__links space-y-3">
                        <li><a href="${pageContext.request.contextPath}/contact" class="footer__link text-sm hover:text-white transition-colors">Contact Us</a></li>
                        <li><a href="${pageContext.request.contextPath}/support" class="footer__link text-sm hover:text-white transition-colors">Help Center</a></li>
                        <li><a href="${pageContext.request.contextPath}/shipping" class="footer__link text-sm hover:text-white transition-colors">Shipping</a></li>
                        <li><a href="${pageContext.request.contextPath}/returns" class="footer__link text-sm hover:text-white transition-colors">Returns</a></li>
                    </ul>
                </div>
                
                <!-- Contact Info -->
                <div class="footer__section">
                    <h3 class="footer__title text-white font-semibold mb-4 text-base">Contact Info</h3>
                    <div class="space-y-3">
                        <div class="flex items-center gap-2 text-sm">
                            <svg class="w-4 h-4 text-brand-primary flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
                                <path d="M2.003 5.884L10 9.882l7.997-3.998A2 2 0 0016 4H4a2 2 0 00-1.997 1.884z"/>
                                <path d="M18 8.118l-8 4-8-4V14a2 2 0 002 2h12a2 2 0 002-2V8.118z"/>
                            </svg>
                            <span>support@iotbay.com</span>
                        </div>
                        <div class="flex items-center gap-2 text-sm">
                            <svg class="w-4 h-4 text-brand-primary flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
                                <path d="M2 3a1 1 0 011-1h2.153a1 1 0 01.986.836l.74 4.435a1 1 0 01-.54 1.06l-1.548.773a11.037 11.037 0 006.105 6.105l.774-1.548a1 1 0 011.059-.54l4.435.74a1 1 0 01.836.986V17a1 1 0 01-1 1h-2C7.82 18 2 12.18 2 5V3z"/>
                            </svg>
                            <span>1-800-IOT-TECH</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Footer Bottom -->
        <div class="footer__bottom border-t border-neutral-800 py-6">
            <div class="flex flex-col sm:flex-row items-center justify-between gap-4">
                <div class="footer__copyright text-sm text-neutral-400">
                    © 2024 IoT Bay. All rights reserved.
                </div>
                <div class="footer__legal flex gap-6 text-sm">
                    <a href="${pageContext.request.contextPath}/privacy" class="footer__link hover:text-white transition-colors">Privacy</a>
                    <a href="${pageContext.request.contextPath}/terms" class="footer__link hover:text-white transition-colors">Terms</a>
                    <a href="${pageContext.request.contextPath}/cookies" class="footer__link hover:text-white transition-colors">Cookies</a>
                </div>
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

<style>
/* Footer Container - Responsive */
.footer-container {
    width: 100% !important;
    max-width: 1200px !important;
    margin: 0 auto !important;
    padding: 0 1rem !important;
}

@media (min-width: 640px) {
    .footer-container {
        padding: 0 1.5rem !important;
    }
}

@media (min-width: 768px) {
    .footer-container {
        padding: 0 2rem !important;
    }
}

@media (min-width: 1024px) {
    .footer-container {
        max-width: 1024px !important;
    }
}

@media (min-width: 1280px) {
    .footer-container {
        max-width: 1280px !important;
    }
}

/* Footer Grid Responsive Styles */
.footer-grid {
    display: grid !important;
    grid-template-columns: 1fr !important;
    gap: 2rem !important;
}

/* Small screens (576px and up) */
@media (min-width: 576px) {
    .footer-grid {
        grid-template-columns: repeat(2, 1fr) !important;
    }
}

/* Large screens (1024px and up) */
@media (min-width: 1024px) {
    .footer-grid {
        grid-template-columns: repeat(4, 1fr) !important;
    }
}

/* Footer Brand and Section Styles */
.footer__brand {
    display: flex;
    flex-direction: column;
    text-align: left;
}

.footer__section {
    display: flex;
    flex-direction: column;
    text-align: left;
}

.footer__section h3 {
    color: #ffffff;
    font-size: 1.125rem;
    font-weight: 600;
    margin-bottom: 1rem;
}

.footer__links {
    list-style: none;
    padding: 0;
    margin: 0;
}

.footer__links li {
    margin-bottom: 0.75rem;
}

.footer__link {
    color: #a3a3a3;
    text-decoration: none;
    transition: color 0.2s ease;
}

.footer__link:hover {
    color: #ffffff;
}

.space-y-3 > * + * {
    margin-top: 0.75rem;
}

.flex {
    display: flex;
}

.items-center {
    align-items: center;
}

.gap-2 {
    gap: 0.5rem;
}

.text-sm {
    font-size: 0.875rem;
}

.text-brand-primary {
    color: #3b82f6;
}

.flex-shrink-0 {
    flex-shrink: 0;
}

/* Footer Bottom */
.footer__bottom {
    border-top: 1px solid #404040;
    padding: 1.5rem 0;
}

.footer__copyright {
    color: #a3a3a3;
    font-size: 0.875rem;
}

.footer__legal {
    display: flex;
    gap: 1.5rem;
    font-size: 0.875rem;
}

/* Responsive Footer Bottom */
@media (min-width: 640px) {
    .footer__bottom > div {
        flex-direction: row !important;
        justify-content: space-between !important;
    }
}
</style>

<script>
// Back to top functionality
document.addEventListener('DOMContentLoaded', function() {
    const backToTopButton = document.getElementById('backToTop');
    
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