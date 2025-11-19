/**
 * Validation Utility Class
 * Provides real-time form validation with immediate feedback
 * Following Java-style conventions
 * 
 * @author IoT Bay Development Team
 * @version 1.0.0
 */

/**
 * Validation rule interface
 */
interface ValidationRule {
    validate: (value: string) => boolean;
    message: string;
}

/**
 * Validation result interface
 */
interface ValidationResult {
    readonly valid: boolean;
    readonly errors: ReadonlyArray<string>;
}

/**
 * Field validation rules type
 */
type FieldRules = ReadonlyArray<string | ValidationRule | ((value: string) => boolean | string)>;

/**
 * Form validation rules type
 */
type FormRules = Record<string, FieldRules>;

/**
 * Validation Utility class
 * 
 * @class ValidationUtil
 */
class ValidationUtil {
    /**
     * Validation rules
     */
    private static readonly RULES: Record<string, ValidationRule> = {
        required: {
            validate: (value: string): boolean => value.trim().length > 0,
            message: 'This field is required'
        },
        email: {
            validate: (value: string): boolean => {
                const emailRegex: RegExp = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                return emailRegex.test(value);
            },
            message: 'Please enter a valid email address'
        },
        phone: {
            validate: (value: string): boolean => {
                const phoneRegex: RegExp = /^[\d\s\-\+\(\)]+$/;
                return phoneRegex.test(value) && value.replace(/\D/g, '').length >= 10;
            },
            message: 'Please enter a valid phone number'
        },
        number: {
            validate: (value: string): boolean => {
                return !isNaN(Number(value)) && !isNaN(parseFloat(value));
            },
            message: 'Must be a valid number'
        },
        positive: {
            validate: (value: string): boolean => parseFloat(value) > 0,
            message: 'Must be a positive number'
        }
    };

    /**
     * Create min length rule
     * 
     * @param {number} min - Minimum length
     * @returns {ValidationRule} Validation rule
     * @public
     * @static
     */
    public static minLength(min: number): ValidationRule {
        return {
            validate: (value: string): boolean => value.length >= min,
            message: `Must be at least ${min} characters`
        };
    }

    /**
     * Create max length rule
     * 
     * @param {number} max - Maximum length
     * @returns {ValidationRule} Validation rule
     * @public
     * @static
     */
    public static maxLength(max: number): ValidationRule {
        return {
            validate: (value: string): boolean => value.length <= max,
            message: `Must be no more than ${max} characters`
        };
    }

    /**
     * Create pattern rule
     * 
     * @param {RegExp} regex - Regular expression
     * @param {string} message - Error message
     * @returns {ValidationRule} Validation rule
     * @public
     * @static
     */
    public static pattern(regex: RegExp, message?: string): ValidationRule {
        return {
            validate: (value: string): boolean => regex.test(value),
            message: message || 'Invalid format'
        };
    }

    /**
     * Create match rule
     * 
     * @param {string} fieldName - Field name to match
     * @param {() => string} getValue - Function to get value to match
     * @returns {ValidationRule} Validation rule
     * @public
     * @static
     */
    public static match(fieldName: string, getValue: () => string): ValidationRule {
        return {
            validate: (value: string): boolean => value === getValue(),
            message: `Must match ${fieldName}`
        };
    }

    /**
     * Validate a single field
     * 
     * @param {HTMLInputElement} input - Input element
     * @param {FieldRules} rules - Validation rules
     * @returns {ValidationResult} Validation result
     * @public
     * @static
     */
    public static validateField(input: HTMLInputElement, rules: FieldRules): ValidationResult {
        const value: string = input.value;
        const errors: string[] = [];
        
        // Check each rule
        rules.forEach((rule: string | ValidationRule | ((value: string) => boolean | string)): void => {
            if (typeof rule === 'string') {
                // Simple rule name
                const ruleObj: ValidationRule | undefined = ValidationUtil.RULES[rule];
                if (ruleObj && !ruleObj.validate(value)) {
                    errors.push(ruleObj.message);
                }
            } else if (typeof rule === 'function') {
                // Custom validation function
                const result: boolean | string = rule(value);
                if (result !== true) {
                    errors.push(typeof result === 'string' ? result : 'Invalid value');
                }
            } else if (rule && typeof rule.validate === 'function') {
                // Rule object
                if (!rule.validate(value)) {
                    errors.push(rule.message);
                }
            }
        });
        
        return {
            valid: errors.length === 0,
            errors: Object.freeze(errors)
        };
    }

