<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet" href="css/profile/profile.css">

<style>
/* Profile Page Styles - COMPACT VERSION */
.profile-page-content {
    padding: 20px;
    max-width: 1200px;
    margin: 0 auto;
    min-height: 80vh;
}

.profile-container {
    background: white;
    border-radius: 12px;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
    overflow: hidden;
}

.profile-header {
    background: linear-gradient(135deg, #003366, #004488);
    color: white;
    padding: 30px 20px;
    text-align: center;
    position: relative;
}

.profile-avatar {
    width: 80px;
    height: 80px;
    background: linear-gradient(135deg, #10b981, #059669);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 32px;
    color: white;
    font-weight: bold;
    margin: 0 auto 12px;
    border: 3px solid rgba(255, 255, 255, 0.3);
}

.profile-name {
    font-size: 20px;
    font-weight: 700;
    margin-bottom: 4px;
}

.profile-username {
    font-size: 13px;
    opacity: 0.9;
    margin-bottom: 3px;
}

.profile-email {
    font-size: 12px;
    opacity: 0.85;
}

.profile-tabs {
    display: flex;
    background: #f8f9fa;
    border-bottom: 1px solid #e9ecef;
}

.profile-tab {
    flex: 1;
    padding: 12px 15px;
    text-align: center;
    cursor: pointer;
    transition: all 0.3s ease;
    border: none;
    background: none;
    font-size: 13px;
    font-weight: 600;
    color: #666;
}

.profile-tab.active {
    background: white;
    color: #003366;
    border-bottom: 3px solid #10b981;
}

.profile-tab:hover {
    background: #e9ecef;
}

.profile-content {
    padding: 25px;
}

.profile-section {
    display: none;
}

.profile-section.active {
    display: block;
}

.profile-form {
    max-width: 100%;
}

/* ✅ 3-COLUMN LAYOUT - COMPACT */
.form-row {
    display: grid;
    grid-template-columns: 1fr 1fr 1fr;
    gap: 15px;
    margin-bottom: 15px;
}

.form-group {
    margin-bottom: 0;
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
    color: #10b981;
    width: 14px;
    font-size: 12px;
}

.form-input {
    width: 100%;
    padding: 8px 12px;
    border: 1px solid #e9ecef;
    border-radius: 6px;
    font-size: 12px;
    transition: all 0.3s ease;
    box-sizing: border-box;
}

.form-input:focus {
    outline: none;
    border-color: #10b981;
    box-shadow: 0 0 0 2px rgba(16, 185, 129, 0.1);
    background: #f0fdf4;
}

.form-input:disabled {
    background: #f8f9fa;
    color: #6c757d;
    cursor: not-allowed;
}

.form-input::placeholder {
    color: #aaa;
    font-size: 11px;
}

/* Full width for address and country */
.form-row.full-width {
    grid-template-columns: 1fr;
}

.form-actions {
    display: flex;
    gap: 12px;
    justify-content: center;
    margin-top: 20px;
    padding-top: 15px;
    border-top: 1px solid #e9ecef;
}

.btn {
    padding: 8px 20px;
    border: none;
    border-radius: 6px;
    font-size: 12px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s ease;
    display: flex;
    align-items: center;
    gap: 6px;
}

.btn-primary {
    background: linear-gradient(135deg, #10b981, #059669);
    color: white;
    min-width: 130px;
    justify-content: center;
}

.btn-primary:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(16, 185, 129, 0.3);
}

.btn-secondary {
    background: #6c757d;
    color: white;
    min-width: 100px;
    justify-content: center;
}

.btn-secondary:hover {
    background: #5a6268;
}

.btn-danger {
    background: linear-gradient(135deg, #ef4444, #dc2626);
    color: white;
    min-width: 130px;
    justify-content: center;
}

.btn-danger:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
}

.info-card {
    background: linear-gradient(135deg, #e3f2fd, #bbdefb);
    border-left: 3px solid #2196f3;
    padding: 15px;
    border-radius: 8px;
    margin-bottom: 20px;
}

.info-card h4 {
    margin: 0 0 6px 0;
    color: #1976d2;
    font-size: 13px;
    font-weight: 600;
}

.info-card p {
    margin: 0;
    color: #424242;
    font-size: 12px;
    line-height: 1.5;
}

.password-section {
    background: #fff3cd;
    border: 1px solid #ffeaa7;
    border-radius: 8px;
    padding: 20px;
    text-align: center;
}

.password-section h4 {
    color: #856404;
    margin-bottom: 10px;
    font-size: 13px;
    font-weight: 600;
}

.password-section p {
    color: #856404;
    margin-bottom: 15px;
    font-size: 12px;
    line-height: 1.5;
}

/* Message Styles */
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

/* Account Info Styling */
.account-info-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 15px;
    margin-top: 15px;
}

.account-info-item {
    background: #f8f9fa;
    padding: 15px;
    border-radius: 8px;
    border-left: 3px solid #10b981;
}

.account-info-item strong {
    display: block;
    color: #333;
    margin-bottom: 5px;
    font-size: 12px;
}

.account-info-item span {
    color: #666;
    font-size: 12px;
    font-weight: 500;
}

/* Responsive */
@media (max-width: 1024px) {
    .form-row {
        grid-template-columns: 1fr 1fr;
        gap: 12px;
    }
}

@media (max-width: 768px) {
    .profile-page-content {
        padding: 15px;
    }
    
    .profile-header {
        padding: 20px 15px;
    }
    
    .profile-avatar {
        width: 70px;
        height: 70px;
        font-size: 28px;
    }
    
    .profile-name {
        font-size: 18px;
    }
    
    .profile-content {
        padding: 15px;
    }
    
    .form-row {
        grid-template-columns: 1fr;
        gap: 10px;
    }
    
    .form-actions {
        flex-direction: column;
        gap: 10px;
    }
    
    .btn {
        width: 100%;
        padding: 10px 15px;
    }
    
    .account-info-grid {
        grid-template-columns: 1fr;
        gap: 10px;
    }
}

@media (max-width: 480px) {
    .profile-page-content {
        padding: 10px;
    }
    
    .profile-header {
        padding: 15px 10px;
    }
    
    .profile-avatar {
        width: 60px;
        height: 60px;
        font-size: 24px;
    }
    
    .profile-name {
        font-size: 16px;
    }
    
    .profile-username {
        font-size: 11px;
    }
    
    .profile-email {
        font-size: 11px;
    }
    
    .profile-tab {
        padding: 10px 10px;
        font-size: 11px;
    }
    
    .profile-content {
        padding: 12px;
    }
    
    .form-group label {
        font-size: 11px;
    }
    
    .form-input {
        padding: 7px 10px;
        font-size: 11px;
    }
    
    .message {
        right: 10px;
        left: 10px;
        min-width: auto;
        font-size: 11px;
        padding: 10px 12px;
    }
}
</style>

<!-- Message Container -->
<div id="msg" class="message"></div>

<div class="profile-page-content">
    <div class="profile-container">
        <!-- Profile Header -->
        <div class="profile-header">
            <div class="profile-avatar" id="profileAvatar">U</div>
            <div class="profile-name" id="profileName">Loading...</div>
            <div class="profile-username" id="profileUsername">@username</div>
            <div class="profile-email" id="profileEmail">user@example.com</div>
        </div>

        <!-- Profile Tabs -->
        <div class="profile-tabs">
            <button class="profile-tab active" onclick="showProfileSection('personal')">
                <i class="fas fa-user"></i> Personal Info
            </button>
            <button class="profile-tab" onclick="showProfileSection('security')">
                <i class="fas fa-shield-alt"></i> Security
            </button>
            <button class="profile-tab" onclick="showProfileSection('preferences')">
                <i class="fas fa-cog"></i> Preferences
            </button>
        </div>

        <!-- Profile Content -->
        <div class="profile-content">
            <!-- Personal Information Section -->
            <div class="profile-section active" id="personalSection">
                <div class="info-card">
                    <h4><i class="fas fa-info-circle"></i> Personal Information</h4>
                    <p>Update your personal details below. Changes will be saved automatically.</p>
                </div>

                <form class="profile-form" id="profileForm">
                    <!-- Row 1: First Name, Last Name, Username -->
                    <div class="form-row">
                        <div class="form-group">
                            <label for="firstName">
                                <i class="fas fa-user"></i> First Name
                            </label>
                            <input type="text" id="firstName" name="firstName" class="form-input" placeholder="First name" required>
                        </div>
                        <div class="form-group">
                            <label for="lastName">
                                <i class="fas fa-user"></i> Last Name
                            </label>
                            <input type="text" id="lastName" name="lastName" class="form-input" placeholder="Last name" required>
                        </div>
                        <div class="form-group">
                            <label for="username">
                                <i class="fas fa-at"></i> Username
                            </label>
                            <input type="text" id="username" name="username" class="form-input" placeholder="Username" required>
                        </div>
                    </div>

                    <!-- Row 2: Email, Phone, Secondary Phone -->
                    <div class="form-row">
                        <div class="form-group">
                            <label for="email">
                                <i class="fas fa-envelope"></i> Email
                            </label>
                            <input type="email" id="email" name="email" class="form-input" placeholder="Email" required>
                        </div>
                        <div class="form-group">
                            <label for="phone">
                                <i class="fas fa-phone"></i> Primary Phone
                            </label>
                            <input type="tel" id="phone" name="phone" class="form-input" placeholder="+94771234567" required>
                        </div>
                        <div class="form-group">
                            <label for="phone2">
                                <i class="fas fa-phone"></i> Secondary Phone
                            </label>
                            <input type="tel" id="phone2" name="phone2" class="form-input" placeholder="+94112345678">
                        </div>
                    </div>

                    <!-- Row 3: National ID, Date of Birth, City -->
                    <div class="form-row">
                        <div class="form-group">
                            <label for="nationalId">
                                <i class="fas fa-id-card"></i> National ID
                            </label>
                            <input type="text" id="nationalId" name="nationalId" class="form-input" placeholder="ID">
                        </div>
                        <div class="form-group">
                            <label for="dateOfBirth">
                                <i class="fas fa-calendar"></i> DOB
                            </label>
                            <input type="date" id="dateOfBirth" name="dateOfBirth" class="form-input">
                        </div>
                        <div class="form-group">
                            <label for="city">
                                <i class="fas fa-city"></i> City
                            </label>
                            <input type="text" id="city" name="city" class="form-input" placeholder="City">
                        </div>
                    </div>

                    <!-- Row 4: Address (Full Width) -->
                    <div class="form-row full-width">
                        <div class="form-group">
                            <label for="address">
                                <i class="fas fa-map-marker-alt"></i> Address
                            </label>
                            <textarea id="address" name="address" class="form-input" rows="3" placeholder="Enter address" style="resize: vertical; min-height: 70px;"></textarea>
                        </div>
                    </div>

                    <!-- Row 5: Country (Full Width) -->
                    <div class="form-row full-width">
                        <div class="form-group">
                            <label for="country">
                                <i class="fas fa-flag"></i> Country
                            </label>
                            <input type="text" id="country" name="country" class="form-input" value="Sri Lanka">
                        </div>
                    </div>

                    <!-- Form Actions -->
                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary" id="saveBtn">
                            <i class="fas fa-save"></i> Save
                        </button>
                        <button type="button" class="btn btn-secondary" onclick="loadProfileData()">
                            <i class="fas fa-undo"></i> Reset
                        </button>
                    </div>
                </form>
            </div>

            <!-- Security Section -->
            <div class="profile-section" id="securitySection">
                <div class="info-card">
                    <h4><i class="fas fa-shield-alt"></i> Account Security</h4>
                    <p>Manage your account security settings and password.</p>
                </div>

                <div class="password-section">
                    <h4><i class="fas fa-key"></i> Password Management</h4>
                    <p>For security reasons, password changes are handled separately.</p>
                    <button class="btn btn-danger" onclick="goToPasswordReset()">
                        <i class="fas fa-lock"></i> Change Password
                    </button>
                </div>

                <!-- Account Info -->
                <div style="margin-top: 25px;">
                    <h4 style="font-size: 13px; font-weight: 600; margin-bottom: 12px;">Account Information</h4>
                    <div class="account-info-grid">
                        <div class="account-info-item">
                            <strong>Account Created:</strong>
                            <span id="accountCreated">Loading...</span>
                        </div>
                        <div class="account-info-item">
                            <strong>Last Login:</strong>
                            <span id="lastLogin">Loading...</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Preferences Section -->
            <div class="profile-section" id="preferencesSection">
                <div class="info-card">
                    <h4><i class="fas fa-cog"></i> Account Preferences</h4>
                    <p>Customize your account preferences and settings.</p>
                </div>

                <div style="background: #f8f9fa; padding: 30px; border-radius: 8px; text-align: center;">
                    <h4 style="font-size: 14px; margin-bottom: 10px;">Coming Soon</h4>
                    <p style="font-size: 12px; color: #666; margin-bottom: 15px;">Preference settings will be available in future updates.</p>
                    <i class="fas fa-tools" style="font-size: 40px; color: #ccc;"></i>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
console.log('🚀 Profile page loaded');

// Show message function
function showMessage(text, type) {
    const messageDiv = document.getElementById('msg');
    messageDiv.textContent = text;
    messageDiv.className = 'message ' + type + ' show';
    setTimeout(() => messageDiv.classList.remove('show'), 5000);
}

// Show profile section
function showProfileSection(section) {
    document.querySelectorAll('.profile-section').forEach(s => s.classList.remove('active'));
    document.querySelectorAll('.profile-tab').forEach(t => t.classList.remove('active'));
    
    document.getElementById(section + 'Section').classList.add('active');
    event.target.classList.add('active');
}

// Load profile data
function loadProfileData() {
    console.log('📊 Loading profile data...');
    
    fetch('getProfile')
        .then(response => {
            if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
            return response.json();
        })
        .then(data => {
            if (data.success) {
                const user = data.user;
                const firstName = user.firstName || '';
                const lastName = user.lastName || '';
                const fullName = (firstName && lastName) ? `${firstName} ${lastName}` : 
                                firstName || lastName || user.username || 'User';
                
                document.getElementById('profileAvatar').textContent = fullName.charAt(0).toUpperCase();
                document.getElementById('profileName').textContent = fullName;
                document.getElementById('profileUsername').textContent = '@' + (user.username || 'user');
                document.getElementById('profileEmail').textContent = user.email || '';
                
                document.getElementById('firstName').value = user.firstName || '';
                document.getElementById('lastName').value = user.lastName || '';
                document.getElementById('username').value = user.username || '';
                document.getElementById('email').value = user.email || '';
                document.getElementById('phone').value = user.phone || '';
                document.getElementById('phone2').value = user.phone2 || '';
                document.getElementById('nationalId').value = user.nationalId || '';
                document.getElementById('dateOfBirth').value = user.dateOfBirth || '';
                document.getElementById('address').value = user.address || '';
                document.getElementById('city').value = user.city || '';
                document.getElementById('country').value = user.country || 'Sri Lanka';
                
                document.getElementById('accountCreated').textContent = user.createdAt || 'N/A';
                document.getElementById('lastLogin').textContent = user.lastLogin || 'N/A';
                
            } else {
                showMessage('❌ ' + data.message, 'error');
            }
        })
        .catch(error => {
            showMessage('⚠️ Network error', 'error');
        });
}

// Save profile data
document.getElementById('profileForm').addEventListener('submit', function(e) {
    e.preventDefault();
    
    const saveBtn = document.getElementById('saveBtn');
    saveBtn.disabled = true;
    saveBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Saving...';
    
    const formData = {
        firstName: document.getElementById('firstName').value.trim(),
        lastName: document.getElementById('lastName').value.trim(),
        username: document.getElementById('username').value.trim(),
        email: document.getElementById('email').value.trim(),
        phone: document.getElementById('phone').value.trim(),
        phone2: document.getElementById('phone2').value.trim(),
        nationalId: document.getElementById('nationalId').value.trim(),
        dateOfBirth: document.getElementById('dateOfBirth').value.trim(),
        address: document.getElementById('address').value.trim(),
        city: document.getElementById('city').value.trim(),
        country: document.getElementById('country').value.trim()
    };
    
    if (!formData.firstName || !formData.lastName || !formData.username || !formData.email || !formData.phone) {
        showMessage('❌ Please fill all required fields', 'error');
        saveBtn.disabled = false;
        saveBtn.innerHTML = '<i class="fas fa-save"></i> Save';
        return;
    }
    
    const params = new URLSearchParams();
    Object.keys(formData).forEach(key => params.append(key, formData[key]));
    
    fetch('updateProfile', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: params.toString()
    })
    .then(r => r.json())
    .then(data => {
        saveBtn.disabled = false;
        saveBtn.innerHTML = '<i class="fas fa-save"></i> Save';
        
        if (data.success) {
            showMessage('✅ Profile updated!', 'success');
            if (typeof updateNavbarForLoggedInUser === 'function') {
                updateNavbarForLoggedInUser(data.user);
            }
            setTimeout(loadProfileData, 1000);
        } else {
            showMessage('❌ ' + data.message, 'error');
        }
    })
    .catch(error => {
        saveBtn.disabled = false;
        saveBtn.innerHTML = '<i class="fas fa-save"></i> Save';
        showMessage('⚠️ Network error', 'error');
    });
});

function goToPasswordReset() {
    if (typeof loadPage === 'function') {
        loadPage('profile/password-reset');
    }
}

document.addEventListener('DOMContentLoaded', loadProfileData);
setTimeout(loadProfileData, 1000);
</script>
