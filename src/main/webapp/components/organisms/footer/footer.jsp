<%--
  ============================================
  Organism: Footer
  ============================================
  
  Description:
    Site footer composed of multiple sections.
    Refactored to use Atomic Design components.
  
  Dependencies:
    - atoms/icon/icon.jsp
    - atoms/button/button.jsp
  
  Last Updated: 2025
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<footer class="footer" role="contentinfo">
  <div class="container">
    <%-- Main Footer Content --%>
    <div class="footer__content">
      <div class="footer__grid">
        <%-- Brand Column (First, wider on desktop) --%>
        <div class="footer__column footer__column--brand">
          <div class="footer__brand">
            <a href="${pageContext.request.contextPath}/" class="footer__brand-link" aria-label="IoT Bay - Home">
              <img src="${pageContext.request.contextPath}/images/logo.png" alt="IoT Bay Logo" class="footer__brand-logo" />
              <span class="footer__brand-text">IoT Bay</span>
            </a>
            <p class="footer__brand-description">
              Your premier destination for innovative IoT devices and smart technology solutions.
            </p>
          </div>
          
          <%-- Contact Information --%>
          <div class="footer__contact">
            <address class="footer__address">
              <div class="footer__contact-item">
                <jsp:include page="/components/atoms/icon/icon.jsp">
                  <jsp:param name="name" value="email" />
                  <jsp:param name="size" value="small" />
                </jsp:include>
                <a href="mailto:support@iotbay.com" class="footer__link">support@iotbay.com</a>
              </div>
              <div class="footer__contact-item">
                <jsp:include page="/components/atoms/icon/icon.jsp">
                  <jsp:param name="name" value="phone" />
                  <jsp:param name="size" value="small" />
                </jsp:include>
                <a href="tel:18004688324" class="footer__link">1-800-IOT-TECH</a>
              </div>
            </address>
          </div>
          
          <%-- Social Media Links --%>
          <div class="footer__social">
            <span class="footer__social-label">Follow Us</span>
            <div class="footer__social-links">
              <a href="https://github.com" target="_blank" rel="noopener noreferrer" class="footer__social-link" aria-label="GitHub">
                <jsp:include page="/components/atoms/icon/icon.jsp">
                  <jsp:param name="name" value="github" />
                  <jsp:param name="size" value="medium" />
                </jsp:include>
              </a>
              <a href="https://linkedin.com" target="_blank" rel="noopener noreferrer" class="footer__social-link" aria-label="LinkedIn">
                <jsp:include page="/components/atoms/icon/icon.jsp">
                  <jsp:param name="name" value="linkedin" />
                  <jsp:param name="size" value="medium" />
                </jsp:include>
              </a>
              <a href="https://twitter.com" target="_blank" rel="noopener noreferrer" class="footer__social-link" aria-label="Twitter">
                <jsp:include page="/components/atoms/icon/icon.jsp">
                  <jsp:param name="name" value="twitter" />
                  <jsp:param name="size" value="medium" />
                </jsp:include>
              </a>
            </div>
          </div>
        </div>
        
        <%-- Company Column --%>
        <div class="footer__column">
          <h3 class="footer__title">Company</h3>
          <nav aria-label="Company links">
            <ul class="footer__links">
              <li><a href="${pageContext.request.contextPath}/about.jsp" class="footer__link">About Us</a></li>
              <li><a href="${pageContext.request.contextPath}/contact.jsp" class="footer__link">Contact</a></li>
              <li><a href="${pageContext.request.contextPath}/careers.jsp" class="footer__link">Careers</a></li>
              <li><a href="${pageContext.request.contextPath}/blog.jsp" class="footer__link">Blog</a></li>
            </ul>
          </nav>
        </div>
        
        <%-- Products Column --%>
        <div class="footer__column">
          <h3 class="footer__title">Products</h3>
          <nav aria-label="Product links">
            <ul class="footer__links">
              <li><a href="${pageContext.request.contextPath}/browse.jsp" class="footer__link">Browse All</a></li>
              <li><a href="${pageContext.request.contextPath}/browse.jsp?featured=true" class="footer__link">Featured Products</a></li>
              <li><a href="${pageContext.request.contextPath}/categories.jsp" class="footer__link">Categories</a></li>
              <li><a href="${pageContext.request.contextPath}/browse.jsp?new=true" class="footer__link">New Arrivals</a></li>
            </ul>
          </nav>
        </div>
        
        <%-- Support Column --%>
        <div class="footer__column">
          <h3 class="footer__title">Support</h3>
          <nav aria-label="Support links">
            <ul class="footer__links">
              <li><a href="${pageContext.request.contextPath}/support.jsp" class="footer__link">Help Center</a></li>
              <li><a href="${pageContext.request.contextPath}/shipping.jsp" class="footer__link">Shipping Info</a></li>
              <li><a href="${pageContext.request.contextPath}/returns.jsp" class="footer__link">Returns & Refunds</a></li>
              <li><a href="${pageContext.request.contextPath}/faq.jsp" class="footer__link">FAQ</a></li>
            </ul>
          </nav>
        </div>
        
        <%-- Legal Column --%>
        <div class="footer__column">
          <h3 class="footer__title">Legal</h3>
          <nav aria-label="Legal links">
            <ul class="footer__links">
              <li><a href="${pageContext.request.contextPath}/privacy.jsp" class="footer__link">Privacy Policy</a></li>
              <li><a href="${pageContext.request.contextPath}/terms.jsp" class="footer__link">Terms of Service</a></li>
              <li><a href="${pageContext.request.contextPath}/cookies.jsp" class="footer__link">Cookie Policy</a></li>
            </ul>
          </nav>
        </div>
      </div>
      
      <%-- Newsletter Signup Section --%>
      <div class="footer__newsletter">
        <div class="footer__newsletter-content">
          <div class="footer__newsletter-text">
            <h3 class="footer__newsletter-title">Stay Updated</h3>
            <p class="footer__newsletter-description">Get the latest IoT solutions and exclusive offers delivered to your inbox.</p>
          </div>
          <form class="footer__newsletter-form" action="${pageContext.request.contextPath}/newsletter/subscribe" method="post">
            <div class="footer__newsletter-input-wrapper">
              <jsp:include page="/components/atoms/input/input.jsp">
                <jsp:param name="type" value="email" />
                <jsp:param name="name" value="email" />
                <jsp:param name="id" value="newsletter-email" />
                <jsp:param name="placeholder" value="Enter your email" />
                <jsp:param name="required" value="true" />
                <jsp:param name="ariaLabel" value="Email address for newsletter" />
              </jsp:include>
              <jsp:include page="/components/atoms/button/button.jsp">
                <jsp:param name="text" value="Subscribe" />
                <jsp:param name="type" value="primary" />
                <jsp:param name="size" value="medium" />
              </jsp:include>
            </div>
          </form>
        </div>
      </div>
    </div>
    
    <%-- Footer Bottom --%>
    <div class="footer__bottom">
      <div class="footer__bottom-content">
        <div class="footer__copyright">
          <p class="footer__copyright-text">© 2025 IoT Bay. All rights reserved.</p>
          <p class="footer__copyright-sub">University of Technology Sydney (UTS) - 41025 ISD Assignment 2</p>
        </div>
        <div class="footer__legal-links">
          <a href="${pageContext.request.contextPath}/privacy.jsp" class="footer__legal-link">Privacy</a>
          <span class="footer__legal-separator">•</span>
          <a href="${pageContext.request.contextPath}/terms.jsp" class="footer__legal-link">Terms</a>
          <span class="footer__legal-separator">•</span>
          <a href="${pageContext.request.contextPath}/cookies.jsp" class="footer__legal-link">Cookies</a>
        </div>
      </div>
    </div>
  </div>
  
  <%-- Back to Top Button --%>
  <button id="backToTop" 
          class="footer__back-to-top"
          aria-label="Back to top">
    <jsp:include page="/components/atoms/icon/icon.jsp">
      <jsp:param name="name" value="arrow-up" />
      <jsp:param name="size" value="medium" />
    </jsp:include>
  </button>
</footer>

<script>
// Back to top functionality
document.addEventListener('DOMContentLoaded', function() {
  const backToTopButton = document.getElementById('backToTop');
  if (!backToTopButton) return;
  
  window.addEventListener('scroll', function() {
    if (window.pageYOffset > 300) {
      backToTopButton.classList.add('footer__back-to-top--visible');
    } else {
      backToTopButton.classList.remove('footer__back-to-top--visible');
    }
  });
  
  backToTopButton.addEventListener('click', function() {
    window.scrollTo({ top: 0, behavior: 'smooth' });
  });
});
</script>