    /**
     * Setup inline validation for a form
     * 
     * @param {string | HTMLFormElement} formSelector - Form selector or element
     * @param {FormRules} fieldRules - Field validation rules
     * @public
     * @static
     */
    public static setupForm(formSelector: string | HTMLFormElement, fieldRules: FormRules): void {
        const form: HTMLFormElement | null = typeof formSelector === 'string' 
            ? document.querySelector<HTMLFormElement>(formSelector) 
            : formSelector;
        
        if (!form) {
            console.warn('Form not found:', formSelector);
            return;
        }
        
        // Setup validation for each field
        Object.keys(fieldRules).forEach((fieldName: string): void => {
            const input: HTMLInputElement | null = form.querySelector<HTMLInputElement>(`[name="${fieldName}"]`);
            if (!input) {
                return;
            }
            
            const rules: FieldRules = fieldRules[fieldName];
            
            // Validate on blur (after user leaves field)
            input.addEventListener('blur', (): void => {
                ValidationUtil.validateAndShow(input, rules);
            });
            
            // Validate on input (real-time feedback)
            input.addEventListener('input', (): void => {
                // Only show errors after first blur
                if (input.dataset.validated === 'true') {
                    ValidationUtil.validateAndShow(input, rules);
                }
            });
            
            // Mark as validated on first blur
            input.addEventListener('blur', (): void => {
                input.dataset.validated = 'true';
            }, { once: true });
        });
        
        // Validate entire form on submit
        form.addEventListener('submit', (e: Event): void => {
            const isValid: boolean = ValidationUtil.validateForm(form, fieldRules);
            if (!isValid) {
                e.preventDefault();
                // Focus first invalid field
                const firstInvalid: HTMLElement | null = form.querySelector<HTMLElement>('.input--error');
                if (firstInvalid) {
                    firstInvalid.focus();
                    firstInvalid.scrollIntoView({ behavior: 'smooth', block: 'center' });
                }
            }
        });
    }

    /**
     * Validate and show feedback for a single field
     * 
     * @param {HTMLInputElement} input - Input element
     * @param {FieldRules} rules - Validation rules
     * @public
     * @static
     */
    public static validateAndShow(input: HTMLInputElement, rules: FieldRules): void {
        const result: ValidationResult = ValidationUtil.validateField(input, rules);
        const wrapper: HTMLElement | null = input.closest('.input-wrapper') || input.parentElement;
        
        if (!wrapper) {
            return;
        }
        
        // Remove previous error state
        input.classList.remove('input--error', 'input--success');
        const existingError: HTMLElement | null = wrapper.querySelector<HTMLElement>('.input-error');
        if (existingError) {
            existingError.remove();
        }
        
        if (result.valid) {
            // Show success state
            input.classList.add('input--success');
            input.setAttribute('aria-invalid', 'false');
        } else {
            // Show error state
            input.classList.add('input--error');
            input.setAttribute('aria-invalid', 'true');
            
            // Show error message
            const errorMsg: HTMLDivElement = document.createElement('div');
            errorMsg.className = 'input-error';
            errorMsg.setAttribute('role', 'alert');
            errorMsg.setAttribute('id', `${input.id || input.name}-error`);
            errorMsg.textContent = result.errors[0] || ''; // Show first error
            
            wrapper.appendChild(errorMsg);
            
            // Update aria-describedby
            const describedBy: string = input.getAttribute('aria-describedby') || '';
            input.setAttribute('aria-describedby', `${describedBy} ${errorMsg.id}`.trim());
        }
    }

    /**
     * Validate entire form
     * 
     * @param {HTMLFormElement} form - Form element
     * @param {FormRules} fieldRules - Field validation rules
     * @returns {boolean} True if form is valid
     * @public
     * @static
     */
    public static validateForm(form: HTMLFormElement, fieldRules: FormRules): boolean {
        let isValid: boolean = true;
        
        Object.keys(fieldRules).forEach((fieldName: string): void => {
            const input: HTMLInputElement | null = form.querySelector<HTMLInputElement>(`[name="${fieldName}"]`);
            if (!input) {
                return;
            }
            
            const rules: FieldRules = fieldRules[fieldName];
            ValidationUtil.validateAndShow(input, rules);
            
            const result: ValidationResult = ValidationUtil.validateField(input, rules);
            if (!result.valid) {
                isValid = false;
            }
        });
        
        return isValid;
    }

    /**
     * Clear validation state
     * 
     * @param {HTMLInputElement} input - Input element
     * @public
     * @static
     */
    public static clearValidation(input: HTMLInputElement): void {
        input.classList.remove('input--error', 'input--success');
        input.setAttribute('aria-invalid', 'false');
        
        const wrapper: HTMLElement | null = input.closest('.input-wrapper') || input.parentElement;
        if (wrapper) {
            const errorMsg: HTMLElement | null = wrapper.querySelector<HTMLElement>('.input-error');
            if (errorMsg) {
                errorMsg.remove();
            }
        }
    }
}

// Export
(window as any).InlineValidation = ValidationUtil;

