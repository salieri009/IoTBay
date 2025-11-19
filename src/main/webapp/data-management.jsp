<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ page import="java.util.*" %>
<%@ page import="model.User" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>

<%
    // Admin authorization check
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null || !"staff".equalsIgnoreCase(currentUser.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<t:base title="Data Management - IoT Bay Admin" description="Admin data import/export, backup/restore, logs">
    <main class="admin-layout">
    <style>
        .admin-layout {
            min-height: 100vh;
            background: linear-gradient(135deg, var(--neutral-50) 0%, var(--neutral-100) 100%);
        }
        
        .admin-container {
            max-width: 1200px;
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
        
        .operations-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
            gap: 2rem;
            margin-bottom: 2rem;
        }
        
        .operation-card {
            background: var(--neutral-0);
            border-radius: var(--border-radius-xl);
            border: 1px solid var(--neutral-200);
            box-shadow: var(--shadow-md);
            overflow: hidden;
            transition: all 0.3s ease;
        }
        
        .operation-card:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-lg);
        }
        
        .card-header {
            padding: 2rem 2rem 1rem;
            background: linear-gradient(135deg, var(--brand-primary-50) 0%, var(--brand-secondary-50) 100%);
        }
        
        .card-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--neutral-800);
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .card-description {
            color: var(--neutral-600);
            line-height: 1.6;
        }
        
        .card-body {
            padding: 2rem;
        }
        
        .upload-area {
            border: 2px dashed var(--neutral-300);
            border-radius: var(--border-radius-lg);
            padding: 3rem 2rem;
            text-align: center;
            transition: all 0.3s ease;
            cursor: pointer;
            margin-bottom: 2rem;
        }
        
        .upload-area:hover {
            border-color: var(--brand-primary);
            background: var(--brand-primary-50);
        }
        
        .upload-area.dragover {
            border-color: var(--brand-primary);
            background: var(--brand-primary-100);
        }
        
        .upload-icon {
            width: 3rem;
            height: 3rem;
            color: var(--neutral-400);
            margin: 0 auto 1rem;
        }
        
        .upload-text {
            font-size: 1.125rem;
            font-weight: 500;
            color: var(--neutral-700);
            margin-bottom: 0.5rem;
        }
        
        .upload-hint {
            color: var(--neutral-500);
            font-size: 0.875rem;
        }
        
        .file-input {
            display: none;
        }
        
        .entity-selector {
            margin-bottom: 2rem;
        }
        
        .entity-selector label {
            display: block;
            font-weight: 500;
            color: var(--neutral-700);
            margin-bottom: 0.5rem;
        }
        
        .entity-select {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid var(--neutral-300);
            border-radius: var(--border-radius-lg);
            font-size: 0.875rem;
            background: var(--neutral-0);
        }
        
        .progress-container {
            display: none;
            margin: 1rem 0;
        }
        
        .progress-bar {
            width: 100%;
            height: 0.5rem;
            background: var(--neutral-200);
            border-radius: var(--border-radius-full);
            overflow: hidden;
        }
        
        .progress-fill {
            height: 100%;
            background: var(--brand-gradient);
            width: 0%;
            transition: width 0.3s ease;
        }
        
        .progress-text {
            text-align: center;
            margin-top: 0.5rem;
            font-size: 0.875rem;
            color: var(--neutral-600);
        }
        
        .results-container {
            display: none;
            margin-top: 2rem;
        }
        
        .results-header {
            display: flex;
            justify-content: between;
            align-items: center;
            margin-bottom: 1rem;
        }
        
        .results-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--neutral-800);
        }
        
        .results-summary {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(120px, 1fr));
            gap: 1rem;
            margin-bottom: 2rem;
        }
        
        .summary-item {
            background: var(--neutral-50);
            padding: 1rem;
            border-radius: var(--border-radius-lg);
            text-align: center;
        }
        
        .summary-number {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 0.25rem;
        }
        
        .summary-number.success {
            color: var(--success);
        }
        
        .summary-number.error {
            color: var(--error);
        }
        
        .summary-number.warning {
            color: var(--warning);
        }
        
        .summary-label {
            font-size: 0.75rem;
            color: var(--neutral-600);
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }
        
        .error-list {
            background: var(--error-light);
            border: 1px solid var(--error);
            border-radius: var(--border-radius-lg);
            padding: 1rem;
            max-height: 300px;
            overflow-y: auto;
        }
        
        .error-item {
            padding: 0.5rem 0;
            border-bottom: 1px solid var(--error-200);
            font-size: 0.875rem;
            color: var(--error-dark);
        }
        
        .error-item:last-child {
            border-bottom: none;
        }
        
        .export-options {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-bottom: 2rem;
        }
        
        .export-option {
            background: var(--neutral-50);
            border: 1px solid var(--neutral-200);
            border-radius: var(--border-radius-lg);
            padding: 1.5rem;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .export-option:hover {
            background: var(--brand-primary-50);
            border-color: var(--brand-primary-200);
        }
        
        .export-icon {
            width: 2rem;
            height: 2rem;
            color: var(--neutral-600);
            margin: 0 auto 1rem;
        }
        
        .export-title {
            font-weight: 600;
            color: var(--neutral-800);
            margin-bottom: 0.5rem;
        }
        
        .export-description {
            font-size: 0.875rem;
            color: var(--neutral-600);
        }
        
        .backup-section {
            background: var(--neutral-0);
            border-radius: var(--border-radius-xl);
            border: 1px solid var(--neutral-200);
            box-shadow: var(--shadow-md);
            padding: 2rem;
            margin-bottom: 2rem;
        }
        
        .backup-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }
        
        .backup-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--neutral-800);
        }
        
        .backup-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
        }
        
        .backup-option {
            background: var(--neutral-50);
            border: 1px solid var(--neutral-200);
            border-radius: var(--border-radius-lg);
            padding: 1.5rem;
            text-align: center;
        }
        
        .backup-option-title {
            font-weight: 600;
            color: var(--neutral-800);
            margin-bottom: 1rem;
        }
        
        .backup-option-description {
            font-size: 0.875rem;
            color: var(--neutral-600);
            margin-bottom: 1.5rem;
        }
        
        .logs-section {
            background: var(--neutral-0);
            border-radius: var(--border-radius-xl);
            border: 1px solid var(--neutral-200);
            box-shadow: var(--shadow-md);
            padding: 2rem;
        }
        
        .logs-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }
        
        .logs-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--neutral-800);
        }
        
        .logs-table {
            width: 100%;
            border-collapse: collapse;
        }
        
        .logs-table th,
        .logs-table td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid var(--neutral-200);
        }
        
        .logs-table th {
            background: var(--neutral-50);
            font-weight: 600;
            color: var(--neutral-700);
            font-size: 0.875rem;
        }
        
        .logs-table td {
            color: var(--neutral-600);
            font-size: 0.875rem;
        }
        
        .log-status {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            border-radius: var(--border-radius-full);
            font-size: 0.75rem;
            font-weight: 500;
            text-transform: uppercase;
        }
        
        .log-status.success {
            background: var(--success-light);
            color: var(--success-dark);
        }
        
        .log-status.error {
            background: var(--error-light);
            color: var(--error-dark);
        }
        
        .log-status.processing {
            background: var(--warning-light);
            color: var(--warning-dark);
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
            
            .operations-grid {
                grid-template-columns: 1fr;
            }
            
            .export-options {
                grid-template-columns: 1fr;
            }
            
            .backup-grid {
                grid-template-columns: 1fr;
            }
            
            .results-summary {
                grid-template-columns: repeat(2, 1fr);
            }
        }
    </style>
    
    <c:import url="/components/organisms/header/header.jsp" />
    
    <main class="admin-layout">
        <div class="admin-container">
            <!-- Page Header -->
            <header class="page-header">
                <div>
                    <h1 class="page-title">Data Management</h1>
                    <p class="page-subtitle">Bulk import/export operations and data backup tools</p>
                </div>
                <button class="btn btn--outline" onclick="window.location.reload()">
                    <svg style="width: 1rem; height: 1rem; margin-right: 0.5rem;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"/>
                    </svg>
                    Refresh
                </button>
            </header>
            
            <!-- Main Operations -->
            <section class="operations-grid">
                <!-- Import Data -->
                <div class="operation-card">
                    <div class="card-header">
                        <h3 class="card-title">
                            <svg style="width: 1.5rem; height: 1.5rem;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M9 19l3 3m0 0l3-3m-3 3V10"/>
                            </svg>
                            Import Data
                        </h3>
                        <p class="card-description">Upload CSV files to bulk import users, products, or suppliers</p>
                    </div>
                    <div class="card-body">
                        <div class="entity-selector">
                            <label for="importEntityType">Select Data Type:</label>
                            <select class="entity-select" id="importEntityType">
                                <option value="">Choose entity type...</option>
                                <option value="users">Users</option>
                                <option value="products">Products</option>
                                <option value="suppliers">Suppliers</option>
                                <option value="orders">Orders</option>
                                <option value="categories">Categories</option>
                            </select>
                        </div>
                        
                        <div class="upload-area" id="uploadArea" onclick="document.getElementById('fileInput').click()">
                            <svg class="upload-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12"/>
                            </svg>
                            <div class="upload-text">Drop CSV file here or click to browse</div>
                            <div class="upload-hint">Supported formats: CSV (max 10MB)</div>
                            <input type="file" id="fileInput" class="file-input" accept=".csv" onchange="handleFileSelect(event)">
                        </div>
                        
                        <div class="progress-container" id="importProgress">
                            <div class="progress-bar">
                                <div class="progress-fill" id="importProgressFill"></div>
                            </div>
                            <div class="progress-text" id="importProgressText">Processing...</div>
                        </div>
                        
                        <div class="results-container" id="importResults">
                            <div class="results-header">
                                <h4 class="results-title">Import Results</h4>
                            </div>
                            <div class="results-summary">
                                <div class="summary-item">
                                    <div class="summary-number success" id="successCount">0</div>
                                    <div class="summary-label">Successful</div>
                                </div>
                                <div class="summary-item">
                                    <div class="summary-number error" id="errorCount">0</div>
                                    <div class="summary-label">Errors</div>
                                </div>
                                <div class="summary-item">
                                    <div class="summary-number warning" id="skippedCount">0</div>
                                    <div class="summary-label">Skipped</div>
                                </div>
                            </div>
                            <div class="error-list" id="errorList" style="display: none;">
                                <!-- Error items will be populated here -->
                            </div>
                        </div>
                        
                        <button class="btn btn--primary w-full" id="importBtn" onclick="startImport()" disabled>
                            Start Import
                        </button>
                    </div>
                </div>
                
                <!-- Export Data -->
                <div class="operation-card">
                    <div class="card-header">
                        <h3 class="card-title">
                            <svg style="width: 1.5rem; height: 1.5rem;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12"/>
                            </svg>
                            Export Data
                        </h3>
                        <p class="card-description">Download system data in CSV format for backup or analysis</p>
                    </div>
                    <div class="card-body">
                        <div class="export-options">
                            <div class="export-option" onclick="exportData('users')">
                                <svg class="export-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197m13.5-9a2.5 2.5 0 11-5 0 2.5 2.5 0 015 0z"/>
                                </svg>
                                <div class="export-title">Users</div>
                                <div class="export-description">All user accounts and profiles</div>
                            </div>
                            
                            <div class="export-option" onclick="exportData('products')">
                                <svg class="export-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4"/>
                                </svg>
                                <div class="export-title">Products</div>
                                <div class="export-description">Product catalog with details</div>
                            </div>
                            
                            <div class="export-option" onclick="exportData('orders')">
                                <svg class="export-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z"/>
                                </svg>
                                <div class="export-title">Orders</div>
                                <div class="export-description">Order history and transactions</div>
                            </div>
                            
                            <div class="export-option" onclick="exportData('suppliers')">
                                <svg class="export-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"/>
                                </svg>
                                <div class="export-title">Suppliers</div>
                                <div class="export-description">Supplier information and contacts</div>
                            </div>
                        </div>
                        
                        <button class="btn btn--outline w-full" onclick="exportAll()">
                            <svg style="width: 1rem; height: 1rem; margin-right: 0.5rem;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 10v6m0 0l-3-3m3 3l3-3M3 17V7a2 2 0 012-2h6l2 2h6a2 2 0 012 2v10a2 2 0 01-2 2H5a2 2 0 01-2-2z"/>
                            </svg>
                            Export All Data (ZIP)
                        </button>
                    </div>
                </div>
            </section>
            
            <!-- Backup & Restore -->
            <section class="backup-section" id="backup">
                <div class="backup-header">
                    <h3 class="backup-title">
                        <svg style="width: 1.5rem; height: 1.5rem; margin-right: 0.5rem;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7H5a2 2 0 00-2 2v9a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2h-3m-1 4l-3-3m0 0l-3 3m3-3v12"/>
                        </svg>
                        System Backup & Restore
                    </h3>
                    <span class="text-sm text-neutral-600">Last backup: <span id="lastBackupTime">Never</span></span>
                </div>
                
                <div class="backup-grid">
                    <div class="backup-option">
                        <div class="backup-option-title">Full System Backup</div>
                        <div class="backup-option-description">
                            Complete backup including all data, configurations, and user files
                        </div>
                        <button class="btn btn--primary w-full" onclick="createBackup('full')">
                            Create Full Backup
                        </button>
                    </div>
                    
                    <div class="backup-option">
                        <div class="backup-option-title">Data Only Backup</div>
                        <div class="backup-option-description">
                            Backup only database content (users, products, orders, etc.)
                        </div>
                        <button class="btn btn--outline w-full" onclick="createBackup('data')">
                            Create Data Backup
                        </button>
                    </div>
                    
                    <div class="backup-option">
                        <div class="backup-option-title">Restore from Backup</div>
                        <div class="backup-option-description">
                            Restore system from a previous backup file
                        </div>
                        <button class="btn btn--secondary w-full" onclick="showRestoreModal()">
                            Restore System
                        </button>
                    </div>
                </div>
            </section>
            
            <!-- Operation Logs -->
            <section class="logs-section">
                <div class="logs-header">
                    <h3 class="logs-title">Recent Data Operations</h3>
                    <button class="btn btn--outline btn--sm" onclick="refreshLogs()">
                        <svg style="width: 1rem; height: 1rem; margin-right: 0.25rem;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"/>
                        </svg>
                        Refresh
                    </button>
                </div>
                
                <table class="logs-table">
                    <thead>
                        <tr>
                            <th>Operation</th>
                            <th>Entity Type</th>
                            <th>Records</th>
                            <th>Status</th>
                            <th>User</th>
                            <th>Date</th>
                        </tr>
                    </thead>
                    <tbody id="logsTableBody">
                        <!-- Sample Log Entries -->
                        <tr>
                            <td>Import</td>
                            <td>Products</td>
                            <td>245</td>
                            <td><span class="log-status success">Success</span></td>
                            <td>Admin User</td>
                            <td>2024-01-15 14:30</td>
                        </tr>
                        <tr>
                            <td>Export</td>
                            <td>Users</td>
                            <td>1,234</td>
                            <td><span class="log-status success">Success</span></td>
                            <td>Admin User</td>
                            <td>2024-01-15 10:15</td>
                        </tr>
                        <tr>
                            <td>Import</td>
                            <td>Suppliers</td>
                            <td>15</td>
                            <td><span class="log-status error">Failed</span></td>
                            <td>Staff User</td>
                            <td>2024-01-14 16:45</td>
                        </tr>
                        <tr>
                            <td>Backup</td>
                            <td>Full System</td>
                            <td>-</td>
                            <td><span class="log-status success">Success</span></td>
                            <td>Admin User</td>
                            <td>2024-01-14 02:00</td>
                        </tr>
                    </tbody>
                </table>
            </section>
        </div>
    </main>
    
    <c:import url="/components/organisms/footer/footer.jsp" />
    
    <script>
        // File Upload Handling
        let selectedFile = null;
        
        // Drag and Drop functionality
        const uploadArea = document.getElementById('uploadArea');
        
        ['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
            uploadArea.addEventListener(eventName, preventDefaults, false);
        });
        
        function preventDefaults(e) {
            e.preventDefault();
            e.stopPropagation();
        }
        
        ['dragenter', 'dragover'].forEach(eventName => {
            uploadArea.addEventListener(eventName, highlight, false);
        });
        
        ['dragleave', 'drop'].forEach(eventName => {
            uploadArea.addEventListener(eventName, unhighlight, false);
        });
        
        function highlight(e) {
            uploadArea.classList.add('dragover');
        }
        
        function unhighlight(e) {
            uploadArea.classList.remove('dragover');
        }
        
        uploadArea.addEventListener('drop', handleDrop, false);
        
        function handleDrop(e) {
            const dt = e.dataTransfer;
            const files = dt.files;
            
            if (files.length > 0) {
                handleFileSelect({ target: { files: files } });
            }
        }
        
        function handleFileSelect(event) {
            const file = event.target.files[0];
            if (file) {
                if (file.type !== 'text/csv' && !file.name.endsWith('.csv')) {
                    alert('Please select a valid CSV file.');
                    return;
                }
                
                if (file.size > 10 * 1024 * 1024) { // 10MB limit
                    alert('File size must be less than 10MB.');
                    return;
                }
                
                selectedFile = file;
                updateUploadArea(file.name);
                
                const entityType = document.getElementById('importEntityType').value;
                const importBtn = document.getElementById('importBtn');
                importBtn.disabled = !entityType;
            }
        }
        
        function updateUploadArea(fileName) {
            const uploadArea = document.getElementById('uploadArea');
            uploadArea.innerHTML = `
                <svg class="upload-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                </svg>
                <div class="upload-text">Selected: ${fileName}</div>
                <div class="upload-hint">Click to select a different file</div>
            `;
        }
        
        // Entity type change handler
        document.getElementById('importEntityType').addEventListener('change', function() {
            const importBtn = document.getElementById('importBtn');
            importBtn.disabled = !(this.value && selectedFile);
        });
        
        // Import Functions
        function startImport() {
            const entityType = document.getElementById('importEntityType').value;
            if (!entityType || !selectedFile) {
                alert('Please select both entity type and file.');
                return;
            }
            
            // Show progress
            document.getElementById('importProgress').style.display = 'block';
            document.getElementById('importResults').style.display = 'none';
            
            // Simulate import process
            simulateImport(entityType, selectedFile);
        }
        
        function simulateImport(entityType, file) {
            const progressFill = document.getElementById('importProgressFill');
            const progressText = document.getElementById('importProgressText');
            let progress = 0;
            
            const interval = setInterval(() => {
                progress += Math.random() * 15;
                if (progress > 100) progress = 100;
                
                progressFill.style.width = progress + '%';
                progressText.textContent = `Processing ${entityType}... ${Math.round(progress)}%`;
                
                if (progress >= 100) {
                    clearInterval(interval);
                    setTimeout(() => {
                        showImportResults(entityType);
                    }, 500);
                }
            }, 200);
        }
        
        function showImportResults(entityType) {
            document.getElementById('importProgress').style.display = 'none';
            
            // Simulate results
            const totalRecords = Math.floor(Math.random() * 500) + 50;
            const errors = Math.floor(Math.random() * 10);
            const skipped = Math.floor(Math.random() * 5);
            const successful = totalRecords - errors - skipped;
            
            document.getElementById('successCount').textContent = successful;
            document.getElementById('errorCount').textContent = errors;
            document.getElementById('skippedCount').textContent = skipped;
            
            if (errors > 0) {
                const errorList = document.getElementById('errorList');
                errorList.style.display = 'block';
                errorList.innerHTML = '';
                
                for (let i = 0; i < Math.min(errors, 5); i++) {
                    const errorDiv = document.createElement('div');
                    errorDiv.className = 'error-item';
                    const columnName = entityType === 'users' ? 'email' : 'name';
                    errorDiv.textContent = `Row ${Math.floor(Math.random() * totalRecords) + 1}: Invalid data format in column '${columnName}'`;
                    errorList.appendChild(errorDiv);
                }
            }
            
            document.getElementById('importResults').style.display = 'block';
            
            // Add to logs
            addOperationLog('Import', entityType, totalRecords, errors > 0 ? 'error' : 'success');
            
            showNotification(`Import completed! ${successful} records processed successfully.`, errors > 0 ? 'warning' : 'success');
        }
        
        // Export Functions
        function exportData(entityType) {
            showNotification(`Preparing ${entityType} export...`, 'info');
            
            // Simulate export process
            setTimeout(() => {
                const recordCount = Math.floor(Math.random() * 1000) + 100;
                
                // Create and trigger download (simulation)
                const filename = `${entityType}_export_${new Date().toISOString().split('T')[0]}.csv`;
                
                // In a real implementation, this would trigger an actual file download
                showNotification(`${entityType} export completed! ${recordCount} records exported.`, 'success');
                
                // Add to logs
                addOperationLog('Export', entityType, recordCount, 'success');
            }, 2000);
        }
        
        function exportAll() {
            showNotification('Preparing complete system export...', 'info');
            
            setTimeout(() => {
                showNotification('Complete system export ready for download!', 'success');
                addOperationLog('Export', 'All Data', '-', 'success');
            }, 5000);
        }
        
        // Backup Functions
        function createBackup(type) {
            const backupType = type === 'full' ? 'Full System' : 'Data Only';
            showNotification(`Creating ${backupType.toLowerCase()} backup...`, 'info');
            
            setTimeout(() => {
                const timestamp = new Date().toLocaleString();
                document.getElementById('lastBackupTime').textContent = timestamp;
                showNotification(`${backupType} backup completed successfully!`, 'success');
                
                addOperationLog('Backup', backupType, '-', 'success');
            }, 3000);
        }
        
        function showRestoreModal() {
            // This would open a modal for file selection and restore options
            alert('Restore functionality would open a modal for selecting backup files and restore options.');
        }
        
        // Utility Functions
        function addOperationLog(operation, entityType, records, status) {
            const tbody = document.getElementById('logsTableBody');
            const row = document.createElement('tr');
            
            const timestamp = new Date().toLocaleString();
            const user = 'Current User'; // Would get from session
            
            row.innerHTML = `
                <td>${operation}</td>
                <td>${entityType}</td>
                <td>${records}</td>
                <td><span class="log-status ${status}">${status.charAt(0).toUpperCase() + status.slice(1)}</span></td>
                <td>${user}</td>
                <td>${timestamp}</td>
            `;
            
            tbody.insertBefore(row, tbody.firstChild);
            
            // Keep only last 10 entries
            while (tbody.children.length > 10) {
                tbody.removeChild(tbody.lastChild);
            }
        }
        
        function refreshLogs() {
            showNotification('Logs refreshed', 'info');
        }
        
        function showNotification(message, type = 'info') {
            const notification = document.createElement('div');
            notification.className = `notification notification--${type}`;
            notification.textContent = message;
            notification.style.cssText = `
                position: fixed;
                top: 2rem;
                right: 2rem;
                padding: 1rem 1.5rem;
                background: ${type === 'success' ? 'var(--success)' : type === 'warning' ? 'var(--warning)' : 'var(--brand-primary)'};
                color: var(--neutral-0);
                border-radius: var(--border-radius-lg);
                box-shadow: var(--shadow-lg);
                z-index: 2000;
                animation: slideIn 0.3s ease;
            `;
            
            document.body.appendChild(notification);
            
            setTimeout(() => {
                notification.remove();
            }, 4000);
        }
        
        // Initialize page
        document.addEventListener('DOMContentLoaded', function() {
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
                
                .w-full {
                    width: 100%;
                }
                
                .btn--sm {
                    padding: 0.5rem 1rem;
                    font-size: 0.875rem;
                }
            `;
            document.head.appendChild(style);
            
            // Set last backup time (would come from backend)
            const lastBackup = localStorage.getItem('lastBackupTime');
            if (lastBackup) {
                document.getElementById('lastBackupTime').textContent = lastBackup;
            }
        });
    </script>
    </main>
</t:base>
