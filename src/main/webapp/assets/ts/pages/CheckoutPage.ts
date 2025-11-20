/**
 * Checkout Page Controller
 * 
 * Handles multi-step checkout with inline validation.
 * 
 * @author Nexus - Chief Experience Architect
 */

interface ValidationRules {
    [key: string]: any[];
}

interface StepValidationRules {
    [key: number]: ValidationRules;
}

export class CheckoutPage {
    private static currentStep: number = 1;
    private static readonly totalSteps: number = 3;
    
    /**
     * Initialize checkout page
     */
    public static init(): void {
        CheckoutPage.setupMultiStep();
        CheckoutPage.setupInlineValidation();
        CheckoutPage.setupPaymentValidation();
        CheckoutPage.setupProgressIndicator();
    }
    
    /**
     * Setup multi-step checkout
     */
    private static setupMultiStep(): void {
        // Step navigation
        document.addEventListener('click', (e: Event) => {
            const target = e.target as HTMLElement;
            const nextBtn = target.closest<HTMLElement>('[data-checkout-next]');
            const prevBtn = target.closest<HTMLElement>('[data-checkout-prev]');
            
            if (nextBtn) {
                e.preventDefault();
                CheckoutPage.nextStep();
            }
            
            if (prevBtn) {
                e.preventDefault();
                CheckoutPage.prevStep();
            }
        });
        
        // Initialize first step
        CheckoutPage.showStep(1);
    }
    
    /**
     * Show specific step
     */
    private static showStep(step: number): void {
        CheckoutPage.currentStep = step;
        
        // Hide all steps
        document.querySelectorAll<HTMLElement>('[data-checkout-step]').forEach((el: HTMLElement) => {
            el.classList.add('hidden');
            el.setAttribute('aria-hidden', 'true');
        });
        
        // Show current step
        const currentStepEl = document.querySelector<HTMLElement>(`[data-checkout-step="${step}"]`);
        if (currentStepEl) {
            currentStepEl.classList.remove('hidden');
            currentStepEl.setAttribute('aria-hidden', 'false');
        }
        
        // Update navigation buttons
        CheckoutPage.updateNavigation();
        CheckoutPage.updateProgressIndicator();
        
        // Focus first input in step
        const firstInput = currentStepEl?.querySelector<HTMLElement>('input, select, textarea');
        if (firstInput) {
            setTimeout(() => (firstInput as HTMLElement).focus(), 100);
        }
    }
    
    /**
     * Go to next step
     */
    private static nextStep(): void {
        if (CheckoutPage.validateCurrentStep()) {
            if (CheckoutPage.currentStep < CheckoutPage.totalSteps) {
                CheckoutPage.showStep(CheckoutPage.currentStep + 1);
            } else {
                CheckoutPage.submitCheckout();
            }
        }
    }
    
    /**
     * Go to previous step
     */
    private static prevStep(): void {
        if (CheckoutPage.currentStep > 1) {
            CheckoutPage.showStep(CheckoutPage.currentStep - 1);
        }
    }
    
    /**
     * Validate current step
     */
    private static validateCurrentStep(): boolean {
        const currentStepEl = document.querySelector<HTMLElement>(`[data-checkout-step="${CheckoutPage.currentStep}"]`);
        if (!currentStepEl) return false;
        
        const form = currentStepEl.querySelector<HTMLFormElement>('form');
        if (!form) return true;
        
        // Get validation rules for current step
        const rules = CheckoutPage.getStepValidationRules(CheckoutPage.currentStep);
        
        const inlineValidation = (window as any).InlineValidation;
        if (inlineValidation && inlineValidation.validateForm) {
            return inlineValidation.validateForm(form, rules);
        }
        
        return form.checkValidity();
    }
    
