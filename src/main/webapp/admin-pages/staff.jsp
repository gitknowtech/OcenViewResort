<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
    .staff-container {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 30px;
        height: calc(100vh - 200px);
    }
    
    .staff-left {
        display: flex;
        flex-direction: column;
    }
    
    .staff-right {
        display: flex;
        flex-direction: column;
    }
    
    .staff-table-wrapper {
        background: white;
        border-radius: 12px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        overflow: hidden;
        display: flex;
        flex-direction: column;
        flex: 1;
    }
    
    .staff-table-header {
        padding: 20px;
        background: #f8f9fa;
        border-bottom: 2px solid #e5e7eb;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    
    .staff-table-header h3 {
        margin: 0;
        color: #0f172a;
        font-size: 18px;
    }
    
    .staff-search {
        padding: 10px 15px;
        border: 1px solid #e5e7eb;
        border-radius: 8px;
        font-size: 14px;
        width: 250px;
    }
    
    .staff-table {
        overflow-y: auto;
        flex: 1;
    }
    
    .data-table {
        width: 100%;
        border-collapse: collapse;
    }
    
    .data-table thead {
        background: #f9fafb;
        position: sticky;
        top: 0;
    }
    
    .data-table th {
        padding: 15px;
        text-align: left;
        font-weight: 600;
        color: #374151;
        font-size: 13px;
        border-bottom: 2px solid #e5e7eb;
    }
    
    .data-table td {
        padding: 15px;
        border-bottom: 1px solid #f3f4f6;
        font-size: 14px;
    }
    
    .data-table tbody tr:hover {
        background: #f9fafb;
    }
    
    .staff-actions {
        display: flex;
        gap: 8px;
    }
    
    .action-icon-btn {
        width: 32px;
        height: 32px;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
        transition: all 0.3s ease;
        font-size: 14px;
    }
    
    .action-view {
        background: #dbeafe;
        color: #1d4ed8;
    }
    
    .action-view:hover {
        background: #bfdbfe;
    }
    
    .action-edit {
        background: #dbeafe;
        color: #1d4ed8;
    }
    
    .action-edit:hover {
        background: #bfdbfe;
    }
    
    .action-delete {
        background: #fee2e2;
        color: #991b1b;
    }
    
    .action-delete:hover {
        background: #fecaca;
    }
    
    .staff-form-wrapper {
        background: white;
        border-radius: 12px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        padding: 30px;
        overflow-y: auto;
    }
    
    .staff-form-title {
        font-size: 18px;
        font-weight: 700;
        color: #0f172a;
        margin-bottom: 25px;
    }
    
    .success-message {
        background: #d1fae5;
        border: 1px solid #6ee7b7;
        color: #065f46;
        padding: 15px;
        border-radius: 8px;
        margin-bottom: 20px;
        display: none;
        animation: slideDown 0.3s ease-out;
    }
    
    .success-message.show {
        display: block;
    }
    
    .error-message {
        background: #fee2e2;
        border: 1px solid #fca5a5;
        color: #991b1b;
        padding: 15px;
        border-radius: 8px;
        margin-bottom: 20px;
        display: none;
        animation: slideDown 0.3s ease-out;
    }
    
    .error-message.show {
        display: block;
    }
    
    @keyframes slideDown {
        from {
            opacity: 0;
            transform: translateY(-10px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
    
    .form-group {
        margin-bottom: 20px;
    }
    
    .form-group label {
        display: block;
        font-weight: 600;
        color: #374151;
        margin-bottom: 8px;
        font-size: 14px;
    }
    
    .form-group input,
    .form-group select {
        width: 100%;
        padding: 10px 12px;
        border: 1px solid #d1d5db;
        border-radius: 8px;
        font-size: 14px;
        font-family: inherit;
    }
    
    .form-group input:focus,
    .form-group select:focus {
        outline: none;
        border-color: #3b82f6;
        box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
    }
    
    .form-buttons {
        display: flex;
        gap: 10px;
        margin-top: 30px;
    }
    
    .btn {
        flex: 1;
        padding: 12px;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        font-weight: 600;
        font-size: 14px;
        transition: all 0.3s ease;
    }
    
    .btn-submit {
        background: #3b82f6;
        color: white;
    }
    
    .btn-submit:hover {
        background: #1d4ed8;
        transform: translateY(-2px);
    }
    
    .btn-submit:disabled {
        background: #9ca3af;
        cursor: not-allowed;
        transform: none;
    }
    
    .btn-reset {
        background: #e5e7eb;
        color: #374151;
    }
    
    .btn-reset:hover {
        background: #d1d5db;
    }
    
    .staff-info-display {
        background: linear-gradient(135deg, #eff6ff 0%, #dbeafe 100%);
        padding: 20px;
        border-radius: 8px;
        margin-bottom: 20px;
        border-left: 4px solid #3b82f6;
        display: none;
        animation: slideDown 0.3s ease-out;
    }
    
    .staff-info-display.show {
        display: block;
    }
    
    .staff-info-row {
        display: flex;
        justify-content: space-between;
        margin-bottom: 12px;
        font-size: 14px;
    }
    
    .staff-info-label {
        font-weight: 600;
        color: #1f2937;
    }
    
    .staff-info-value {
        color: #6b7280;
    }
    
    @media (max-width: 1400px) {
        .staff-container {
            grid-template-columns: 1fr;
            height: auto;
        }
        
        .staff-table-wrapper {
            max-height: 400px;
        }
    }
</style>

<div class="staff-container">
    <!-- LEFT: Staff Table -->
    <div class="staff-left">
        <div class="staff-table-wrapper">
            <div class="staff-table-header">
                <h3>👔 Staff Members</h3>
                <input type="text" class="staff-search" id="staffSearch" placeholder="Search staff...">
            </div>
            <div class="staff-table">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Username</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Position</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody id="staffTableBody">
                        <tr>
                            <td colspan="7" style="text-align: center; color: #999;">Loading...</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    
    <!-- RIGHT: Add/Edit Staff Form -->
    <div class="staff-right">
        <div class="staff-form-wrapper">
            <div class="success-message" id="successMessage">
                <i class="fas fa-check-circle"></i>
                <span id="successText">Success!</span>
            </div>
            
            <div class="error-message" id="errorMessage">
                <i class="fas fa-exclamation-circle"></i>
                <span id="errorText">Error!</span>
            </div>
            
            <div class="staff-form-title" id="formTitle">➕ Add New Staff</div>
            
            <div class="staff-info-display" id="staffInfoDisplay"></div>
            
            <form id="staffForm" onsubmit="submitStaffForm(event)">
                <input type="hidden" id="staffId" value="">
                <input type="hidden" id="formMode" value="add">
                
                <!-- Full Name -->
                <div class="form-group">
                    <label for="name">Full Name <span style="color: #dc2626;">*</span></label>
                    <input type="text" id="name" name="name" placeholder="Enter full name" required>
                </div>
                
                <!-- Username -->
                <div class="form-group">
                    <label for="username">Username <span style="color: #dc2626;">*</span></label>
                    <input type="text" id="username" name="username" placeholder="Enter username" required>
                </div>
                
                <!-- Email -->
                <div class="form-group">
                    <label for="email">Email <span style="color: #dc2626;">*</span></label>
                    <input type="email" id="email" name="email" placeholder="Enter email" required>
                </div>
                
                <!-- Password -->
                <div class="form-group">
                    <label for="password">Password <span style="color: #dc2626;">*</span></label>
                    <input type="password" id="password" name="password" placeholder="Enter password" required>
                </div>
                
                <!-- Phone -->
                <div class="form-group">
                    <label for="phone">Phone <span style="color: #dc2626;">*</span></label>
                    <input type="tel" id="phone" name="phone" placeholder="Enter phone number" required>
                </div>
                
                <!-- Form Buttons -->
                <div class="form-buttons">
                    <button type="submit" class="btn btn-submit" id="submitBtn">➕ Add Staff</button>
                    <button type="reset" class="btn btn-reset" onclick="resetStaffForm()">Clear</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
console.log('👔 Staff Management Page Loaded');

// Load all staff on page load
function loadAllStaff() {
    console.log('📥 Loading all staff...');
    
    $.ajax({
        url: 'staff?action=getAll',
        type: 'GET',
        dataType: 'json',
        success: function(data) {
            console.log('✅ Staff loaded:', data.length);
            displayStaffTable(data);
        },
        error: function(xhr) {
            console.error('❌ Error loading staff:', xhr);
            document.getElementById('staffTableBody').innerHTML = '<tr><td colspan="7" style="text-align: center; color: #dc2626;">Error loading staff</td></tr>';
        }
    });
}

// Display staff in table
function displayStaffTable(staff) {
    const tbody = document.getElementById('staffTableBody');
    
    if (staff.length === 0) {
        tbody.innerHTML = '<tr><td colspan="7" style="text-align: center; color: #999;">No staff members yet</td></tr>';
        return;
    }
    
    let html = '';
    for (let i = 0; i < staff.length; i++) {
        const s = staff[i];
        
        html += '<tr>';
        html += '<td>' + s.id + '</td>';
        html += '<td>' + s.name + '</td>';
        html += '<td>' + s.username + '</td>';
        html += '<td>' + s.email + '</td>';
        html += '<td>' + s.phone + '</td>';
        html += '<td>' + s.position + '</td>';
        html += '<td>';
        html += '<div class="staff-actions">';
        html += '<button class="action-icon-btn action-view" onclick="viewStaff(' + s.id + ')" title="View"><i class="fas fa-eye"></i></button>';
        html += '<button class="action-icon-btn action-edit" onclick="editStaff(' + s.id + ')" title="Edit"><i class="fas fa-edit"></i></button>';
        html += '<button class="action-icon-btn action-delete" onclick="deleteStaff(' + s.id + ')" title="Delete"><i class="fas fa-trash"></i></button>';
        html += '</div>';
        html += '</td>';
        html += '</tr>';
    }
    
    tbody.innerHTML = html;
}

// View staff details
function viewStaff(id) {
    console.log('👁️ Viewing staff:', id);
    
    $.ajax({
        url: 'staff?action=getById&id=' + id,
        type: 'GET',
        dataType: 'json',
        success: function(data) {
            if (data.success) {
                const s = data.staff;
                const display = document.getElementById('staffInfoDisplay');
                
                let html = '';
                html += '<div class="staff-info-row">';
                html += '<span class="staff-info-label">ID:</span>';
                html += '<span class="staff-info-value">' + s.id + '</span>';
                html += '</div>';
                
                html += '<div class="staff-info-row">';
                html += '<span class="staff-info-label">Name:</span>';
                html += '<span class="staff-info-value">' + s.name + '</span>';
                html += '</div>';
                
                html += '<div class="staff-info-row">';
                html += '<span class="staff-info-label">Username:</span>';
                html += '<span class="staff-info-value">' + s.username + '</span>';
                html += '</div>';
                
                html += '<div class="staff-info-row">';
                html += '<span class="staff-info-label">Email:</span>';
                html += '<span class="staff-info-value">' + s.email + '</span>';
                html += '</div>';
                
                html += '<div class="staff-info-row">';
                html += '<span class="staff-info-label">Phone:</span>';
                html += '<span class="staff-info-value">' + s.phone + '</span>';
                html += '</div>';
                
                html += '<div class="staff-info-row">';
                html += '<span class="staff-info-label">Position:</span>';
                html += '<span class="staff-info-value">' + s.position + '</span>';
                html += '</div>';
                
                display.innerHTML = html;
                display.classList.add('show');
            }
        }
    });
}

// Edit staff
function editStaff(id) {
    console.log('✏️ Editing staff:', id);
    
    $.ajax({
        url: 'staff?action=getById&id=' + id,
        type: 'GET',
        dataType: 'json',
        success: function(data) {
            if (data.success) {
                const s = data.staff;
                
                document.getElementById('staffId').value = s.id;
                document.getElementById('formMode').value = 'edit';
                document.getElementById('name').value = s.name;
                document.getElementById('username').value = s.username;
                document.getElementById('username').readOnly = true;
                document.getElementById('email').value = s.email;
                document.getElementById('phone').value = s.phone;
                document.getElementById('password').value = '';
                document.getElementById('password').placeholder = 'Leave empty to keep current password';
                document.getElementById('password').required = false;
                
                document.getElementById('formTitle').textContent = '✏️ Edit Staff';
                document.getElementById('submitBtn').textContent = '💾 Update Staff';
                
                document.getElementById('staffInfoDisplay').classList.remove('show');
                document.getElementById('successMessage').classList.remove('show');
                document.getElementById('errorMessage').classList.remove('show');
                
                document.querySelector('.staff-form-wrapper').scrollIntoView({ behavior: 'smooth' });
            }
        }
    });
}

// Delete staff
function deleteStaff(id) {
    if (!confirm('⚠️ Are you sure you want to delete this staff member?')) return;
    
    console.log('🗑️ Deleting staff:', id);
    
    $.ajax({
        url: 'staff',
        type: 'POST',
        data: {
            action: 'delete',
            id: id
        },
        dataType: 'json',
        success: function(data) {
            console.log('Response:', data);
            if (data.success) {
                console.log('✅ Staff deleted');
                showSuccessMessage(data.message);
                loadAllStaff();
            } else {
                showErrorMessage(data.message);
            }
        },
        error: function(xhr, status, error) {
            console.error('Delete error:', error);
            showErrorMessage('Error deleting staff: ' + error);
        }
    });
}

// Show success message
function showSuccessMessage(message) {
    const successMsg = document.getElementById('successMessage');
    const successText = document.getElementById('successText');
    
    successText.textContent = message;
    successMsg.classList.add('show');
    
    // Hide error message
    document.getElementById('errorMessage').classList.remove('show');
    
    setTimeout(function() {
        successMsg.classList.remove('show');
    }, 4000);
}

// Show error message
function showErrorMessage(message) {
    const errorMsg = document.getElementById('errorMessage');
    const errorText = document.getElementById('errorText');
    
    errorText.textContent = message;
    errorMsg.classList.add('show');
    
    // Hide success message
    document.getElementById('successMessage').classList.remove('show');
    
    setTimeout(function() {
        errorMsg.classList.remove('show');
    }, 4000);
}

// Submit staff form
function submitStaffForm(e) {
    e.preventDefault();
    
    const mode = document.getElementById('formMode').value;
    const name = document.getElementById('name').value.trim();
    const username = document.getElementById('username').value.trim();
    const email = document.getElementById('email').value.trim();
    const password = document.getElementById('password').value.trim();
    const phone = document.getElementById('phone').value.trim();
    
    console.log('=== FORM SUBMISSION ===');
    console.log('Mode:', mode);
    console.log('Name:', name);
    console.log('Username:', username);
    console.log('Email:', email);
    console.log('Phone:', phone);
    console.log('Password:', password ? '***' : 'empty');
    
    // Validation
    if (!name) {
        showErrorMessage('❌ Name is required');
        return;
    }
    
    if (!username) {
        showErrorMessage('❌ Username is required');
        return;
    }
    
    if (!email) {
        showErrorMessage('❌ Email is required');
        return;
    }
    
    if (!phone) {
        showErrorMessage('❌ Phone is required');
        return;
    }
    
    if (mode === 'add' && !password) {
        showErrorMessage('❌ Password is required for new staff');
        return;
    }
    
    const submitBtn = document.getElementById('submitBtn');
    const originalText = submitBtn.textContent;
    submitBtn.disabled = true;
    submitBtn.textContent = '⏳ Processing...';
    
    const formData = new FormData();
    formData.append('action', (mode === 'add') ? 'add' : 'update');
    formData.append('name', name);
    formData.append('username', username);
    formData.append('email', email);
    formData.append('phone', phone);
    
    if (mode === 'add' || password) {
        formData.append('password', password);
    }
    
    if (mode === 'edit') {
        formData.append('id', document.getElementById('staffId').value);
    }
    
    console.log('Sending AJAX request...');
    
    $.ajax({
        url: 'staff',
        type: 'POST',
        data: formData,
        processData: false,
        contentType: false,
        dataType: 'json',
        success: function(data) {
            console.log('✅ AJAX Success Response:', data);
            
            if (data.success) {
                showSuccessMessage(data.message);
                resetStaffForm();
                loadAllStaff();
                
                if (mode === 'add') {
                    setTimeout(function() {
                        viewStaff(data.id);
                    }, 500);
                }
            } else {
                showErrorMessage(data.message);
            }
            
            submitBtn.disabled = false;
            submitBtn.textContent = originalText;
        },
        error: function(xhr, status, error) {
            console.error('❌ AJAX Error:', error);
            console.error('Status:', xhr.status);
            console.error('Response:', xhr.responseText);
            
            let errorMsg = 'Error: ' + error;
            if (xhr.responseText) {
                try {
                    const response = JSON.parse(xhr.responseText);
                    errorMsg = response.message || errorMsg;
                } catch (e) {
                    errorMsg = xhr.responseText;
                }
            }
            
            showErrorMessage(errorMsg);
            submitBtn.disabled = false;
            submitBtn.textContent = originalText;
        }
    });
}

// Reset form
function resetStaffForm() {
    document.getElementById('staffForm').reset();
    document.getElementById('staffId').value = '';
    document.getElementById('formMode').value = 'add';
    document.getElementById('username').readOnly = false;
    document.getElementById('password').placeholder = 'Enter password';
    document.getElementById('password').required = true;
    document.getElementById('formTitle').textContent = '➕ Add New Staff';
    document.getElementById('submitBtn').textContent = '➕ Add Staff';
    document.getElementById('staffInfoDisplay').classList.remove('show');
    document.getElementById('successMessage').classList.remove('show');
    document.getElementById('errorMessage').classList.remove('show');
}

// Initialize
$(document).ready(function() {
    console.log('✅ Staff management initialized');
    loadAllStaff();
});
</script>
