<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>

<t:base title="Create Account - IoT Bay" description="Create your IoT Bay account to access exclusive IoT products and services">
    <main class="min-h-screen flex items-center justify-center bg-neutral-50 py-12 px-4">
        <!-- Auth Card Container -->
        <div class="w-full max-w-5xl">
            <div class="bg-white rounded-2xl shadow-sm border border-neutral-200 overflow-hidden">
                <div class="grid grid-cols-1 lg:grid-cols-2">
                    <!-- Benefits Section (Sidebar) -->
                    <div class="bg-neutral-50 p-8 lg:p-12 border-b lg:border-b-0 lg:border-r border-neutral-200">
                        <div class="text-center lg:text-left mb-8">
                            <h1 class="text-3xl font-bold text-neutral-900 mb-2">Join IoT Bay</h1>
                            <p class="text-lg text-neutral-600">Create your account to start shopping for IoT solutions</p>
                        </div>
                        
                        <figure class="text-center mb-8">
                            <img src="${pageContext.request.contextPath}/images/wewantyou.png" alt="Join IoT Bay community" class="w-full max-w-xs mx-auto rounded-lg shadow-sm" />
                        </figure>
                        
                        <div class="space-y-6">
                            <h2 class="text-xl font-semibold text-neutral-900">Why join IoT Bay?</h2>
                            <dl class="space-y-4">
                                <div class="flex items-start gap-3">
                                    <svg class="w-5 h-5 text-success flex-shrink-0 mt-0.5" fill="currentColor" viewBox="0 0 20 20">
                                        <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path>
                                    </svg>
                                    <div>
                                        <dt class="text-sm font-medium text-neutral-900">Exclusive access</dt>
                                        <dd class="text-sm text-neutral-600 mt-1">Latest IoT products and early releases</dd>
                                    </div>
                                </div>
                                <div class="flex items-start gap-3">
                                    <svg class="w-5 h-5 text-success flex-shrink-0 mt-0.5" fill="currentColor" viewBox="0 0 20 20">
                                        <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path>
                                    </svg>
                                    <div>
                                        <dt class="text-sm font-medium text-neutral-900">Member discounts</dt>
                                        <dd class="text-sm text-neutral-600 mt-1">Special pricing and promotional deals</dd>
                                    </div>
                                </div>
                                <div class="flex items-start gap-3">
                                    <svg class="w-5 h-5 text-success flex-shrink-0 mt-0.5" fill="currentColor" viewBox="0 0 20 20">
                                        <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path>
                                    </svg>
                                    <div>
                                        <dt class="text-sm font-medium text-neutral-900">Secure checkout</dt>
                                        <dd class="text-sm text-neutral-600 mt-1">Fast and encrypted payment processing</dd>
                                    </div>
                                </div>
                            </dl>
                        </div>
                    </div>
                    
                    <!-- Registration Form -->
                    <div class="space-y-8">
                        <form class="space-y-8" id="registerForm" action="<%= contextPath %>/api/auth/register" method="post">
                            <!-- Account Information -->
                            <fieldset class="space-y-4">
                                <legend class="text-lg font-semibold text-neutral-900 border-b border-neutral-200 pb-2 w-full">Account information</legend>
                                
                                <jsp:include page="/components/molecules/form-field/form-field.jsp">
                                    <jsp:param name="label" value="Email Address *" />
                                    <jsp:param name="name" value="email" />
                                    <jsp:param name="type" value="email" />
                                    <jsp:param name="placeholder" value="Enter your email" />
                                    <jsp:param name="required" value="true" />
                                    <jsp:param name="helpText" value="We'll use this to send order confirmations" />
                                    <jsp:param name="id" value="email" />
                                </jsp:include>
                                
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                    <jsp:include page="/components/molecules/form-field/form-field.jsp">
                                        <jsp:param name="label" value="Password *" />
                                        <jsp:param name="name" value="password" />
                                        <jsp:param name="type" value="password" />
                                        <jsp:param name="placeholder" value="Create a password" />
                                        <jsp:param name="required" value="true" />
                                        <jsp:param name="helpText" value="Must be at least 8 characters" />
                                        <jsp:param name="id" value="password" />
                                    </jsp:include>
                                    
                                    <jsp:include page="/components/molecules/form-field/form-field.jsp">
                                        <jsp:param name="label" value="Confirm Password *" />
                                        <jsp:param name="name" value="confirmPassword" />
                                        <jsp:param name="type" value="password" />
                                        <jsp:param name="placeholder" value="Confirm your password" />
                                        <jsp:param name="required" value="true" />
                                        <jsp:param name="id" value="confirmPassword" />
                                    </jsp:include>
                                </div>
                            </div>
                            
                            </fieldset>
                            
                            <!-- Personal Information -->
                            <fieldset class="space-y-4">
                                <legend class="text-lg font-semibold text-neutral-900 border-b border-neutral-200 pb-2 w-full">Personal information</legend>
                                
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                    <jsp:include page="/components/molecules/form-field/form-field.jsp">
                                        <jsp:param name="label" value="First Name *" />
                                        <jsp:param name="name" value="firstName" />
                                        <jsp:param name="placeholder" value="Your first name" />
                                        <jsp:param name="required" value="true" />
                                        <jsp:param name="id" value="firstName" />
                                    </jsp:include>
                                    
                                    <jsp:include page="/components/molecules/form-field/form-field.jsp">
                                        <jsp:param name="label" value="Last Name *" />
                                        <jsp:param name="name" value="lastName" />
                                        <jsp:param name="placeholder" value="Your last name" />
                                        <jsp:param name="required" value="true" />
                                        <jsp:param name="id" value="lastName" />
                                    </jsp:include>
                                </div>
                                
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                    <jsp:include page="/components/molecules/form-field/form-field.jsp">
                                        <jsp:param name="label" value="Phone Number *" />
                                        <jsp:param name="name" value="phone" />
                                        <jsp:param name="type" value="tel" />
                                        <jsp:param name="placeholder" value="Your phone number" />
                                        <jsp:param name="required" value="true" />
                                        <jsp:param name="id" value="phone" />
                                    </jsp:include>
                                    
                                    <jsp:include page="/components/molecules/form-field/form-field.jsp">
                                        <jsp:param name="label" value="Date of Birth" />
                                        <jsp:param name="name" value="dateOfBirth" />
                                        <jsp:param name="type" value="date" />
                                        <jsp:param name="id" value="dateOfBirth" />
                                    </jsp:include>
                                </div>
                            </div>
                            
                            </fieldset>
                            
                            <!-- Address Information -->
                            <fieldset class="space-y-4">
                                <legend class="text-lg font-semibold text-neutral-900 border-b border-neutral-200 pb-2 w-full">Address information</legend>
                                
                                <jsp:include page="/components/molecules/form-field/form-field.jsp">
                                    <jsp:param name="label" value="Address Line 1 *" />
                                    <jsp:param name="name" value="addressLine1" />
                                    <jsp:param name="placeholder" value="Street address" />
                                    <jsp:param name="required" value="true" />
                                    <jsp:param name="id" value="addressLine1" />
                                </jsp:include>
                                
                                <jsp:include page="/components/molecules/form-field/form-field.jsp">
                                    <jsp:param name="label" value="Address Line 2" />
                                    <jsp:param name="name" value="addressLine2" />
                                    <jsp:param name="placeholder" value="Apartment, suite, etc. (optional)" />
                                    <jsp:param name="id" value="addressLine2" />
                                </jsp:include>
                                
                                <jsp:include page="/components/molecules/form-field/form-field.jsp">
                                    <jsp:param name="label" value="Postal Code *" />
                                    <jsp:param name="name" value="postalCode" />
                                    <jsp:param name="placeholder" value="Postal code" />
                                    <jsp:param name="required" value="true" />
                                    <jsp:param name="id" value="postalCode" />
                                </jsp:include>
                            </div>
                            
                            </fieldset>
                            
                            <!-- Payment Method -->
                            <fieldset class="space-y-4">
                                <legend class="text-lg font-semibold text-neutral-900 border-b border-neutral-200 pb-2 w-full">Payment method</legend>
                                
                                <div class="form-group">
                                    <label for="paymentMethod" class="form-label">Preferred payment method</label>
                                    <select name="paymentMethod" id="paymentMethod" class="form-select" aria-describedby="paymentMethod-help">
                                        <option value="CreditCard">Credit Card</option>
                                        <option value="PayPal">PayPal</option>
                                        <option value="BankTransfer">Bank Transfer</option>
                                    </select>
                                    <div id="paymentMethod-help" class="form-help text-xs text-neutral-500 mt-1">You can change this later in your account settings</div>
                                </div>
                            </fieldset>
                            
                            <!-- Terms and Conditions -->
                            <div class="space-y-4">
                                <label class="checkbox">
                                    <input type="checkbox" name="tos" id="tos" class="checkbox__input" required aria-describedby="tos-help">
                                    <span class="checkbox__mark"></span>
                                    <span class="checkbox__label">
                                        I agree to the <a href="terms.jsp" class="text-brand-primary hover:text-brand-primary-600">Terms of Service</a> 
                                        and <a href="privacy.jsp" class="text-brand-primary hover:text-brand-primary-600">Privacy Policy</a>
                                    </span>
                                </label>
                                <div id="tos-help" class="sr-only">Required to create an account</div>
                            </div>
                            
                            <input type="hidden" name="from" value="register" />
                            <button type="submit" class="btn btn--primary btn--lg w-full">Create account</button>
                        </form>
                        
                        <div class="text-center">
                            <p class="text-neutral-600">Already have an account? <a href="<%= contextPath %>/login.jsp" class="text-primary-600 hover:text-primary-700 font-medium">Sign in</a></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- Error Modal -->
    <div id="errorModal" class="fixed inset-0 bg-black bg-opacity-50 hidden items-center justify-center z-50">
        <div class="bg-white rounded-lg p-6 max-w-md w-full mx-4">
            <div class="flex items-center justify-between mb-4">
                <h2 class="text-lg font-semibold text-neutral-900">Registration Error</h2>
                <button class="text-neutral-400 hover:text-neutral-600" onclick="closeModal()">
                    <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd"></path>
                    </svg>
                </button>
            </div>
            <div class="mb-6">
                <p id="modalMessage" class="text-neutral-600"></p>
            </div>
            <div class="flex justify-end">
                <button class="btn btn--outline" onclick="closeModal()">Close</button>
            </div>
        </div>
    </div>

    <script src="<%= contextPath %>/js/main.js"></script>
    <script>
        function showModal(message) {
            document.getElementById('modalMessage').textContent = message;
            document.getElementById('errorModal').classList.remove('hidden');
            document.getElementById('errorModal').classList.add('flex');
        }
        
        function closeModal() {
            document.getElementById('errorModal').classList.add('hidden');
            document.getElementById('errorModal').classList.remove('flex');
        }

        // Real-time validation
        const emailInput = document.getElementById('email');
        const passwordInput = document.getElementById('password');
        const confirmPasswordInput = document.getElementById('confirmPassword');
        
        // Email validation
        emailInput.addEventListener('blur', function() {
            const email = this.value.trim();
            const emailError = document.getElementById('emailError');
            
            if (!email) {
                showFieldError('emailError', 'Email address is required');
            } else if (!isValidEmail(email)) {
                showFieldError('emailError', 'Please enter a valid email address (e.g., user@example.com)');
            } else {
                hideFieldError('emailError');
            }
        });
        
        // Password validation
        passwordInput.addEventListener('input', function() {
            const password = this.value;
            const strength = checkPasswordStrength(password);
            updatePasswordStrength(strength);
            
            if (password.length > 0 && password.length < 8) {
                showFieldError('passwordError', 'Password must be at least 8 characters long');
            } else {
                hideFieldError('passwordError');
            }
            
            // Re-check confirmation if it's already filled
            if (confirmPasswordInput.value) {
                confirmPasswordInput.dispatchEvent(new Event('blur'));
            }
        });
        
        // Password confirmation validation
        confirmPasswordInput.addEventListener('blur', function() {
            const password = passwordInput.value;
            const confirmPassword = this.value;
            
            if (!confirmPassword) {
                showFieldError('confirmPasswordError', 'Please confirm your password');
            } else if (password !== confirmPassword) {
                showFieldError('confirmPasswordError', 'Passwords do not match. Please try again.');
            } else {
                hideFieldError('confirmPasswordError');
            }
        });
        
        // Helper functions
        function isValidEmail(email) {
            return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
        }
        
        function checkPasswordStrength(password) {
            let strength = 0;
            if (password.length >= 8) strength++;
            if (password.length >= 12) strength++;
            if (/[a-z]/.test(password) && /[A-Z]/.test(password)) strength++;
            if (/\d/.test(password)) strength++;
            if (/[^a-zA-Z\d]/.test(password)) strength++;
            return Math.min(strength, 4);
        }
        
        function updatePasswordStrength(strength) {
            const strengthDiv = document.getElementById('passwordStrength');
            const strengthFill = document.getElementById('passwordStrengthFill');
            const strengthText = document.getElementById('passwordStrengthText');
            
            if (strength === 0) {
                strengthDiv.style.display = 'none';
                return;
            }
            
            strengthDiv.style.display = 'block';
            const percentage = (strength / 4) * 100;
            strengthFill.style.width = percentage + '%';
            
            const levels = ['Weak', 'Fair', 'Good', 'Strong'];
            const colors = ['#ef4444', '#f59e0b', '#3b82f6', '#10b981'];
            strengthText.textContent = levels[strength - 1] || 'Weak';
            strengthFill.style.backgroundColor = colors[strength - 1] || colors[0];
        }
        
        function showFieldError(fieldId, message) {
            const errorDiv = document.getElementById(fieldId);
            if (errorDiv) {
                errorDiv.textContent = message;
                errorDiv.style.display = 'block';
                const input = errorDiv.previousElementSibling;
                if (input && input.classList) {
                    input.classList.add('form-input--error');
                }
            }
        }
        
        function hideFieldError(fieldId) {
            const errorDiv = document.getElementById(fieldId);
            if (errorDiv) {
                errorDiv.style.display = 'none';
                const input = errorDiv.previousElementSibling;
                if (input && input.classList) {
                    input.classList.remove('form-input--error');
                }
            }
        }
        
        // Form submission
        document.getElementById('registerForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            // Validate all fields
            let hasErrors = false;
            const email = emailInput.value.trim();
            const password = passwordInput.value;
            const confirmPassword = confirmPasswordInput.value;
            
            // Validate email
            if (!email || !isValidEmail(email)) {
                showFieldError('emailError', 'Please enter a valid email address');
                hasErrors = true;
            }
            
            // Validate password
            if (password.length < 8) {
                showFieldError('passwordError', 'Password must be at least 8 characters long');
                hasErrors = true;
            }
            
            // Validate password confirmation
            if (password !== confirmPassword) {
                showFieldError('confirmPasswordError', 'Passwords do not match. Please try again.');
                hasErrors = true;
            }
            
            if (hasErrors) {
                showModal('Please fix the errors in the form before submitting.');
                return;
            }
            
            const submitBtn = this.querySelector('button[type="submit"]');
            const originalText = submitBtn.textContent;
            
            // Show loading state
            submitBtn.textContent = 'Creating Account...';
            submitBtn.disabled = true;
            if (typeof showLoading === 'function') {
                showLoading(submitBtn);
            }
            
            fetch(this.action, {
                method: 'POST',
                body: new FormData(this)
            })
            .then(response => {
                if (response.ok) {
                    return response.json().catch(() => ({})); // Handle non-JSON responses
                } else {
                    return response.json().then(data => {
                        throw new Error(data.message || data.error || 'Registration failed');
                    }).catch(() => {
                        throw new Error('Registration failed. Please check your information and try again.');
                    });
                }
            })
            .then(data => {
                // Show success message
                if (typeof showToast === 'function') {
                    showToast('Account created successfully! Redirecting...', 'success');
                }
                // Redirect after short delay
                setTimeout(() => {
                    window.location.href = '<%= contextPath %>/welcome.jsp';
                }, 1000);
            })
            .catch(error => {
                console.error('Error:', error);
                
                // Provide specific error messages
                let errorMessage = 'Registration failed. ';
                if (error.message.includes('email') || error.message.includes('Email')) {
                    errorMessage += 'This email is already registered. Would you like to <a href="<%= contextPath %>/login.jsp">log in</a> instead?';
                } else if (error.message.includes('password')) {
                    errorMessage += 'Please check your password and try again.';
                } else {
                    errorMessage += error.message || 'Please check your information and try again.';
                }
                
                showModal(errorMessage);
                submitBtn.textContent = originalText;
                submitBtn.disabled = false;
                if (typeof hideLoading === 'function') {
                    hideLoading(submitBtn);
                }
            });
        });
    </script>
</body>
</html>