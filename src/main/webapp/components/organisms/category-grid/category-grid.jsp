<%--
  ============================================
  Organism: Category Grid
  ============================================
  
  Description:
    A grid section displaying product categories using category-card molecules.
    
  Usage:
    <jsp:include page="/components/organisms/category-grid/category-grid.jsp" />
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section class="py-16 bg-white">
    <div class="l-container">
        <div class="flex flex-col md:flex-row justify-between items-end mb-8 gap-4">
            <div>
                <h2 class="text-display-sm font-bold text-neutral-900 mb-2">Shop by Category</h2>
                <p class="text-lg text-neutral-600">Find exactly what you need for your IoT projects</p>
            </div>
            <a href="${pageContext.request.contextPath}/categories" class="text-brand-primary font-medium hover:underline inline-flex items-center group">
                View All Categories
                <svg class="w-4 h-4 ml-1 transform group-hover:translate-x-1 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 8l4 4m0 0l-4 4m4-4H3"/>
                </svg>
            </a>
        </div>
        
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
            <!-- Industrial Category Card -->
            <jsp:include page="/components/molecules/category-card/category-card.jsp">
                <jsp:param name="href" value="${pageContext.request.contextPath}/category/industrial" />
                <jsp:param name="title" value="Industrial" />
                <jsp:param name="iconColorClass" value="bg-brand-primary-100" />
                <jsp:param name="iconTextClass" value="text-brand-primary" />
                <jsp:param name="iconSvgPath" value="M19.428 15.428a2 2 0 00-1.022-.547l-2.387-.477a6 6 0 00-3.86.517l-.318.158a6 6 0 01-3.86.517L6.05 15.21a2 2 0 00-1.806.547M8 4h8l-1 1v5.172a2 2 0 00.586 1.414l5 5c1.26 1.26.367 3.414-1.415 3.414H4.828c-1.782 0-2.674-2.154-1.414-3.414l5-5A2 2 0 009 8.172V5L8 4z" />
                <jsp:param name="subItems" value="Sensors,Controllers,Connectivity" />
            </jsp:include>

            <!-- Warehouse Category Card -->
            <jsp:include page="/components/molecules/category-card/category-card.jsp">
                <jsp:param name="href" value="${pageContext.request.contextPath}/category/warehouse" />
                <jsp:param name="title" value="Warehouse" />
                <jsp:param name="iconColorClass" value="bg-brand-secondary-100" />
                <jsp:param name="iconTextClass" value="text-brand-secondary" />
                <jsp:param name="iconSvgPath" value="M5 8h14M5 8a2 2 0 110-4h1.586a1 1 0 01.707.293l1.414 1.414a1 1 0 00.707.293H15a2 2 0 012 2v0M5 8v10a2 2 0 002 2h10a2 2 0 002-2V8m-9 4h4" />
                <jsp:param name="subItems" value="RFID Systems,Automation,Monitoring" />
            </jsp:include>

            <!-- Agriculture Category Card -->
            <jsp:include page="/components/molecules/category-card/category-card.jsp">
                <jsp:param name="href" value="${pageContext.request.contextPath}/category/agriculture" />
                <jsp:param name="title" value="Agriculture" />
                <jsp:param name="iconColorClass" value="bg-success-100" />
                <jsp:param name="iconTextClass" value="text-success" />
                <jsp:param name="iconSvgPath" value="M5 3v4M3 5h4M6 17v4m-2-2h4m5-16l2.286 6.857L21 12l-5.714 2.143L13 21l-2.286-6.857L5 12l5.714-2.143L13 3z" />
                <jsp:param name="subItems" value="Environmental Sensors,Irrigation,Livestock Monitoring" />
            </jsp:include>

            <!-- Smart Home Category Card -->
            <jsp:include page="/components/molecules/category-card/category-card.jsp">
                <jsp:param name="href" value="${pageContext.request.contextPath}/category/smarthome" />
                <jsp:param name="title" value="Smart Home" />
                <jsp:param name="iconColorClass" value="bg-accent-100" />
                <jsp:param name="iconTextClass" value="text-accent" />
                <jsp:param name="iconSvgPath" value="M3 7v10a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2H5a2 2 0 00-2-2H3v10z" />
                <jsp:param name="subItems" value="Security Systems,Energy Management,Home Automation" />
            </jsp:include>
        </div>
    </div>
</section>
