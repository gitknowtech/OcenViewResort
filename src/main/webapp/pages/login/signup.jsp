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

<!-- Same HTML structure as before -->
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
                        <span>Easy Registration</span>
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

        <!-- Right Column - Signup Form -->
        <div class="signup-form-container">
            <div class="signup-form-wrapper">
                <div class="form-header">
                    <h2>Create Account</h2>
                    <p>Join Ocean View Beach Resort</p>
                </div>

                <!-- WORKING FORM WITH CORRECT CSS CLASSES -->
                <form class="signup-form" id="f" method="post" action="signup">
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
                            placeholder="Enter your email"
                            required
                        >
                        <span class="form-error" id="ee"></span>
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
                                placeholder="Create a password"
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
console.log('✅ Signup script loaded with auto redirect');

// Enhanced message function with countdown
function msg(text, type, callback) {
    const m = document.getElementById('msg');
    m.textContent = text;
    m.className = 'message ' + type + ' show';
    
    // Auto hide after 5 seconds (or call callback)
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
            // Redirect to login
            goLogin();
        }
    }
    
    updateMessage();
}

// Clear form function
function clear() {
    document.getElementById('e').value = '';
    document.getElementById('p').value = '';
    document.getElementById('cp').value = '';
    document.getElementById('t').checked = false;
    document.getElementById('ee').textContent = '';
    document.getElementById('pe').textContent = '';
    document.getElementById('cpe').textContent = '';
    
    // Remove error styling
    document.getElementById('e').classList.remove('error');
    document.getElementById('p').classList.remove('error');
    document.getElementById('cp').classList.remove('error');
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
        // Alternative redirect if loadPage function is not available
        window.location.href = 'login.jsp'; // Change this to your login page URL
    }
}

// Form submission handler - UPDATED WITH AUTO REDIRECT
document.getElementById('f').onsubmit = function(e) {
    e.preventDefault();
    
    const email = document.getElementById('e').value.trim();
    const pass = document.getElementById('p').value;
    const cpass = document.getElementById('cp').value;
    const terms = document.getElementById('t').checked;
    const btn = document.getElementById('btn');
    
    // Clear errors
    document.getElementById('ee').textContent = '';
    document.getElementById('pe').textContent = '';
    document.getElementById('cpe').textContent = '';
    
    // Remove error styling
    document.getElementById('e').classList.remove('error');
    document.getElementById('p').classList.remove('error');
    document.getElementById('cp').classList.remove('error');
    
    let ok = true;
    
    // Validation with error styling
    if (!email) { 
        document.getElementById('ee').textContent = 'Email is required'; 
        document.getElementById('e').classList.add('error');
        ok = false; 
    } else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
        document.getElementById('ee').textContent = 'Please enter a valid email address';
        document.getElementById('e').classList.add('error');
        ok = false;
    }
    
    if (!pass) { 
        document.getElementById('pe').textContent = 'Password is required'; 
        document.getElementById('p').classList.add('error');
        ok = false; 
    } else if (pass.length < 8) { 
        document.getElementById('pe').textContent = 'Password must be 8+ characters'; 
        document.getElementById('p').classList.add('error');
        ok = false; 
    }
    
    if (!cpass) { 
        document.getElementById('cpe').textContent = 'Confirm password is required'; 
        document.getElementById('cp').classList.add('error');
        ok = false; 
    } else if (pass !== cpass) { 
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
    const data = 'email=' + encodeURIComponent(email) + 
                 '&password=' + encodeURIComponent(pass) + 
                 '&confirmPassword=' + encodeURIComponent(cpass);
    
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
            // SUCCESS - Show message with auto redirect
            console.log('✅ Account created successfully');
            clear();
            
            // Show success message with countdown and auto redirect
            showSuccessWithRedirect(d.message + ' Welcome to Ocean View! Please login.');
            
        } else {
            // ERROR
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
