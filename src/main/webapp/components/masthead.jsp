<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    // Parameters (via <jsp:param> from including page)
    String title = request.getParameter("title");
    String subtitle = request.getParameter("subtitle");
    String image = request.getParameter("image");
    String size = request.getParameter("size"); // xs | sm | md | lg
    String align = request.getParameter("align"); // left | center

    // Safe parameter handling with proper null checks
    if (title == null) title = "";
    if (subtitle == null) subtitle = "";
    if (align == null) align = "left";
    if (size == null) size = "lg";
    if (image == null) image = pageContext.getRequest().getServletContext().getContextPath() + "/images/hero.png";
    
    // Additional safety checks
    title = title.trim();
    subtitle = subtitle.trim();
    
    // Safe null checks for display
    boolean hasTitle = title != null && !title.isEmpty();
    boolean hasSubtitle = subtitle != null && !subtitle.isEmpty();

    // Height class mapping (use padding only to avoid custom min-h classes)
    String heightClass;
    switch (size) {
        case "xs": heightClass = "py-8"; break;
        case "sm": heightClass = "py-10"; break;
        case "md": heightClass = "py-12"; break;
        default: heightClass = "py-16"; // lg
    }
%>

<section class="masthead bg-neutral-50 relative overflow-hidden <%= heightClass %>">
    <!-- Background image -->
    <div class="absolute inset-0">
        <img src="<%= image %>" alt="" class="w-full h-full object-cover opacity-20" />
        <!-- Strong overlay for better text readability -->
        <div class="absolute inset-0 bg-gradient-to-br from-neutral-900/70 via-neutral-800/60 to-neutral-900/80"></div>
        <!-- Additional white overlay for text contrast -->
        <div class="absolute inset-0 bg-white/30"></div>
        <!-- Text shadow overlay -->
        <div class="absolute inset-0 bg-gradient-to-r from-white/80 via-white/40 to-white/60"></div>
    </div>

    <div class="container relative z-10">
        <div class="grid grid-cols-1 lg:grid-cols-12 items-center gap-10">
            <div class="<%= "left".equals(align) ? "lg:col-span-7" : "lg:col-span-12 text-center" %>">
                <% if (hasTitle) { %>
                <h1 class="text-4xl md:text-6xl font-bold tracking-tight text-white mb-6 drop-shadow-2xl">
                    <span class="bg-gradient-to-r from-white via-blue-50 to-white bg-clip-text text-transparent drop-shadow-2xl relative">
                        <span class="absolute inset-0 bg-black/20 rounded-lg -m-3 blur-md"></span>
                        <span class="relative z-10 text-shadow-lg"><%= title %></span>
                    </span>
                </h1>
                <% } %>
                <% if (hasSubtitle) { %>
                <p class="text-lg md:text-xl text-white max-w-2xl <%= "left".equals(align) ? "" : "mx-auto" %> mb-8 drop-shadow-2xl font-semibold relative">
                    <span class="absolute inset-0 bg-black/30 rounded-lg -m-2 blur-sm"></span>
                    <span class="relative z-10 text-shadow-lg"><%= subtitle %></span>
                </p>
                <% } %>
                <div class="flex flex-wrap gap-3 <%= "left".equals(align) ? "" : "justify-center" %>">
                    <!-- Optional CTAs can be provided by the page directly below the header include -->
                </div>
            </div>
        </div>
    </div>
</section>
