/**
 * Admin Dashboard Controller
 * 
 * Handles data visualization with Chart.js and Undo UX.
 * 
 * @author Nexus - Chief Experience Architect
 */

const AdminDashboard = {
  charts: {},
  undoStack: [],
  maxUndoStack: 10,
  
  /**
   * Initialize admin dashboard
   */
  init: function() {
    if (typeof Chart === 'undefined') {
      console.warn('Chart.js not loaded. Loading from CDN...');
      this.loadChartJS();
      return;
    }
    
    this.initCharts();
    this.setupUndoUX();
    this.setupDataUpdates();
  },
  
  /**
   * Load Chart.js from CDN
   */
  loadChartJS: function() {
    const script = document.createElement('script');
    script.src = 'https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js';
    script.onload = () => {
      this.initCharts();
    };
    document.head.appendChild(script);
  },
  
  /**
   * Initialize all charts
   */
  initCharts: function() {
    // Sales Chart
    const salesCtx = document.getElementById('sales-chart');
    if (salesCtx) {
      this.charts.sales = new Chart(salesCtx, {
        type: 'line',
        data: {
          labels: this.getLast30Days(),
          datasets: [{
            label: 'Sales',
            data: this.getSalesData(),
            borderColor: 'rgb(10, 149, 255)',
            backgroundColor: 'rgba(10, 149, 255, 0.1)',
            tension: 0.4,
            fill: true
          }]
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          plugins: {
            legend: {
              display: false
            }
          },
          scales: {
            y: {
              beginAtZero: true
            }
          }
        }
      });
    }
    
    // Revenue Chart
    const revenueCtx = document.getElementById('revenue-chart');
    if (revenueCtx) {
      this.charts.revenue = new Chart(revenueCtx, {
        type: 'bar',
        data: {
          labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
          datasets: [{
            label: 'Revenue',
            data: [12000, 19000, 15000, 25000, 22000, 30000],
            backgroundColor: 'rgba(10, 149, 255, 0.8)'
          }]
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          plugins: {
            legend: {
              display: false
            }
          },
          scales: {
            y: {
              beginAtZero: true
            }
          }
        }
      });
    }
    
    // Product Categories Chart
    const categoriesCtx = document.getElementById('categories-chart');
    if (categoriesCtx) {
      this.charts.categories = new Chart(categoriesCtx, {
        type: 'doughnut',
        data: {
          labels: ['Industrial', 'Warehouse', 'Agriculture', 'Smart Home'],
          datasets: [{
            data: [30, 25, 20, 25],
            backgroundColor: [
              'rgba(10, 149, 255, 0.8)',
              'rgba(100, 116, 139, 0.8)',
              'rgba(34, 197, 94, 0.8)',
              'rgba(249, 115, 22, 0.8)'
            ]
          }]
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          plugins: {
            legend: {
              position: 'bottom'
            }
          }
        }
      });
    }
  },
  
  /**
   * Get last 30 days labels
   */
  getLast30Days: function() {
    const days = [];
    for (let i = 29; i >= 0; i--) {
      const date = new Date();
      date.setDate(date.getDate() - i);
      days.push(date.toLocaleDateString('en-US', { month: 'short', day: 'numeric' }));
    }
    return days;
  },
  
  /**
   * Get sales data (mock)
   */
  getSalesData: function() {
    // Replace with actual API call
    return Array.from({ length: 30 }, () => Math.floor(Math.random() * 1000) + 500);
  },
  
  /**
   * Setup Undo UX
   */
  setupUndoUX: function() {
    // Listen for admin actions
    document.addEventListener('click', (e) => {
      const actionBtn = e.target.closest('[data-admin-action]');
      if (actionBtn) {
        const action = actionBtn.getAttribute('data-admin-action');
        this.saveStateBeforeAction(action);
      }
    });
    
    // Undo button
    const undoBtn = document.querySelector('[data-undo-action]');
    if (undoBtn) {
      undoBtn.addEventListener('click', () => {
        this.undoLastAction();
      });
    }
    
    // Keyboard shortcut (Ctrl+Z)
    document.addEventListener('keydown', (e) => {
      if ((e.ctrlKey || e.metaKey) && e.key === 'z' && !e.shiftKey) {
        e.preventDefault();
        this.undoLastAction();
      }
    });
  },
  
  /**
   * Save state before action
   */
  saveStateBeforeAction: function(action) {
    const state = {
      action: action,
      timestamp: Date.now(),
      data: this.captureCurrentState()
    };
    
    this.undoStack.push(state);
    
    // Limit stack size
    if (this.undoStack.length > this.maxUndoStack) {
      this.undoStack.shift();
    }
    
    // Show undo notification
    this.showUndoNotification();
  },
  
  /**
   * Capture current state
   */
  captureCurrentState: function() {
    // Capture relevant form/table states
    const forms = document.querySelectorAll('[data-admin-form]');
    const state = {};
    
    forms.forEach(form => {
      const formId = form.id || 'default';
      state[formId] = new FormData(form);
    });
    
    return state;
  },
  
  /**
   * Undo last action
   */
  undoLastAction: function() {
    if (this.undoStack.length === 0) {
      this.showNotification('No actions to undo', 'info');
      return;
    }
    
    const lastState = this.undoStack.pop();
    
    // Restore state
    this.restoreState(lastState);
    
    // Show confirmation
    this.showNotification(`Undid: ${lastState.action}`, 'success');
    
    // Update charts if needed
    this.refreshCharts();
  },
  
  /**
   * Restore state
   */
  restoreState: function(state) {
    // Restore form states
    Object.keys(state.data).forEach(formId => {
      const form = document.getElementById(formId) || document.querySelector('[data-admin-form]');
      if (form && state.data[formId]) {
        // Restore form data
        const formData = state.data[formId];
        // Implementation depends on form structure
      }
    });
  },
  
  /**
   * Show undo notification
   */
  showUndoNotification: function() {
    if (window.OptimisticUI) {
      OptimisticUI.showFeedback('Action completed. Press Ctrl+Z to undo.', 'info');
    }
    
    // Show undo button
    const undoBtn = document.querySelector('[data-undo-action]');
    if (undoBtn) {
      undoBtn.style.display = 'block';
      undoBtn.classList.add('animate-pulse');
      
      // Hide after 5 seconds
      setTimeout(() => {
        undoBtn.classList.remove('animate-pulse');
      }, 5000);
    }
  },
  
  /**
   * Show notification
   */
  showNotification: function(message, type) {
    if (window.OptimisticUI) {
      OptimisticUI.showFeedback(message, type);
    }
  },
  
  /**
   * Setup data updates
   */
  setupDataUpdates: function() {
    // Auto-refresh charts every 30 seconds
    setInterval(() => {
      this.refreshCharts();
    }, 30000);
  },
  
  /**
   * Refresh charts
   */
  refreshCharts: function() {
    // Update chart data (replace with actual API calls)
    if (this.charts.sales) {
      this.charts.sales.data.datasets[0].data = this.getSalesData();
      this.charts.sales.update();
    }
  }
};

// Initialize on DOM ready
if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', () => AdminDashboard.init());
} else {
  AdminDashboard.init();
}

// Export
window.AdminDashboard = AdminDashboard;

