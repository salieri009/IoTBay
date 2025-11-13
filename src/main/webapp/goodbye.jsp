<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="css/modern-theme.css" />
    <title>Goodbye - IoT Bay</title>
</head>
<body>
    <main class="goodbye-page">
        <div class="container">
            <div class="goodbye-content">
                <div class="goodbye-icon">
                    <svg fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-8.293l-3-3a1 1 0 00-1.414 0l-3 3a1 1 0 001.414 1.414L9 9.414V13a1 1 0 102 0V9.414l1.293 1.293a1 1 0 001.414-1.414z" clip-rule="evenodd"></path>
                    </svg>
                </div>
                
                <h1 class="goodbye-title">Thank you for visiting IoT Bay!</h1>
                <p class="goodbye-description">
                    You have successfully logged out. We hope you enjoyed your experience 
                    exploring our IoT solutions and products.
                </p>
                
                <div class="goodbye-features">
                    <div class="feature-highlight">
                        <h3>Come back soon!</h3>
                        <p>We're constantly adding new products and features to enhance your IoT experience.</p>
                    </div>
                </div>
                
                <div class="goodbye-actions">
                    <a href="index.jsp" class="btn btn--primary btn--lg">
                        <svg class="btn__icon" fill="currentColor" viewBox="0 0 20 20">
                            <path d="M10.707 2.293a1 1 0 00-1.414 0l-7 7a1 1 0 001.414 1.414L4 10.414V17a1 1 0 001 1h2a1 1 0 001-1v-2a1 1 0 011-1h2a1 1 0 011 1v2a1 1 0 001 1h2a1 1 0 001-1v-6.586l.293.293a1 1 0 001.414-1.414l-7-7z"></path>
                        </svg>
                        Return to Home
                    </a>
                    <a href="login.jsp" class="btn btn--outline btn--lg">
                        <svg class="btn__icon" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M3 3a1 1 0 011 1v12a1 1 0 11-2 0V4a1 1 0 011-1zm7.707 3.293a1 1 0 010 1.414L9.414 9H17a1 1 0 110 2H9.414l1.293 1.293a1 1 0 01-1.414 1.414l-3-3a1 1 0 010-1.414l3-3a1 1 0 011.414 0z" clip-rule="evenodd"></path>
                        </svg>
                        Sign In Again
                    </a>
                </div>
                
                <div class="goodbye-newsletter">
                    <h3>Stay Connected</h3>
                    <p>Subscribe to our newsletter for the latest IoT products and updates</p>
                    <form class="newsletter-form">
                        <input type="email" class="form__input" placeholder="Enter your email">
                        <button type="submit" class="btn btn--primary">Subscribe</button>
                    </form>
                </div>
            </div>
        </div>
    </main>
    
    <script src="js/main.js"></script>
    <script>
        // Newsletter form submission
        document.querySelector('.newsletter-form')?.addEventListener('submit', function(e) {
            e.preventDefault();
            const email = this.querySelector('input[type="email"]').value;
            if (email) {
                if (window.showToast) {
                    window.showToast('Thank you for subscribing!', 'success');
                }
                this.reset();
            }
        });
        
        // Add farewell animation
        document.addEventListener('DOMContentLoaded', function() {
            setTimeout(() => {
                document.querySelector('.goodbye-content').classList.add('animate-in');
            }, 300);
        });
    </script>
</body>
</html>
<body>
<div class="goodbye-container">
    <div class="emoji">👋</div>
    <h2>Goodbye!</h2>
    <p>
        Thank you for visiting.<br>
        We hope to see you again soon.
    </p>
    <a href="<%= request.getContextPath() %>/index.jsp">Go to Home</a>
</div>
</body>
</html>
