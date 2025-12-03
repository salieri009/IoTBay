<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
    <%@ page import="java.util.*" %>
        <%@ page import="model.User" %>
            <%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>

                <% // Admin authorization check User currentUser=(User) session.getAttribute("user"); if
                    (currentUser==null || !"staff".equalsIgnoreCase(currentUser.getRole())) {
                    response.sendRedirect(request.getContextPath() + "/login.jsp" ); return; } %>

                    <t:base title="Data Management - IoT Bay Admin"
                        description="Admin data import/export, backup/restore, logs">
                        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/data-management.css">
                        <main class="admin-layout">
                            <div class="admin-container">
                                <!-- Page Header -->
                                <header class="page-header">
                                    <div>
                                        <h1 class="page-title">Data Management</h1>
                                        <p class="page-subtitle">Bulk import/export operations and data backup tools</p>
                                    </div>
                                    <button class="btn btn--outline" onclick="window.location.reload()">
                                        <svg style="width: 1rem; height: 1rem; margin-right: 0.5rem;" fill="none"
                                            stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15" />
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
                                                <svg style="width: 1.5rem; height: 1.5rem;" fill="none"
                                                    stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2"
                                                        d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M9 19l3 3m0 0l3-3m-3 3V10" />
                                                </svg>
                                                Import Data
                                            </h3>
                                            <p class="card-description">Upload CSV files to bulk import users, products,
                                                or suppliers</p>
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

                                            <div class="upload-area" id="uploadArea"
                                                onclick="document.getElementById('fileInput').click()">
                                                <svg class="upload-icon" fill="none" stroke="currentColor"
                                                    viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2"
                                                        d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12" />
                                                </svg>
                                                <div class="upload-text">Drop CSV file here or click to browse</div>
                                                <div class="upload-hint">Supported formats: CSV (max 10MB)</div>
                                                <input type="file" id="fileInput" class="file-input" accept=".csv"
                                                    onchange="handleFileSelect(event)">
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

                                            <button class="btn btn--primary w-full" id="importBtn"
                                                onclick="startImport()" disabled>
                                                Start Import
                                            </button>
                                        </div>
                                    </div>

                                    <!-- Export Data -->
                                    <div class="operation-card">
                                        <div class="card-header">
                                            <h3 class="card-title">
                                                <svg style="width: 1.5rem; height: 1.5rem;" fill="none"
                                                    stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2"
                                                        d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12" />
                                                </svg>
                                                Export Data
                                            </h3>
                                            <p class="card-description">Download system data in CSV format for backup or
                                                analysis</p>
                                        </div>
                                        <div class="card-body">
                                            <div class="export-options">
                                                <div class="export-option" onclick="exportData('users')">
                                                    <svg class="export-icon" fill="none" stroke="currentColor"
                                                        viewBox="0 0 24 24">
                                                        <path stroke-linecap="round" stroke-linejoin="round"
                                                            stroke-width="2"
                                                            d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197m13.5-9a2.5 2.5 0 11-5 0 2.5 2.5 0 015 0z" />
                                                    </svg>
                                                    <div class="export-title">Users</div>
                                                    <div class="export-description">All user accounts and profiles</div>
                                                </div>

                                                <div class="export-option" onclick="exportData('products')">
                                                    <svg class="export-icon" fill="none" stroke="currentColor"
                                                        viewBox="0 0 24 24">
                                                        <path stroke-linecap="round" stroke-linejoin="round"
                                                            stroke-width="2"
                                                            d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" />
                                                    </svg>
                                                    <div class="export-title">Products</div>
                                                    <div class="export-description">Product catalog with details</div>
                                                </div>

                                                <div class="export-option" onclick="exportData('orders')">
                                                    <svg class="export-icon" fill="none" stroke="currentColor"
                                                        viewBox="0 0 24 24">
                                                        <path stroke-linecap="round" stroke-linejoin="round"
                                                            stroke-width="2"
                                                            d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z" />
                                                    </svg>
                                                    <div class="export-title">Orders</div>
                                                    <div class="export-description">Order history and transactions</div>
                                                </div>

                                                <div class="export-option" onclick="exportData('suppliers')">
                                                    <svg class="export-icon" fill="none" stroke="currentColor"
                                                        viewBox="0 0 24 24">
                                                        <path stroke-linecap="round" stroke-linejoin="round"
                                                            stroke-width="2"
                                                            d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4" />
                                                    </svg>
                                                    <div class="export-title">Suppliers</div>
                                                    <div class="export-description">Supplier information and contacts
                                                    </div>
                                                </div>
                                            </div>

                                            <button class="btn btn--outline w-full" onclick="exportAll()">
                                                <svg style="width: 1rem; height: 1rem; margin-right: 0.5rem;"
                                                    fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2"
                                                        d="M12 10v6m0 0l-3-3m3 3l3-3M3 17V7a2 2 0 012-2h6l2 2h6a2 2 0 012 2v10a2 2 0 01-2 2H5a2 2 0 01-2-2z" />
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
                                            <svg style="width: 1.5rem; height: 1.5rem; margin-right: 0.5rem;"
                                                fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M8 7H5a2 2 0 00-2 2v9a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2h-3m-1 4l-3-3m0 0l-3 3m3-3v12" />
                                            </svg>
                                            System Backup & Restore
                                        </h3>
                                        <span class="text-sm text-neutral-600">Last backup: <span
                                                id="lastBackupTime">Never</span></span>
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
                                            <svg style="width: 1rem; height: 1rem; margin-right: 0.25rem;" fill="none"
                                                stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15" />
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
                        <script src="${pageContext.request.contextPath}/js/data-management.js"></script>
                    </t:base>