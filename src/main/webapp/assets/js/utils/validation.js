/**
 * Inline Validation Utility
 * 
 * Provides real-time form validation with immediate feedback.
 * Reduces cognitive load by showing errors as user types.
 * 
 * @author Nexus - Chief Experience Architect
 * @version 1.0.0
 */

const InlineValidation = {
  /**
   * Validation rules
   */
  rules: {
    required: {
      validate: (value) => value.trim().length > 0,
      message: 'This field is required'
    },
    email: {
      validate: (value) => {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return emailRegex.test(value);
      },
      message: 'Please enter a valid email address'
    },
    phone: {
      validate: (value) => {
        const phoneRegex = /^[\d\s\-\+\(\)]+$/;
        return phoneRegex.test(value) && value.replace(/\D/g, '').length >= 10;
      },
      message: 'Please enter a valid phone number'
    },
    minLength: (min) => ({
      validate: (value) => value.length >= min,
      message: `Must be at least ${min} characters`
    }),
    maxLength: (max) => ({
      validate: (value) => value.length <= max,
      message: `Must be no more than ${max} characters`
    }),
    pattern: (regex, message) => ({
      validate: (value) => regex.test(value),
      message: message || 'Invalid format'
    }),
    match: (fieldName, getValue) => ({
      validate: (value) => value === getValue(),
      message: `Must match ${fieldName}`
    }),
    number: {
      validate: (value) => !isNaN(value) && !isNaN(parseFloat(value)),
      message: 'Must be a valid number'
    },
    positive: {
      validate: (value) => parseFloat(value) > 0,
      message: 'Must be a positive number'
    }
  },

  /**
   * Validate a single field
   */
  validateField: function(input, rules) {
    const value = input.value;
    const errors = [];
    
    // Check each rule
    rules.forEach(rule => {
      if (typeof rule === 'string') {
        // Simple rule name
        const ruleObj = this.rules[rule];
        if (ruleObj && !ruleObj.validate(value)) {
          errors.push(ruleObj.message);
        }
      } else if (typeof rule === 'function') {
        // Custom validation function
        const result = rule(value);
        if (result !== true) {
          errors.push(result || 'Invalid value');
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
      errors: errors
    };
  },

  /**
   * Setup inline validation for a form
   */
  setupForm: function(formSelector, fieldRules) {
    const form = typeof formSelector === 'string' 
      ? document.querySelector(formSelector) 
      : formSelector;
    
    if (!form) {
      console.warn('Form not found:', formSelector);
      return;
    }
    
    // Setup validation for each field
    Object.keys(fieldRules).forEach(fieldName => {
      const input = form.querySelector(`[name="${fieldName}"]`);
      if (!input) return;
      
      const rules = fieldRules[fieldName];
      
      // Validate on blur (after user leaves field)
      input.addEventListener('blur', () => {
        this.validateAndShow(input, rules);
      });
      
      // Validate on input (real-time feedback)
      input.addEventListener('input', () => {
        // Only show errors after first blur
        if (input.dataset.validated === 'true') {
          this.validateAndShow(input, rules);
        }
      });
      
      // Mark as validated on first blur
      input.addEventListener('blur', () => {
        input.dataset.validated = 'true';
      }, { once: true });
    });
    
    // Validate entire form on submit
    form.addEventListener('submit', (e) => {
      const isValid = this.validateForm(form, fieldRules);
      if (!isValid) {
        e.preventDefault();
        // Focus first invalid field
        const firstInvalid = form.querySelector('.input--error');
        if (firstInvalid) {
          firstInvalid.focus();
          firstInvalid.scrollIntoView({ behavior: 'smooth', block: 'center' });
        }
      }
    });
  },

  /**
   * Validate and show feedback for a single field
   */
  validateAndShow: function(input, rules) {
    const result = this.validateField(input, rules);
    const wrapper = input.closest('.input-wrapper') || input.parentElement;
    
    // Remove previous error state
    input.classList.remove('input--error', 'input--success');
    const existingError = wrapper.querySelector('.input-error');
    if (existingError) {
      existingError.remove();
    }
    
    if (result.valid) {
      // Show success state
      input.classList.add('input--success');
      input.setAttribute('aria-invalid', 'false');
      
      // Remove error message if exists
      const errorMsg = wrapper.querySelector('.input-error');
      if (errorMsg) {
        errorMsg.remove();
      }
    } else {
      // Show error state
      input.classList.add('input--error');
      input.setAttribute('aria-invalid', 'true');
      
      // Show error message
      const errorMsg = document.createElement('div');
      errorMsg.className = 'input-error';
      errorMsg.setAttribute('role', 'alert');
      errorMsg.setAttribute('id', `${input.id || input.name}-error`);
      errorMsg.textContent = result.errors[0]; // Show first error
      
      wrapper.appendChild(errorMsg);
      
      // Update aria-describedby
      const describedBy = input.getAttribute('aria-describedby') || '';
      input.setAttribute('aria-describedby', `${describedBy} ${errorMsg.id}`.trim());
    }
  },

  /**
   * Validate entire form
   */
  validateForm: function(form, fieldRules) {
    let isValid = true;
    
    Object.keys(fieldRules).forEach(fieldName => {
      const input = form.querySelector(`[name="${fieldName}"]`);
      if (!input) return;
      
      const rules = fieldRules[fieldName];
      const result = this.validateAndShow(input, rules);
      
      if (!result.valid) {
        isValid = false;
      }
    });
    
    return isValid;
  },

  /**
   * Clear validation state
   */
  clearValidation: function(input) {
    input.classList.remove('input--error', 'input--success');
    input.setAttribute('aria-invalid', 'false');
    
    const wrapper = input.closest('.input-wrapper') || input.parentElement;
    const errorMsg = wrapper.querySelector('.input-error');
    if (errorMsg) {
      errorMsg.remove();
    }
  }
};

// Export
window.InlineValidation = InlineValidation;

