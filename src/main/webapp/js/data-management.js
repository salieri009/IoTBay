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
        <div class="upload-text">Selected: \${fileName}</div>
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
        progressText.textContent = `Processing \${entityType}... \${Math.round(progress)}%`;
        
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
            errorDiv.textContent = `Row \${Math.floor(Math.random() * totalRecords) + 1}: Invalid data format in column '\${columnName}'`;
            errorList.appendChild(errorDiv);
        }
    }
    
    document.getElementById('importResults').style.display = 'block';
    
    // Add to logs
    addOperationLog('Import', entityType, totalRecords, errors > 0 ? 'error' : 'success');
    
    showNotification(`Import completed! \${successful} records processed successfully.`, errors > 0 ? 'warning' : 'success');
}

// Export Functions
function exportData(entityType) {
    showNotification(`Preparing \${entityType} export...`, 'info');
    
    // Simulate export process
    setTimeout(() => {
        const recordCount = Math.floor(Math.random() * 1000) + 100;
        
        // Create and trigger download (simulation)
        const filename = `\${entityType}_export_\${new Date().toISOString().split('T')[0]}.csv`;
        
        // In a real implementation, this would trigger an actual file download
        showNotification(`\${entityType} export completed! \${recordCount} records exported.`, 'success');
        
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
    showNotification(`Creating \${backupType.toLowerCase()} backup...`, 'info');
    
    setTimeout(() => {
        const timestamp = new Date().toLocaleString();
        document.getElementById('lastBackupTime').textContent = timestamp;
        showNotification(`\${backupType} backup completed successfully!`, 'success');
        
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
        <td>\${operation}</td>
        <td>\${entityType}</td>
        <td>\${records}</td>
        <td><span class="log-status \${status}">\${status.charAt(0).toUpperCase() + status.slice(1)}</span></td>
        <td>\${user}</td>
        <td>\${timestamp}</td>
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
    notification.className = `notification notification--\${type}`;
    notification.textContent = message;
    notification.style.cssText = `
        position: fixed;
        top: 2rem;
        right: 2rem;
        padding: 1rem 1.5rem;
        background: \${type === 'success' ? 'var(--success)' : type === 'warning' ? 'var(--warning)' : 'var(--brand-primary)'};
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
    // Set last backup time (would come from backend)
    const lastBackup = localStorage.getItem('lastBackupTime');
    if (lastBackup) {
        document.getElementById('lastBackupTime').textContent = lastBackup;
    }
});
