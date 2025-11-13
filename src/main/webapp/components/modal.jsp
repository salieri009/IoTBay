<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- 
    Modal Component
    
    Parameters:
    - id: modal ID (required)
    - title: modal title
    - size: sm, md, lg, xl (default: md)
    - closable: boolean (default: true)
    - backdrop: boolean (default: true)
--%>

<c:set var="modalId" value="${param.id}" />
<c:set var="size" value="${param.size != null ? param.size : 'md'}" />
<c:set var="closable" value="${param.closable != null ? param.closable : true}" />
<c:set var="backdrop" value="${param.backdrop != null ? param.backdrop : true}" />

<div id="${modalId}" 
     class="modal fixed inset-0 z-50 hidden overflow-y-auto" 
     role="dialog" 
     aria-modal="true" 
     aria-labelledby="${modalId}-title"
     aria-hidden="true">
     
    <!-- Backdrop -->
    <div class="modal__backdrop fixed inset-0 bg-black transition-opacity ${backdrop ? 'bg-opacity-50' : 'bg-opacity-0'}" 
         aria-hidden="true"></div>
    
    <!-- Modal Container -->
    <div class="modal__container flex min-h-full items-center justify-center p-4">
        
        <!-- Modal Content -->
        <div class="modal__content relative bg-white rounded-lg shadow-xl transform transition-all w-full
                    ${size == 'sm' ? 'max-w-sm' : 
                      size == 'lg' ? 'max-w-4xl' : 
                      size == 'xl' ? 'max-w-6xl' : 'max-w-lg'}">
                      
            <!-- Header -->
            <c:if test="${param.title != null || closable}">
                <div class="modal__header flex items-center justify-between p-6 border-b border-neutral-200">
                    <c:if test="${param.title != null}">
                        <h3 id="${modalId}-title" class="modal__title text-lg font-semibold text-neutral-900">
                            ${param.title}
                        </h3>
                    </c:if>
                    
                    <c:if test="${closable}">
                        <button type="button" 
                                class="modal__close text-neutral-400 hover:text-neutral-600 transition-colors"
                                aria-label="Close modal">
                            <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 20 20">
                                <path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd"/>
                            </svg>
                        </button>
                    </c:if>
                </div>
            </c:if>
            
            <!-- Body -->
            <div class="modal__body p-6">
                <!-- Content will be inserted here -->
                <jsp:doBody/>
            </div>
            
            <!-- Footer (optional, can be added via content) -->
            <c:if test="${param.showFooter}">
                <div class="modal__footer flex justify-end gap-3 p-6 border-t border-neutral-200">
                    <c:if test="${closable}">
                        <button type="button" class="btn btn--ghost modal__cancel">
                            Cancel
                        </button>
                    </c:if>
                    <c:if test="${param.primaryAction != null}">
                        <button type="button" class="btn btn--primary modal__primary">
                            ${param.primaryAction}
                        </button>
                    </c:if>
                </div>
            </c:if>
        </div>
    </div>
</div>

<script>
// Modal functionality
class Modal {
    constructor(element) {
        this.element = element;
        this.backdrop = element.querySelector('.modal__backdrop');
        this.content = element.querySelector('.modal__content');
        this.closeButtons = element.querySelectorAll('.modal__close, .modal__cancel');
        this.isOpen = false;
        
        this.init();
    }
    
    init() {
        // Close button events
        this.closeButtons.forEach(btn => {
            btn.addEventListener('click', () => this.close());
        });
        
        // Backdrop click to close
        if (this.backdrop) {
            this.backdrop.addEventListener('click', (e) => {
                if (e.target === this.backdrop) {
                    this.close();
                }
            });
        }
        
        // Escape key to close
        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape' && this.isOpen) {
                this.close();
            }
        });
    }
    
    open() {
        this.isOpen = true;
        this.element.classList.remove('hidden');
        this.element.setAttribute('aria-hidden', 'false');
        
        // Prevent body scroll
        document.body.style.overflow = 'hidden';
        
        // Focus management
        const firstFocusable = this.content.querySelector('button, [href], input, select, textarea, [tabindex]:not([tabindex="-1"])');
        if (firstFocusable) {
            firstFocusable.focus();
        }
        
        // Animation
        requestAnimationFrame(() => {
            this.backdrop.style.opacity = '1';
            this.content.style.transform = 'scale(1)';
            this.content.style.opacity = '1';
        });
        
        // Dispatch event
        this.element.dispatchEvent(new CustomEvent('modal:open'));
    }
    
    close() {
        this.isOpen = false;
        
        // Animation
        this.backdrop.style.opacity = '0';
        this.content.style.transform = 'scale(0.95)';
        this.content.style.opacity = '0';
        
        setTimeout(() => {
            this.element.classList.add('hidden');
            this.element.setAttribute('aria-hidden', 'true');
            
            // Restore body scroll
            document.body.style.overflow = '';
            
            // Restore focus to trigger element
            if (this.triggerElement) {
                this.triggerElement.focus();
            }
        }, 150);
        
        // Dispatch event
        this.element.dispatchEvent(new CustomEvent('modal:close'));
    }
    
    setTrigger(element) {
        this.triggerElement = element;
    }
}

// Initialize modals
document.addEventListener('DOMContentLoaded', function() {
    const modals = {};
    
    // Initialize all modals
    document.querySelectorAll('.modal').forEach(modalElement => {
        const modal = new Modal(modalElement);
        modals[modalElement.id] = modal;
    });
    
    // Global modal controls
    window.Modal = {
        open: function(id) {
            if (modals[id]) {
                modals[id].open();
            }
        },
        
        close: function(id) {
            if (modals[id]) {
                modals[id].close();
            }
        },
        
        closeAll: function() {
            Object.values(modals).forEach(modal => {
                if (modal.isOpen) {
                    modal.close();
                }
            });
        }
    };
    
    // Auto-wire modal triggers
    document.querySelectorAll('[data-modal-target]').forEach(trigger => {
        trigger.addEventListener('click', function(e) {
            e.preventDefault();
            const targetId = this.getAttribute('data-modal-target');
            if (modals[targetId]) {
                modals[targetId].setTrigger(this);
                modals[targetId].open();
            }
        });
    });
});
</script>

<style>
.modal {
    backdrop-filter: blur(4px);
}

.modal__content {
    transform: scale(0.95);
    opacity: 0;
    transition: all 0.15s ease-out;
}

.modal__backdrop {
    opacity: 0;
    transition: opacity 0.15s ease-out;
}

/* Focus trap styles */
.modal:not(.hidden) .modal__content {
    transform: scale(1);
    opacity: 1;
}

.modal:not(.hidden) .modal__backdrop {
    opacity: 1;
}

/* Responsive modal sizing */
@media (max-width: 640px) {
    .modal__content {
        margin: 1rem;
        max-height: calc(100vh - 2rem);
        overflow-y: auto;
    }
}
</style>
