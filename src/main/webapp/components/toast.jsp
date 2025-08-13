<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- 
    Toast Notification Component
    
    Parameters:
    - type: success, error, warning, info
    - message: notification message
    - title: optional title
    - autoHide: boolean (default: true)
    - duration: milliseconds (default: 5000)
--%>

<c:set var="type" value="${param.type != null ? param.type : 'info'}" />
<c:set var="autoHide" value="${param.autoHide != null ? param.autoHide : true}" />
<c:set var="duration" value="${param.duration != null ? param.duration : 5000}" />

<div class="toast toast--${type} fixed top-4 right-4 z-50 max-w-sm w-full bg-white rounded-lg shadow-lg border-l-4 transform translate-x-full transition-transform duration-300 ease-in-out"
     role="alert" 
     aria-live="polite" 
     data-auto-hide="${autoHide}" 
     data-duration="${duration}">
     
    <div class="toast__content flex items-start p-4">
        <!-- Icon -->
        <div class="toast__icon flex-shrink-0 mr-3">
            <c:choose>
                <c:when test="${type == 'success'}">
                    <div class="w-6 h-6 text-success">
                        <svg fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
                        </svg>
                    </div>
                </c:when>
                <c:when test="${type == 'error'}">
                    <div class="w-6 h-6 text-error">
                        <svg fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"/>
                        </svg>
                    </div>
                </c:when>
                <c:when test="${type == 'warning'}">
                    <div class="w-6 h-6 text-warning">
                        <svg fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M8.257 3.099c.765-1.36 2.722-1.36 3.486 0l5.58 9.92c.75 1.334-.213 2.98-1.742 2.98H4.42c-1.53 0-2.493-1.646-1.743-2.98l5.58-9.92zM11 13a1 1 0 11-2 0 1 1 0 012 0zm-1-8a1 1 0 00-1 1v3a1 1 0 002 0V6a1 1 0 00-1-1z" clip-rule="evenodd"/>
                        </svg>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="w-6 h-6 text-info">
                        <svg fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clip-rule="evenodd"/>
                        </svg>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        
        <!-- Content -->
        <div class="toast__text flex-1 min-w-0">
            <c:if test="${param.title != null}">
                <div class="toast__title font-semibold text-neutral-900 mb-1">
                    ${param.title}
                </div>
            </c:if>
            <div class="toast__message text-sm text-neutral-600">
                ${param.message}
            </div>
        </div>
        
        <!-- Close Button -->
        <button class="toast__close flex-shrink-0 ml-3 text-neutral-400 hover:text-neutral-600 transition-colors" 
                aria-label="Close notification">
            <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd"/>
            </svg>
        </button>
    </div>
    
    <!-- Progress Bar (for auto-hide) -->
    <c:if test="${autoHide}">
        <div class="toast__progress absolute bottom-0 left-0 right-0 h-1 bg-neutral-200 rounded-b-lg overflow-hidden">
            <div class="toast__progress-bar h-full bg-current opacity-30 transition-all duration-linear" 
                 style="animation: toast-progress ${duration}ms linear"></div>
        </div>
    </c:if>
</div>

<style>
@keyframes toast-progress {
    from { width: 100%; }
    to { width: 0%; }
}

.toast--success { border-left-color: var(--color-success); }
.toast--error { border-left-color: var(--color-error); }
.toast--warning { border-left-color: var(--color-warning); }
.toast--info { border-left-color: var(--color-info); }
</style>

<script>
// Toast notification functionality
class ToastManager {
    constructor() {
        this.container = this.createContainer();
        this.toasts = new Map();
    }
    
    createContainer() {
        let container = document.getElementById('toast-container');
        if (!container) {
            container = document.createElement('div');
            container.id = 'toast-container';
            container.className = 'fixed top-4 right-4 z-50 space-y-2';
            container.setAttribute('role', 'region');
            container.setAttribute('aria-label', 'Notifications');
            document.body.appendChild(container);
        }
        return container;
    }
    
