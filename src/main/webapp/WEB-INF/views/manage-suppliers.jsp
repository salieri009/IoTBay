<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Supplier" %>
<%@ page import="service.SupplierService" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Suppliers - IoT Bay Admin</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/modern-theme.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;900&display=swap" rel="stylesheet">
    <style>
        .admin-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 2rem;
        }
        
        .admin-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid var(--color-border);
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-bottom: 2rem;
        }
        
        .stat-card {
            background: var(--color-surface);
            padding: 1.5rem;
            border-radius: var(--border-radius-lg);
            border: 1px solid var(--color-border);
            text-align: center;
        }
        
        .stat-number {
            font-size: 2rem;
            font-weight: 700;
            color: var(--color-primary);
            margin-bottom: 0.5rem;
        }
        
        .stat-label {
            color: var(--color-text-secondary);
            font-size: 0.875rem;
        }
        
        .controls-section {
            display: flex;
            gap: 1rem;
            margin-bottom: 2rem;
            flex-wrap: wrap;
            align-items: center;
        }
        
        .search-form {
            display: flex;
            gap: 0.5rem;
            flex: 1;
        }
        
        .filter-form {
            display: flex;
            gap: 0.5rem;
            align-items: center;
        }
        
        .table-container {
            background: var(--color-surface);
            border-radius: var(--border-radius-lg);
            overflow: hidden;
            border: 1px solid var(--color-border);
        }
        
        .suppliers-table {
            width: 100%;
            border-collapse: collapse;
        }
        
        .suppliers-table th,
        .suppliers-table td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid var(--color-border);
        }
        
        .suppliers-table th {
            background: var(--color-background-secondary);
            font-weight: 600;
            color: var(--color-text-primary);
        }
        
        .suppliers-table tr:hover {
            background: var(--color-background-secondary);
        }
        
        .status-badge {
            padding: 0.25rem 0.75rem;
            border-radius: var(--border-radius-full);
            font-size: 0.75rem;
            font-weight: 600;
        }
        
        .status-active {
            background: var(--color-success-light);
            color: var(--color-success-dark);
        }
        
        .status-inactive {
            background: var(--color-error-light);
            color: var(--color-error-dark);
        }
        
        .action-buttons {
            display: flex;
            gap: 0.5rem;
        }
        
        .btn-sm {
            padding: 0.5rem 1rem;
            font-size: 0.875rem;
        }
        
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            align-items: center;
            justify-content: center;
        }
        
        .modal.active {
            display: flex;
        }
        
        .modal-content {
            background: var(--color-surface);
            padding: 2rem;
            border-radius: var(--border-radius-lg);
            max-width: 600px;
            width: 90%;
            max-height: 90vh;
            overflow-y: auto;
        }
        
        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
        }
        
        .form-grid .form__group.full-width {
            grid-column: 1 / -1;
        }
        
        .alert {
            padding: 1rem;
            border-radius: var(--border-radius);
            margin-bottom: 1rem;
        }
        
        .alert-success {
            background: var(--color-success-light);
            color: var(--color-success-dark);
            border: 1px solid var(--color-success);
        }
        
        .alert-error {
            background: var(--color-error-light);
            color: var(--color-error-dark);
            border: 1px solid var(--color-error);
        }
    </style>
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="../../components/header.jsp" />
    
    <main class="admin-container">
        <!-- Admin Header -->
        <div class="admin-header">
            <div>
                <h1 class="text-3xl font-bold text-primary">Supplier Management</h1>
                <p class="text-secondary">Manage supplier information and company details</p>
            </div>
            <button class="btn btn--primary" onclick="openCreateModal()">
                <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"></path>
                </svg>
                Add New Supplier
            </button>
        </div>
        
        <!-- Success/Error Messages -->
        <%
            String success = request.getParameter("success");
            String error = request.getParameter("error");
            
            if (success != null) {
                String message = "";
                switch(success) {
                    case "created": message = "Supplier created successfully!"; break;
                    case "updated": message = "Supplier updated successfully!"; break;
                    case "deleted": message = "Supplier deleted successfully!"; break;
                    default: message = "Operation completed successfully!";
                }
        %>
            <div class="alert alert-success">
                <strong>Success!</strong> <%= message %>
            </div>
        <% } %>
        
        <% if (error != null) { %>
            <div class="alert alert-error">
                <strong>Error!</strong> <%= error %>
            </div>
        <% } %>
        
        <!-- Statistics -->
        <%
            List<SupplierService.SupplierStatistic> statistics = 
                (List<SupplierService.SupplierStatistic>) request.getAttribute("statistics");
            Integer totalCount = (Integer) request.getAttribute("totalCount");
        %>
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-number"><%= totalCount != null ? totalCount : 0 %></div>
                <div class="stat-label">Total Suppliers</div>
            </div>
            <% if (statistics != null) {
                for (SupplierService.SupplierStatistic stat : statistics) { %>
                    <div class="stat-card">
                        <div class="stat-number"><%= stat.getCount() %></div>
                        <div class="stat-label"><%= stat.getType() %></div>
                    </div>
            <% } } %>
        </div>
        
        <!-- Controls -->
        <div class="controls-section">
            <!-- Search Form -->
            <form class="search-form" method="get" action="">
                <input type="hidden" name="action" value="search">
                <input type="text" name="search" class="form__input" 
                       placeholder="Search suppliers..." 
                       value="<%= request.getAttribute("searchKeyword") != null ? request.getAttribute("searchKeyword") : "" %>">
                <button type="submit" class="btn btn--outline">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
                    </svg>
                    Search
                </button>
            </form>
            
            <!-- Filter Form -->
            <form class="filter-form" method="get" action="">
                <input type="hidden" name="action" value="filter">
                <select name="type" class="form__input">
                    <option value="">All Types</option>
                    <%
                        String[] supplierTypes = (String[]) request.getAttribute("supplierTypes");
                        String currentFilter = (String) request.getAttribute("filterType");
                        if (supplierTypes != null) {
                            for (String type : supplierTypes) {
                                boolean selected = type.equals(currentFilter);
                    %>
                        <option value="<%= type %>" <%= selected ? "selected" : "" %>><%= type %></option>
                    <% } } %>
                </select>
                <button type="submit" class="btn btn--outline">Filter</button>
            </form>
            
            <!-- Clear Filters -->
            <a href="<%= request.getContextPath() %>/manage/suppliers" class="btn btn--ghost">Clear Filters</a>
        </div>
        
        <!-- Suppliers Table -->
        <div class="table-container">
            <table class="suppliers-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Company Name</th>
                        <th>Contact Name</th>
                        <th>Email</th>
                        <th>Type</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Supplier> suppliers = (List<Supplier>) request.getAttribute("suppliers");
                        if (suppliers != null && !suppliers.isEmpty()) {
                            for (Supplier supplier : suppliers) {
                    %>
                        <tr>
                            <td><%= supplier.getId() %></td>
                            <td>
                                <div class="font-medium"><%= supplier.getCompanyName() %></div>
                                <% if (supplier.getWebsite() != null && !supplier.getWebsite().trim().isEmpty()) { %>
                                    <div class="text-sm text-secondary">
                                        <a href="<%= supplier.getWebsite() %>" target="_blank" class="link">
                                            <%= supplier.getWebsite() %>
                                        </a>
                                    </div>
                                <% } %>
                            </td>
                            <td>
                                <div><%= supplier.getContactName() %></div>
                                <% if (supplier.getPhoneNumber() != null && !supplier.getPhoneNumber().trim().isEmpty()) { %>
                                    <div class="text-sm text-secondary"><%= supplier.getPhoneNumber() %></div>
                                <% } %>
                            </td>
                            <td><%= supplier.getEmail() %></td>
                            <td><%= supplier.getSupplierType() %></td>
                            <td>
                                <span class="status-badge <%= supplier.isActive() ? "status-active" : "status-inactive" %>">
                                    <%= supplier.isActive() ? "Active" : "Inactive" %>
                                </span>
                            </td>
                            <td>
                                <div class="action-buttons">
                                    <button class="btn btn--outline btn-sm" 
                                            onclick="openEditModal(<%= supplier.getId() %>)">
                                        Edit
                                    </button>
                                    <button class="btn <%= supplier.isActive() ? "btn--warning" : "btn--success" %> btn-sm" 
                                            onclick="toggleSupplierStatus(<%= supplier.getId() %>, <%= !supplier.isActive() %>)">
                                        <%= supplier.isActive() ? "Deactivate" : "Activate" %>
                                    </button>
                                    <button class="btn btn--danger btn-sm" 
                                            onclick="deleteSupplier(<%= supplier.getId() %>, '<%= supplier.getCompanyName() %>')">
                                        Delete
                                    </button>
                                </div>
                            </td>
                        </tr>
                    <% } } else { %>
                        <tr>
                            <td colspan="7" class="text-center py-8 text-secondary">
                                No suppliers found. <a href="#" onclick="openCreateModal()" class="link">Add the first supplier</a>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </main>
    
    <!-- Create/Edit Supplier Modal -->
    <div id="supplierModal" class="modal">
        <div class="modal-content">
            <div class="flex justify-between items-center mb-6">
                <h2 id="modalTitle" class="text-xl font-bold">Add New Supplier</h2>
                <button onclick="closeModal()" class="btn btn--ghost">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                    </svg>
                </button>
            </div>
            
            <form id="supplierForm" method="post" action="<%= request.getContextPath() %>/manage/suppliers">
                <input type="hidden" id="supplierId" name="supplierId">
                <input type="hidden" id="formAction" name="action" value="create">
                
                <div class="form-grid">
                    <div class="form__group">
                        <label for="contactName" class="form__label required">Contact Name</label>
                        <input type="text" id="contactName" name="contactName" class="form__input" required maxlength="100">
                    </div>
                    
                    <div class="form__group">
                        <label for="companyName" class="form__label required">Company Name</label>
                        <input type="text" id="companyName" name="companyName" class="form__input" required maxlength="200">
                    </div>
                    
                    <div class="form__group">
                        <label for="email" class="form__label required">Email</label>
                        <input type="email" id="email" name="email" class="form__input" required maxlength="100">
                    </div>
                    
                    <div class="form__group">
                        <label for="phoneNumber" class="form__label">Phone Number</label>
                        <input type="tel" id="phoneNumber" name="phoneNumber" class="form__input" maxlength="20">
                    </div>
                    
                    <div class="form__group">
                        <label for="supplierType" class="form__label required">Supplier Type</label>
                        <select id="supplierType" name="supplierType" class="form__input" required>
                            <option value="">Select Type</option>
                            <% if (supplierTypes != null) {
                                for (String type : supplierTypes) { %>
                                    <option value="<%= type %>"><%= type %></option>
                            <% } } %>
                        </select>
                    </div>
                    
                    <div class="form__group">
                        <label for="website" class="form__label">Website</label>
                        <input type="url" id="website" name="website" class="form__input" maxlength="200">
                    </div>
                    
                    <div class="form__group full-width">
                        <label for="addressLine1" class="form__label">Address Line 1</label>
                        <input type="text" id="addressLine1" name="addressLine1" class="form__input" maxlength="200">
                    </div>
                    
                    <div class="form__group full-width">
                        <label for="addressLine2" class="form__label">Address Line 2</label>
                        <input type="text" id="addressLine2" name="addressLine2" class="form__input" maxlength="200">
                    </div>
                    
                    <div class="form__group">
                        <label for="city" class="form__label">City</label>
                        <input type="text" id="city" name="city" class="form__input" maxlength="100">
                    </div>
                    
                    <div class="form__group">
                        <label for="state" class="form__label">State</label>
                        <input type="text" id="state" name="state" class="form__input" maxlength="100">
                    </div>
                    
                    <div class="form__group">
                        <label for="postalCode" class="form__label">Postal Code</label>
                        <input type="text" id="postalCode" name="postalCode" class="form__input" maxlength="20">
                    </div>
                    
                    <div class="form__group">
                        <label for="country" class="form__label">Country</label>
                        <input type="text" id="country" name="country" class="form__input" maxlength="100">
                    </div>
                </div>
                
                <div class="flex gap-2 justify-end mt-6">
                    <button type="button" onclick="closeModal()" class="btn btn--outline">Cancel</button>
                    <button type="submit" class="btn btn--primary">
                        <span id="submitText">Create Supplier</span>
                    </button>
                </div>
            </form>
        </div>
    </div>

    <jsp:include page="../../components/footer.jsp" />
    <script src="<%=request.getContextPath()%>/js/main.js"></script>
    
    <script>
        // JavaScript for modal and supplier management
        let suppliersData = [];
        
        // Initialize suppliers data
        <%
            if (suppliers != null) {
                for (Supplier supplier : suppliers) {
        %>
            suppliersData.push({
                id: <%= supplier.getId() %>,
                contactName: '<%= supplier.getContactName().replace("'", "\\'") %>',
                companyName: '<%= supplier.getCompanyName().replace("'", "\\'") %>',
                email: '<%= supplier.getEmail() %>',
                phoneNumber: '<%= supplier.getPhoneNumber() != null ? supplier.getPhoneNumber().replace("'", "\\'") : "" %>',
                addressLine1: '<%= supplier.getAddressLine1() != null ? supplier.getAddressLine1().replace("'", "\\'") : "" %>',
                addressLine2: '<%= supplier.getAddressLine2() != null ? supplier.getAddressLine2().replace("'", "\\'") : "" %>',
                city: '<%= supplier.getCity() != null ? supplier.getCity().replace("'", "\\'") : "" %>',
                state: '<%= supplier.getState() != null ? supplier.getState().replace("'", "\\'") : "" %>',
                postalCode: '<%= supplier.getPostalCode() != null ? supplier.getPostalCode().replace("'", "\\'") : "" %>',
                country: '<%= supplier.getCountry() != null ? supplier.getCountry().replace("'", "\\'") : "" %>',
                website: '<%= supplier.getWebsite() != null ? supplier.getWebsite().replace("'", "\\'") : "" %>',
                supplierType: '<%= supplier.getSupplierType() %>',
                isActive: <%= supplier.isActive() %>
            });
        <% } } %>
        
        function openCreateModal() {
            document.getElementById('modalTitle').textContent = 'Add New Supplier';
            document.getElementById('formAction').value = 'create';
            document.getElementById('submitText').textContent = 'Create Supplier';
            document.getElementById('supplierForm').reset();
            document.getElementById('supplierId').value = '';
            document.getElementById('supplierModal').classList.add('active');
        }
        
        function openEditModal(supplierId) {
            const supplier = suppliersData.find(s => s.id === supplierId);
            if (!supplier) return;
            
            document.getElementById('modalTitle').textContent = 'Edit Supplier';
            document.getElementById('formAction').value = 'update';
            document.getElementById('submitText').textContent = 'Update Supplier';
            
            // Populate form fields
            document.getElementById('supplierId').value = supplier.id;
            document.getElementById('contactName').value = supplier.contactName;
            document.getElementById('companyName').value = supplier.companyName;
            document.getElementById('email').value = supplier.email;
            document.getElementById('phoneNumber').value = supplier.phoneNumber;
            document.getElementById('addressLine1').value = supplier.addressLine1;
            document.getElementById('addressLine2').value = supplier.addressLine2;
            document.getElementById('city').value = supplier.city;
            document.getElementById('state').value = supplier.state;
            document.getElementById('postalCode').value = supplier.postalCode;
            document.getElementById('country').value = supplier.country;
            document.getElementById('website').value = supplier.website;
            document.getElementById('supplierType').value = supplier.supplierType;
            
            document.getElementById('supplierModal').classList.add('active');
        }
        
        function closeModal() {
            document.getElementById('supplierModal').classList.remove('active');
        }
        
        function toggleSupplierStatus(supplierId, newStatus) {
            const action = newStatus ? 'activate' : 'deactivate';
            if (confirm(`Are you sure you want to ${action} this supplier?`)) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '<%= request.getContextPath() %>/manage/suppliers';
                
                form.innerHTML = `
                    <input type="hidden" name="action" value="updateStatus">
                    <input type="hidden" name="supplierId" value="${supplierId}">
                    <input type="hidden" name="isActive" value="${newStatus}">
                `;
                
                document.body.appendChild(form);
                form.submit();
            }
        }
        
        function deleteSupplier(supplierId, companyName) {
            if (confirm(`Are you sure you want to delete supplier "${companyName}"? This action cannot be undone.`)) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '<%= request.getContextPath() %>/manage/suppliers';
                
                form.innerHTML = `
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="supplierId" value="${supplierId}">
                `;
                
                document.body.appendChild(form);
                form.submit();
            }
        }
        
        // Close modal when clicking outside
        document.getElementById('supplierModal').addEventListener('click', function(e) {
            if (e.target === this) {
                closeModal();
            }
        });
        
        // Form validation
        document.getElementById('supplierForm').addEventListener('submit', function(e) {
            const requiredFields = ['contactName', 'companyName', 'email', 'supplierType'];
            let isValid = true;
            
            requiredFields.forEach(fieldName => {
                const field = document.getElementById(fieldName);
                if (!field.value.trim()) {
                    isValid = false;
                    field.style.borderColor = 'var(--color-error)';
                } else {
                    field.style.borderColor = '';
                }
            });
            
            if (!isValid) {
                e.preventDefault();
                alert('Please fill in all required fields.');
            }
        });
    </script>
</body>
</html>
