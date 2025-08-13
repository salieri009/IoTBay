<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<footer class="footer bg-neutral-900 text-neutral-300 mt-auto">
    <div class="container">
        <!-- Main Footer Content -->
        <div class="footer__content grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8 py-12">
            
            <!-- Company Info -->
            <div class="footer__section">
                <div class="footer__logo mb-4">
                    <img src="${pageContext.request.contextPath}/images/logo-white.png" alt="IoT Bay" class="h-8">
                </div>
                <p class="text-sm text-neutral-400 mb-4">
                    Your premier destination for cutting-edge IoT devices and smart technology solutions.
                    Building the connected future, one device at a time.
                </p>
                <div class="footer__social flex gap-3">
                    <a href="#" class="social-link" aria-label="Facebook">
                        <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24">
                            <path d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.47h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.47h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z"/>
                        </svg>
                    </a>
                    <a href="#" class="social-link" aria-label="Twitter">
                        <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24">
                            <path d="M23.953 4.57a10 10 0 01-2.825.775 4.958 4.958 0 002.163-2.723c-.951.555-2.005.959-3.127 1.184a4.92 4.92 0 00-8.384 4.482C7.69 8.095 4.067 6.13 1.64 3.162a4.822 4.822 0 00-.666 2.475c0 1.71.87 3.213 2.188 4.096a4.904 4.904 0 01-2.228-.616v.06a4.923 4.923 0 003.946 4.827 4.996 4.996 0 01-2.212.085 4.936 4.936 0 004.604 3.417 9.867 9.867 0 01-6.102 2.105c-.39 0-.779-.023-1.17-.067a13.995 13.995 0 007.557 2.209c9.053 0 13.998-7.496 13.998-13.985 0-.21 0-.42-.015-.63A9.935 9.935 0 0024 4.59z"/>
                        </svg>
                    </a>
                    <a href="#" class="social-link" aria-label="LinkedIn">
                        <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24">
                            <path d="M20.447 20.452h-3.554v-5.569c0-1.328-.027-3.037-1.852-3.037-1.853 0-2.136 1.445-2.136 2.939v5.667H9.351V9h3.414v1.561h.046c.477-.9 1.637-1.85 3.37-1.85 3.601 0 4.267 2.37 4.267 5.455v6.286zM5.337 7.433c-1.144 0-2.063-.926-2.063-2.065 0-1.138.92-2.063 2.063-2.063 1.14 0 2.064.925 2.064 2.063 0 1.139-.925 2.065-2.064 2.065zm1.782 13.019H3.555V9h3.564v11.452zM22.225 0H1.771C.792 0 0 .774 0 1.729v20.542C0 23.227.792 24 1.771 24h20.451C23.2 24 24 23.227 24 22.271V1.729C24 .774 23.2 0 22.222 0h.003z"/>
                        </svg>
                    </a>
                </div>
            </div>
            
            <!-- Quick Links -->
            <div class="footer__section">
                <h3 class="footer__title text-white font-semibold mb-4">Quick Links</h3>
                <ul class="footer__links space-y-2">
                    <li><a href="${pageContext.request.contextPath}/" class="footer__link">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/browse" class="footer__link">Browse Products</a></li>
                    <li><a href="${pageContext.request.contextPath}/categories" class="footer__link">Categories</a></li>
                    <li><a href="${pageContext.request.contextPath}/deals" class="footer__link">Special Deals</a></li>
                    <li><a href="${pageContext.request.contextPath}/about" class="footer__link">About Us</a></li>
                </ul>
            </div>
            
            <!-- Customer Service -->
            <div class="footer__section">
                <h3 class="footer__title text-white font-semibold mb-4">Customer Service</h3>
                <ul class="footer__links space-y-2">
                    <li><a href="${pageContext.request.contextPath}/contact" class="footer__link">Contact Us</a></li>
                    <li><a href="${pageContext.request.contextPath}/support" class="footer__link">Support Center</a></li>
                    <li><a href="${pageContext.request.contextPath}/shipping" class="footer__link">Shipping Info</a></li>
                    <li><a href="${pageContext.request.contextPath}/returns" class="footer__link">Returns</a></li>
                    <li><a href="${pageContext.request.contextPath}/faq" class="footer__link">FAQ</a></li>
                </ul>
            </div>
            
            <!-- Newsletter -->
            <div class="footer__section">
                <h3 class="footer__title text-white font-semibold mb-4">Stay Connected</h3>
                <p class="text-sm text-neutral-400 mb-4">
                    Subscribe to our newsletter for the latest IoT trends and exclusive offers.
                </p>
                <form class="footer__newsletter" action="${pageContext.request.contextPath}/newsletter" method="post">
                    <div class="flex">
                        <input 
                            type="email" 
                            name="email" 
                            placeholder="Enter your email" 
                            class="form__input flex-1 rounded-r-none"
                            required
                        >
                        <button 
                            type="submit" 
                            class="btn btn--primary rounded-l-none px-4"
                        >
                            Subscribe
                        </button>
                    </div>
                </form>
                
                <!-- Contact Info -->
                <div class="footer__contact mt-6 space-y-2">
                    <div class="flex items-center gap-2 text-sm">
                        <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                            <path d="M2.003 5.884L10 9.882l7.997-3.998A2 2 0 0016 4H4a2 2 0 00-1.997 1.884z"/>
                            <path d="M18 8.118l-8 4-8-4V14a2 2 0 002 2h12a2 2 0 002-2V8.118z"/>
                        </svg>
                        <span>support@iotbay.com</span>
                    </div>
                    <div class="flex items-center gap-2 text-sm">
                        <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                            <path d="M2 3a1 1 0 011-1h2.153a1 1 0 01.986.836l.74 4.435a1 1 0 01-.54 1.06l-1.548.773a11.037 11.037 0 006.105 6.105l.774-1.548a1 1 0 011.059-.54l4.435.74a1 1 0 01.836.986V17a1 1 0 01-1 1h-2C7.82 18 2 12.18 2 5V3z"/>
                        </svg>
                        <span>1-800-IOT-TECH</span>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Footer Bottom -->
        <div class="footer__bottom border-t border-neutral-800 py-6">
            <div class="flex flex-col md:flex-row justify-between items-center gap-4">
                <div class="footer__copyright text-sm text-neutral-400">
                    © <%= java.time.Year.now().getValue() %> IoT Bay. All rights reserved.
                </div>
                <div class="footer__legal flex gap-6 text-sm">
                    <a href="${pageContext.request.contextPath}/privacy" class="footer__link">Privacy Policy</a>
                    <a href="${pageContext.request.contextPath}/terms" class="footer__link">Terms of Service</a>
                    <a href="${pageContext.request.contextPath}/cookies" class="footer__link">Cookie Policy</a>
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
                    <a href="#" class="footer__social-link" aria-label="Twitter">
                        <svg fill="currentColor" viewBox="0 0 24 24">
                            <path d="M23.953 4.57a10 10 0 01-2.825.775 4.958 4.958 0 002.163-2.723c-.951.555-2.005.959-3.127 1.184a4.92 4.92 0 00-8.384 4.482C7.69 8.095 4.067 6.13 1.64 3.162a4.822 4.822 0 00-.666 2.475c0 1.71.87 3.213 2.188 4.096a4.904 4.904 0 01-2.228-.616v.06a4.923 4.923 0 003.946 4.827 4.996 4.996 0 01-2.212.085 4.936 4.936 0 004.604 3.417 9.867 9.867 0 01-6.102 2.105c-.39 0-.779-.023-1.17-.067a13.995 13.995 0 007.557 2.209c9.053 0 13.998-7.496 13.998-13.985 0-.21 0-.42-.015-.63A9.935 9.935 0 0024 4.59z"/>
                        </svg>
                    </a>
                    <a href="#" class="footer__social-link" aria-label="LinkedIn">
                        <svg fill="currentColor" viewBox="0 0 24 24">
                            <path d="M20.447 20.452h-3.554v-5.569c0-1.328-.027-3.037-1.852-3.037-1.853 0-2.136 1.445-2.136 2.939v5.667H9.351V9h3.414v1.561h.046c.477-.9 1.637-1.85 3.37-1.85 3.601 0 4.267 2.37 4.267 5.455v6.286zM5.337 7.433c-1.144 0-2.063-.926-2.063-2.065 0-1.138.92-2.063 2.063-2.063 1.14 0 2.064.925 2.064 2.063 0 1.139-.925 2.065-2.064 2.065zm1.782 13.019H3.555V9h3.564v11.452zM22.225 0H1.771C.792 0 0 .774 0 1.729v20.542C0 23.227.792 24 1.771 24h20.451C23.2 24 24 23.227 24 22.271V1.729C24 .774 23.2 0 22.222 0h.003z"/>
                        </svg>
                    </a>
                    <a href="#" class="footer__social-link" aria-label="Instagram">
                        <svg fill="currentColor" viewBox="0 0 24 24">
                            <path d="M12.017 0C5.396 0 .029 5.367.029 11.987c0 6.618 5.367 11.986 11.988 11.986s11.987-5.368 11.987-11.986C24.014 5.367 18.635.001 12.017.001zM8.449 16.988c-1.297 0-2.448-.49-3.323-1.295C4.198 14.814 3.674 13.52 3.674 12c0-1.52.524-2.813 1.452-3.693.875-.805 2.026-1.295 3.323-1.295 1.297 0 2.448.49 3.323 1.295.928.88 1.452 2.173 1.452 3.693 0 1.52-.524 2.814-1.452 3.693-.875.805-2.026 1.295-3.323 1.295zm7.068 0c-1.297 0-2.448-.49-3.323-1.295-.928-.879-1.452-2.173-1.452-3.693 0-1.52.524-2.813 1.452-3.693.875-.805 2.026-1.295 3.323-1.295 1.297 0 2.448.49 3.323 1.295.928.88 1.452 2.173 1.452 3.693 0 1.52-.524 2.814-1.452 3.693-.875.805-2.026 1.295-3.323 1.295z"/>
                        </svg>
                    </a>
                </div>
            </div>
            
            <div class="footer__section">
                <h3 class="footer__title">Shop</h3>
                <ul class="footer__links">
                    <li><a href="browse?category=industrial" class="footer__link">Industrial IoT</a></li>
                    <li><a href="browse?category=warehouse" class="footer__link">Warehouse Solutions</a></li>
                    <li><a href="browse?category=agriculture" class="footer__link">Smart Agriculture</a></li>
                    <li><a href="browse?category=smart-home" class="footer__link">Smart Home</a></li>
                    <li><a href="browse.jsp" class="footer__link">All Products</a></li>
                </ul>
            </div>
            
            <div class="footer__section">
                <h3 class="footer__title">Support</h3>
                <ul class="footer__links">
                    <li><a href="support.jsp" class="footer__link">Help Center</a></li>
                    <li><a href="contact.jsp" class="footer__link">Contact Us</a></li>
                    <li><a href="shipping.jsp" class="footer__link">Shipping Info</a></li>
                    <li><a href="returns.jsp" class="footer__link">Returns</a></li>
                    <li><a href="warranty.jsp" class="footer__link">Warranty</a></li>
                </ul>
            </div>
            
            <div class="footer__section">
                <h3 class="footer__title">Company</h3>
                <ul class="footer__links">
                    <li><a href="about.jsp" class="footer__link">About Us</a></li>
                    <li><a href="careers.jsp" class="footer__link">Careers</a></li>
                    <li><a href="news.jsp" class="footer__link">News</a></li>
                    <li><a href="investors.jsp" class="footer__link">Investors</a></li>
                    <li><a href="sustainability.jsp" class="footer__link">Sustainability</a></li>
                </ul>
            </div>
            
            <div class="footer__section">
                <h3 class="footer__title">Connect</h3>
                <div class="footer__contact">
                    <div class="footer__contact-item">
                        <svg class="footer__contact-icon" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M5.05 4.05a7 7 0 119.9 9.9L10 18.9l-4.95-4.95a7 7 0 010-9.9zM10 11a2 2 0 100-4 2 2 0 000 4z" clip-rule="evenodd"></path>
                        </svg>
                        <span>9999 George St, Sydney NSW 2000</span>
                    </div>
                    <div class="footer__contact-item">
                        <svg class="footer__contact-icon" fill="currentColor" viewBox="0 0 20 20">
                            <path d="M2 3a1 1 0 011-1h2.153a1 1 0 01.986.836l.74 4.435a1 1 0 01-.54 1.06l-1.548.773a11.037 11.037 0 006.105 6.105l.774-1.548a1 1 0 011.059-.54l4.435.74a1 1 0 01.836.986V17a1 1 0 01-1 1h-2C7.82 18 2 12.18 2 5V3z"></path>
                        </svg>
                        <span>02-1234-9876</span>
                    </div>
                    <div class="footer__contact-item">
                        <svg class="footer__contact-icon" fill="currentColor" viewBox="0 0 20 20">
                            <path d="M2.003 5.884L10 9.882l7.997-3.998A2 2 0 0016 4H4a2 2 0 00-1.997 1.884z"></path>
                            <path d="M18 8.118l-8 4-8-4V14a2 2 0 002 2h12a2 2 0 002-2V8.118z"></path>
                        </svg>
                        <span>seriously@good.com</span>
                    </div>
                </div>
                
                <div class="footer__newsletter">
                    <h4 class="footer__newsletter-title">Stay Updated</h4>
                    <form class="footer__newsletter-form">
                        <input type="email" placeholder="Enter your email" class="footer__newsletter-input" />
                        <button type="submit" class="footer__newsletter-btn">Subscribe</button>
                    </form>
                </div>
            </div>
        </div>
        
        <div class="footer__bottom">
            <div class="footer__bottom-content">
                <p class="footer__copyright">
                    © 2024 IoT Bay. All rights reserved.
                </p>
                <div class="footer__legal">
                    <a href="privacy.jsp" class="footer__legal-link">Privacy Policy</a>
                    <a href="terms.jsp" class="footer__legal-link">Terms of Service</a>
                    <a href="cookies.jsp" class="footer__legal-link">Cookie Policy</a>
                </div>
            </div>
        </div>
    </div>
</footer>