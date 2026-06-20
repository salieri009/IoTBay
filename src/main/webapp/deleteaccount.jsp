<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<t:base title="Delete Account - IoT Bay">
    <div class="max-w-md mx-auto py-16 px-4">
        <div class="bg-white rounded-2xl shadow-lg p-8 text-center">
            <h2 class="text-2xl font-bold text-error mb-4">Delete Account</h2>

            <div class="alert alert--error mb-6">
                <p class="font-semibold text-lg mb-1">This action <u>cannot be undone!</u></p>
                <p>Your account will be <strong>permanently deleted</strong> and all information will be lost.</p>
            </div>

            <p class="text-neutral-600 mb-8">
                Are you absolutely sure you want to <strong class="text-error">delete</strong> your account?<br>
                <span class="text-error font-semibold">Please think carefully before proceeding.</span>
            </p>

            <div class="flex flex-col gap-3">
                <button class="btn btn--danger btn--lg w-full" onclick="deleteAccount()">
                    Permanently Delete Account
                </button>
                <a href="<c:url value='/api/profile'/>" class="btn btn--secondary btn--lg w-full">
                    Cancel — Keep My Account
                </a>
            </div>
        </div>
    </div>

    <script>
    function deleteAccount() {
        // First confirmation
        if (!confirm('WARNING: This will permanently delete your account.\n\nAll your data, orders, and information will be lost forever.\n\nAre you absolutely sure you want to continue?')) {
            return;
        }

        // Second confirmation requiring typed input
        const confirmMessage = 'This is your final warning!\n\n' +
                              'Deleting your account will:\n' +
                              '- Permanently remove all your personal information\n' +
                              '- Delete your order history\n' +
                              '- Remove all saved preferences\n' +
                              '- This action CANNOT be undone\n\n' +
                              'Type "DELETE" to confirm:';

        const userInput = prompt(confirmMessage);
        if (userInput !== 'DELETE') {
            if (userInput !== null) {
                alert('Account deletion cancelled. Your account is safe.');
            }
            return;
        }

        // Show loading state
        const deleteBtn = document.querySelector('.btn--danger');
        const originalText = deleteBtn.innerHTML;
        deleteBtn.innerHTML = 'Deleting account...';
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
            if (typeof showToast === 'function') {
                showToast('Account deleted successfully', 'success');
            }
            setTimeout(() => {
                window.location.href = '<%=request.getContextPath()%>/goodbye.jsp';
            }, 1000);
        })
        .catch(err => {
            console.error('Error:', err);
            deleteBtn.innerHTML = originalText;
            deleteBtn.disabled = false;
            deleteBtn.style.opacity = '1';
            deleteBtn.style.cursor = 'pointer';

            if (typeof hideLoading === 'function') {
                hideLoading(deleteBtn);
            }

            const errorMsg = err.message || 'An error occurred while deleting your account. Please try again or contact support.';
            if (typeof showToast === 'function') {
                showToast(errorMsg, 'error');
            } else {
                alert(errorMsg);
            }
        });
    }
    </script>
</t:base>
