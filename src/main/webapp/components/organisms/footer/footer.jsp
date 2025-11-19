<%--
  ============================================
  Organism: Footer
  ============================================
  
  Description:
    Site footer composed of multiple sections.
    Refactored to use Atomic Design components and Tailwind CSS.
  
  Dependencies:
    - atoms/icon/icon.jsp (optional, using inline SVGs for performance)
  
  Last Updated: 2025
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    /* Critical Fix: Force Footer Grid Layout */
    .o-footer__grid {
        display: grid !important;
        grid-template-columns: 1fr !important;
        gap: 2rem !important;
        width: 100% !important;
    }
    
    @media (min-width: 768px) {
        .o-footer__grid {
            grid-template-columns: repeat(2, minmax(0, 1fr)) !important;
        }
    }
    
    @media (min-width: 1024px) {
        .o-footer__grid {
            grid-template-columns: repeat(12, minmax(0, 1fr)) !important;
            gap: 3rem !important;
        }
        
        /* Brand Column */
        .o-footer__grid > div:nth-child(1) {
            grid-column: span 4 / span 4 !important;
        }
        
        /* Shop Column */
        .o-footer__grid > div:nth-child(2) {
            grid-column: span 2 / span 2 !important;
        }
        
        /* Support Column */
        .o-footer__grid > div:nth-child(3) {
            grid-column: span 2 / span 2 !important;
        }
        
        /* Contact Column */
        .o-footer__grid > div:nth-child(4) {
            grid-column: span 4 / span 4 !important;
        }
    }
</style>