    /**
     * Get validation rules for step
     */
    private static getStepValidationRules(step: number): ValidationRules {
        const inlineValidation = (window as any).InlineValidation;
        const rules: StepValidationRules = {
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
                    inlineValidation?.rules?.pattern ? inlineValidation.rules.pattern(/^\d{16}$/, 'Card number must be 16 digits') : 'pattern'
                ],
                'payment-card-expiry': [
                    'required',
                    inlineValidation?.rules?.pattern ? inlineValidation.rules.pattern(/^\d{2}\/\d{2}$/, 'Format: MM/YY') : 'pattern'
                ],
                'payment-card-cvv': [
                    'required',
                    inlineValidation?.rules?.pattern ? inlineValidation.rules.pattern(/^\d{3,4}$/, 'CVV must be 3-4 digits') : 'pattern'
                ],
                'payment-card-name': ['required']
            },
            3: { // Review
                // No validation needed for review step
            }
        };
        
        return rules[step] || {};
    }
    
    /**
     * Setup inline validation
     */
    private static setupInlineValidation(): void {
        const inlineValidation = (window as any).InlineValidation;
        if (!inlineValidation) return;
        
        // Shipping form validation
        const shippingForm = document.querySelector<HTMLFormElement>('[data-checkout-step="1"] form');
        if (shippingForm) {
            const shippingRules = CheckoutPage.getStepValidationRules(1);
            if (inlineValidation.setupForm) {
                inlineValidation.setupForm(shippingForm, shippingRules);
            }
        }
        
        // Payment form validation
        const paymentForm = document.querySelector<HTMLFormElement>('[data-checkout-step="2"] form');
        if (paymentForm) {
            const paymentRules = CheckoutPage.getStepValidationRules(2);
            if (inlineValidation.setupForm) {
                inlineValidation.setupForm(paymentForm, paymentRules);
            }
        }
    }
    
    /**
     * Setup payment validation
     */
    private static setupPaymentValidation(): void {
        // Format card number
        const cardNumberInput = document.querySelector<HTMLInputElement>('[name="payment-card-number"]');
        if (cardNumberInput) {
            cardNumberInput.addEventListener('input', (e: Event) => {
                const target = e.target as HTMLInputElement;
                let value = target.value.replace(/\D/g, '');
                if (value.length > 16) value = value.slice(0, 16);
                target.value = value.replace(/(.{4})/g, '$1 ').trim();
            });
        }
        
        // Format expiry date
        const expiryInput = document.querySelector<HTMLInputElement>('[name="payment-card-expiry"]');
        if (expiryInput) {
            expiryInput.addEventListener('input', (e: Event) => {
                const target = e.target as HTMLInputElement;
                let value = target.value.replace(/\D/g, '');
                if (value.length >= 2) {
                    value = value.slice(0, 2) + '/' + value.slice(2, 4);
                }
                target.value = value;
            });
        }
        
        // Format CVV
        const cvvInput = document.querySelector<HTMLInputElement>('[name="payment-card-cvv"]');
        if (cvvInput) {
            cvvInput.addEventListener('input', (e: Event) => {
                const target = e.target as HTMLInputElement;
                target.value = target.value.replace(/\D/g, '').slice(0, 4);
            });
        }
    }
    
    /**
     * Update navigation buttons
     */
    private static updateNavigation(): void {
        const prevBtn = document.querySelector<HTMLButtonElement>('[data-checkout-prev]');
        const nextBtn = document.querySelector<HTMLButtonElement>('[data-checkout-next]');
        
        if (prevBtn) {
            prevBtn.disabled = CheckoutPage.currentStep === 1;
            prevBtn.setAttribute('aria-disabled', (CheckoutPage.currentStep === 1).toString());
        }
        
        if (nextBtn) {
            if (CheckoutPage.currentStep === CheckoutPage.totalSteps) {
                nextBtn.textContent = 'Place Order';
                nextBtn.setAttribute('data-checkout-submit', 'true');
            } else {
                nextBtn.textContent = 'Continue';
                nextBtn.removeAttribute('data-checkout-submit');
            }
        }
    }
    
    /**
     * Setup progress indicator
     */
    private static setupProgressIndicator(): void {
        CheckoutPage.updateProgressIndicator();
    }
    
    /**
     * Update progress indicator
     */
    private static updateProgressIndicator(): void {
        const progressBar = document.querySelector<HTMLElement>('[data-checkout-progress]');
        if (progressBar) {
            const progress = (CheckoutPage.currentStep / CheckoutPage.totalSteps) * 100;
            progressBar.style.width = `${progress}%`;
            progressBar.setAttribute('aria-valuenow', CheckoutPage.currentStep.toString());
            progressBar.setAttribute('aria-valuemax', CheckoutPage.totalSteps.toString());
        }
        
        // Update step indicators
        document.querySelectorAll<HTMLElement>('[data-checkout-step-indicator]').forEach((indicator: HTMLElement, index: number) => {
            const stepNum = index + 1;
            if (stepNum < CheckoutPage.currentStep) {
                indicator.classList.add('checkout-step--completed');
                indicator.setAttribute('aria-current', 'false');
            } else if (stepNum === CheckoutPage.currentStep) {
                indicator.classList.add('checkout-step--active');
                indicator.setAttribute('aria-current', 'step');
            } else {
                indicator.classList.remove('checkout-step--active', 'checkout-step--completed');
                indicator.setAttribute('aria-current', 'false');
            }
        });
    }
    
    /**
     * Submit checkout
     */
    private static submitCheckout(): void {
        const checkoutForm = document.querySelector<HTMLFormElement>('[data-checkout-form]');
        if (!checkoutForm) return;
        
        // Final validation
        if (!CheckoutPage.validateCurrentStep()) {
            return;
        }
        
        // Disable submit button
        const submitBtn = checkoutForm.querySelector<HTMLButtonElement>('[type="submit"]');
        if (submitBtn) {
            submitBtn.disabled = true;
            submitBtn.textContent = 'Processing...';
        }
        
        // Submit form
        checkoutForm.submit();
    }
}

// Initialize on DOM ready
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', () => CheckoutPage.init());
} else {
    CheckoutPage.init();
}

// Export
(window as any).CheckoutPage = CheckoutPage;

