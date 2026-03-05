<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet" href="css/login/signup.css">

<style>
/* Message Styles - Enhanced */
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
.show { display: block; }

@keyframes slideIn {
    from { transform: translateX(100%); opacity: 0; }
    to { transform: translateX(0); opacity: 1; }
}

/* Success redirect message style */
.redirect-message {
    background: linear-gradient(135deg, #3b82f6, #1d4ed8);
    color: white;
    border-left: 4px solid #1e40af;
}
</style>

<!-- Message Container -->
<div id="msg" class="message"></div>

<div class="signup-page-content">
    <div class="signup-container">
        <!-- Left Column - Branding -->
        <div class="signup-branding">
            <div class="branding-content">
                <div class="branding-logo">
                    <i class="fas fa-water"></i>
                </div>
                <h1>Ocean View</h1>
                <p>Beach Resort</p>
                <div class="branding-description">
                    <p>Join us for an unforgettable experience in beautiful Kalpitiya, Sri Lanka</p>
                </div>
                <div class="branding-features">
                    <div class="feature">
                        <i class="fas fa-user-plus"></i>
                        <span>Quick Registration</span>
                    </div>
                    <div class="feature">
                        <i class="fas fa-shield-alt"></i>
                        <span>Secure Account</span>
                    </div>
                    <div class="feature">
                        <i class="fas fa-gift"></i>
                        <span>Exclusive Offers</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Right Column - Simple Signup Form -->
        <div class="signup-form-container">
            <div class="signup-form-wrapper">
                <div class="form-header">
                    <h2>Create Account</h2>
                    <p>Join Ocean View Beach Resort</p>
                </div>

                <!-- SIMPLE FORM - 5 FIELDS ONLY -->
                <form class="signup-form" id="f" method="post" action="signup">
                    
                    <!-- Username Field -->
                    <div class="form-group">
                        <label for="u">
                            <i class="fas fa-user"></i> Username
                        </label>
                        <input 
                            type="text" 
                            id="u" 
                            name="username"
                            class="form-input" 
                            placeholder="Choose a unique username"
                            required
                        >
                        <span class="form-error" id="ue"></span>
                    </div>

                    <!-- Email Field -->
                    <div class="form-group">
                        <label for="e">
                            <i class="fas fa-envelope"></i> Email Address
                        </label>
                        <input 
                            type="email" 
                            id="e" 
                            name="email"
                            class="form-input" 
                            placeholder="Enter your email address"
                            required
                        >
                        <span class="form-error" id="ee"></span>
                    </div>

                    <!-- Mobile Number Field -->
                    <div class="form-group">
                        <label for="m">
                            <i class="fas fa-mobile-alt"></i> Mobile Number
                        </label>
                        <input 
                            type="tel" 
                            id="m" 
                            name="mobile"
                            class="form-input" 
                            placeholder="+94771234567"
                            required
                        >
                        <span class="form-error" id="me"></span>
                    </div>

                    <!-- Password Field -->
                    <div class="form-group">
                        <label for="p">
                            <i class="fas fa-lock"></i> Password
                        </label>
                        <div class="password-input-wrapper">
                            <input 
                                type="password" 
                                id="p" 
                                name="password"
                                class="form-input" 
                                placeholder="Create a strong password"
                                required
                            >
                            <button type="button" class="toggle-password" onclick="togglePassword('p')">
                                <i class="fas fa-eye"></i>
                            </button>
                        </div>
                        <span class="form-error" id="pe"></span>
                    </div>

                    <!-- Confirm Password Field -->
                    <div class="form-group">
                        <label for="cp">
                            <i class="fas fa-lock"></i> Confirm Password
                        </label>
                        <div class="password-input-wrapper">
                            <input 
                                type="password" 
                                id="cp" 
                                name="confirmPassword"
                                class="form-input" 
                                placeholder="Confirm your password"
                                required
                            >
                            <button type="button" class="toggle-password" onclick="togglePassword('cp')">
                                <i class="fas fa-eye"></i>
                            </button>
                        </div>
                        <span class="form-error" id="cpe"></span>
                    </div>

                    <!-- Terms & Conditions -->
                    <div class="form-options">
                        <label class="terms-checkbox">
                            <input type="checkbox" id="t" required>
                            <span>I agree to the <a href="#" class="terms-link">Terms of Service</a> and <a href="#" class="privacy-link">Privacy Policy</a></span>
                        </label>
                    </div>

                    <!-- Signup Button -->
                    <button type="submit" class="signup-submit-btn" id="btn">
                        <i class="fas fa-user-plus"></i> Create Account
                    </button>

                    <!-- Login Link -->
                    <div class="login-link">
                        <p>Already have an account? <a href="#" onclick="goLogin()">Sign in here</a></p>
                    </div>

                    <!-- Footer -->
                    <div class="signup-footer">
                        <p>By creating an account, you agree to receive promotional emails from Ocean View Beach Resort</p>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
console.log('✅ Simple Signup script loaded');

// Enhanced message function
function msg(text, type, callback) {
    const m = document.getElementById('msg');
    m.textContent = text;
    m.className = 'message ' + type + ' show';
    
    setTimeout(() => {
        m.classList.remove('show');
        if (callback) callback();
    }, 5000);
}

// Show success message with countdown and redirect
function showSuccessWithRedirect(message) {
    const m = document.getElementById('msg');
    m.className = 'message success show';
    
    let countdown = 3;
    
    function updateMessage() {
        m.textContent = `🎉 ${message} Redirecting to login in ${countdown}s...`;
        countdown--;
        
        if (countdown >= 0) {
            setTimeout(updateMessage, 1000);
        } else {
            m.classList.remove('show');
            goLogin();
        }
    }
    
    updateMessage();
}

// Clear form function
function clear() {
    const fields = ['u', 'e', 'm', 'p', 'cp'];
    const errors = ['ue', 'ee', 'me', 'pe', 'cpe'];
    
    fields.forEach(field => {
        document.getElementById(field).value = '';
        document.getElementById(field).classList.remove('error');
    });
    
    errors.forEach(error => {
        document.getElementById(error).textContent = '';
    });
    
    document.getElementById('t').checked = false;
}

// Password toggle function
function togglePassword(fieldId) {
    const field = document.getElementById(fieldId);
    const button = field.nextElementSibling;
    const icon = button.querySelector('i');
    
    if (field.type === 'password') {
        field.type = 'text';
        icon.className = 'fas fa-eye-slash';
    } else {
        field.type = 'password';
        icon.className = 'fas fa-eye';
    }
}

// Go to login function
function goLogin() {
    if (typeof loadPage === 'function') {
        loadPage('login/login');
    } else {
        console.log('Redirecting to login page...');
        window.location.href = 'login.jsp';
    }
}

// Form submission handler - SIMPLE VERSION
document.getElementById('f').onsubmit = function(e) {
    e.preventDefault();
    
    // Get field values
    const username = document.getElementById('u').value.trim();
    const email = document.getElementById('e').value.trim();
    const mobile = document.getElementById('m').value.trim();
    const password = document.getElementById('p').value;
    const confirmPassword = document.getElementById('cp').value;
    const terms = document.getElementById('t').checked;
    const btn = document.getElementById('btn');
    
    // Clear all errors
    const errors = ['ue', 'ee', 'me', 'pe', 'cpe'];
    const fields = ['u', 'e', 'm', 'p', 'cp'];
    
    errors.forEach(error => document.getElementById(error).textContent = '');
    fields.forEach(field => document.getElementById(field).classList.remove('error'));
    
    let ok = true;
    
    // Validation
    if (!username) { 
        document.getElementById('ue').textContent = 'Username is required'; 
        document.getElementById('u').classList.add('error');
        ok = false; 
    } else if (username.length < 3) {
        document.getElementById('ue').textContent = 'Username must be at least 3 characters';
        document.getElementById('u').classList.add('error');
        ok = false;
    } else if (!/^[a-zA-Z0-9_]+$/.test(username)) {
        document.getElementById('ue').textContent = 'Username can only contain letters, numbers, and underscores';
        document.getElementById('u').classList.add('error');
        ok = false;
    }
    
    if (!email) { 
        document.getElementById('ee').textContent = 'Email is required'; 
        document.getElementById('e').classList.add('error');
        ok = false; 
    } else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
        document.getElementById('ee').textContent = 'Please enter a valid email address';
        document.getElementById('e').classList.add('error');
        ok = false;
    }
    
    if (!mobile) { 
        document.getElementById('me').textContent = 'Mobile number is required'; 
        document.getElementById('m').classList.add('error');
        ok = false; 
    } else if (!/^\+94\d{9}$/.test(mobile)) {
        document.getElementById('me').textContent = 'Please enter a valid Sri Lankan mobile number (+94xxxxxxxxx)';
        document.getElementById('m').classList.add('error');
        ok = false;
    }
    
    if (!password) { 
        document.getElementById('pe').textContent = 'Password is required'; 
        document.getElementById('p').classList.add('error');
        ok = false; 
    } else if (password.length < 8) { 
        document.getElementById('pe').textContent = 'Password must be at least 8 characters'; 
        document.getElementById('p').classList.add('error');
        ok = false; 
    }
    
    if (!confirmPassword) { 
        document.getElementById('cpe').textContent = 'Confirm password is required'; 
        document.getElementById('cp').classList.add('error');
        ok = false; 
    } else if (password !== confirmPassword) { 
        document.getElementById('cpe').textContent = 'Passwords do not match'; 
        document.getElementById('cp').classList.add('error');
        ok = false; 
    }
    
    if (!terms) { 
        msg('Please accept Terms of Service to continue', 'error'); 
        ok = false; 
    }
    
    if (!ok) return;
    
    // Show loading state
    btn.disabled = true;
    btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Creating Account...';
    
    // Send data
    const data = 'username=' + encodeURIComponent(username) + 
                 '&email=' + encodeURIComponent(email) + 
                 '&mobile=' + encodeURIComponent(mobile) +
                 '&password=' + encodeURIComponent(password) + 
                 '&confirmPassword=' + encodeURIComponent(confirmPassword);
    
    fetch('signup', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: data
    })
    .then(r => r.json())
    .then(d => {
        // Reset button
        btn.disabled = false;
        btn.innerHTML = '<i class="fas fa-user-plus"></i> Create Account';
        
        if (d.success) {
            console.log('✅ Account created successfully');
            clear();
            showSuccessWithRedirect(d.message + ' Welcome to Ocean View!');
        } else {
            msg('❌ ' + d.message, 'error');
        }
    })
    .catch(err => {
        // Reset button
        btn.disabled = false;
        btn.innerHTML = '<i class="fas fa-user-plus"></i> Create Account';
        console.error('❌ Error:', err);
        msg('⚠️ Network error. Please try again.', 'error');
    });
};
</script>
