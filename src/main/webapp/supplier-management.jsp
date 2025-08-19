<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="model.User" %>

<%
    // Admin authorization check
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null || !"staff".equalsIgnoreCase(currentUser.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Supplier Management - IoT Bay Admin</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/modern-theme.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;900&display=swap" rel="stylesheet">
    <style>
        .admin-layout {
            min-height: 100vh;
            background: linear-gradient(135deg, var(--neutral-50) 0%, var(--neutral-100) 100%);
        }
        
        .admin-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 2rem;
        }
        
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            padding: 2rem;
            background: var(--neutral-0);
            border-radius: var(--border-radius-xl);
            box-shadow: var(--shadow-lg);
            border: 1px solid var(--neutral-200);
        }
        
        .page-title {
            font-size: 2rem;
            font-weight: 900;
            background: var(--brand-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        
        .page-subtitle {
            color: var(--neutral-600);
            font-size: 1rem;
            margin-top: 0.5rem;
        }
        
        .stats-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .stat-card {
            background: var(--neutral-0);
            padding: 1.5rem;
            border-radius: var(--border-radius-lg);
            border: 1px solid var(--neutral-200);
            box-shadow: var(--shadow-sm);
            text-align: center;
        }
        
        .stat-number {
            font-size: 2rem;
            font-weight: 700;
            color: var(--brand-primary);
            margin-bottom: 0.5rem;
        }
        
        .stat-label {
            color: var(--neutral-600);
            font-size: 0.875rem;
        }
        
        .controls-section {
            display: flex;
            gap: 1rem;
            margin-bottom: 2rem;
            flex-wrap: wrap;
            align-items: center;
        }
        
        .search-container {
            flex: 1;
            min-width: 300px;
            position: relative;
        }
        
        .search-input {
            width: 100%;
            padding: 0.75rem 1rem 0.75rem 2.5rem;
            border: 1px solid var(--neutral-300);
            border-radius: var(--border-radius-lg);
            font-size: 0.875rem;
        }
        
        .search-icon {
            position: absolute;
            left: 0.75rem;
            top: 50%;
            transform: translateY(-50%);
            width: 1rem;
            height: 1rem;
            color: var(--neutral-400);
        }
        
        .filter-group {
            display: flex;
            gap: 0.5rem;
            align-items: center;
        }
        
        .filter-select {
            padding: 0.75rem;
            border: 1px solid var(--neutral-300);
            border-radius: var(--border-radius-lg);
            font-size: 0.875rem;
        }
        
        .suppliers-table-container {
            background: var(--neutral-0);
            border-radius: var(--border-radius-xl);
            overflow: hidden;
            box-shadow: var(--shadow-lg);
            border: 1px solid var(--neutral-200);
        }
        
        .table-header {
            padding: 1.5rem;
            background: var(--neutral-50);
            border-bottom: 1px solid var(--neutral-200);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .table-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--neutral-800);
        }
        
        .suppliers-table {
            width: 100%;
            border-collapse: collapse;
        }
        
        .suppliers-table th,
        .suppliers-table td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid var(--neutral-200);
        }
        
        .suppliers-table th {
            background: var(--neutral-50);
            font-weight: 600;
            color: var(--neutral-700);
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }
        
        .suppliers-table td {
            color: var(--neutral-600);
            font-size: 0.875rem;
        }
        
        .supplier-name {
            font-weight: 600;
            color: var(--neutral-800);
        }
        
        .supplier-status {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            border-radius: var(--border-radius-full);
            font-size: 0.75rem;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }
        
        .status-active {
            background: var(--success-light);
            color: var(--success-dark);
        }
        
        .status-inactive {
            background: var(--error-light);
            color: var(--error-dark);
        }
        
        .status-pending {
            background: var(--warning-light);
            color: var(--warning-dark);
        }
        
        .action-buttons {
            display: flex;
            gap: 0.5rem;
        }
        
        .action-btn {
            padding: 0.5rem;
            border: none;
            border-radius: var(--border-radius-md);
            cursor: pointer;
            transition: all 0.2s ease;
        }
        
        .action-btn--edit {
            background: var(--brand-primary-100);
            color: var(--brand-primary-700);
        }
        
        .action-btn--edit:hover {
            background: var(--brand-primary-200);
        }
        
        .action-btn--delete {
            background: var(--error-light);
            color: var(--error-dark);
        }
        
        .action-btn--delete:hover {
            background: var(--error);
            color: var(--neutral-0);
        }
        
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.5);
            display: none;
            align-items: center;
            justify-content: center;
            z-index: 1000;
        }
        
        .modal-overlay.active {
            display: flex;
        }
        
        .modal-content {
            background: var(--neutral-0);
            border-radius: var(--border-radius-xl);
            padding: 2rem;
            width: 90%;
            max-width: 600px;
            max-height: 80vh;
            overflow-y: auto;
            box-shadow: var(--shadow-xl);
        }
        
        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid var(--neutral-200);
        }
        
        .modal-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--neutral-800);
        }
        
        .modal-close {
            background: none;
            border: none;
            font-size: 1.5rem;
            color: var(--neutral-400);
            cursor: pointer;
            padding: 0.5rem;
            border-radius: var(--border-radius-md);
        }
        
        .modal-close:hover {
            background: var(--neutral-100);
            color: var(--neutral-600);
        }
        
        .form-group {
            margin-bottom: 1.5rem;
        }
        
        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: var(--neutral-700);
        }
        
        .form-input,
        .form-select,
        .form-textarea {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid var(--neutral-300);
            border-radius: var(--border-radius-lg);
            font-size: 0.875rem;
            transition: border-color 0.2s ease;
        }
        
        .form-input:focus,
        .form-select:focus,
        .form-textarea:focus {
            outline: none;
            border-color: var(--brand-primary);
            box-shadow: 0 0 0 3px var(--brand-primary-100);
        }
        
        .form-textarea {
            resize: vertical;
            min-height: 100px;
        }
        
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
        }
        
        .modal-actions {
            display: flex;
            gap: 1rem;
            justify-content: flex-end;
            margin-top: 2rem;
            padding-top: 1rem;
            border-top: 1px solid var(--neutral-200);
        }
        
        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 0.5rem;
            margin-top: 2rem;
        }
        
        .pagination-btn {
            padding: 0.5rem 1rem;
            border: 1px solid var(--neutral-300);
            background: var(--neutral-0);
            color: var(--neutral-600);
            border-radius: var(--border-radius-md);
            cursor: pointer;
            transition: all 0.2s ease;
        }
        
        .pagination-btn:hover {
            background: var(--neutral-50);
        }
        
        .pagination-btn.active {
            background: var(--brand-primary);
            color: var(--neutral-0);
            border-color: var(--brand-primary);
        }
        
        .pagination-btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }
        
        @media (max-width: 768px) {
            .admin-container {
                padding: 1rem;
            }
            
            .page-header {
                flex-direction: column;
                text-align: center;
                gap: 1rem;
            }
            
            .controls-section {
                flex-direction: column;
            }
            
            .search-container {
                min-width: auto;
            }
            
            .form-row {
                grid-template-columns: 1fr;
            }
            
            .modal-content {
                width: 95%;
                padding: 1rem;
            }
            
            .suppliers-table {
                font-size: 0.75rem;
            }
            
            .suppliers-table th,
            .suppliers-table td {
                padding: 0.5rem;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="components/header.jsp" />
    
    <main class="admin-layout">
        <div class="admin-container">
            <!-- Page Header -->
            <header class="page-header">
                <div>
                    <h1 class="page-title">Supplier Management</h1>
                    <p class="page-subtitle">Manage supplier relationships and performance tracking</p>
                </div>
                <button class="btn btn--primary" onclick="openSupplierModal()">
                    <svg style="width: 1rem; height: 1rem; margin-right: 0.5rem;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"/>
                    </svg>
                    Add New Supplier
                </button>
            </header>
            
            <!-- Statistics -->
            <section class="stats-row">
                <div class="stat-card">
                    <div class="stat-number" id="totalSuppliers">95</div>
                    <div class="stat-label">Total Suppliers</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number" id="activeSuppliers">78</div>
                    <div class="stat-label">Active Suppliers</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number" id="pendingSuppliers">12</div>
                    <div class="stat-label">Pending Approval</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number" id="inactiveSuppliers">5</div>
                    <div class="stat-label">Inactive</div>
                </div>
            </section>
            
            <!-- Controls -->
            <section class="controls-section">
                <div class="search-container">
                    <input type="text" class="search-input" placeholder="Search suppliers by name, company, or email..." id="searchInput">
                    <svg class="search-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                    </svg>
                </div>
                <div class="filter-group">
                    <label for="statusFilter">Status:</label>
                    <select class="filter-select" id="statusFilter">
                        <option value="all">All Status</option>
                        <option value="active">Active</option>
                        <option value="inactive">Inactive</option>
                        <option value="pending">Pending</option>
                    </select>
                </div>
                <div class="filter-group">
                    <label for="typeFilter">Type:</label>
                    <select class="filter-select" id="typeFilter">
                        <option value="all">All Types</option>
                        <option value="manufacturer">Manufacturer</option>
                        <option value="distributor">Distributor</option>
                        <option value="wholesaler">Wholesaler</option>
                        <option value="service">Service Provider</option>
                    </select>
                </div>
            </section>
            
            <!-- Suppliers Table -->
            <section class="suppliers-table-container">
                <div class="table-header">
                    <h3 class="table-title">Supplier Directory</h3>
                    <span class="text-sm text-neutral-600">Showing <span id="showingCount">25</span> of <span id="totalCount">95</span> suppliers</span>
                </div>
                <table class="suppliers-table">
                    <thead>
                        <tr>
                            <th>Company Name</th>
                            <th>Contact Person</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Type</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody id="suppliersTableBody">
                        <!-- Sample Data - This would be populated from backend -->
                        <tr>
                            <td class="supplier-name">IoT Solutions Inc.</td>
                            <td>John Smith</td>
                            <td>john.smith@iotsolutions.com</td>
                            <td>+1 (555) 123-4567</td>
                            <td>Manufacturer</td>
                            <td><span class="supplier-status status-active">Active</span></td>
                            <td>
                                <div class="action-buttons">
                                    <button class="action-btn action-btn--edit" onclick="editSupplier(1)" title="Edit Supplier">
                                        <svg style="width: 1rem; height: 1rem;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"/>
                                        </svg>
                                    </button>
                                    <button class="action-btn action-btn--delete" onclick="deleteSupplier(1)" title="Delete Supplier">
                                        <svg style="width: 1rem; height: 1rem;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"/>
                                        </svg>
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="supplier-name">Smart Tech Distributors</td>
                            <td>Sarah Johnson</td>
                            <td>sarah@smarttech.com</td>
                            <td>+1 (555) 987-6543</td>
                            <td>Distributor</td>
                            <td><span class="supplier-status status-active">Active</span></td>
                            <td>
                                <div class="action-buttons">
                                    <button class="action-btn action-btn--edit" onclick="editSupplier(2)" title="Edit Supplier">
                                        <svg style="width: 1rem; height: 1rem;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"/>
                                        </svg>
                                    </button>
                                    <button class="action-btn action-btn--delete" onclick="deleteSupplier(2)" title="Delete Supplier">
                                        <svg style="width: 1rem; height: 1rem;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"/>
                                        </svg>
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="supplier-name">Industrial Automation Co.</td>
                            <td>Mike Chen</td>
                            <td>m.chen@indauto.com</td>
                            <td>+1 (555) 456-7890</td>
                            <td>Service Provider</td>
                            <td><span class="supplier-status status-pending">Pending</span></td>
                            <td>
                                <div class="action-buttons">
                                    <button class="action-btn action-btn--edit" onclick="editSupplier(3)" title="Edit Supplier">
                                        <svg style="width: 1rem; height: 1rem;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"/>
                                        </svg>
                                    </button>
                                    <button class="action-btn action-btn--delete" onclick="deleteSupplier(3)" title="Delete Supplier">
                                        <svg style="width: 1rem; height: 1rem;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"/>
                                        </svg>
                                    </button>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
                
                <!-- Pagination -->
                <div class="pagination">
                    <button class="pagination-btn" disabled>Previous</button>
                    <button class="pagination-btn active">1</button>
                    <button class="pagination-btn">2</button>
                    <button class="pagination-btn">3</button>
                    <button class="pagination-btn">Next</button>
                </div>
            </section>
        </div>
    </main>
    
    <!-- Supplier Modal -->
    <div class="modal-overlay" id="supplierModal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title" id="modalTitle">Add New Supplier</h2>
                <button class="modal-close" onclick="closeSupplierModal()">×</button>
            </div>
            <form id="supplierForm" onsubmit="handleSupplierSubmit(event)">
                <div class="form-group">
                    <label class="form-label" for="companyName">Company Name *</label>
                    <input type="text" class="form-input" id="companyName" name="companyName" required>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label" for="contactPerson">Contact Person *</label>
                        <input type="text" class="form-input" id="contactPerson" name="contactPerson" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="supplierType">Supplier Type *</label>
                        <select class="form-select" id="supplierType" name="supplierType" required>
                            <option value="">Select Type</option>
                            <option value="manufacturer">Manufacturer</option>
                            <option value="distributor">Distributor</option>
                            <option value="wholesaler">Wholesaler</option>
                            <option value="service">Service Provider</option>
                        </select>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label" for="email">Email Address *</label>
                        <input type="email" class="form-input" id="email" name="email" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="phone">Phone Number *</label>
                        <input type="tel" class="form-input" id="phone" name="phone" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="form-label" for="address">Address</label>
                    <textarea class="form-textarea" id="address" name="address" placeholder="Enter complete address"></textarea>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label" for="website">Website</label>
                        <input type="url" class="form-input" id="website" name="website" placeholder="https://example.com">
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="status">Status</label>
                        <select class="form-select" id="status" name="status">
                            <option value="pending">Pending</option>
                            <option value="active">Active</option>
                            <option value="inactive">Inactive</option>
                        </select>
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="form-label" for="notes">Notes</label>
                    <textarea class="form-textarea" id="notes" name="notes" placeholder="Additional notes or comments"></textarea>
                </div>
                
                <div class="modal-actions">
                    <button type="button" class="btn btn--outline" onclick="closeSupplierModal()">Cancel</button>
                    <button type="submit" class="btn btn--primary">Save Supplier</button>
                </div>
            </form>
        </div>
    </div>
    
    <jsp:include page="components/footer.jsp" />
    
    <script>
        // Modal Management
        function openSupplierModal(supplierId = null) {
            const modal = document.getElementById('supplierModal');
            const modalTitle = document.getElementById('modalTitle');
            const form = document.getElementById('supplierForm');
            
            if (supplierId) {
                modalTitle.textContent = 'Edit Supplier';
                // Load supplier data (would come from backend)
                loadSupplierData(supplierId);
            } else {
                modalTitle.textContent = 'Add New Supplier';
                form.reset();
            }
            
            modal.classList.add('active');
            document.body.style.overflow = 'hidden';
        }
        
        function closeSupplierModal() {
            const modal = document.getElementById('supplierModal');
            modal.classList.remove('active');
            document.body.style.overflow = 'auto';
        }
        
        function editSupplier(supplierId) {
            openSupplierModal(supplierId);
        }
        
        function deleteSupplier(supplierId) {
            if (confirm('Are you sure you want to delete this supplier? This action cannot be undone.')) {
                // Delete supplier (would call backend API)
                console.log('Deleting supplier:', supplierId);
                // Refresh table
                loadSuppliers();
            }
        }
        
        function loadSupplierData(supplierId) {
            // This would load data from backend API
            const sampleData = {
                1: {
                    companyName: 'IoT Solutions Inc.',
                    contactPerson: 'John Smith',
                    email: 'john.smith@iotsolutions.com',
                    phone: '+1 (555) 123-4567',
                    supplierType: 'manufacturer',
                    address: '123 Tech Street, Silicon Valley, CA 94000',
                    website: 'https://iotsolutions.com',
                    status: 'active',
                    notes: 'Reliable supplier for IoT sensors and components.'
                }
            };
            
            const data = sampleData[supplierId];
            if (data) {
                Object.keys(data).forEach(key => {
                    const element = document.getElementById(key);
                    if (element) {
                        element.value = data[key];
                    }
                });
            }
        }
        
        function handleSupplierSubmit(event) {
            event.preventDefault();
            const formData = new FormData(event.target);
            const supplierData = Object.fromEntries(formData.entries());
            
            // Validate required fields
            const requiredFields = ['companyName', 'contactPerson', 'email', 'phone', 'supplierType'];
            const missingFields = requiredFields.filter(field => !supplierData[field]);
            
            if (missingFields.length > 0) {
                alert('Please fill in all required fields: ' + missingFields.join(', '));
                return;
            }
            
            // Submit to backend (would be actual API call)
            console.log('Submitting supplier data:', supplierData);
            
            // Close modal and refresh table
            closeSupplierModal();
            loadSuppliers();
            
            // Show success message
            showNotification('Supplier saved successfully!', 'success');
        }
        
        function loadSuppliers() {
            // This would load suppliers from backend API
            // For now, just refresh the page statistics
            updateStatistics();
        }
        
        function updateStatistics() {
            // Simulate updating statistics
            const stats = {
                total: Math.floor(Math.random() * 20) + 90,
                active: Math.floor(Math.random() * 10) + 75,
                pending: Math.floor(Math.random() * 5) + 10,
                inactive: Math.floor(Math.random() * 3) + 3
            };
            
            document.getElementById('totalSuppliers').textContent = stats.total;
            document.getElementById('activeSuppliers').textContent = stats.active;
            document.getElementById('pendingSuppliers').textContent = stats.pending;
            document.getElementById('inactiveSuppliers').textContent = stats.inactive;
        }
        
        function showNotification(message, type = 'info') {
            // Simple notification system
            const notification = document.createElement('div');
            notification.className = `notification notification--${type}`;
            notification.textContent = message;
            notification.style.cssText = `
                position: fixed;
                top: 2rem;
                right: 2rem;
                padding: 1rem 1.5rem;
                background: ${type === 'success' ? 'var(--success)' : 'var(--brand-primary)'};
                color: var(--neutral-0);
                border-radius: var(--border-radius-lg);
                box-shadow: var(--shadow-lg);
                z-index: 2000;
                animation: slideIn 0.3s ease;
            `;
            
            document.body.appendChild(notification);
            
            setTimeout(() => {
                notification.remove();
            }, 3000);
        }
        
        // Search and Filter functionality
        document.getElementById('searchInput').addEventListener('input', function() {
            const searchTerm = this.value.toLowerCase();
            filterSuppliers();
        });
        
        document.getElementById('statusFilter').addEventListener('change', filterSuppliers);
        document.getElementById('typeFilter').addEventListener('change', filterSuppliers);
        
        function filterSuppliers() {
            const searchTerm = document.getElementById('searchInput').value.toLowerCase();
            const statusFilter = document.getElementById('statusFilter').value;
            const typeFilter = document.getElementById('typeFilter').value;
            
            // This would filter the suppliers table
            console.log('Filtering suppliers:', { searchTerm, statusFilter, typeFilter });
        }
        
        // Close modal on outside click
        document.getElementById('supplierModal').addEventListener('click', function(e) {
            if (e.target === this) {
                closeSupplierModal();
            }
        });
        
        // Initialize page
        document.addEventListener('DOMContentLoaded', function() {
            updateStatistics();
            
            // Add CSS animation for notifications
            const style = document.createElement('style');
            style.textContent = `
                @keyframes slideIn {
                    from {
                        transform: translateX(100%);
                        opacity: 0;
                    }
                    to {
                        transform: translateX(0);
                        opacity: 1;
                    }
                }
            `;
            document.head.appendChild(style);
        });
    </script>
</body>
</html>
