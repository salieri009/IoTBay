<%--
  ============================================
  Organism: Newsletter Section
  ============================================
  
  Description:
    A full-width section for newsletter subscription.
    Contains a heading, description, and a subscription form.
  
  Parameters:
    - title (string): Section title (default: "Stay Updated...")
    - description (string): Section description
    - placeholder (string): Input placeholder
    - buttonText (string): Button label
  
  Dependencies:
    - components/atoms/button/button.jsp
    - components/atoms/input/input.jsp
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String title = request.getParameter("title") != null ? request.getParameter("title") : "Stay Updated with Latest IoT Solutions";
    String description = request.getParameter("description") != null ? request.getParameter("description") : "Get the latest product updates, technical guides, and exclusive offers delivered to your inbox.";
    String placeholder = request.getParameter("placeholder") != null ? request.getParameter("placeholder") : "Enter your email address";
    String buttonText = request.getParameter("buttonText") != null ? request.getParameter("buttonText") : "Subscribe";
%>

<section class="py-12 bg-gradient-to-r from-brand-primary-50 to-brand-secondary-50">
    <div class="container">
        <div class="max-w-2xl mx-auto text-center">
            <h2 class="text-display-sm font-bold text-neutral-900 mb-4"><%= title %></h2>
            <p class="text-lg text-neutral-600 mb-6">
                <%= description %>
            </p>
            
            <form class="newsletter-form flex flex-col sm:flex-row gap-3 max-w-md mx-auto" 
                  id="newsletterForm"
                  onsubmit="handleNewsletterSubmit(event)">
                
                <div class="flex-1">
                    <jsp:include page="/components/atoms/input/input.jsp">
                        <jsp:param name="type" value="email" />
                        <jsp:param name="name" value="email" />
                        <jsp:param name="id" value="newsletterEmail" />
                        <jsp:param name="placeholder" value="<%= placeholder %>" />
                        <jsp:param name="required" value="true" />
                        <jsp:param name="ariaLabel" value="Email address for newsletter" />
                        <jsp:param name="attributes" value="aria-describedby='newsletter-help'" />
                    </jsp:include>
                </div>

                <jsp:include page="/components/atoms/button/button.jsp">
                    <jsp:param name="type" value="primary" />
                    <jsp:param name="htmlType" value="submit" />
                    <jsp:param name="text" value="<%= buttonText %>" />
                </jsp:include>
            </form>
            
            <p id="newsletter-help" class="text-sm text-neutral-500 mt-3">
                We respect your privacy. Unsubscribe at any time.
            </p>
        </div>
    </div>
</section>

<script>
    // Newsletter form handler (if not already defined globally)
    if (typeof handleNewsletterSubmit === 'undefined') {
        window.handleNewsletterSubmit = function(event) {
            event.preventDefault();
            // const email = document.getElementById('newsletterEmail').value; // Not strictly needed for the toast
            
            if (typeof showToast === 'function') {
                showToast('Thank you for subscribing!', 'success');
            } else {
                alert('Thank you for subscribing!');
            }
            
            // Reset form
            event.target.reset();
        }
    }
</script>
