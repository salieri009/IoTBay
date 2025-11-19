<%--
  ============================================
  Organism: Hero Banner
  ============================================
  
  Description:
    A large hero banner component typically used at the top of the homepage.
    
  Parameters:
    - badgeText: Text for the badge (optional)
    - title: Main headline
    - description: Sub-headline or description
    - primaryCtaText: Text for the primary CTA button
    - primaryCtaHref: URL for the primary CTA button
    - secondaryCtaText: Text for the secondary CTA button (optional)
    - secondaryCtaHref: URL for the secondary CTA button (optional)
    - imageUrl: URL for the hero image
    
  Usage:
    <jsp:include page="/components/organisms/hero-banner/hero-banner.jsp">
        <jsp:param name="title" value="Build Your Connected World" />
        ...
    </jsp:include>
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String badgeText = request.getParameter("badgeText");
    String title = request.getParameter("title");
    String description = request.getParameter("description");
    String primaryCtaText = request.getParameter("primaryCtaText");
    String primaryCtaHref = request.getParameter("primaryCtaHref");
    String secondaryCtaText = request.getParameter("secondaryCtaText");
    String secondaryCtaHref = request.getParameter("secondaryCtaHref");
    String imageUrl = request.getParameter("imageUrl");
%>

<div class="hero-card relative overflow-hidden rounded-2xl bg-neutral-900 text-white p-8 md:p-12 lg:p-16 min-h-[500px] flex items-center">
    <div class="hero-card__background absolute inset-0 bg-gradient-to-r from-neutral-900 to-neutral-800 z-0"></div>
    <div class="hero-card__overlay absolute inset-0 bg-black/20 z-10"></div>
    <div class="hero-card__content relative z-20 max-w-2xl">
        <!-- Badge -->
        <c:if test="${not empty param.badgeText}">
            <span class="hero-card__badge a-badge a-badge--accent fade-in-left">
                ${param.badgeText}
            </span>
        </c:if>
        
        <!-- Headline -->
        <h1 class="hero-card__headline text-display-xl fade-in-left" style="animation-delay: 0.1s;">
            ${param.title}
        </h1>
        
        <!-- Sub-headline -->
        <p class="hero-card__subheadline text-body-lg fade-in-left" style="animation-delay: 0.2s;">
            ${param.description}
        </p>
        
        <!-- CTA Group -->
        <div class="hero-card__cta-group fade-in-left" style="animation-delay: 0.3s;">
            <a href="${param.primaryCtaHref}" 
               class="btn btn--primary btn--lg hero-card__cta hero-card__cta--primary"
               aria-label="${param.primaryCtaText}">
                <svg class="w-5 h-5 inline mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z"/>
                </svg>
                ${param.primaryCtaText}
            </a>
            
            <c:if test="${not empty param.secondaryCtaText}">
                <a href="${param.secondaryCtaHref}" 
                   class="btn btn--outline btn--lg hero-card__cta hero-card__cta--secondary"
                   aria-label="${param.secondaryCtaText}">
                    <svg class="w-5 h-5 inline mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14.752 11.168l-3.197-2.132A1 1 0 0010 9.87v4.263a1 1 0 001.555.832l3.197-2.132a1 1 0 000-1.664z"/>
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                    </svg>
                    ${param.secondaryCtaText}
                </a>
            </c:if>
        </div>
    </div>
    
    <!-- Visual Wrapper: 3D Floating Image -->
    <div class="hero-card__visual absolute right-0 bottom-0 w-1/2 h-full hidden lg:block pointer-events-none z-10">
        <img src="${param.imageUrl}"
             alt="Hero Image"
             class="w-full h-full object-contain object-right-bottom transform translate-y-10 translate-x-10"
             onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/images/hero.png';">
    </div>
</div>