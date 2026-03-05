<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet" href="css/login/login.css">

<style>
/* User Status Bar */
.user-status-bar {
    position: fixed;
    top: 90px;
    right: 20px;
    background: linear-gradient(135deg, #10b981, #059669);
    color: white;
    padding: 12px 20px;
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.15);
    z-index: 1000;
    display: none;
    animation: slideIn 0.3s ease-out;
}

.user-status-bar.show { display: block; }

.user-status-bar .user-info {
    display: flex;
    align-items: center;
    gap: 10px;
}

.user-status-bar .user-avatar {
    width: 32px;
    height: 32px;
    background: rgba(255,255,255,0.2);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: bold;
}

.user-status-bar .user-details {
    display: flex;
    flex-direction: column;
}

.user-status-bar .user-name {
    font-weight: 600;
    font-size: 14px;
}

.user-status-bar .user-email {
    font-size: 11px;
    opacity: 0.8;
}

.user-status-bar .logout-btn {
    background: rgba(255,255,255,0.2);
    border: none;
    color: white;
    padding: 6px 12px;
    border-radius: 4px;
    cursor: pointer;
    margin-left: 10px;
    transition: background 0.2s;
    font-size: 12px;
}

.user-status-bar .logout-btn:hover {
    background: rgba(255,255,255,0.3);
}

