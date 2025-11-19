<%--
  ============================================
  Organism: Product Gallery
  ============================================
  
  Description:
    A product image gallery with a main image and a thumbnail grid.
    Refactored to use Tailwind CSS.
    
  Parameters:
    - mainImageUrl: URL of the main product image
    - productName: Name of the product (for alt text)
    
  Usage:
    <jsp:include page="/components/organisms/product-gallery/product-gallery.jsp">
        <jsp:param name="mainImageUrl" value="${product.imageUrl}" />
        <jsp:param name="productName" value="${product.name}" />
    </jsp:include>
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="space-y-4">
    <figure class="bg-white rounded-2xl border border-neutral-200 overflow-hidden aspect-[4/3] relative group">
        <img src="${param.mainImageUrl}" 
             alt="${param.productName}" 
             class="w-full h-full object-cover object-center group-hover:scale-105 transition-transform duration-500"
             id="mainProductImage"
             onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/images/default-product.png';" />
        <div class="absolute inset-0 pointer-events-none ring-1 ring-inset ring-black/5 rounded-2xl"></div>
    </figure>
    <div class="grid grid-cols-4 gap-4">
        <div class="col-span-1 cursor-pointer">
            <div class="aspect-square overflow-hidden rounded-lg border-2 border-brand-primary bg-white relative">
                <img src="${param.mainImageUrl}" 
                     alt="${param.productName} gallery image" 
                     class="w-full h-full object-cover object-center"
                     onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/images/default-product.png';">
            </div>
        </div>
        <!-- Hardcoded samples for now as per original design -->
        <div class="col-span-1 cursor-pointer opacity-70 hover:opacity-100 transition-opacity">
            <div class="aspect-square overflow-hidden rounded-lg border border-neutral-200 bg-neutral-100 relative">
                <img src="${pageContext.request.contextPath}/images/sample2.png" 
                     alt="${param.productName} alternate view" 
                     class="w-full h-full object-cover object-center"
                     onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/images/default-product.png';">
            </div>
        </div>
        <div class="col-span-1 cursor-pointer opacity-70 hover:opacity-100 transition-opacity">
            <div class="aspect-square overflow-hidden rounded-lg border border-neutral-200 bg-neutral-100 relative">
                <img src="${pageContext.request.contextPath}/images/sample3.png" 
                     alt="${param.productName} component detail" 
                     class="w-full h-full object-cover object-center"
                     onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/images/default-product.png';">
            </div>
        </div>
        <div class="col-span-1 cursor-pointer opacity-70 hover:opacity-100 transition-opacity">
            <div class="aspect-square rounded-lg border border-neutral-200 bg-neutral-50 flex items-center justify-center text-xs text-neutral-500 font-medium">
                +2 more
            </div>
        </div>
    </div>
</div>