    show(options) {
        const toast = this.createToast(options);
        this.container.appendChild(toast);
        
        // Trigger animation
        requestAnimationFrame(() => {
            toast.classList.remove('translate-x-full');
            toast.classList.add('translate-x-0');
        });
        
        // Set up close button
        const closeBtn = toast.querySelector('.toast__close');
        if (closeBtn) {
            closeBtn.addEventListener('click', () => this.hide(toast));
        }
        
        // Auto-hide
        if (options.autoHide !== false) {
            const duration = options.duration || 5000;
            setTimeout(() => this.hide(toast), duration);
        }
        
        return toast;
    }
    
    createToast(options) {
        const toast = document.createElement('div');
        const type = options.type || 'info';
        const id = 'toast-' + Date.now() + Math.random().toString(36).substr(2, 9);
        
        toast.id = id;
        toast.className = `toast toast--${type} max-w-sm w-full bg-white rounded-lg shadow-lg border-l-4 transform translate-x-full transition-transform duration-300 ease-in-out`;
        toast.setAttribute('role', 'alert');
        toast.setAttribute('aria-live', 'polite');
        
        const icons = {
            success: '<svg fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/></svg>',
            error: '<svg fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"/></svg>',
            warning: '<svg fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M8.257 3.099c.765-1.36 2.722-1.36 3.486 0l5.58 9.92c.75 1.334-.213 2.98-1.742 2.98H4.42c-1.53 0-2.493-1.646-1.743-2.98l5.58-9.92zM11 13a1 1 0 11-2 0 1 1 0 012 0zm-1-8a1 1 0 00-1 1v3a1 1 0 002 0V6a1 1 0 00-1-1z" clip-rule="evenodd"/></svg>',
            info: '<svg fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clip-rule="evenodd"/></svg>'
        };
        
        const colorClasses = {
            success: 'text-success border-success',
            error: 'text-error border-error',
            warning: 'text-warning border-warning',
            info: 'text-info border-info'
        };
        
        toast.innerHTML = `
            <div class="toast__content flex items-start p-4">
                <div class="toast__icon flex-shrink-0 mr-3">
                    <div class="w-6 h-6 ${colorClasses[type].split(' ')[0]}">
                        ${icons[type]}
                    </div>
                </div>
                <div class="toast__text flex-1 min-w-0">
                    ${options.title ? `<div class="toast__title font-semibold text-neutral-900 mb-1">${options.title}</div>` : ''}
                    <div class="toast__message text-sm text-neutral-600">${options.message}</div>
                </div>
                <button class="toast__close flex-shrink-0 ml-3 text-neutral-400 hover:text-neutral-600 transition-colors" aria-label="Close notification">
                    <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd"/>
                    </svg>
                </button>
            </div>
        `;
        
        return toast;
    }
    
    hide(toast) {
        toast.classList.remove('translate-x-0');
        toast.classList.add('translate-x-full');
        
        setTimeout(() => {
            if (toast.parentNode) {
                toast.parentNode.removeChild(toast);
            }
        }, 300);
    }
    
    success(message, title = null, options = {}) {
        return this.show({ ...options, type: 'success', message, title });
    }
    
    error(message, title = null, options = {}) {
        return this.show({ ...options, type: 'error', message, title });
    }
    
    warning(message, title = null, options = {}) {
        return this.show({ ...options, type: 'warning', message, title });
    }
    
    info(message, title = null, options = {}) {
        return this.show({ ...options, type: 'info', message, title });
    }
}

// Global toast instance
window.Toast = new ToastManager();

// Initialize existing toasts on page load
document.addEventListener('DOMContentLoaded', function() {
    const existingToasts = document.querySelectorAll('.toast');
    existingToasts.forEach(toast => {
        // Show animation
        requestAnimationFrame(() => {
            toast.classList.remove('translate-x-full');
            toast.classList.add('translate-x-0');
        });
        
        // Close button event
        const closeBtn = toast.querySelector('.toast__close');
        if (closeBtn) {
            closeBtn.addEventListener('click', () => window.Toast.hide(toast));
        }
        
        // Auto-hide
        const autoHide = toast.getAttribute('data-auto-hide') !== 'false';
        if (autoHide) {
            const duration = parseInt(toast.getAttribute('data-duration')) || 5000;
            setTimeout(() => window.Toast.hide(toast), duration);
        }
    });
});
</script>