/* Message Styles */
.message {
    position: fixed; 
    top: 20px; 
    right: 20px; 
    padding: 15px 20px; 
    border-radius: 8px; 
    z-index: 9999; 
    display: none; 
    font-weight: bold;
    box-shadow: 0 4px 12px rgba(0,0,0,0.15);
    min-width: 250px;
    animation: slideIn 0.3s ease-out;
}
.success { 
    background: linear-gradient(135deg, #10b981, #059669); 
    color: white; 
    border-left: 4px solid #047857;
}
.error { 
    background: linear-gradient(135deg, #ef4444, #dc2626); 
    color: white; 
    border-left: 4px solid #b91c1c;
}
.info { 
    background: linear-gradient(135deg, #3b82f6, #1d4ed8); 
    color: white; 
    border-left: 4px solid #1e40af;
}
.show { display: block; }

@keyframes slideIn {
    from { transform: translateX(100%); opacity: 0; }
    to { transform: translateX(0); opacity: 1; }
}

/* Form error highlighting */
.form-input.error {
    border-color: #dc2626 !important;
    background: #fef2f2 !important;
    box-shadow: 0 0 0 3px rgba(220, 38, 38, 0.1) !important;
}

.form-error {
    color: #dc2626;
    font-size: 0.75rem;
    margin-top: 4px;
    display: block;
    min-height: 18px;
}

.form-error.show {
    animation: errorSlideIn 0.3s ease-out;
}

@keyframes errorSlideIn {
    from { opacity: 0; transform: translateY(-5px); }
    to { opacity: 1; transform: translateY(0); }
}

/* Login method indicator */
.login-method-hint {
    font-size: 0.75rem;
    color: #6b7280;
    margin-top: 4px;
    display: block;
}

.login-method-hint.show {
    color: #10b981;
    font-weight: 500;
}

/* Hide login form when logged in */
.login-container.logged-in {
    display: none;
}

.logged-in-container {
    display: none;
    text-align: center;
    padding: 50px;
    background: white;
    border-radius: 12px;
    box-shadow: 0 4px 20px rgba(0, 51, 102, 0.15);
    max-width: 600px;
    margin: 50px auto;
}

.logged-in-container.show {
    display: block;
}

.logged-in-container h2 {
    color: rgba(0, 51, 102, 0.9);
    margin-bottom: 20px;
}

.logged-in-container .user-welcome {
    background: linear-gradient(135deg, rgba(0, 51, 102, 0.1), rgba(0, 68, 136, 0.1));
    padding: 25px;
    border-radius: 12px;
    margin-bottom: 25px;
    border-left: 4px solid #003366;
}

.logged-in-container .user-welcome h3 {
    margin: 0 0 10px 0;
    color: #003366;
    font-size: 20px;
}

.logged-in-container .user-welcome .user-info-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 15px;
    margin-top: 15px;
    text-align: left;
}

.logged-in-container .user-info-item {
    background: rgba(255, 255, 255, 0.7);
    padding: 12px;
    border-radius: 8px;
    border-left: 3px solid #10b981;
}

.logged-in-container .user-info-label {
    font-size: 12px;
    color: #666;
    font-weight: 500;
    margin-bottom: 4px;
}

.logged-in-container .user-info-value {
    font-size: 14px;
    color: #333;
    font-weight: 600;
}

.logged-in-container .action-buttons {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 15px;
    margin-top: 25px;
}

.logged-in-container .action-btn {
    background: linear-gradient(135deg, rgba(0, 51, 102, 0.95), rgba(0, 68, 136, 0.95));
    color: white;
    border: none;
    padding: 15px 20px;
    border-radius: 10px;
    cursor: pointer;
    text-decoration: none;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 10px;
    transition: all 0.3s ease;
    font-weight: 500;
    font-size: 14px;
}

.logged-in-container .action-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(0, 51, 102, 0.3);
}

.logged-in-container .action-btn i {
    font-size: 16px;
}

.logged-in-container .logout-btn {
    background: linear-gradient(135deg, #ef4444, #dc2626);
    grid-column: 1 / -1;
}

.logged-in-container .logout-btn:hover {
    box-shadow: 0 6px 20px rgba(239, 68, 68, 0.3);
}

/* Quick stats */
.logged-in-container .quick-stats {
    display: flex;
    justify-content: space-around;
    margin: 20px 0;
    padding: 20px;
    background: rgba(16, 185, 129, 0.1);
    border-radius: 10px;
}

.logged-in-container .stat-item {
    text-align: center;
}

.logged-in-container .stat-number {
    font-size: 24px;
    font-weight: bold;
    color: #10b981;
    display: block;
}

.logged-in-container .stat-label {
    font-size: 12px;
    color: #666;
    margin-top: 4px;
}

/* Responsive */
@media (max-width: 768px) {
    .logged-in-container {
        margin: 20px;
        padding: 30px 20px;
    }
    
    .logged-in-container .user-info-grid {
        grid-template-columns: 1fr;
    }
    
    .logged-in-container .action-buttons {
        grid-template-columns: 1fr;
    }
    
    .logged-in-container .quick-stats {
        flex-direction: column;
        gap: 15px;
    }
}
</style>

<!-- Message Container -->
<div id="msg" class="message"></div>

<!-- User Status Bar -->
<div id="userStatusBar" class="user-status-bar">
    <div class="user-info">
        <div class="user-avatar" id="statusUserAvatar">
            <i class="fas fa-user"></i>
        </div>
        <div class="user-details">
            <div class="user-name" id="statusUserName">User</div>
            <div class="user-email" id="statusUserEmail">user@example.com</div>
        </div>
        <button class="logout-btn" onclick="logoutFromLoginPage()">
            <i class="fas fa-sign-out-alt"></i> Logout
        </button>
    </div>
</div>

<!-- Login Page Content -->
<div class="login-page-content">
    <!-- Regular Login Container -->
    <div class="login-container" id="loginContainer">
        <!-- Left Column - Branding -->
        <div class="login-branding">
            <div class="branding-content">
                <div class="branding-logo">
                    <i class="fas fa-water"></i>
                </div>
                <h1>Ocean View</h1>
                <p>Beach Resort</p>
                <div class="branding-description">
                    <p>Experience luxury and adventure in beautiful Kalpitiya, Sri Lanka</p>
                </div>
                <div class="branding-features">
                    <div class="feature">
                        <i class="fas fa-star"></i>
                        <span>Premium Accommodation</span>
                    </div>
                    <div class="feature">
                        <i class="fas fa-compass"></i>
                        <span>Exciting Activities</span>
                    </div>
                    <div class="feature">
                        <i class="fas fa-utensils"></i>
                        <span>World-Class Cuisine</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Right Column - Login Form -->
        <div class="login-form-container">
            <div class="login-form-wrapper">
                <div class="form-header">
                    <h2>Welcome Back</h2>
                    <p>Sign in to your account</p>
                </div>

                <form class="login-form" id="loginForm" novalidate>
                    <!-- Username or Email Field -->
                    <div class="form-group">
                        <label for="loginField">
                            <i class="fas fa-user"></i> Username or Email
                        </label>
                        <input 
                            type="text" 
                            id="loginField" 
                            name="loginField" 
                            class="form-input" 
                            placeholder="Enter username or email"
                            autocomplete="username"
                            required
                        >
                        <span class="form-error" id="loginField-error"></span>
                        <span class="login-method-hint" id="loginMethodHint">You can use either username or email</span>
                    </div>

                    <!-- Password Field -->
                    <div class="form-group">
                        <label for="password">
                            <i class="fas fa-lock"></i> Password
                        </label>
                        <div class="password-input-wrapper">
                            <input 
                                type="password" 
                                id="password" 
                                name="password" 
                                class="form-input" 
                                placeholder="Enter your password"
                                autocomplete="current-password"
                                required
                            >
                            <button type="button" class="toggle-password" onclick="togglePasswordVisibility()">
                                <i class="fas fa-eye"></i>
                            </button>
                        </div>
                        <span class="form-error" id="password-error"></span>
                    </div>

                    <!-- Remember Me & Forgot Password -->
                    <div class="form-options">
                        <label class="remember-me">
                            <input type="checkbox" name="remember" id="remember">
                            <span>Remember me for 30 days</span>
                        </label>
                        <a href="#" class="forgot-password">Forgot Password?</a>
                    </div>

                    <!-- Login Button -->
                    <button type="submit" class="login-submit-btn" id="loginBtn">
                        <i class="fas fa-sign-in-alt"></i> Sign In
                    </button>

                    <!-- Sign Up Link -->
                    <div class="signup-link">
                        <p>Don't have an account? <a href="#" onclick="goToSignupPage()">Sign up here</a></p>
                    </div>

                    <!-- Footer -->
                    <div class="login-footer">
                        <p>By signing in, you agree to our <a href="#">Terms of Service</a> and <a href="#">Privacy Policy</a></p>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Enhanced Logged In Container -->
    <div class="logged-in-container" id="loggedInContainer">
        <h2><i class="fas fa-check-circle" style="color: #10b981;"></i> Welcome Back!</h2>
        
        <div class="user-welcome">
            <h3>Hello, <span id="welcomeUserName">User</span>! 👋</h3>
            
            <div class="user-info-grid">
                <div class="user-info-item">
                    <div class="user-info-label">Username</div>
                    <div class="user-info-value" id="welcomeUsername">username</div>
                </div>
                <div class="user-info-item">
                    <div class="user-info-label">Email Address</div>
                    <div class="user-info-value" id="welcomeUserEmail">user@example.com</div>
                </div>
                <div class="user-info-item">
                    <div class="user-info-label">Account Status</div>
                    <div class="user-info-value">
                        <i class="fas fa-check-circle" style="color: #10b981;"></i> Active
                    </div>
                </div>
                <div class="user-info-item">
                    <div class="user-info-label">Last Login</div>
                    <div class="user-info-value" id="lastLoginTime">Just now</div>
                </div>
            </div>
        </div>

        <!-- Quick Stats -->
        <div class="quick-stats">
            <div class="stat-item">
                <span class="stat-number" id="totalBookings">0</span>
                <span class="stat-label">Total Bookings</span>
            </div>
            <div class="stat-item">
                <span class="stat-number" id="activeBookings">0</span>
                <span class="stat-label">Active Bookings</span>
            </div>
            <div class="stat-item">
                <span class="stat-number" id="loyaltyPoints">0</span>
                <span class="stat-label">Loyalty Points</span>
            </div>
        </div>

        <!-- Action Buttons -->
        <div class="action-buttons">
            <a href="#" class="action-btn" onclick="goToBookingPage()">
                <i class="fas fa-calendar-plus"></i> New Booking
            </a>
            <a href="#" class="action-btn" onclick="goToBookingsPage()">
                <i class="fas fa-list"></i> My Bookings
            </a>
            <a href="#" class="action-btn" onclick="goToProfilePage()">
                <i class="fas fa-user-cog"></i> Profile Settings
            </a>
            <a href="#" class="action-btn" onclick="goToSupportPage()">
                <i class="fas fa-headset"></i> Support
            </a>
            <button class="action-btn logout-btn" onclick="logoutFromLoginPage()">
                <i class="fas fa-sign-out-alt"></i> Sign Out
            </button>
        </div>
    </div>
</div>

<script>
console.log('🚀 Login page loaded - USERNAME OR EMAIL VERSION');

let currentLoginPageUser = null;

// Enhanced message function
function showLoginMessage(text, type) {
    console.log(`LOGIN PAGE ${type.toUpperCase()}: ${text}`);
    
    // Remove existing messages first
    const existingMessages = document.querySelectorAll('.message, .main-message');
    existingMessages.forEach(msg => msg.remove());
    
    // Try to use main.js showMessage function first
    if (typeof showMessage === 'function') {
        showMessage(text, type);
        return;
    }
    
    // Fallback to local message display
    const messageDiv = document.getElementById('msg');
    if (messageDiv) {
        messageDiv.textContent = text;
        messageDiv.className = 'message ' + type + ' show';
        setTimeout(() => messageDiv.classList.remove('show'), 5000);
    }
}

// Detect login method and show hint
function detectLoginMethod() {
    const loginField = document.getElementById('loginField');
    const hint = document.getElementById('loginMethodHint');
    
    if (!loginField || !hint) return;
    
    const value = loginField.value.trim();
    
    if (!value) {
        hint.textContent = 'You can use either username or email';
        hint.classList.remove('show');
        return;
    }
    
    if (value.includes('@')) {
        hint.textContent = '📧 Email login detected';
        hint.classList.add('show');
    } else {
        hint.textContent = '👤 Username login detected';
        hint.classList.add('show');
    }
}

// Enhanced form validation
function validateLoginForm() {
    console.log('🔍 Validating login form...');
    
    const loginFieldInput = document.getElementById('loginField');
    const passwordInput = document.getElementById('password');
    const loginFieldError = document.getElementById('loginField-error');
    const passwordError = document.getElementById('password-error');
    
    if (!loginFieldInput || !passwordInput) {
        console.error('❌ Form elements not found!');
        showLoginMessage('Form elements not found. Please refresh the page.', 'error');
        return false;
    }
    
    const loginField = loginFieldInput.value.trim();
    const password = passwordInput.value;
    
    console.log('📊 Form values:', { 
        loginField: loginField, 
        loginFieldLength: loginField.length,
        password: password ? '[HIDDEN]' : 'EMPTY', 
        passwordLength: password.length 
    });
    
    // Clear previous errors and styling
    loginFieldInput.classList.remove('error');
    passwordInput.classList.remove('error');
    if (loginFieldError) loginFieldError.textContent = '';
    if (passwordError) passwordError.textContent = '';
    
    let isValid = true;
    
    // Login field validation (username or email)
    if (!loginField) {
        console.log('❌ Login field is empty');
        if (loginFieldError) {
            loginFieldError.textContent = 'Username or email is required';
            loginFieldError.classList.add('show');
        }
        loginFieldInput.classList.add('error');
        isValid = false;
    } else if (loginField.length < 3) {
        console.log('❌ Login field too short:', loginField.length);
        if (loginFieldError) {
            loginFieldError.textContent = 'Username or email must be at least 3 characters';
            loginFieldError.classList.add('show');
        }
        loginFieldInput.classList.add('error');
        isValid = false;
    } else if (loginField.includes('@') && !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(loginField)) {
        console.log('❌ Email format invalid:', loginField);
        if (loginFieldError) {
            loginFieldError.textContent = 'Please enter a valid email address';
            loginFieldError.classList.add('show');
        }
        loginFieldInput.classList.add('error');
        isValid = false;
    } else {
        console.log('✅ Login field is valid:', loginField);
    }
    
    // Password validation
    if (!password) {
        console.log('❌ Password is empty');
        if (passwordError) {
            passwordError.textContent = 'Password is required';
            passwordError.classList.add('show');
        }
        passwordInput.classList.add('error');
        isValid = false;
    } else if (password.length < 3) {
        console.log('❌ Password too short:', password.length);
        if (passwordError) {
            passwordError.textContent = 'Password must be at least 3 characters';
            passwordError.classList.add('show');
        }
        passwordInput.classList.add('error');
        isValid = false;
    } else {
        console.log('✅ Password is valid');
    }
    
    console.log('📊 Validation result:', isValid);
    return isValid;
}

// Password toggle
function togglePasswordVisibility() {
    const passwordInput = document.getElementById('password');
    const toggleBtn = document.querySelector('.toggle-password i');
    
    if (!passwordInput || !toggleBtn) return;
    
    if (passwordInput.type === 'password') {
        passwordInput.type = 'text';
        toggleBtn.className = 'fas fa-eye-slash';
    } else {
        passwordInput.type = 'password';
        toggleBtn.className = 'fas fa-eye';
    }
}

// Check user status on page load
function checkLoginPageUserStatus() {
    console.log('🔍 LOGIN PAGE: Checking user login status...');
    
    fetch('/OceanViewResort/checkUser')
        .then(response => {
            if (!response.ok) {
                throw new Error(`HTTP ${response.status}: ${response.statusText}`);
            }
            return response.json();
        })
        .then(data => {
            console.log('📊 LOGIN PAGE: User status:', data);
            
            if (data.loggedIn) {
                currentLoginPageUser = data.user;
                showLoggedInState(data.user, data.autoLogin);
            } else {
                showLoginForm();
            }
        })
        .catch(error => {
            console.error('❌ LOGIN PAGE: Error checking user status:', error);
            showLoginForm();
        });
}

// Show logged in state
function showLoggedInState(user, autoLogin = false) {
    console.log('✅ LOGIN PAGE: User is logged in:', user);
    
    const loginContainer = document.getElementById('loginContainer');
    const loggedInContainer = document.getElementById('loggedInContainer');
    
    if (loginContainer) loginContainer.style.display = 'none';
    if (loggedInContainer) loggedInContainer.classList.add('show');
    
    // Update user info in status bar
    const displayName = user.username || user.email.split('@')[0];
    const firstLetter = displayName.charAt(0).toUpperCase();
    
    const statusUserAvatar = document.getElementById('statusUserAvatar');
    const statusUserName = document.getElementById('statusUserName');
    const statusUserEmail = document.getElementById('statusUserEmail');
    
    if (statusUserAvatar) statusUserAvatar.textContent = firstLetter;
    if (statusUserName) statusUserName.textContent = displayName;
    if (statusUserEmail) statusUserEmail.textContent = user.email;
    
    // Update user info in welcome container
    const welcomeUserName = document.getElementById('welcomeUserName');
    const welcomeUsername = document.getElementById('welcomeUsername');
    const welcomeUserEmail = document.getElementById('welcomeUserEmail');
    const lastLoginTime = document.getElementById('lastLoginTime');
    
    if (welcomeUserName) welcomeUserName.textContent = displayName;
    if (welcomeUsername) welcomeUsername.textContent = user.username;
    if (welcomeUserEmail) welcomeUserEmail.textContent = user.email;
    if (lastLoginTime) lastLoginTime.textContent = new Date().toLocaleString();
    
    // Show user status bar
    const userStatusBar = document.getElementById('userStatusBar');
    if (userStatusBar) userStatusBar.classList.add('show');
    
    // Update main navbar using global function
    if (typeof updateNavbarForLoggedInUser === 'function') {
        updateNavbarForLoggedInUser(user);
    }
    
    if (autoLogin) {
        showLoginMessage('🎉 Welcome back, ' + displayName + '! Auto-logged in from saved session.', 'info');
    }
    
    // Load user stats
    loadUserStats();
}

// Show login form
function showLoginForm() {
    console.log('📝 LOGIN PAGE: Showing login form');
    
    const loginContainer = document.getElementById('loginContainer');
    const loggedInContainer = document.getElementById('loggedInContainer');
    const userStatusBar = document.getElementById('userStatusBar');
    
    if (loginContainer) loginContainer.style.display = 'flex';
    if (loggedInContainer) loggedInContainer.classList.remove('show');
    if (userStatusBar) userStatusBar.classList.remove('show');
    
    // Update main navbar using global function
    if (typeof updateNavbarForLoggedOutUser === 'function') {
        updateNavbarForLoggedOutUser();
    }
    
    currentLoginPageUser = null;
}

// Load user stats
function loadUserStats() {
    const totalBookings = document.getElementById('totalBookings');
    const activeBookings = document.getElementById('activeBookings');
    const loyaltyPoints = document.getElementById('loyaltyPoints');
    
    if (totalBookings) totalBookings.textContent = Math.floor(Math.random() * 10) + 1;
    if (activeBookings) activeBookings.textContent = Math.floor(Math.random() * 3);
    if (loyaltyPoints) loyaltyPoints.textContent = Math.floor(Math.random() * 1000) + 100;
}

// UPDATED: Login form submission with username or email
function handleLoginFormSubmission(e) {
    e.preventDefault();
    e.stopPropagation();
    
    console.log('🔐 LOGIN PAGE: Form submitted');
    
    // Validate form first
    if (!validateLoginForm()) {
        console.log('❌ Form validation failed');
        showLoginMessage('Please fix the errors above and try again.', 'error');
        return false;
    }
    
    const loginField = document.getElementById('loginField').value.trim();
    const password = document.getElementById('password').value;
    const remember = document.getElementById('remember').checked;
    const loginBtn = document.getElementById('loginBtn');
    
    console.log('📊 LOGIN PAGE: Sending login request for:', loginField);
    console.log('📊 LOGIN PAGE: Remember me:', remember);
    
    // Show loading state
    if (loginBtn) {
        loginBtn.disabled = true;
        loginBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Signing In...';
    }
    
    // Prepare form data with loginField (can be username or email)
    const formData = new URLSearchParams();
    formData.append('loginField', loginField);
    formData.append('password', password);
    if (remember) formData.append('remember', 'true');
    
    console.log('📊 LOGIN PAGE: Form data string:', formData.toString());
    
    // Send request with proper headers
    fetch('/OceanViewResort/login', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
        },
        body: formData.toString()
    })
    .then(response => {
        console.log('📊 LOGIN PAGE: Response status:', response.status);
        
        if (!response.ok) {
            throw new Error(`HTTP ${response.status}: ${response.statusText}`);
        }
        return response.json();
    })
    .then(data => {
        console.log('📊 LOGIN PAGE: Login response:', data);
        
        // Reset button
        if (loginBtn) {
            loginBtn.disabled = false;
            loginBtn.innerHTML = '<i class="fas fa-sign-in-alt"></i> Sign In';
        }
        
        if (data.success) {
            console.log('✅ LOGIN SUCCESS!');
            showLoginMessage('✅ ' + data.message, 'success');
            
            // Clear form
            document.getElementById('loginField').value = '';
            document.getElementById('password').value = '';
            document.getElementById('remember').checked = false;
            
            // Update main navbar immediately
            if (typeof updateNavbarForLoggedInUser === 'function') {
                updateNavbarForLoggedInUser(data.user);
            }
            
            // Show logged in state after delay
            setTimeout(() => {
                showLoggedInState(data.user);
            }, 1500);
            
        } else {
            console.log('❌ LOGIN FAILED:', data.message);
            showLoginMessage('❌ ' + data.message, 'error');
        }
    })
    .catch(error => {
        console.error('❌ LOGIN PAGE: Login error:', error);
        
        // Reset button
        if (loginBtn) {
            loginBtn.disabled = false;
            loginBtn.innerHTML = '<i class="fas fa-sign-in-alt"></i> Sign In';
        }
        
        showLoginMessage('⚠️ Network error. Please check your connection and try again.', 'error');
    });
    
    return false;
}

