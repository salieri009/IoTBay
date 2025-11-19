/**
 * Checkout Page Controller
 * 
 * Handles multi-step checkout with inline validation.
 * 
 * @author Nexus - Chief Experience Architect
 */

const CheckoutPage = {
  currentStep: 1,
  totalSteps: 3,
  
  /**
   * Initialize checkout page
   */
  init: function() {
    this.setupMultiStep();
    this.setupInlineValidation();
    this.setupPaymentValidation();
    this.setupProgressIndicator();
  },
  
  /**
   * Setup multi-step checkout
   */
  setupMultiStep: function() {
    // Step navigation
    document.addEventListener('click', (e) => {
      const nextBtn = e.target.closest('[data-checkout-next]');
      const prevBtn = e.target.closest('[data-checkout-prev]');
      
      if (nextBtn) {
        e.preventDefault();
        this.nextStep();
      }
      
      if (prevBtn) {
        e.preventDefault();
        this.prevStep();
      }
    });
    
    // Initialize first step
    this.showStep(1);
  },
  
  /**
   * Show specific step
   */
  showStep: function(step) {
    this.currentStep = step;
    
    // Hide all steps
    document.querySelectorAll('[data-checkout-step]').forEach(el => {
      el.classList.add('hidden');
      el.setAttribute('aria-hidden', 'true');
    });
    
    // Show current step
    const currentStepEl = document.querySelector(`[data-checkout-step="${step}"]`);
    if (currentStepEl) {
      currentStepEl.classList.remove('hidden');
      currentStepEl.setAttribute('aria-hidden', 'false');
    }
    
    // Update navigation buttons
    this.updateNavigation();
    this.updateProgressIndicator();
    
    // Focus first input in step
    const firstInput = currentStepEl?.querySelector('input, select, textarea');
    if (firstInput) {
      setTimeout(() => firstInput.focus(), 100);
    }
  },
  
  /**
   * Go to next step
   */
  nextStep: function() {
    if (this.validateCurrentStep()) {
      if (this.currentStep < this.totalSteps) {
        this.showStep(this.currentStep + 1);
      } else {
        this.submitCheckout();
      }
    }
  },
  
  /**
   * Go to previous step
   */
  prevStep: function() {
    if (this.currentStep > 1) {
      this.showStep(this.currentStep - 1);
    }
  },
  
  /**
   * Validate current step
   */
  validateCurrentStep: function() {
    const currentStepEl = document.querySelector(`[data-checkout-step="${this.currentStep}"]`);
    if (!currentStepEl) return false;
    
    const form = currentStepEl.querySelector('form');
    if (!form) return true;
    
    // Get validation rules for current step
    const rules = this.getStepValidationRules(this.currentStep);
    
    if (window.InlineValidation) {
      return InlineValidation.validateForm(form, rules);
    }
    
    return form.checkValidity();
  },
  
  /**
   * Get validation rules for step
   */
  getStepValidationRules: function(step) {
    const rules = {
      1: { // Shipping
        'shipping-name': ['required'],
        'shipping-email': ['required', 'email'],
        'shipping-phone': ['required', 'phone'],
        'shipping-address': ['required'],
        'shipping-city': ['required'],
        'shipping-zip': ['required']
      },
      2: { // Payment
        'payment-card-number': [
          'required',
          InlineValidation.rules.pattern(/^\d{16}$/, 'Card number must be 16 digits')
        ],
        'payment-card-expiry': [
          'required',
          InlineValidation.rules.pattern(/^\d{2}\/\d{2}$/, 'Format: MM/YY')
        ],
        'payment-card-cvv': [
          'required',
          InlineValidation.rules.pattern(/^\d{3,4}$/, 'CVV must be 3-4 digits')
        ],
        'payment-card-name': ['required']
      },
      3: { // Review
        // No validation needed for review step
      }
    };
    
    return rules[step] || {};
  },
  
  /**
   * Setup inline validation
   */
  setupInlineValidation: function() {
    if (!window.InlineValidation) return;
    
    // Shipping form validation
    const shippingForm = document.querySelector('[data-checkout-step="1"] form');
    if (shippingForm) {
      const shippingRules = this.getStepValidationRules(1);
      InlineValidation.setupForm(shippingForm, shippingRules);
    }
    
    // Payment form validation
    const paymentForm = document.querySelector('[data-checkout-step="2"] form');
    if (paymentForm) {
      const paymentRules = this.getStepValidationRules(2);
      InlineValidation.setupForm(paymentForm, paymentRules);
    }
  },
  
  /**
   * Setup payment validation
   */
  setupPaymentValidation: function() {
    // Format card number
    const cardNumberInput = document.querySelector('[name="payment-card-number"]');
    if (cardNumberInput) {
      cardNumberInput.addEventListener('input', (e) => {
        let value = e.target.value.replace(/\D/g, '');
        if (value.length > 16) value = value.slice(0, 16);
        e.target.value = value.replace(/(.{4})/g, '$1 ').trim();
      });
    }
    
    // Format expiry date
    const expiryInput = document.querySelector('[name="payment-card-expiry"]');
    if (expiryInput) {
      expiryInput.addEventListener('input', (e) => {
        let value = e.target.value.replace(/\D/g, '');
        if (value.length >= 2) {
          value = value.slice(0, 2) + '/' + value.slice(2, 4);
        }
        e.target.value = value;
      });
    }
    
    // Format CVV
    const cvvInput = document.querySelector('[name="payment-card-cvv"]');
    if (cvvInput) {
      cvvInput.addEventListener('input', (e) => {
        e.target.value = e.target.value.replace(/\D/g, '').slice(0, 4);
      });
    }
  },
  
  /**
   * Update navigation buttons
   */
  updateNavigation: function() {
    const prevBtn = document.querySelector('[data-checkout-prev]');
    const nextBtn = document.querySelector('[data-checkout-next]');
    
    if (prevBtn) {
      prevBtn.disabled = this.currentStep === 1;
      prevBtn.setAttribute('aria-disabled', this.currentStep === 1);
    }
    
    if (nextBtn) {
      if (this.currentStep === this.totalSteps) {
        nextBtn.textContent = 'Place Order';
        nextBtn.setAttribute('data-checkout-submit', 'true');
      } else {
        nextBtn.textContent = 'Continue';
        nextBtn.removeAttribute('data-checkout-submit');
      }
    }
  },
  
  /**
   * Setup progress indicator
   */
  setupProgressIndicator: function() {
    this.updateProgressIndicator();
  },
  
  /**
   * Update progress indicator
   */
  updateProgressIndicator: function() {
    const progressBar = document.querySelector('[data-checkout-progress]');
    if (progressBar) {
      const progress = (this.currentStep / this.totalSteps) * 100;
      progressBar.style.width = `${progress}%`;
      progressBar.setAttribute('aria-valuenow', this.currentStep);
      progressBar.setAttribute('aria-valuemax', this.totalSteps);
    }
    
    // Update step indicators
    document.querySelectorAll('[data-checkout-step-indicator]').forEach((indicator, index) => {
      const stepNum = index + 1;
      if (stepNum < this.currentStep) {
        indicator.classList.add('checkout-step--completed');
        indicator.setAttribute('aria-current', 'false');
      } else if (stepNum === this.currentStep) {
        indicator.classList.add('checkout-step--active');
        indicator.setAttribute('aria-current', 'step');
      } else {
        indicator.classList.remove('checkout-step--active', 'checkout-step--completed');
        indicator.setAttribute('aria-current', 'false');
      }
    });
  },
  
  /**
   * Submit checkout
   */
  submitCheckout: function() {
    const checkoutForm = document.querySelector('[data-checkout-form]');
    if (!checkoutForm) return;
    
    // Final validation
    if (!this.validateCurrentStep()) {
      return;
    }
    
    // Disable submit button
    const submitBtn = checkoutForm.querySelector('[type="submit"]');
    if (submitBtn) {
      submitBtn.disabled = true;
      submitBtn.textContent = 'Processing...';
    }
    
    // Submit form
    checkoutForm.submit();
  }
};

// Initialize on DOM ready
if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', () => CheckoutPage.init());
} else {
  CheckoutPage.init();
}

// Export
window.CheckoutPage = CheckoutPage;

