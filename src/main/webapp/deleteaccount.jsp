<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Delete Account</title>
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: #f9f9f9;
            padding: 40px;
        }
        .container {
            max-width: 420px;
            margin: 60px auto;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 24px rgba(0,0,0,0.10);
            padding: 36px 32px;
            text-align: center;
        }
        .warning {
            color: #d9534f;
            font-weight: bold;
            font-size: 1.2em;
            margin-bottom: 18px;
        }
        .delete-btn {
            background: linear-gradient(90deg, #ff5858 0%, #ff1e1e 100%);
            color: #fff;
            border: none;
            padding: 16px 38px;
            border-radius: 8px;
            font-size: 1.2em;
            font-weight: bold;
            letter-spacing: 1px;
            margin-top: 24px;
            cursor: pointer;
            box-shadow: 0 2px 8px rgba(255,30,30,0.20);
            transition: background 0.2s, transform 0.2s;
        }
        .delete-btn:hover {
            background: linear-gradient(90deg, #c9302c 0%, #a90000 100%);
            transform: scale(1.04);
        }
    </style>
</head>
<body>
<div class="container">
    <h2 style="color:#c9302c; margin-bottom: 10px;">?†Ô∏è Delete Account</h2>
    <div class="warning">
        <span style="font-size:1.4em;">This action <u>cannot be undone!</u></span><br>
        <span>Your account will be <b>permanently deleted</b> and all information will be lost.</span>
    </div>
    <p style="margin-bottom: 30px;">
        Are you absolutely sure you want to <b style="color:#b71c1c;">delete</b> your account?<br>
        <span style="color:#b71c1c; font-weight:bold;">Please think carefully before proceeding.</span>
    </p>
    <button class="delete-btn" onclick="deleteAccount()">?ö® Permanently Delete Account</button>
</div>

<script>
function deleteAccount() {
    // First confirmation
    if (!confirm('?†Ô∏è WARNING: This will permanently delete your account.\n\nAll your data, orders, and information will be lost forever.\n\nAre you absolutely sure you want to continue?')) {
        return;
    }
    
    // Second confirmation with more details
    const confirmMessage = 'This is your final warning!\n\n' +
                          'Deleting your account will:\n' +
                          '??Permanently remove all your personal information\n' +
                          '??Delete your order history\n' +
                          '??Remove all saved preferences\n' +
                          '??This action CANNOT be undone\n\n' +
                          'Type "DELETE" to confirm:';
    
    const userInput = prompt(confirmMessage);
    if (userInput !== 'DELETE') {
        if (userInput !== null) {
            alert('Account deletion cancelled. Your account is safe.');
        }
        return;
    }
    
    // Show loading state
    const deleteBtn = document.querySelector('.delete-btn');
    const originalText = deleteBtn.innerHTML;
    deleteBtn.innerHTML = '<div class="loading mr-2"></div> Deleting account...';
    deleteBtn.disabled = true;
    deleteBtn.style.opacity = '0.6';
    deleteBtn.style.cursor = 'not-allowed';
    
    if (typeof showLoading === 'function') {
        showLoading(deleteBtn);
    }
    
    fetch('<%=request.getContextPath()%>/api/Profiles', {
        method: 'DELETE',
        credentials: 'same-origin'
    })
    .then(response => {
        if (response.ok) {
            return response.text();
        } else {
            throw new Error('Failed to delete account. Please try again or contact support.');
        }
    })
    .then(msg => {
        // Show success message
        if (typeof showToast === 'function') {
            showToast('Account deleted successfully', 'success');
        }
        // Redirect to goodbye page after short delay
        setTimeout(() => {
            window.location.href = '<%=request.getContextPath()%>/goodbye.jsp';
        }, 1000);
    })
    .catch(err => {
        console.error('Error:', err);
        // Reset button
        deleteBtn.innerHTML = originalText;
        deleteBtn.disabled = false;
        deleteBtn.style.opacity = '1';
        deleteBtn.style.cursor = 'pointer';
        
        if (typeof hideLoading === 'function') {
            hideLoading(deleteBtn);
        }
        
        // Show error message
        const errorMsg = err.message || 'An error occurred while deleting your account. Please try again or contact support.';
        if (typeof showToast === 'function') {
            showToast(errorMsg, 'error');
        } else {
            alert(errorMsg);
        }
    });
}
</script>
</body>
</html>