// Logout function
function logoutFromLoginPage() {
    if (!confirm('Are you sure you want to logout?')) return;
    
    console.log('👋 LOGIN PAGE: Logging out user...');
    
    fetch('/OceanViewResort/logout', {
        method: 'POST'
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            showLoginMessage('👋 ' + data.message, 'info');
            
            // Update main navbar
            if (typeof updateNavbarForLoggedOutUser === 'function') {
                updateNavbarForLoggedOutUser();
            }
            
            showLoginForm();
        } else {
            showLoginMessage('❌ Error during logout', 'error');
        }
    })
    .catch(error => {
        console.error('❌ LOGIN PAGE: Logout error:', error);
        showLoginMessage('⚠️ Network error during logout', 'error');
    });
}

// Navigation functions
function goToSignupPage() {
    console.log('🔗 LOGIN PAGE: Going to signup');
    if (typeof loadPage === 'function') {
        loadPage('login/signup');
    } else {
        console.warn('⚠️ loadPage function not available');
    }
}

function goToBookingPage() {
    console.log('🔗 LOGIN PAGE: Going to booking');
    if (typeof loadPage === 'function') {
        loadPage('reservation');
    }
}

function goToBookingsPage() {
    console.log('🔗 LOGIN PAGE: Going to bookings');
    if (typeof loadPage === 'function') {
        loadPage('bookings');
    }
}

