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
        <button class="logout-btn" onclick="logout()">
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

                <form class="login-form" id="loginForm">
                    <!-- Email Field -->
                    <div class="form-group">
                        <label for="email">
                            <i class="fas fa-envelope"></i> Email Address
                        </label>
                        <input 
                            type="email" 
                            id="email" 
                            name="email" 
                            class="form-input" 
                            placeholder="Enter your email"
                            required
                        >
                        <span class="form-error" id="email-error"></span>
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
                                required
                            >
                            <button type="button" class="toggle-password" onclick="togglePassword()">
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
                        <p>Don't have an account? <a href="#" onclick="goToSignup()">Sign up here</a></p>
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
                    <div class="user-info-label">Member Since</div>
                    <div class="user-info-value" id="memberSince">2024</div>
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
            <a href="#" class="action-btn" onclick="goToBooking()">
                <i class="fas fa-calendar-plus"></i> New Booking
            </a>
            <a href="#" class="action-btn" onclick="goToBookings()">
                <i class="fas fa-list"></i> My Bookings
            </a>
            <a href="#" class="action-btn" onclick="goToProfile()">
                <i class="fas fa-user-cog"></i> Profile Settings
            </a>
            <a href="#" class="action-btn" onclick="goToSupport()">
                <i class="fas fa-headset"></i> Support
            </a>
            <button class="action-btn logout-btn" onclick="logout()">
                <i class="fas fa-sign-out-alt"></i> Sign Out
            </button>
        </div>
    </div>
</div>

<script>
console.log('🚀 Enhanced login page loaded with full navbar integration');

let currentUser = null;

// Message function
function showMessage(text, type) {
    const messageDiv = document.getElementById('msg');
    messageDiv.textContent = text;
    messageDiv.className = 'message ' + type + ' show';
    
    setTimeout(() => messageDiv.classList.remove('show'), 5000);
}

// Password toggle
function togglePassword() {
    const passwordInput = document.getElementById('password');
    const toggleBtn = document.querySelector('.toggle-password i');
    
    if (passwordInput.type === 'password') {
        passwordInput.type = 'text';
        toggleBtn.className = 'fas fa-eye-slash';
    } else {
        passwordInput.type = 'password';
        toggleBtn.className = 'fas fa-eye';
    }
}

// Check user status on page load
function checkUserStatus() {
    console.log('🔍 Checking user login status...');
    
    fetch('checkUser')
        .then(response => response.json())
        .then(data => {
            console.log('📊 User status:', data);
            
            if (data.loggedIn) {
                currentUser = data.user;
                showLoggedInState(data.user, data.autoLogin);
            } else {
                showLoginForm();
            }
        })
        .catch(error => {
            console.error('❌ Error checking user status:', error);
            showLoginForm();
        });
}

// Show logged in state
function showLoggedInState(user, autoLogin = false) {
    console.log('✅ User is logged in:', user);
    
    // Hide login form, show logged in container
    document.getElementById('loginContainer').style.display = 'none';
    document.getElementById('loggedInContainer').classList.add('show');
    
    // Update user info in status bar
    const displayName = user.name || user.email.split('@')[0];
    const firstLetter = displayName.charAt(0).toUpperCase();
    
    document.getElementById('statusUserAvatar').textContent = firstLetter;
    document.getElementById('statusUserName').textContent = displayName;
    document.getElementById('statusUserEmail').textContent = user.email;
    
    // Update user info in welcome container
    document.getElementById('welcomeUserName').textContent = displayName;
    document.getElementById('welcomeUserEmail').textContent = user.email;
    document.getElementById('memberSince').textContent = new Date().getFullYear();
    document.getElementById('lastLoginTime').textContent = new Date().toLocaleString();
    
    // Show user status bar
    document.getElementById('userStatusBar').classList.add('show');
    
    // Update navbar immediately
    if (typeof updateNavbarAfterLogin === 'function') {
        updateNavbarAfterLogin(user);
    }
    
    if (autoLogin) {
        showMessage('🎉 Welcome back, ' + displayName + '! Auto-logged in from saved session.', 'info');
    }
    
    // Load user stats (mock data for now)
    loadUserStats();
}

// Show login form
function showLoginForm() {
    console.log('📝 Showing login form');
    
    document.getElementById('loginContainer').style.display = 'flex';
    document.getElementById('loggedInContainer').classList.remove('show');
    document.getElementById('userStatusBar').classList.remove('show');
    
    // Update navbar to show login button
    if (typeof updateNavbarAfterLogout === 'function') {
        updateNavbarAfterLogout();
    }
    
    currentUser = null;
}