<footer class="bg-neutral-900 text-white pt-16 pb-8 border-t border-neutral-800" role="contentinfo">
  <div class="o-footer__container max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
    <%-- Main Footer Content --%>
    <div class="o-footer__grid grid grid-cols-1 md:grid-cols-2 lg:grid-cols-12 gap-8 lg:gap-12 mb-12 w-full">
        <%-- Brand Column (4/12 cols) --%>
        <div class="space-y-6 lg:col-span-4">
          <div class="flex items-center gap-3">
            <a href="${pageContext.request.contextPath}/" class="flex items-center gap-2 group" aria-label="IoT Bay - Home">
              <div class="w-10 h-10 bg-brand-primary rounded-lg flex items-center justify-center text-white font-bold text-xl shadow-lg shadow-brand-primary/20 transition-transform group-hover:scale-105">
                IoT
              </div>
              <span class="text-xl font-bold tracking-tight group-hover:text-brand-primary transition-colors">IoT Bay</span>
            </a>
          </div>
          <p class="text-neutral-400 text-sm leading-relaxed max-w-sm">
            Your premier destination for innovative IoT devices and smart technology solutions. Empowering developers and businesses since 2025.
          </p>
          
          <%-- Social Media Links --%>
          <div class="flex gap-4">
              <a href="#" class="w-10 h-10 rounded-full bg-neutral-800 flex items-center justify-center text-neutral-400 hover:bg-brand-primary hover:text-white transition-all duration-300 hover:scale-110 hover:shadow-lg hover:shadow-brand-primary/20" aria-label="GitHub">
                <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24" aria-hidden="true"><path fill-rule="evenodd" d="M12 2C6.477 2 2 6.484 2 12.017c0 4.425 2.865 8.18 6.839 9.504.5.092.682-.217.682-.483 0-.237-.008-.868-.013-1.703-2.782.605-3.369-1.343-3.369-1.343-.454-1.158-1.11-1.466-1.11-1.466-.908-.62.069-.608.069-.608 1.003.07 1.531 1.032 1.531 1.032.892 1.53 2.341 1.088 2.91.832.092-.647.35-1.088.636-1.338-2.22-.253-4.555-1.113-4.555-4.951 0-1.093.39-1.988 1.029-2.688-.103-.253-.446-1.272.098-2.65 0 0 .84-.27 2.75 1.026A9.564 9.564 0 0112 6.844c.85.004 1.705.115 2.504.337 1.909-1.296 2.747-1.027 2.747-1.027.546 1.379.202 2.398.1 2.651.64.7 1.028 1.595 1.028 2.688 0 3.848-2.339 4.695-4.566 4.943.359.309.678.92.678 1.855 0 1.338-.012 2.419-.012 2.747 0 .268.18.58.688.482A10.019 10.019 0 0022 12.017C22 6.484 17.522 2 12 2z" clip-rule="evenodd"></path></svg>
              </a>
              <a href="#" class="w-10 h-10 rounded-full bg-neutral-800 flex items-center justify-center text-neutral-400 hover:bg-brand-primary hover:text-white transition-all duration-300 hover:scale-110 hover:shadow-lg hover:shadow-brand-primary/20" aria-label="Twitter">
                <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24" aria-hidden="true"><path d="M8.29 20.251c7.547 0 11.675-6.253 11.675-11.675 0-.178 0-.355-.012-.53A8.348 8.348 0 0022 5.92a8.19 8.19 0 01-2.357.646 4.118 4.118 0 001.804-2.27 8.224 8.224 0 01-2.605.996 4.107 4.107 0 00-6.993 3.743 11.65 11.65 0 01-8.457-4.287 4.106 4.106 0 001.27 5.477A4.072 4.072 0 012.8 9.713v.052a4.105 4.105 0 003.292 4.022 4.095 4.095 0 01-1.853.07 4.108 4.108 0 003.834 2.85A8.233 8.233 0 012 18.407a11.616 11.616 0 006.29 1.84"></path></svg>
              </a>
              <a href="#" class="w-10 h-10 rounded-full bg-neutral-800 flex items-center justify-center text-neutral-400 hover:bg-brand-primary hover:text-white transition-all duration-300 hover:scale-110 hover:shadow-lg hover:shadow-brand-primary/20" aria-label="LinkedIn">
                <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24" aria-hidden="true"><path fill-rule="evenodd" d="M19 0h-14c-2.761 0-5 2.239-5 5v14c0 2.761 2.239 5 5 5h14c2.762 0 5-2.239 5-5v-14c0-2.761-2.238-5-5-5zm-11 19h-3v-11h3v11zm-1.5-12.268c-.966 0-1.75-.79-1.75-1.764s.784-1.764 1.75-1.764 1.75.79 1.75 1.764-.783 1.764-1.75 1.764zm13.5 12.268h-3v-5.604c0-3.368-4-3.113-4 0v5.604h-3v-11h3v1.765c1.396-2.586 7-2.777 7 2.476v6.759z" clip-rule="evenodd"></path></svg>
              </a>
          </div>
        </div>
        
        <%-- Shop Navigation (2/12 cols) --%>
        <div class="lg:col-span-2">
          <h3 class="text-white font-semibold text-lg mb-4 tracking-wide">Shop</h3>
          <ul class="space-y-3">
            <li><a href="${pageContext.request.contextPath}/browse.jsp" class="text-neutral-400 hover:text-brand-primary transition-colors text-sm">All Products</a></li>
            <li><a href="${pageContext.request.contextPath}/category-industrial.jsp" class="text-neutral-400 hover:text-brand-primary transition-colors text-sm">Industrial</a></li>
            <li><a href="${pageContext.request.contextPath}/category-smarthome.jsp" class="text-neutral-400 hover:text-brand-primary transition-colors text-sm">Smart Home</a></li>
            <li><a href="${pageContext.request.contextPath}/browse.jsp?featured=true" class="text-neutral-400 hover:text-brand-primary transition-colors text-sm">Featured</a></li>
            <li><a href="${pageContext.request.contextPath}/browse.jsp?new=true" class="text-neutral-400 hover:text-brand-primary transition-colors text-sm">New Arrivals</a></li>
          </ul>
        </div>
        
        <%-- Support Navigation (2/12 cols) --%>
        <div class="lg:col-span-2">
          <h3 class="text-white font-semibold text-lg mb-4 tracking-wide">Support</h3>
          <ul class="space-y-3">
            <li><a href="${pageContext.request.contextPath}/help.jsp" class="text-neutral-400 hover:text-brand-primary transition-colors text-sm">Help Center</a></li>
            <li><a href="${pageContext.request.contextPath}/shipping.jsp" class="text-neutral-400 hover:text-brand-primary transition-colors text-sm">Shipping & Returns</a></li>
            <li><a href="${pageContext.request.contextPath}/warranty.jsp" class="text-neutral-400 hover:text-brand-primary transition-colors text-sm">Warranty Info</a></li>
            <li><a href="${pageContext.request.contextPath}/contact.jsp" class="text-neutral-400 hover:text-brand-primary transition-colors text-sm">Contact Us</a></li>
            <li><a href="${pageContext.request.contextPath}/faq.jsp" class="text-neutral-400 hover:text-brand-primary transition-colors text-sm">FAQ</a></li>
          </ul>
        </div>

        <%-- Contact Info (4/12 cols) --%>
        <div class="lg:col-span-4">
            <h3 class="text-white font-semibold text-lg mb-4 tracking-wide">Contact</h3>
            <ul class="space-y-4">
                <li class="flex items-start gap-3 group">
                    <div class="w-8 h-8 rounded-full bg-neutral-800 flex items-center justify-center shrink-0 group-hover:bg-brand-primary/20 transition-colors">
                        <svg class="w-4 h-4 text-brand-primary" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"/><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"/></svg>
                    </div>
                    <span class="text-neutral-400 text-sm leading-relaxed pt-1">123 IoT Street, Tech District<br>Sydney, NSW 2000, Australia</span>
                </li>
                <li class="flex items-center gap-3 group">
                    <div class="w-8 h-8 rounded-full bg-neutral-800 flex items-center justify-center shrink-0 group-hover:bg-brand-primary/20 transition-colors">
                        <svg class="w-4 h-4 text-brand-primary" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"/></svg>
                    </div>
                    <a href="mailto:support@iotbay.com" class="text-neutral-400 hover:text-white transition-colors text-sm">support@iotbay.com</a>
                </li>
                <li class="flex items-center gap-3 group">
                    <div class="w-8 h-8 rounded-full bg-neutral-800 flex items-center justify-center shrink-0 group-hover:bg-brand-primary/20 transition-colors">
                        <svg class="w-4 h-4 text-brand-primary" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z"/></svg>
                    </div>
                    <a href="tel:+61212345678" class="text-neutral-400 hover:text-white transition-colors text-sm">+61 2 1234 5678</a>
                </li>
            </ul>
        </div>
    </div>
    
    <%-- Bottom Bar --%>
    <div class="border-t border-neutral-800 pt-8 mt-8 flex flex-col md:flex-row justify-between items-center gap-4">
        <div class="flex flex-col md:flex-row items-center gap-2 md:gap-6">
            <p class="text-neutral-500 text-sm">
                &copy; 2025 IoT Bay. All rights reserved.
            </p>
            <span class="hidden md:inline text-neutral-700">|</span>
            <p class="text-neutral-600 text-xs">
                University of Technology Sydney (UTS) - 41025 ISD Assignment 2
            </p>
        </div>
        <div class="flex gap-6">
            <a href="${pageContext.request.contextPath}/privacy.jsp" class="text-neutral-500 hover:text-white text-sm transition-colors">Privacy Policy</a>
            <a href="${pageContext.request.contextPath}/terms.jsp" class="text-neutral-500 hover:text-white text-sm transition-colors">Terms of Service</a>
            <a href="${pageContext.request.contextPath}/sitemap.jsp" class="text-neutral-500 hover:text-white text-sm transition-colors">Sitemap</a>
        </div>
    </div>
  </div>
</footer>