function goToProfilePage() {
    console.log('🔗 LOGIN PAGE: Going to profile');
    if (typeof loadPage === 'function') {
        loadPage('profile');
    }
}

function goToSupportPage() {
    console.log('🔗 LOGIN PAGE: Going to support');
    if (typeof loadPage === 'function') {
        loadPage('support');
    }
}

// Real-time validation and login method detection
function setupRealTimeValidation() {
    const loginFieldInput = document.getElementById('loginField');
    const passwordInput = document.getElementById('password');
    
    if (loginFieldInput) {
        // Detect login method on input
        loginFieldInput.addEventListener('input', function() {
            this.classList.remove('error');
            const loginFieldError = document.getElementById('loginField-error');
            if (loginFieldError) loginFieldError.textContent = '';
            
            // Detect login method
            detectLoginMethod();
        });
        
        loginFieldInput.addEventListener('blur', function() {
            const loginField = this.value.trim();
            const loginFieldError = document.getElementById('loginField-error');
            
            this.classList.remove('error');
            if (loginFieldError) loginFieldError.textContent = '';
            
            if (loginField && loginField.includes('@') && !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(loginField)) {
                this.classList.add('error');
                if (loginFieldError) {
                    loginFieldError.textContent = 'Please enter a valid email address';
                    loginFieldError.classList.add('show');
                }
            }
        });
    }
    
    if (passwordInput) {
        passwordInput.addEventListener('input', function() {
            this.classList.remove('error');
            const passwordError = document.getElementById('password-error');
            if (passwordError) passwordError.textContent = '';
        });
    }
}

