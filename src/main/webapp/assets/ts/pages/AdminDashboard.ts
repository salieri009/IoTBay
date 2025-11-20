/**
 * Admin Dashboard Controller
 * 
 * Handles data visualization with Chart.js and Undo UX.
 * 
 * @author Nexus - Chief Experience Architect
 */

interface Chart {
    data: {
        labels: string[];
        datasets: Array<{
            label?: string;
            data: number[];
            [key: string]: any;
        }>;
    };
    update(): void;
}

interface ChartInstance {
    [key: string]: Chart;
}

interface UndoState {
    action: string;
    timestamp: number;
    data: any;
}

declare const Chart: any;

export class AdminDashboard {
    private static charts: ChartInstance = {};
    private static undoStack: UndoState[] = [];
    private static readonly maxUndoStack: number = 10;
    
    /**
     * Initialize admin dashboard
     */
    public static init(): void {
        if (typeof Chart === 'undefined') {
            console.warn('Chart.js not loaded. Loading from CDN...');
            AdminDashboard.loadChartJS();
            return;
        }
        
        AdminDashboard.initCharts();
        AdminDashboard.setupUndoUX();
        AdminDashboard.setupDataUpdates();
    }
    
    /**
     * Load Chart.js from CDN
     */
    private static loadChartJS(): void {
        const script = document.createElement('script');
        script.src = 'https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js';
        script.onload = () => {
            AdminDashboard.initCharts();
        };
        document.head.appendChild(script);
    }
    
    /**
     * Initialize all charts
     */
    private static initCharts(): void {
        // Sales Chart
        const salesCtx = document.getElementById('sales-chart') as HTMLCanvasElement;
        if (salesCtx) {
            AdminDashboard.charts.sales = new Chart(salesCtx, {
                type: 'line',
                data: {
                    labels: AdminDashboard.getLast30Days(),
                    datasets: [{
                        label: 'Sales',
                        data: AdminDashboard.getSalesData(),
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
        const revenueCtx = document.getElementById('revenue-chart') as HTMLCanvasElement;
        if (revenueCtx) {
            AdminDashboard.charts.revenue = new Chart(revenueCtx, {
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
        const categoriesCtx = document.getElementById('categories-chart') as HTMLCanvasElement;
        if (categoriesCtx) {
            AdminDashboard.charts.categories = new Chart(categoriesCtx, {
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
    }
    
    /**
     * Get last 30 days labels
     */
    private static getLast30Days(): string[] {
        const days: string[] = [];
        for (let i = 29; i >= 0; i--) {
            const date = new Date();
            date.setDate(date.getDate() - i);
            days.push(date.toLocaleDateString('en-US', { month: 'short', day: 'numeric' }));
        }
        return days;
    }
    
    /**
     * Get sales data (mock)
     */
    private static getSalesData(): number[] {
        // Replace with actual API call
        return Array.from({ length: 30 }, () => Math.floor(Math.random() * 1000) + 500);
    }
    
    /**
     * Setup Undo UX
     */
    private static setupUndoUX(): void {
        // Listen for admin actions
        document.addEventListener('click', (e: Event) => {
            const target = e.target as HTMLElement;
            const actionBtn = target.closest<HTMLElement>('[data-admin-action]');
            if (actionBtn) {
                const action = actionBtn.getAttribute('data-admin-action');
                if (action) {
                    AdminDashboard.saveStateBeforeAction(action);
                }
            }
        });
        
        // Undo button
        const undoBtn = document.querySelector<HTMLElement>('[data-undo-action]');
        if (undoBtn) {
            undoBtn.addEventListener('click', () => {
                AdminDashboard.undoLastAction();
            });
        }
        
        // Keyboard shortcut (Ctrl+Z)
        document.addEventListener('keydown', (e: KeyboardEvent) => {
            if ((e.ctrlKey || e.metaKey) && e.key === 'z' && !e.shiftKey) {
                e.preventDefault();
                AdminDashboard.undoLastAction();
            }
        });
    }
    
    /**
     * Save state before action
     */
    private static saveStateBeforeAction(action: string): void {
        const state: UndoState = {
            action: action,
            timestamp: Date.now(),
            data: AdminDashboard.captureCurrentState()
        };
        
        AdminDashboard.undoStack.push(state);
        
        // Limit stack size
        if (AdminDashboard.undoStack.length > AdminDashboard.maxUndoStack) {
            AdminDashboard.undoStack.shift();
        }
        
        // Show undo notification
        AdminDashboard.showUndoNotification();
    }
    
    /**
     * Capture current state
     */
    private static captureCurrentState(): any {
        // Capture relevant form/table states
        const forms = document.querySelectorAll<HTMLFormElement>('[data-admin-form]');
        const state: any = {};
        
        forms.forEach((form: HTMLFormElement) => {
            const formId = form.id || 'default';
            state[formId] = new FormData(form);
        });
        
        return state;
    }
    
    /**
     * Undo last action
     */
    private static undoLastAction(): void {
        if (AdminDashboard.undoStack.length === 0) {
            AdminDashboard.showNotification('No actions to undo', 'info');
            return;
        }
        
        const lastState = AdminDashboard.undoStack.pop();
        if (!lastState) return;
        
        // Restore state
        AdminDashboard.restoreState(lastState);
        
        // Show confirmation
        AdminDashboard.showNotification(`Undid: ${lastState.action}`, 'success');
        
        // Update charts if needed
        AdminDashboard.refreshCharts();
    }
    
    /**
     * Restore state
     */
    private static restoreState(state: UndoState): void {
        // Restore form states
        Object.keys(state.data).forEach((formId: string) => {
            const form = document.getElementById(formId) as HTMLFormElement || 
                        document.querySelector<HTMLFormElement>('[data-admin-form]');
            if (form && state.data[formId]) {
                // Restore form data
                const formData = state.data[formId];
                // Implementation depends on form structure
            }
        });
    }
    
    /**
     * Show undo notification
     */
    private static showUndoNotification(): void {
        const optimisticUI = (window as any).OptimisticUI;
        if (optimisticUI && optimisticUI.showFeedback) {
            optimisticUI.showFeedback('Action completed. Press Ctrl+Z to undo.', 'info');
        }
        
        // Show undo button
        const undoBtn = document.querySelector<HTMLElement>('[data-undo-action]');
        if (undoBtn) {
            undoBtn.style.display = 'block';
            undoBtn.classList.add('animate-pulse');
            
            // Hide after 5 seconds
            setTimeout(() => {
                undoBtn.classList.remove('animate-pulse');
            }, 5000);
        }
    }
    
    /**
     * Show notification
     */
    private static showNotification(message: string, type: string): void {
        const optimisticUI = (window as any).OptimisticUI;
        if (optimisticUI && optimisticUI.showFeedback) {
            optimisticUI.showFeedback(message, type);
        }
    }
    
    /**
     * Setup data updates
     */
    private static setupDataUpdates(): void {
        // Auto-refresh charts every 30 seconds
        setInterval(() => {
            AdminDashboard.refreshCharts();
        }, 30000);
    }
    
    /**
     * Refresh charts
     */
    private static refreshCharts(): void {
        // Update chart data (replace with actual API calls)
        if (AdminDashboard.charts.sales) {
            AdminDashboard.charts.sales.data.datasets[0].data = AdminDashboard.getSalesData();
            AdminDashboard.charts.sales.update();
        }
    }
}

// Initialize on DOM ready
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', () => AdminDashboard.init());
} else {
    AdminDashboard.init();
}

// Export
(window as any).AdminDashboard = AdminDashboard;

