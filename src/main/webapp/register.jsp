<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="css/modern-theme.css" />
    <title>IoT Bay - Create Account</title>
</head>
<body>
    <jsp:include page="components/header.jsp" />

    <main class="auth-page">
        <div class="container">
            <div class="auth-card auth-card--wide">
                <div class="auth-card__header">
                    <h1 class="auth-card__title">Join IoT Bay</h1>
                    <p class="auth-card__subtitle">Create your account to start shopping</p>
                </div>
                
                <div class="register__contents">
                    <div class="register__hero">
                        <img class="register__image" src="images/wewantyou.png" alt="Join IoT Bay" />
                        <div class="register__benefits">
                            <h3>Why join IoT Bay?</h3>
                            <ul class="benefits-list">
                                <li>✓ Exclusive access to latest IoT products</li>
                                <li>✓ Member-only discounts and deals</li>
                                <li>✓ Fast and secure checkout</li>
                                <li>✓ Order tracking and history</li>
                            </ul>
                        </div>
                    </div>
                    
                    <div class="register__form-container">
                        <form class="auth-form" id="registerForm" action="/api/auth/register" method="post" autocomplete="off">
                            <div class="form__section">
                                <h3 class="form__section-title">Account Information</h3>
                                <div class="form__row">
                                    <div class="form__group">
                                        <label for="email" class="form__label">Email Address *</label>
                                        <input type="email" id="email" name="email" class="form__input" 
                                               placeholder="Enter your email" required />
                                    </div>
                                </div>
                                <div class="form__row">
                                    <div class="form__group">
                                        <label for="password" class="form__label">Password *</label>
                                        <input type="password" id="password" name="password" class="form__input" 
                                               placeholder="Create a password" required />
                                    </div>
                                    <div class="form__group">
                                        <label for="confirmPassword" class="form__label">Confirm Password *</label>
                                        <input type="password" id="confirmPassword" name="confirmPassword" 
                                               class="form__input" placeholder="Confirm your password" required />
                                    </div>
                                </div>
                            </div>
                            
                            <div class="form__section">
                                <h3 class="form__section-title">Personal Information</h3>
                                <div class="form__row">
                                    <div class="form__group">
                                        <label for="firstName" class="form__label">First Name *</label>
                                        <input type="text" id="firstName" name="firstName" class="form__input" 
                                               placeholder="Your first name" required />
                                    </div>
                                    <div class="form__group">
                                        <label for="lastName" class="form__label">Last Name *</label>
                                        <input type="text" id="lastName" name="lastName" class="form__input" 
                                               placeholder="Your last name" required />
                                    </div>
                                </div>
                                <div class="form__row">
                                    <div class="form__group">
                                        <label for="phone" class="form__label">Phone Number *</label>
                                        <input type="tel" id="phone" name="phone" class="form__input" 
                                               placeholder="Your phone number" required />
                                    </div>
                                    <div class="form__group">
                                        <label for="dateOfBirth" class="form__label">Date of Birth</label>
                                        <input type="date" id="dateOfBirth" name="dateOfBirth" class="form__input" />
                                    </div>
                                </div>
                            </div>
                            
                            <div class="form__section">
                                <h3 class="form__section-title">Address Information</h3>
                                <div class="form__row">
                                    <div class="form__group">
                                        <label for="addressLine1" class="form__label">Address Line 1 *</label>
                                        <input type="text" id="addressLine1" name="addressLine1" class="form__input" 
                                               placeholder="Street address" required />
                                    </div>
                                    <div class="form__group">
                                        <label for="postalCode" class="form__label">Postal Code *</label>
                                        <input type="text" id="postalCode" name="postalCode" class="form__input" 
                                               placeholder="Postal code" required />
                                    </div>
                                </div>
                                <div class="form__row">
                                    <div class="form__group">
                                        <label for="addressLine2" class="form__label">Address Line 2</label>
                                        <input type="text" id="addressLine2" name="addressLine2" class="form__input" 
                                               placeholder="Apartment, suite, etc. (optional)" />
                                    </div>
                                </div>
                            </div>
                            
                            <div class="form__section">
                                <h3 class="form__section-title">Payment Method</h3>
                                <div class="form__group">
                                    <label for="paymentMethod" class="form__label">Preferred Payment Method</label>
                                    <select name="paymentMethod" id="paymentMethod" class="form__select">
                                        <option value="CreditCard">Credit Card</option>
                                        <option value="PayPal">PayPal</option>
                                        <option value="BankTransfer">Bank Transfer</option>
                                    </select>
                                </div>
                            </div>
                            
                            <div class="form__section">
                                <label class="checkbox">
                                    <input type="checkbox" name="tos" id="tos" required>
                                    <span class="checkbox__mark"></span>
                                    <span class="checkbox__label">
                                        I agree to the <a href="terms.jsp" class="link">Terms of Service</a> 
                                        and <a href="privacy.jsp" class="link">Privacy Policy</a>
                                    </span>
                                </label>
                            </div>
                            
                            <input type="hidden" name="from" value="register" />
                            <button type="submit" class="btn btn--primary btn--full">Create Account</button>
                        </form>
                    </div>
                </div>
                
                <div class="auth-card__footer">
                    <p>Already have an account? <a href="login.jsp" class="link link--primary">Sign in</a></p>
                </div>
            </div>
        </div>
    </main>

    <!-- Error Modal -->
    <div id="errorModal" class="modal-overlay" style="display:none;">
        <div class="modal modal--error">
            <div class="modal__header">
                <h2 class="modal__title">Registration Error</h2>
                <button class="modal__close" onclick="closeModal()">
                    <svg fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd"></path>
                    </svg>
                </button>
            </div>
            <div class="modal__body">
                <p id="modalMessage"></p>
            </div>
            <div class="modal__footer">
                <button class="btn btn--outline" onclick="closeModal()">Close</button>
            </div>
        </div>
    </div>

    <jsp:include page="components/footer.jsp" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="js/main.js"></script>
    <script>
    function showModal(message) {
        $('#modalMessage').text(message);
        $('#errorModal').fadeIn(150);
    }
    
    function closeModal() {
        $('#errorModal').fadeOut(150);
    }

    $('#registerForm').submit(function(e) {
        e.preventDefault();
        
        // Validate password confirmation
        const password = $('#password').val();
        const confirmPassword = $('#confirmPassword').val();
        
        if (password !== confirmPassword) {
            showModal('Passwords do not match. Please try again.');
            return;
        }
        
        const submitBtn = $(this).find('button[type="submit"]');
        showLoading(submitBtn[0]);
        
        $.ajax({
            url: '/api/auth/register',
            method: 'POST',
            data: $(this).serialize(),
            success: function() {
                window.location.href = 'welcome.jsp';
            },
            error: function(xhr) {
                hideLoading(submitBtn[0]);
                showModal(xhr.responseText || 'Registration failed. Please try again.');
            }
        });
    });
    </script>
</body>
</html>
