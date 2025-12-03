<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>

<t:base title="Data Management - IoT Bay Admin">
    <jsp:attribute name="customCss">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/data-management.css">
    </jsp:attribute>
    
    <jsp:body>
        <div class="data-management-container">
            <header class="page-header">
                <h1>Data Management</h1>
                <p class="subtitle">Import, export, and manage system data</p>
            </header>

            <!-- Success/Error Messages -->
            <c:if test="${not empty successMessage}">
                <div class="alert alert--success">
                    ${successMessage}
                </div>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <div class="alert alert--error">
                    ${errorMessage}
                </div>
            </c:if>

            <!-- Export Section -->
            <section class="card">
                <h2 class="card-title">Export Data</h2>
                <div class="export-grid">
                    <div class="export-item">
                        <h3>Users</h3>
                        <p>Export all user data to CSV</p>
                        <a href="${pageContext.request.contextPath}/api/dataManagement/exportUsers" 
                           class="btn btn--primary">
                            Export Users
                        </a>
                    </div>
                    <div class="export-item">
                        <h3>Products</h3>
                        <p>Export product catalog to CSV</p>
                        <a href="${pageContext.request.contextPath}/api/dataManagement/exportProducts" 
                           class="btn btn--primary">
                            Export Products
                        </a>
                    </div>
                    <div class="export-item">
                        <h3>Orders</h3>
                        <p>Export order history to CSV</p>
                        <a href="${pageContext.request.contextPath}/api/dataManagement/exportOrders" 
                           class="btn btn--primary">
                            Export Orders
                        </a>
                    </div>
                    <div class="export-item">
                        <h3>Access Logs</h3>
                        <p>Export access log data to CSV</p>
                        <a href="${pageContext.request.contextPath}/api/dataManagement/exportAccessLogs" 
                           class="btn btn--primary">
                            Export Access Logs
                        </a>
                    </div>
                </div>
            </section>

            <!-- Import Section -->
            <section class="card">
                <h2 class="card-title">Import Data</h2>
                <p class="card-description">Upload CSV files to import data into the system</p>
                
                <form method="POST" 
                      action="${pageContext.request.contextPath}/api/dataManagement/import" 
                      enctype="multipart/form-data"
                      class="import-form">
                    
                    <div class="form-group">
                        <label for="entityType">Entity Type</label>
                        <select id="entityType" name="entityType" required class="form-control">
                            <option value="">Select entity type...</option>
                            <option value="users">Users</option>
                            <option value="products">Products</option>
                            <option value="orders">Orders</option>
                            <option value="accessLogs">Access Logs</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="csvFile">CSV File</label>
                        <input type="file" 
                               id="csvFile" 
                               name="csvFile" 
                               accept=".csv"
                               required
                               class="form-control">
                        <small class="form-hint">Maximum file size: 10MB</small>
                    </div>

                    <button type="submit" class="btn btn--primary btn--large">
                        Upload and Import
                    </button>
                </form>
            </section>

            <!-- Backup Section -->
            <section class="card">
                <h2 class="card-title">Backup & Restore</h2>
                <div class="backup-grid">
                    <div class="backup-item">
                        <h3>Create Backup</h3>
                        <p>Last backup: <strong id="lastBackupTime">Never</strong></p>
                        <form method="POST" 
                              action="${pageContext.request.contextPath}/api/dataManagement/backup"
                              style="display: inline;">
                            <input type="hidden" name="backupType" value="full">
                            <button type="submit" class="btn btn--secondary">
                                Create Full Backup
                            </button>
                        </form>
                    </div>
                    <div class="backup-item">
                        <h3>Restore from Backup</h3>
                        <p>Upload a backup file to restore</p>
                        <form method="POST" 
                              action="${pageContext.request.contextPath}/api/dataManagement/restore"
                              enctype="multipart/form-data">
                            <input type="file" 
                                   name="backupFile" 
                                   accept=".zip,.sql"
                                   class="form-control mb-2">
                            <button type="submit" class="btn btn--warning">
                                Restore Backup
                            </button>
                        </form>
                    </div>
                </div>
            </section>

            <!-- Operation Log -->
            <section class="card">
                <div class="card-header-flex">
                    <h2 class="card-title">Recent Operations</h2>
                    <form method="GET" style="display: inline;">
                        <button type="submit" class="btn btn--outline btn--sm">
                            Refresh
                        </button>
                    </form>
                </div>
                
                <div class="table-responsive">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Operation</th>
                                <th>Entity Type</th>
                                <th>Records</th>
                                <th>Status</th>
                                <th>User</th>
                                <th>Timestamp</th>
                            </tr>
                        </thead>
                        <tbody id="logsTableBody">
                            <c:choose>
                                <c:when test="${not empty operationLogs}">
                                    <c:forEach items="${operationLogs}" var="log">
                                        <tr>
                                            <td>${log.operation}</td>
                                            <td>${log.entityType}</td>
                                            <td>${log.recordCount}</td>
                                            <td>
                                                <span class="badge badge--${log.status}">
                                                    ${log.status}
                                                </span>
                                            </td>
                                            <td>${log.userName}</td>
                                            <td>${log.timestamp}</td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="6" class="text-center text-muted">
                                            No recent operations
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </section>
        </div>
    </jsp:body>
</t:base>