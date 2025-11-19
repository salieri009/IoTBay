<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<footer class="footer bg-neutral-900 text-neutral-300 mt-auto" role="contentinfo">
    <div class="container mx-auto px-4">
        <!-- Main Footer Content - 4 Column Grid -->
        <div class="footer__content py-12">
            <div class="footer-grid grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8 lg:gap-12">
                
                <!-- Column 1: Company -->
                <div class="footer__column">
                    <h3 class="footer__title text-white font-semibold mb-6 text-lg tracking-tight">Company</h3>
                    <nav aria-label="Company links">
                        <ul class="footer__links space-y-3" role="list">
                            <li role="listitem">
                                <a href="${pageContext.request.contextPath}/about" 
                                   class="footer__link text-sm text-neutral-400 hover:text-white transition-colors duration-200 focus:outline-none focus:ring-2 focus:ring-brand-primary focus:ring-offset-2 focus:ring-offset-neutral-900 rounded px-1">
                                    About
                                </a>
                            </li>
                            <li role="listitem">
                                <a href="${pageContext.request.contextPath}/contact" 
                                   class="footer__link text-sm text-neutral-400 hover:text-white transition-colors duration-200 focus:outline-none focus:ring-2 focus:ring-brand-primary focus:ring-offset-2 focus:ring-offset-neutral-900 rounded px-1">
                                    Contact
                                </a>
                            </li>
                        </ul>
                    </nav>
                </div>
                
                <!-- Column 2: Products -->
                <div class="footer__column">
                    <h3 class="footer__title text-white font-semibold mb-6 text-lg tracking-tight">Products</h3>
                    <nav aria-label="Product links">
                        <ul class="footer__links space-y-3" role="list">
                            <li role="listitem">
                                <a href="${pageContext.request.contextPath}/browse" 
                                   class="footer__link text-sm text-neutral-400 hover:text-white transition-colors duration-200 focus:outline-none focus:ring-2 focus:ring-brand-primary focus:ring-offset-2 focus:ring-offset-neutral-900 rounded px-1">
                                    Browse All
                                </a>
                            </li>
                            <li role="listitem">
                                <a href="${pageContext.request.contextPath}/browse?featured=true" 
                                   class="footer__link text-sm text-neutral-400 hover:text-white transition-colors duration-200 focus:outline-none focus:ring-2 focus:ring-brand-primary focus:ring-offset-2 focus:ring-offset-neutral-900 rounded px-1">
                                    Featured Products
                                </a>
                            </li>
                            <li role="listitem">
                                <a href="${pageContext.request.contextPath}/categories" 
                                   class="footer__link text-sm text-neutral-400 hover:text-white transition-colors duration-200 focus:outline-none focus:ring-2 focus:ring-brand-primary focus:ring-offset-2 focus:ring-offset-neutral-900 rounded px-1">
                                    Categories
                                </a>
                            </li>
                        </ul>
                    </nav>
                </div>
                
                <!-- Column 3: Support -->
                <div class="footer__column">
                    <h3 class="footer__title text-white font-semibold mb-6 text-lg tracking-tight">Support</h3>
                    <nav aria-label="Support and help links">
                        <ul class="footer__links space-y-3" role="list">
                            <li role="listitem">
                                <a href="${pageContext.request.contextPath}/support" 
                                   class="footer__link text-sm text-neutral-400 hover:text-white transition-colors duration-200 focus:outline-none focus:ring-2 focus:ring-brand-primary focus:ring-offset-2 focus:ring-offset-neutral-900 rounded px-1">
                                    Help Center
                                </a>
                            </li>
                            <li role="listitem">
                                <a href="${pageContext.request.contextPath}/shipping" 
                                   class="footer__link text-sm text-neutral-400 hover:text-white transition-colors duration-200 focus:outline-none focus:ring-2 focus:ring-brand-primary focus:ring-offset-2 focus:ring-offset-neutral-900 rounded px-1">
                                    Shipping Info
                                </a>
                            </li>
                            <li role="listitem">
                                <a href="${pageContext.request.contextPath}/returns" 
                                   class="footer__link text-sm text-neutral-400 hover:text-white transition-colors duration-200 focus:outline-none focus:ring-2 focus:ring-brand-primary focus:ring-offset-2 focus:ring-offset-neutral-900 rounded px-1">
                                    Returns & Refunds
                                </a>
                            </li>
                            <li role="listitem">
                                <a href="${pageContext.request.contextPath}/contact" 
                                   class="footer__link text-sm text-neutral-400 hover:text-white transition-colors duration-200 focus:outline-none focus:ring-2 focus:ring-brand-primary focus:ring-offset-2 focus:ring-offset-neutral-900 rounded px-1">
                                    Contact Support
                                </a>
                            </li>
                        </ul>
                    </nav>
                </div>
                
                <!-- Column 4: Legal & Contact -->
                <div class="footer__column">
                    <h3 class="footer__title text-white font-semibold mb-6 text-lg tracking-tight">Legal</h3>
                    <nav aria-label="Legal links" class="mb-6">
                        <ul class="footer__links space-y-3" role="list">
                            <li role="listitem">
                                <a href="${pageContext.request.contextPath}/privacy" 
                                   class="footer__link text-sm text-neutral-400 hover:text-white transition-colors duration-200 focus:outline-none focus:ring-2 focus:ring-brand-primary focus:ring-offset-2 focus:ring-offset-neutral-900 rounded px-1">
                                    Privacy
                                </a>
                            </li>
                            <li role="listitem">
                                <a href="${pageContext.request.contextPath}/terms" 
                                   class="footer__link text-sm text-neutral-400 hover:text-white transition-colors duration-200 focus:outline-none focus:ring-2 focus:ring-brand-primary focus:ring-offset-2 focus:ring-offset-neutral-900 rounded px-1">
                                    Terms
                                </a>
                            </li>
                            <li role="listitem">
                                <a href="${pageContext.request.contextPath}/cookies" 
                                   class="footer__link text-sm text-neutral-400 hover:text-white transition-colors duration-200 focus:outline-none focus:ring-2 focus:ring-brand-primary focus:ring-offset-2 focus:ring-offset-neutral-900 rounded px-1">
                                    Cookies
                                </a>
                            </li>
                        </ul>
                    </nav>
                    
                    <!-- Contact Information -->
                    <div class="footer__contact mt-6 pt-6 border-t border-neutral-800">
                        <address class="space-y-3 not-italic">
                            <div class="flex items-start gap-3 text-sm">
                                <svg class="w-4 h-4 text-brand-primary flex-shrink-0 mt-0.5" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                    <path d="M2.003 5.884L10 9.882l7.997-3.998A2 2 0 0016 4H4a2 2 0 00-1.997 1.884z"/>
                                    <path d="M18 8.118l-8 4-8-4V14a2 2 0 002 2h12a2 2 0 002-2V8.118z"/>
                                </svg>
                                <a href="mailto:support@iotbay.com" 
                                   class="footer__link text-neutral-400 hover:text-white transition-colors duration-200 focus:outline-none focus:ring-2 focus:ring-brand-primary focus:ring-offset-2 focus:ring-offset-neutral-900 rounded">
                                    support@iotbay.com
                                </a>
                            </div>
                            <div class="flex items-start gap-3 text-sm">
                                <svg class="w-4 h-4 text-brand-primary flex-shrink-0 mt-0.5" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                    <path d="M2 3a1 1 0 011-1h2.153a1 1 0 01.986.836l.74 4.435a1 1 0 01-.54 1.06l-1.548.773a11.037 11.037 0 006.105 6.105l.774-1.548a1 1 0 011.059-.54l4.435.74a1 1 0 01.836.986V17a1 1 0 01-1 1h-2C7.82 18 2 12.18 2 5V3z"/>
                                </svg>
                                <a href="tel:18004688324" 
                                   class="footer__link text-neutral-400 hover:text-white transition-colors duration-200 focus:outline-none focus:ring-2 focus:ring-brand-primary focus:ring-offset-2 focus:ring-offset-neutral-900 rounded">
                                    1-800-IOT-TECH
                                </a>
                            </div>
                        </address>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Footer Bottom -->
        <div class="footer__bottom border-t border-neutral-800 py-8">
            <div class="footer__bottom-content flex flex-col md:flex-row justify-between items-center gap-6">
                <div class="footer__copyright text-sm text-neutral-400 text-center md:text-left">
                    <p>© 2025 IoT Bay. All rights reserved.</p>
                    <p class="mt-1 text-xs text-neutral-500">University of Technology Sydney (UTS) - 41025 ISD Assignment 2</p>
                </div>
                
                <!-- Social Media Links -->
                <div class="footer__social flex gap-4 items-center">
                    <a href="https://github.com" target="_blank" rel="noopener noreferrer" 
                       class="text-neutral-400 hover:text-brand-primary transition-colors duration-200 focus:outline-none focus:ring-2 focus:ring-brand-primary focus:ring-offset-2 focus:ring-offset-neutral-900 rounded p-2"
                       aria-label="GitHub">
                        <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                            <path fill-rule="evenodd" d="M12 2C6.477 2 2 6.484 2 12.017c0 4.425 2.865 8.18 6.839 9.504.5.092.682-.217.682-.483 0-.237-.008-.868-.013-1.703-2.782.605-3.369-1.343-3.369-1.343-.454-1.158-1.11-1.466-1.11-1.466-.908-.62.069-.608.069-.608 1.003.07 1.531 1.032 1.531 1.032.892 1.532 2.341 1.088 2.91.832.092-.647.35-1.088.636-1.338-2.22-.253-4.555-1.113-4.555-4.951 0-1.093.39-1.988 1.029-2.688-.103-.253-.446-1.272.098-2.65 0 0 .84-.27 2.75 1.026A9.564 9.564 0 0112 6.844c.85.004 1.705.115 2.504.337 1.909-1.296 2.747-1.027 2.747-1.027.546 1.379.202 2.398.1 2.651.64.7 1.028 1.595 1.028 2.688 0 3.848-2.339 4.695-4.566 4.943.359.309.678.92.678 1.855 0 1.338-.012 2.419-.012 2.747 0 .268.18.58.688.482A10.019 10.019 0 0022 12.017C22 6.484 17.522 2 12 2z" clip-rule="evenodd"/>
                        </svg>
                    </a>
                    <a href="https://linkedin.com" target="_blank" rel="noopener noreferrer" 
                       class="text-neutral-400 hover:text-brand-primary transition-colors duration-200 focus:outline-none focus:ring-2 focus:ring-brand-primary focus:ring-offset-2 focus:ring-offset-neutral-900 rounded p-2"
                       aria-label="LinkedIn">
                        <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                            <path d="M20.447 20.452h-3.554v-5.569c0-1.328-.027-3.037-1.852-3.037-1.853 0-2.136 1.445-2.136 2.939v5.667H9.351V9h3.414v1.561h.046c.477-.9 1.637-1.85 3.37-1.85 3.601 0 4.267 2.37 4.267 5.455v6.286zM5.337 7.433c-1.144 0-2.063-.926-2.063-2.065 0-1.138.92-2.063 2.063-2.063 1.14 0 2.064.925 2.064 2.063 0 1.139-.925 2.065-2.064 2.065zm1.782 13.019H3.555V9h3.564v11.452zM22.225 0H1.771C.792 0 0 .774 0 1.729v20.542C0 23.227.792 24 1.771 24h20.451C23.2 24 24 23.227 24 22.271V1.729C24 .774 23.2 0 22.222 0h.003z"/>
                        </svg>
                    </a>
                    <a href="https://twitter.com" target="_blank" rel="noopener noreferrer" 
                       class="text-neutral-400 hover:text-brand-primary transition-colors duration-200 focus:outline-none focus:ring-2 focus:ring-brand-primary focus:ring-offset-2 focus:ring-offset-neutral-900 rounded p-2"
                       aria-label="Twitter">
                        <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                            <path d="M8.29 20.251c7.547 0 11.675-6.253 11.675-11.675 0-.178 0-.355-.012-.53A8.348 8.348 0 0022 5.92a8.19 8.19 0 01-2.357.646 4.118 4.118 0 001.804-2.27 8.224 8.224 0 01-2.605.996 4.107 4.107 0 00-6.993 3.743 11.65 11.65 0 01-8.457-4.287 4.106 4.106 0 001.27 5.477A4.072 4.072 0 012.8 9.713v.052a4.105 4.105 0 003.292 4.022 4.095 4.095 0 01-1.853.07 4.108 4.108 0 003.834 2.85A8.233 8.233 0 012 18.407a11.616 11.616 0 006.29 1.84"/>
                        </svg>
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Back to Top Button -->
    <button 
        id="backToTop" 
        class="fixed bottom-6 right-6 bg-brand-primary text-white p-3 rounded-full shadow-lg opacity-0 invisible transition-all duration-300 hover:bg-brand-primary-dark focus:outline-none focus:ring-2 focus:ring-brand-primary focus:ring-offset-2 z-50"
        aria-label="Back to top"
    >
        <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
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