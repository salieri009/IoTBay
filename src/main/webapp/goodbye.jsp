<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<t:base title="Thank you for visiting IoTBay!" description="Goodbye page after logout or account deletion">
    <main class="goodbye-page flex items-center justify-center py-20 min-h-screen">
        <div class="container">
            <div class="max-w-2xl mx-auto text-center">
                <!-- Goodbye Icon -->
                <div class="w-20 h-20 bg-brand-primary/10 rounded-full flex items-center justify-center mx-auto mb-6">
                    <svg class="w-10 h-10 text-brand-primary" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 10l7-7m0 0l7 7m-7-7v18"></path>
                    </svg>
                </div>
                
                <!-- Goodbye Title -->
                <h1 class="text-display-lg text-neutral-900 mb-4">
                    Thank you for visiting IoTBay!
                </h1>
                
                <!-- Goodbye Message -->
                <p class="text-lg text-neutral-600 mb-8 max-w-lg mx-auto">
                    You have successfully logged out. We hope you enjoyed your experience 
                    exploring our IoT solutions and products.
                </p>
                
                <!-- Feature Reminders -->
                <div class="bg-neutral-50 rounded-lg p-6 mb-8">
                    <h3 class="font-semibold text-neutral-900 mb-2">Come back soon!</h3>
                    <p class="text-neutral-600">
                        We're constantly adding new products and features to enhance your IoT experience.
                    </p>
                </div>
                
                <!-- Action Buttons -->
                <div class="flex flex-col sm:flex-row gap-4 justify-center">
                    <a href="${pageContext.request.contextPath}/" class="btn btn--primary btn--lg">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"></path>
                        </svg>
                        Return to Homepage
                    </a>
                    <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn--outline btn--lg">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 16l-4-4m0 0l4-4m-4 4h14m-5 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h7a3 3 0 013 3v1"></path>
                        </svg>
                        Log In Again
                    </a>
                </div>
            </div>
        </div>
    </main>
    
    <script>
        // Add farewell animation
        document.addEventListener('DOMContentLoaded', function() {
            setTimeout(() => {
                const content = document.querySelector('.goodbye-page .max-w-2xl');
                if (content) {
                    content.classList.add('animate-in');
                }
            }, 300);
        });
    </script>
</t:base>
