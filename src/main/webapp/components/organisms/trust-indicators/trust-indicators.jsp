<%--
  ============================================
  Organism: Trust Indicators
  ============================================
  
  Description:
    A section displaying key value propositions or trust signals (e.g., Warranty, Support).
    
  Usage:
    <jsp:include page="/components/organisms/trust-indicators/trust-indicators.jsp" />
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section class="py-16 bg-neutral-50 border-t border-neutral-200">
    <div class="l-container">
        <div class="text-center max-w-2xl mx-auto mb-12">
            <h2 class="text-display-sm font-bold text-neutral-900 mb-4">Why Choose IoTBay?</h2>
            <p class="text-lg text-neutral-600">We provide more than just hardware. We provide the reliability and support your projects depend on.</p>
        </div>
        
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
            <jsp:include page="/components/molecules/feature-card/feature-card.jsp">
                <jsp:param name="title" value="Certified Products" />
                <jsp:param name="description" value="CE/FCC Approved for industrial use" />
                <jsp:param name="iconSvgPath" value="M6.267 3.455a3.066 3.066 0 001.745-.723 3.066 3.066 0 013.976 0 3.066 3.066 0 001.745.723 3.066 3.066 0 012.812 2.812c.051.643.304 1.254.723 1.745a3.066 3.066 0 010 3.976 3.066 3.066 0 00-.723 1.745 3.066 3.066 0 01-2.812 2.812 3.066 3.066 0 00-1.745.723 3.066 3.066 0 01-3.976 0 3.066 3.066 0 00-1.745-.723 3.066 3.066 0 01-2.812-2.812 3.066 3.066 0 00-.723-1.745 3.066 3.066 0 010-3.976 3.066 3.066 0 00.723-1.745 3.066 3.066 0 012.812-2.812zm7.44 5.252a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" />
                <jsp:param name="iconColorClass" value="bg-brand-primary-100" />
                <jsp:param name="iconTextClass" value="text-brand-primary" />
            </jsp:include>
            
            <jsp:include page="/components/molecules/feature-card/feature-card.jsp">
                <jsp:param name="title" value="24/7 Expert Support" />
                <jsp:param name="description" value="Direct access to IoT engineers" />
                <jsp:param name="iconSvgPath" value="M2 5a2 2 0 012-2h7a2 2 0 012 2v4a2 2 0 01-2 2H9l-3 3v-3H4a2 2 0 01-2-2V5z M15 7v2a4 4 0 01-4 4H9.828l-1.766 1.767c.28.149.599.233.938.233h2l3 3v-3h2a2 2 0 002-2V9a2 2 0 00-2-2h-1z" />
                <jsp:param name="iconColorClass" value="bg-brand-secondary-100" />
                <jsp:param name="iconTextClass" value="text-brand-secondary" />
            </jsp:include>
            
            <jsp:include page="/components/molecules/feature-card/feature-card.jsp">
                <jsp:param name="title" value="2-Year Warranty" />
                <jsp:param name="description" value="Comprehensive coverage on all items" />
                <jsp:param name="iconSvgPath" value="M2.166 4.999A11.954 11.954 0 0010 1.944 11.954 11.954 0 0017.834 5c.11.65.166 1.32.166 2.001 0 5.225-3.34 9.67-8 11.317C5.34 16.67 2 12.225 2 7c0-.682.057-1.35.166-2.001zm11.541 3.708a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" />
                <jsp:param name="iconColorClass" value="bg-success-100" />
                <jsp:param name="iconTextClass" value="text-success" />
            </jsp:include>
            
            <jsp:include page="/components/molecules/feature-card/feature-card.jsp">
                <jsp:param name="title" value="Fast & Free Shipping" />
                <jsp:param name="description" value="Free delivery on orders over $50" />
                <jsp:param name="iconSvgPath" value="M8 16.5a1.5 1.5 0 11-3 0 1.5 1.5 0 013 0zM15 16.5a1.5 1.5 0 11-3 0 1.5 1.5 0 013 0z M3 4a1 1 0 00-1 1v10a1 1 0 001 1h1.05a2.5 2.5 0 014.9 0H10a1 1 0 001-1V5a1 1 0 00-1-1H3zM14 7a1 1 0 00-1 1v6.05A2.5 2.5 0 0115.95 16H17a1 1 0 001-1v-5a1 1 0 00-.293-.707l-2-2A1 1 0 0015 7h-1z" />
                <jsp:param name="iconColorClass" value="bg-accent-100" />
                <jsp:param name="iconTextClass" value="text-accent" />
            </jsp:include>
        </div>
    </div>
</section>