// Load user stats (mock function - replace with real API call)
function loadUserStats() {
    // Mock stats - replace with real API calls
    document.getElementById('totalBookings').textContent = Math.floor(Math.random() * 10) + 1;
    document.getElementById('activeBookings').textContent = Math.floor(Math.random() * 3);
    document.getElementById('loyaltyPoints').textContent = Math.floor(Math.random() * 1000) + 100;
}

// Login form submission
document.addEventListener('DOMContentLoaded', function() {
    // Check user status on load
    checkUserStatus();
    
    // Login form handler
    const loginForm = document.getElementById('loginForm');
    loginForm.addEventListener('submit', function(e) {
        e.preventDefault();
        
        const email = document.getElementById('email').value.trim();
        const password = document.getElementById('password').value;
        const remember = document.getElementById('remember').checked;
        const loginBtn = document.getElementById('loginBtn');
        
        // Clear errors
        document.getElementById('email-error').textContent = '';
        document.getElementById('password-error').textContent = '';
        
        let isValid = true;
        
        if (!email) {
            document.getElementById('email-error').textContent = 'Email is required';
            isValid = false;
        } else if (!/\S+@\S+\.\S+/.test(email)) {
            document.getElementById('email-error').textContent = 'Please enter a valid email';
            isValid = false;
        }
        
        if (!password) {
            document.getElementById('password-error').textContent = 'Password is required';
            isValid = false;
        }
        
        if (!isValid) return;
        
        // Show loading
        loginBtn.disabled = true;
        loginBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Signing In...';
        
        // Send login request
        const formData = new FormData();
        formData.append('email', email);
        formData.append('password', password);
        if (remember) formData.append('remember', 'true');
        
        fetch('login', {
            method: 'POST',
            body: formData
        })
        .then(response => response.json())
        .then(data => {
            loginBtn.disabled = false;
            loginBtn.innerHTML = '<i class="fas fa-sign-in-alt"></i> Sign In';
            
            if (data.success) {
                showMessage('✅ ' + data.message, 'success');
                
                // Clear form
                document.getElementById('email').value = '';
                document.getElementById('password').value = '';
                document.getElementById('remember').checked = false;
                
                // Update navbar immediately
                if (typeof updateNavbarAfterLogin === 'function') {
                    updateNavbarAfterLogin(data.user);
                }
                
                // Show logged in state
                setTimeout(() => {
                    showLoggedInState(data.user);
                }, 1000);
                
            } else {
                showMessage('❌ ' + data.message, 'error');
            }
        })
        .catch(error => {
            loginBtn.disabled = false;
            loginBtn.innerHTML = '<i class="fas fa-sign-in-alt"></i> Sign In';
            console.error('❌ Login error:', error);
            showMessage('⚠️ Network error. Please try again.', 'error');
        });
    });
});

// Logout function
function logout() {
    if (!confirm('Are you sure you want to logout?')) return;
    
    console.log('👋 Logging out user...');
    
    fetch('logout', {
        method: 'POST'
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            showMessage('👋 ' + data.message, 'info');
            
            // Update navbar immediately
            if (typeof updateNavbarAfterLogout === 'function') {
                updateNavbarAfterLogout();
            }
            
            showLoginForm();
        } else {
            showMessage('❌ Error during logout', 'error');
        }
    })
    .catch(error => {
        console.error('❌ Logout error:', error);
        showMessage('⚠️ Network error during logout', 'error');
    });
}

// Navigation functions
function goToSignup() {
    if (typeof loadPage === 'function') {
        loadPage('login/signup');
    }
}

function goToBooking() {
    if (typeof loadPage === 'function') {
        loadPage('reservation');
    }
}

function goToProfile() {
    if (typeof loadPage === 'function') {
        loadPage('profile');
    }
}

function goToBookings() {
    if (typeof loadPage === 'function') {
        loadPage('bookings');
    }
}

function goToSupport() {
    if (typeof loadPage === 'function') {
        loadPage('support');
    }
}

// Global functions for navbar communication
window.updateNavbarAfterLogin = function(user) {
    console.log('🔄 Updating navbar after login:', user);
    if (typeof updateNavbarAfterLogin === 'function') {
        updateNavbarAfterLogin(user);
    }
};

window.updateNavbarAfterLogout = function() {
    console.log('🔄 Updating navbar after logout');
    if (typeof updateNavbarAfterLogout === 'function') {
        updateNavbarAfterLogout();
    }
};
</script>
