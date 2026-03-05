<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
/* Password Reset Page Styles */
.password-reset-page {
    padding: 20px;
    max-width: 600px;
    margin: 0 auto;
    min-height: 80vh;
}

.password-reset-container {
    background: white;
    border-radius: 12px;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
    overflow: hidden;
}

.reset-header {
    background: linear-gradient(135deg, #ef4444, #dc2626);
    color: white;
    padding: 30px 20px;
    text-align: center;
}

.reset-header h2 {
    margin: 0 0 8px 0;
    font-size: 22px;
    font-weight: 700;
}

.reset-header p {
    margin: 0;
    font-size: 12px;
    opacity: 0.9;
}

.reset-content {
    padding: 25px;
}

.info-box {
    background: #fef3c7;
    border-left: 3px solid #f59e0b;
    padding: 15px;
    border-radius: 8px;
    margin-bottom: 20px;
}

.info-box p {
    margin: 0;
    font-size: 12px;
    color: #92400e;
    line-height: 1.5;
}

.form-group {
    margin-bottom: 15px;
}

.form-group label {
    display: block;
    margin-bottom: 6px;
    font-weight: 600;
    color: #333;
    font-size: 12px;
}

.form-group label i {
    margin-right: 6px;
    color: #ef4444;
    width: 14px;
}

.form-input {
    width: 100%;
    padding: 10px 12px;
    border: 1px solid #e9ecef;
    border-radius: 6px;
    font-size: 12px;
    box-sizing: border-box;
    transition: all 0.3s ease;
}

.form-input:focus {
    outline: none;
    border-color: #ef4444;
    box-shadow: 0 0 0 2px rgba(239, 68, 68, 0.1);
    background: #fef2f2;
}

.password-strength {
    margin-top: 8px;
    height: 4px;
    background: #e9ecef;
    border-radius: 2px;
    overflow: hidden;
}

.strength-bar {
    height: 100%;
    width: 0%;
    transition: all 0.3s ease;
}

.strength-weak {
    background: #ef4444;
}

.strength-fair {
    background: #f59e0b;
}

.strength-good {
    background: #10b981;
}

.strength-text {
    font-size: 11px;
    margin-top: 4px;
    font-weight: 600;
}

.strength-text.weak { color: #ef4444; }
.strength-text.fair { color: #f59e0b; }
.strength-text.good { color: #10b981; }

.form-actions {
    display: flex;
    gap: 12px;
    margin-top: 25px;
    padding-top: 15px;
    border-top: 1px solid #e9ecef;
}

.btn {
    flex: 1;
    padding: 10px 15px;
    border: none;
    border-radius: 6px;
    font-size: 12px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s ease;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 6px;
}

.btn-primary {
    background: linear-gradient(135deg, #ef4444, #dc2626);
    color: white;
}

.btn-primary:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
}

.btn-secondary {
    background: #6c757d;
    color: white;
}

.btn-secondary:hover {
    background: #5a6268;
}

.message {
    position: fixed;
    top: 20px;
    right: 20px;
    padding: 12px 15px;
    border-radius: 8px;
    z-index: 9999;
    display: none;
    font-weight: 600;
    box-shadow: 0 4px 12px rgba(0,0,0,0.15);
    min-width: 250px;
    animation: slideIn 0.3s ease-out;
    font-size: 12px;
}

.success {
    background: linear-gradient(135deg, #10b981, #059669);
    color: white;
    border-left: 3px solid #047857;
}

.error {
    background: linear-gradient(135deg, #ef4444, #dc2626);
    color: white;
    border-left: 3px solid #b91c1c;
}

.info {
    background: linear-gradient(135deg, #3b82f6, #1d4ed8);
    color: white;
    border-left: 3px solid #1e40af;
}

.show { display: block; }

@keyframes slideIn {
    from { transform: translateX(100%); opacity: 0; }
    to { transform: translateX(0); opacity: 1; }
}

.password-requirements {
    background: #f8f9fa;
    border: 1px solid #e9ecef;
    padding: 12px;
    border-radius: 6px;
    margin-top: 15px;
    font-size: 11px;
}

.password-requirements h4 {
    margin: 0 0 8px 0;
    font-size: 12px;
    font-weight: 600;
    color: #333;
}

.requirement {
    display: flex;
    align-items: center;
    margin-bottom: 4px;
    color: #666;
}

.requirement i {
    width: 16px;
    margin-right: 6px;
    text-align: center;
    font-size: 10px;
}

.requirement.met i {
    color: #10b981;
}

.requirement.unmet i {
    color: #ef4444;
}

@media (max-width: 768px) {
    .password-reset-page {
        padding: 15px;
    }
    
    .reset-header {
        padding: 20px 15px;
    }
    
    .reset-header h2 {
        font-size: 18px;
    }
    
    .reset-content {
        padding: 15px;
    }
    
    .form-actions {
        flex-direction: column;
    }
    
    .btn {
        width: 100%;
    }
}
</style>

<!-- Message Container -->
<div id="msg" class="message"></div>

<div class="password-reset-page">
    <div class="password-reset-container">
        <!-- Header -->
        <div class="reset-header">
            <h2><i class="fas fa-lock"></i> Change Password</h2>
            <p>Update your account password to keep your account secure</p>
        </div>

        <!-- Content -->
        <div class="reset-content">
            <!-- Info Box -->
            <div class="info-box">
                <p><i class="fas fa-info-circle"></i> Your password should be strong and unique. Use a combination of uppercase, lowercase, numbers, and special characters.</p>
            </div>

            <!-- Password Reset Form -->
            <form id="passwordResetForm">
                <!-- New Password -->
                <div class="form-group">
                    <label for="newPassword">
                        <i class="fas fa-key"></i> New Password
                    </label>
                    <input type="password" id="newPassword" name="newPassword" class="form-input" placeholder="Enter new password" required>
                    <div class="password-strength">
                        <div class="strength-bar" id="strengthBar"></div>
                    </div>
                    <div class="strength-text" id="strengthText"></div>
                </div>

                <!-- Confirm Password -->
                <div class="form-group">
                    <label for="confirmPassword">
                        <i class="fas fa-check-circle"></i> Confirm Password
                    </label>
                    <input type="password" id="confirmPassword" name="confirmPassword" class="form-input" placeholder="Confirm new password" required>
                </div>

                <!-- Password Requirements -->
                <div class="password-requirements">
                    <h4>Password Requirements:</h4>
                    <div class="requirement unmet" id="req-length">
                        <i class="fas fa-circle"></i> At least 8 characters
                    </div>
                    <div class="requirement unmet" id="req-uppercase">
                        <i class="fas fa-circle"></i> At least one uppercase letter
                    </div>
                    <div class="requirement unmet" id="req-lowercase">
                        <i class="fas fa-circle"></i> At least one lowercase letter
                    </div>
                    <div class="requirement unmet" id="req-number">
                        <i class="fas fa-circle"></i> At least one number
                    </div>
                    <div class="requirement unmet" id="req-special">
                        <i class="fas fa-circle"></i> At least one special character (!@#$%^&*)
                    </div>
                    <div class="requirement unmet" id="req-match">
                        <i class="fas fa-circle"></i> Passwords match
                    </div>
                </div>

                <!-- Form Actions -->
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary" id="updateBtn">
                        <i class="fas fa-save"></i> Update Password
                    </button>
                    <button type="button" class="btn btn-secondary" onclick="goBackToProfile()">
                        <i class="fas fa-arrow-left"></i> Back
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
console.log('🚀 Password reset page loaded');

// Show message function
function showMessage(text, type) {
    const messageDiv = document.getElementById('msg');
    messageDiv.textContent = text;
    messageDiv.className = 'message ' + type + ' show';
    setTimeout(() => messageDiv.classList.remove('show'), 5000);
}

// Go back to profile
function goBackToProfile() {
    if (typeof loadPage === 'function') {
        loadPage('profile');
    } else {
        window.history.back();
    }
}

// Check password strength
function checkPasswordStrength(password) {
    let strength = 0;
    
    // Length check
    const hasLength = password.length >= 8;
    document.getElementById('req-length').classList.toggle('met', hasLength);
    if (hasLength) strength++;
    
    // Uppercase check
    const hasUppercase = /[A-Z]/.test(password);
    document.getElementById('req-uppercase').classList.toggle('met', hasUppercase);
    if (hasUppercase) strength++;
    
    // Lowercase check
    const hasLowercase = /[a-z]/.test(password);
    document.getElementById('req-lowercase').classList.toggle('met', hasLowercase);
    if (hasLowercase) strength++;
    
    // Number check
    const hasNumber = /[0-9]/.test(password);
    document.getElementById('req-number').classList.toggle('met', hasNumber);
    if (hasNumber) strength++;
    
    // Special character check
    const hasSpecial = /[!@#$%^&*]/.test(password);
    document.getElementById('req-special').classList.toggle('met', hasSpecial);
    if (hasSpecial) strength++;
    
    // Update strength bar
    const strengthBar = document.getElementById('strengthBar');
    const strengthText = document.getElementById('strengthText');
    
    strengthBar.style.width = (strength * 20) + '%';
    
    if (strength < 2) {
        strengthBar.className = 'strength-bar strength-weak';
        strengthText.className = 'strength-text weak';
        strengthText.textContent = 'Weak';
    } else if (strength < 4) {
        strengthBar.className = 'strength-bar strength-fair';
        strengthText.className = 'strength-text fair';
        strengthText.textContent = 'Fair';
    } else {
        strengthBar.className = 'strength-bar strength-good';
        strengthText.className = 'strength-text good';
        strengthText.textContent = 'Strong';
    }
}

// Check if passwords match
function checkPasswordMatch() {
    const newPassword = document.getElementById('newPassword').value;
    const confirmPassword = document.getElementById('confirmPassword').value;
    
    const matches = newPassword && confirmPassword && newPassword === confirmPassword;
    document.getElementById('req-match').classList.toggle('met', matches);
    
    return matches;
}

// Listen to password input
document.getElementById('newPassword').addEventListener('input', function() {
    checkPasswordStrength(this.value);
    checkPasswordMatch();
});

document.getElementById('confirmPassword').addEventListener('input', function() {
    checkPasswordMatch();
});

// Handle form submission
document.getElementById('passwordResetForm').addEventListener('submit', function(e) {
    e.preventDefault();
    
    const newPassword = document.getElementById('newPassword').value.trim();
    const confirmPassword = document.getElementById('confirmPassword').value.trim();
    const updateBtn = document.getElementById('updateBtn');
    
    // Validation
    if (!newPassword) {
        showMessage('❌ New password is required', 'error');
        return;
    }
    
    if (newPassword.length < 8) {
        showMessage('❌ Password must be at least 8 characters', 'error');
        return;
    }
    
    if (!/[A-Z]/.test(newPassword)) {
        showMessage('❌ Password must contain uppercase letter', 'error');
        return;
    }
    
    if (!/[a-z]/.test(newPassword)) {
        showMessage('❌ Password must contain lowercase letter', 'error');
        return;
    }
    
    if (!/[0-9]/.test(newPassword)) {
        showMessage('❌ Password must contain number', 'error');
        return;
    }
    
    if (!/[!@#$%^&*]/.test(newPassword)) {
        showMessage('❌ Password must contain special character (!@#$%^&*)', 'error');
        return;
    }
    
    if (newPassword !== confirmPassword) {
        showMessage('❌ Passwords do not match', 'error');
        return;
    }
    
    // Disable button and show loading
    updateBtn.disabled = true;
    updateBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Updating...';
    
    // Send to servlet
    const params = new URLSearchParams();
    params.append('newPassword', newPassword);
    
    fetch('changePassword', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: params.toString()
    })
    .then(response => response.json())
    .then(data => {
        updateBtn.disabled = false;
        updateBtn.innerHTML = '<i class="fas fa-save"></i> Update Password';
        
        if (data.success) {
            showMessage('✅ Password changed successfully!', 'success');
            setTimeout(() => {
                goBackToProfile();
            }, 2000);
        } else {
            showMessage('❌ ' + (data.message || 'Failed to change password'), 'error');
        }
    })
    .catch(error => {
        updateBtn.disabled = false;
        updateBtn.innerHTML = '<i class="fas fa-save"></i> Update Password';
        console.error('❌ Error:', error);
        showMessage('⚠️ Network error occurred', 'error');
    });
});

console.log('✅ Password reset page fully loaded');
</script>
