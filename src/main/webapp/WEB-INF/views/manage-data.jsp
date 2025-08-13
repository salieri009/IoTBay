<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="service.DataManagementService.ImportResult" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Data Management - IoT Bay Admin</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/modern-theme.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;900&display=swap" rel="stylesheet">
    <style>
        .admin-container {
            max-width: 1200px;
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
        
        .data-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 2rem;
            margin-bottom: 2rem;
        }
        
        .data-section {
            background: var(--color-surface);
            padding: 2rem;
            border-radius: var(--border-radius-lg);
            border: 1px solid var(--color-border);
        }
        
        .section-title {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 1rem;
            color: var(--color-text-primary);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .entity-list {
            display: grid;
            gap: 1rem;
        }
        
        .entity-item {
            display: flex;
            justify-content: between;
            align-items: center;
            padding: 1rem;
            background: var(--color-background-secondary);
            border-radius: var(--border-radius);
            border: 1px solid var(--color-border);
        }
        
        .entity-info {
            flex: 1;
        }
        
        .entity-name {
            font-weight: 600;
            color: var(--color-text-primary);
            margin-bottom: 0.25rem;
        }
        
        .entity-description {
            font-size: 0.875rem;
            color: var(--color-text-secondary);
        }
        
        .entity-actions {
            display: flex;
            gap: 0.5rem;
        }
        
        .upload-area {
            border: 2px dashed var(--color-border);
            border-radius: var(--border-radius-lg);
            padding: 2rem;
            text-align: center;
            margin: 1rem 0;
            transition: all 0.3s ease;
            cursor: pointer;
        }
        
        .upload-area:hover {
            border-color: var(--color-primary);
            background: var(--color-background-secondary);
        }
        
        .upload-area.dragover {
            border-color: var(--color-primary);
            background: var(--color-primary-light);
        }
        
        .upload-icon {
            width: 3rem;
            height: 3rem;
            margin: 0 auto 1rem;
            color: var(--color-text-secondary);
        }
        
        .file-input {
            display: none;
        }
        
        .selected-file {
            background: var(--color-success-light);
            border: 1px solid var(--color-success);
            padding: 1rem;
            border-radius: var(--border-radius);
            margin: 1rem 0;
            display: none;
        }
        
        .selected-file.active {
            display: block;
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
        
        .alert-warning {
            background: var(--color-warning-light);
            color: var(--color-warning-dark);
            border: 1px solid var(--color-warning);
        }
        
        .alert-error {
            background: var(--color-error-light);
            color: var(--color-error-dark);
            border: 1px solid var(--color-error);
        }
        
        .alert-info {
            background: var(--color-info-light);
            color: var(--color-info-dark);
            border: 1px solid var(--color-info);
        }
        
        .error-list {
            max-height: 200px;
            overflow-y: auto;
            background: var(--color-background);
            border: 1px solid var(--color-border);
            border-radius: var(--border-radius);
            padding: 1rem;
            margin-top: 1rem;
        }
        
        .error-item {
            padding: 0.5rem 0;
            border-bottom: 1px solid var(--color-border);
            font-family: monospace;
            font-size: 0.875rem;
        }
        
        .error-item:last-child {
            border-bottom: none;
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 1rem;
            margin: 1rem 0;
        }
        
        .stat-card {
            background: var(--color-background);
            padding: 1rem;
            border-radius: var(--border-radius);
            text-align: center;
            border: 1px solid var(--color-border);
        }
        
        .stat-number {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 0.25rem;
        }
        
        .stat-label {
            font-size: 0.875rem;
            color: var(--color-text-secondary);
        }
        
        .btn-sm {
            padding: 0.5rem 1rem;
            font-size: 0.875rem;
        }
        
        .instructions {
            background: var(--color-info-light);
            border: 1px solid var(--color-info);
            border-radius: var(--border-radius);
            padding: 1rem;
            margin-bottom: 2rem;
        }
        
        .instructions h3 {
            margin: 0 0 0.5rem 0;
            color: var(--color-info-dark);
        }
        
        .instructions ul {
            margin: 0;
            padding-left: 1.5rem;
            color: var(--color-info-dark);
        }
        
        .instructions li {
            margin-bottom: 0.25rem;
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
                <h1 class="text-3xl font-bold text-primary">Data Management</h1>
                <p class="text-secondary">Import and export bulk data for system entities</p>
            </div>
        </div>
        
        <!-- Instructions -->
        <div class="instructions">
            <h3>📋 Data Management Instructions</h3>
            <ul>
                <li><strong>Export:</strong> Download current data as CSV files for backup or analysis</li>
                <li><strong>Import:</strong> Upload CSV files to bulk create new records (existing IDs will be ignored)</li>
                <li><strong>File Format:</strong> CSV files must match the exact column format from exports</li>
                <li><strong>Validation:</strong> All data is validated during import - invalid records will be reported</li>
                <li><strong>Backup:</strong> Always export current data before performing bulk imports</li>
            </ul>
        </div>
        
        <!-- Success/Warning/Error Messages -->
        <%
            String success = (String) request.getAttribute("success");
            String warning = (String) request.getAttribute("warning");
            String error = (String) request.getAttribute("error");
            ImportResult importResult = (ImportResult) request.getAttribute("importResult");
            String entityType = (String) request.getAttribute("entityType");
            String fileName = (String) request.getAttribute("fileName");
        %>
        
        <% if (success != null) { %>
            <div class="alert alert-success">
                <strong>Success!</strong> <%= success %>
            </div>
        <% } %>
        
        <% if (warning != null) { %>
            <div class="alert alert-warning">
                <strong>Warning!</strong> <%= warning %>
            </div>
        <% } %>
        
        <% if (error != null) { %>
            <div class="alert alert-error">
                <strong>Error!</strong> <%= error %>
            </div>
        <% } %>
        
        <!-- Import Results -->
        <% if (importResult != null) { %>
            <div class="alert alert-info">
                <strong>Import Results for <%= entityType %> (File: <%= fileName %>)</strong>
                
                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-number text-success"><%= importResult.getSuccessCount() %></div>
                        <div class="stat-label">Successful</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-number text-error"><%= importResult.getErrorCount() %></div>
                        <div class="stat-label">Errors</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-number text-primary"><%= importResult.getTotalProcessed() %></div>
                        <div class="stat-label">Total Processed</div>
                    </div>
                </div>
                
                <% if (importResult.hasErrors()) { %>
                    <h4>Error Details:</h4>
                    <div class="error-list">
                        <% for (String errorMsg : importResult.getErrors()) { %>
                            <div class="error-item"><%= errorMsg %></div>
                        <% } %>
                    </div>
                <% } %>
            </div>
        <% } %>
        
        <!-- Data Management Grid -->
        <div class="data-grid">
            <!-- Export Section -->
            <div class="data-section">
                <h2 class="section-title">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 10v6m0 0l-3-3m3 3l3-3m2 8H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                    </svg>
                    Export Data
                </h2>
                <p class="text-secondary mb-4">Download current data as CSV files</p>
                
                <div class="entity-list">
                    <!-- Users Export -->
                    <div class="entity-item">
                        <div class="entity-info">
                            <div class="entity-name">Users</div>
                            <div class="entity-description">Export all user accounts and profiles</div>
                        </div>
                        <div class="entity-actions">
                            <a href="<%= request.getContextPath() %>/manage/data?action=export&entity=users" 
                               class="btn btn--primary btn-sm">
                                <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 10v6m0 0l-3-3m3 3l3-3"></path>
                                </svg>
                                Export CSV
                            </a>
                        </div>
                    </div>
                    
                    <!-- Products Export -->
                    <div class="entity-item">
                        <div class="entity-info">
                            <div class="entity-name">Products</div>
                            <div class="entity-description">Export all IoT devices and product catalog</div>
                        </div>
                        <div class="entity-actions">
                            <a href="<%= request.getContextPath() %>/manage/data?action=export&entity=products" 
                               class="btn btn--primary btn-sm">
                                <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 10v6m0 0l-3-3m3 3l3-3"></path>
                                </svg>
                                Export CSV
                            </a>
                        </div>
                    </div>
                    
                    <!-- Suppliers Export -->
                    <div class="entity-item">
                        <div class="entity-info">
                            <div class="entity-name">Suppliers</div>
                            <div class="entity-description">Export all supplier information and contacts</div>
                        </div>
                        <div class="entity-actions">
                            <a href="<%= request.getContextPath() %>/manage/data?action=export&entity=suppliers" 
                               class="btn btn--primary btn-sm">
                                <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 10v6m0 0l-3-3m3 3l3-3"></path>
                                </svg>
                                Export CSV
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Import Section -->
            <div class="data-section">
                <h2 class="section-title">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M9 19l3 3m0 0l3-3m-3 3V10"></path>
                    </svg>
                    Import Data
                </h2>
                <p class="text-secondary mb-4">Upload CSV files to bulk create records</p>
                
                <!-- Import Form -->
                <form id="importForm" method="post" action="<%= request.getContextPath() %>/manage/data" 
                      enctype="multipart/form-data">
                    <input type="hidden" name="action" value="import">
                    
                    <!-- Entity Type Selection -->
                    <div class="form__group">
                        <label for="entityType" class="form__label required">Data Type</label>
                        <select id="entityType" name="entity" class="form__input" required>
                            <option value="">Select data type to import</option>
                            <option value="users">Users</option>
                            <option value="products">Products</option>
                            <option value="suppliers">Suppliers</option>
                        </select>
                    </div>
                    
                    <!-- File Upload Area -->
                    <div class="upload-area" onclick="document.getElementById('csvFile').click()">
                        <svg class="upload-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12"></path>
                        </svg>
                        <div>
                            <p class="text-lg font-medium">Click to select CSV file</p>
                            <p class="text-sm text-secondary">or drag and drop here</p>
                            <p class="text-xs text-secondary mt-2">Maximum file size: 10MB</p>
                        </div>
                    </div>
                    
                    <input type="file" id="csvFile" name="csvFile" class="file-input" 
                           accept=".csv,text/csv" required>
                    
                    <!-- Selected File Display -->
                    <div id="selectedFile" class="selected-file">
                        <div class="flex items-center justify-between">
                            <div>
                                <strong>Selected file:</strong> <span id="fileName"></span>
                                <br>
                                <small class="text-secondary">Size: <span id="fileSize"></span></small>
                            </div>
                            <button type="button" onclick="clearFile()" class="btn btn--ghost btn-sm">
                                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                                </svg>
                            </button>
                        </div>
                    </div>
                    
                    <!-- Submit Button -->
                    <div class="flex gap-2 justify-end mt-4">
                        <button type="button" onclick="clearForm()" class="btn btn--outline">
                            Clear
                        </button>
                        <button type="submit" class="btn btn--primary" id="submitBtn" disabled>
                            <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M9 19l3 3m0 0l3-3m-3 3V10"></path>
                            </svg>
                            Import Data
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </main>

    <jsp:include page="../../components/footer.jsp" />
    <script src="<%=request.getContextPath()%>/js/main.js"></script>
    
    <script>
        // File upload handling
        const csvFileInput = document.getElementById('csvFile');
        const selectedFileDiv = document.getElementById('selectedFile');
        const fileName = document.getElementById('fileName');
        const fileSize = document.getElementById('fileSize');
        const submitBtn = document.getElementById('submitBtn');
        const uploadArea = document.querySelector('.upload-area');
        const entityTypeSelect = document.getElementById('entityType');
        
        // File input change handler
        csvFileInput.addEventListener('change', function(e) {
            const file = e.target.files[0];
            if (file) {
                displaySelectedFile(file);
            }
        });
        
        // Entity type change handler
        entityTypeSelect.addEventListener('change', function() {
            updateSubmitButton();
        });
        
        // Drag and drop handlers
        uploadArea.addEventListener('dragover', function(e) {
            e.preventDefault();
            uploadArea.classList.add('dragover');
        });
        
        uploadArea.addEventListener('dragleave', function(e) {
            e.preventDefault();
            uploadArea.classList.remove('dragover');
        });
        
        uploadArea.addEventListener('drop', function(e) {
            e.preventDefault();
            uploadArea.classList.remove('dragover');
            
            const files = e.dataTransfer.files;
            if (files.length > 0) {
                const file = files[0];
                if (file.type === 'text/csv' || file.name.endsWith('.csv')) {
                    csvFileInput.files = files;
                    displaySelectedFile(file);
                } else {
                    alert('Please upload a CSV file.');
                }
            }
        });
        
        function displaySelectedFile(file) {
            fileName.textContent = file.name;
            fileSize.textContent = formatFileSize(file.size);
            selectedFileDiv.classList.add('active');
            updateSubmitButton();
        }
        
        function clearFile() {
            csvFileInput.value = '';
            selectedFileDiv.classList.remove('active');
            updateSubmitButton();
        }
        
        function clearForm() {
            csvFileInput.value = '';
            entityTypeSelect.value = '';
            selectedFileDiv.classList.remove('active');
            updateSubmitButton();
        }
        
        function updateSubmitButton() {
            const hasFile = csvFileInput.files.length > 0;
            const hasEntityType = entityTypeSelect.value !== '';
            submitBtn.disabled = !(hasFile && hasEntityType);
        }
        
        function formatFileSize(bytes) {
            if (bytes === 0) return '0 Bytes';
            const k = 1024;
            const sizes = ['Bytes', 'KB', 'MB', 'GB'];
            const i = Math.floor(Math.log(bytes) / Math.log(k));
            return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
        }
        
        // Form submission handler
        document.getElementById('importForm').addEventListener('submit', function(e) {
            const file = csvFileInput.files[0];
            if (file && file.size > 10 * 1024 * 1024) { // 10MB
                e.preventDefault();
                alert('File size exceeds 10MB limit. Please upload a smaller file.');
                return;
            }
            
            if (!confirm('Are you sure you want to import this data? This will create new records in the database.')) {
                e.preventDefault();
                return;
            }
            
            // Show loading state
            submitBtn.disabled = true;
            submitBtn.innerHTML = '<svg class="w-4 h-4 mr-2 animate-spin" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 2v4m0 12v4m8-8h-4M4 12H0m18.364-5.636l-2.828 2.828M8.464 8.464L5.636 5.636m12.728 12.728l-2.828-2.828M8.464 15.536L5.636 18.364"></path></svg>Importing...';
        });
        
        // Initialize
        updateSubmitButton();
    </script>
</body>
</html>
