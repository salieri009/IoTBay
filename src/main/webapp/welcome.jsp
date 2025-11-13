<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>

<%
    User user = (User) session.getAttribute("user");
    String from = (String) session.getAttribute("from");
    session.removeAttribute("from");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="css/modern-theme.css" />
    <title>IoT Bay - Welcome</title>
</head>
<body>
    <jsp:include page="components/header.jsp" />

    <main class="welcome-page">
        <div class="container">
            <div class="welcome-hero">
                <div class="welcome-content">
                    <div class="welcome-animation">
                        <div class="success-checkmark">
                            <div class="check-icon">
                                <span class="icon-line line-tip"></span>
                                <span class="icon-line line-long"></span>
                                <div class="icon-circle"></div>
                                <div class="icon-fix"></div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="welcome-message">
                        <%
                            if (user != null) {
                                if ("register".equals(from)) {
                        %>
                                <h1 class="welcome-title">Welcome to IoT Bay, <%= user.getFirstName() %>!</h1>
                                <p class="welcome-subtitle">Your registration was successful</p>
                                <p class="welcome-description">
                                    Thank you for joining IoT Bay — your gateway to smarter living. 
                                    Explore our cutting-edge IoT solutions and start your connected journey today.
                                </p>
                        <%
                                } else {
                        %>
                                <h1 class="welcome-title">Welcome back, <%= user.getFirstName() %>!</h1>
                                <p class="welcome-subtitle">You have successfully logged in</p>
                                <p class="welcome-description">
                                    We're glad to see you again. Continue exploring our latest IoT products 
                                    and smart solutions designed for the connected world.
                                </p>
                        <%
                                }
                            } else {
                        %>
                                <h1 class="welcome-title">Welcome to IoT Bay!</h1>
                                <p class="welcome-subtitle">We're glad you're here</p>
                                <p class="welcome-description">
                                    Discover the future of connected technology with our comprehensive 
                                    range of IoT solutions for every need.
                                </p>
                        <%
                            }
                        %>
                    </div>
                    
                    <div class="welcome-actions">
                        <a href="index.jsp" class="btn btn--primary btn--lg">
                            <svg class="btn__icon" fill="currentColor" viewBox="0 0 20 20">
                                <path d="M10.707 2.293a1 1 0 00-1.414 0l-7 7a1 1 0 001.414 1.414L4 10.414V17a1 1 0 001 1h2a1 1 0 001-1v-2a1 1 0 011-1h2a1 1 0 011 1v2a1 1 0 001 1h2a1 1 0 001-1v-6.586l.293.293a1 1 0 001.414-1.414l-7-7z"></path>
                            </svg>
                            Go to Home
                        </a>
                        <a href="browse" class="btn btn--outline btn--lg">
                            <svg class="btn__icon" fill="currentColor" viewBox="0 0 20 20">
                                <path fill-rule="evenodd" d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z" clip-rule="evenodd"></path>
                            </svg>
                            Browse Products
                        </a>
                    </div>
                </div>
                
                <div class="welcome-features">
                    <h3 class="features-title">What's Next?</h3>
                    <div class="features-grid">
                        <div class="feature-card">
                            <div class="feature-card__icon">
                                <svg fill="currentColor" viewBox="0 0 20 20">
                                    <path d="M3 4a1 1 0 011-1h12a1 1 0 011 1v2a1 1 0 01-1 1H4a1 1 0 01-1-1V4zM3 10a1 1 0 011-1h6a1 1 0 011 1v6a1 1 0 01-1 1H4a1 1 0 01-1-1v-6zM14 9a1 1 0 00-1 1v6a1 1 0 001 1h2a1 1 0 001-1v-6a1 1 0 00-1-1h-2z"></path>
                                </svg>
                            </div>
                            <h4 class="feature-card__title">Browse Products</h4>
                            <p class="feature-card__description">Explore our extensive catalog of IoT devices and solutions</p>
                        </div>
                        
                        <div class="feature-card">
                            <div class="feature-card__icon">
                                <svg fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z" clip-rule="evenodd"></path>
                                </svg>
                            </div>
                            <h4 class="feature-card__title">Manage Profile</h4>
                            <p class="feature-card__description">Update your personal information and preferences</p>
                        </div>
                        
                        <div class="feature-card">
                            <div class="feature-card__icon">
                                <svg fill="currentColor" viewBox="0 0 20 20">
                                    <path d="M3 1a1 1 0 000 2h1.22l.305 1.222a.997.997 0 00.01.042l1.358 5.43-.893.892C3.74 11.846 4.632 14 6.414 14H15a1 1 0 000-2H6.414l1-1H14a1 1 0 00.894-.553l3-6A1 1 0 0017 3H6.28l-.31-1.243A1 1 0 005 1H3zM16 16.5a1.5 1.5 0 11-3 0 1.5 1.5 0 013 0zM6.5 18a1.5 1.5 0 100-3 1.5 1.5 0 000 3z"></path>
                                </svg>
                            </div>
                            <h4 class="feature-card__title">Start Shopping</h4>
                            <p class="feature-card__description">Add products to your cart and complete your purchase</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <jsp:include page="components/footer.jsp" />
    <script src="js/main.js"></script>
    <script>
        // Add welcome animation
        document.addEventListener('DOMContentLoaded', function() {
            setTimeout(() => {
                document.querySelector('.welcome-content').classList.add('animate-in');
            }, 300);
        });
    </script>
</body>
</html>