// Initialize when page loads
document.addEventListener('DOMContentLoaded', function() {
    console.log('🚀 LOGIN PAGE: DOM loaded, initializing...');
    
    setTimeout(checkLoginPageUserStatus, 100);
    
    const loginForm = document.getElementById('loginForm');
    if (loginForm) {
        loginForm.addEventListener('submit', handleLoginFormSubmission);
        console.log('✅ LOGIN PAGE: Form event listener attached');
    } else {
        console.error('❌ LOGIN PAGE: Form not found!');
    }
    
    setupRealTimeValidation();
});

// Also check when this script runs (for AJAX loaded pages)
setTimeout(function() {
    if (document.getElementById('loginForm')) {
        console.log('🔄 LOGIN PAGE: Setting up via timeout...');
        
        checkLoginPageUserStatus();
        
        const loginForm = document.getElementById('loginForm');
        if (loginForm && !loginForm.hasAttribute('data-handler-attached')) {
            loginForm.addEventListener('submit', handleLoginFormSubmission);
            loginForm.setAttribute('data-handler-attached', 'true');
            console.log('✅ LOGIN PAGE: Form handler attached via timeout');
        }
        
        setupRealTimeValidation();
    }
}, 200);

console.log('✅ LOGIN PAGE: All functions loaded and ready - USERNAME OR EMAIL VERSION');
</script>
