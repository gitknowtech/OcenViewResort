<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet" href="css/login/signup.css">

<!-- Signup Page Content -->
<div class="signup-page-content">
    <!-- Signup Container -->
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

                <form class="signup-form" method="POST" action="signupProcess.jsp">
                    <!-- Email Field -->
                    <div class="form-group">
                        <label for="signup-email">
                            <i class="fas fa-envelope"></i> Email Address
                        </label>
                        <input 
                            type="email" 
                            id="signup-email" 
                            name="email" 
                            class="form-input" 
                            placeholder="Enter your email"
                            required
                        >
                        <span class="form-error" id="signup-email-error"></span>
                    </div>

                    <!-- Password Field -->
                    <div class="form-group">
                        <label for="signup-password">
                            <i class="fas fa-lock"></i> Password
                        </label>
                        <div class="password-input-wrapper">
                            <input 
                                type="password" 
                                id="signup-password" 
                                name="password" 
                                class="form-input" 
                                placeholder="Create a password"
                                required
                            >
                            <button type="button" class="toggle-password" data-target="signup-password">
                                <i class="fas fa-eye"></i>
                            </button>
                        </div>
                        <span class="form-error" id="signup-password-error"></span>
                        <div class="password-strength" id="password-strength">
                            <div class="strength-bar">
                                <div class="strength-fill" id="strength-fill"></div>
                            </div>
                            <span class="strength-text" id="strength-text">Password strength</span>
                        </div>
                    </div>

                    <!-- Confirm Password Field -->
                    <div class="form-group">
                        <label for="confirm-password">
                            <i class="fas fa-lock"></i> Confirm Password
                        </label>
                        <div class="password-input-wrapper">
                            <input 
                                type="password" 
                                id="confirm-password" 
                                name="confirmPassword" 
                                class="form-input" 
                                placeholder="Confirm your password"
                                required
                            >
                            <button type="button" class="toggle-password" data-target="confirm-password">
                                <i class="fas fa-eye"></i>
                            </button>
                        </div>
                        <span class="form-error" id="confirm-password-error"></span>
                    </div>

                    <!-- Terms & Conditions -->
                    <div class="form-options">
                        <label class="terms-checkbox">
                            <input type="checkbox" name="terms" id="terms" required>
                            <span>I agree to the <a href="#" class="terms-link">Terms of Service</a> and <a href="#" class="privacy-link">Privacy Policy</a></span>
                        </label>
                    </div>

                    <!-- Signup Button -->
                    <button type="submit" class="signup-submit-btn">
                        <i class="fas fa-user-plus"></i> Create Account
                    </button>

                    <!-- Login Link -->
                    <div class="login-link">
                        <p>Already have an account? <a href="#" data-page="login/login">Sign in here</a></p>
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

<!-- Signup JavaScript -->
<script>
document.addEventListener('DOMContentLoaded', function() {
    // Password toggle
    document.querySelectorAll('.toggle-password').forEach(button => {
        button.addEventListener('click', function() {
            const targetId = this.getAttribute('data-target');
            const passwordInput = document.getElementById(targetId);
            
            if (passwordInput) {
                const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
                passwordInput.setAttribute('type', type);
                
                const icon = this.querySelector('i');
                icon.classList.toggle('fa-eye');
                icon.classList.toggle('fa-eye-slash');
            }
        });
    });
    
    // Password strength
    const passwordInput = document.getElementById('signup-password');
    const strengthFill = document.getElementById('strength-fill');
    const strengthText = document.getElementById('strength-text');
    
    if (passwordInput && strengthFill && strengthText) {
        passwordInput.addEventListener('input', function() {
            const password = this.value;
            const strength = calculatePasswordStrength(password);
            updatePasswordStrength(strength, strengthFill, strengthText);
        });
    }
    
    // Form validation
    const signupForm = document.querySelector('.signup-form');
    if (signupForm) {
        signupForm.addEventListener('submit', function(e) {
            e.preventDefault();
            
            const email = document.getElementById('signup-email').value;
            const password = document.getElementById('signup-password').value;
            const confirmPassword = document.getElementById('confirm-password').value;
            const terms = document.getElementById('terms').checked;
            
            // Clear errors
            document.getElementById('signup-email-error').textContent = '';
            document.getElementById('signup-password-error').textContent = '';
            document.getElementById('confirm-password-error').textContent = '';
            
            let isValid = true;
            
            if (!email) {
                document.getElementById('signup-email-error').textContent = 'Email is required';
                isValid = false;
            } else if (!/\S+@\S+\.\S+/.test(email)) {
                document.getElementById('signup-email-error').textContent = 'Please enter a valid email';
                isValid = false;
            }
            
            if (!password) {
                document.getElementById('signup-password-error').textContent = 'Password is required';
                isValid = false;
            } else if (password.length < 8) {
                document.getElementById('signup-password-error').textContent = 'Password must be at least 8 characters';
                isValid = false;
            }
            
            if (!confirmPassword) {
                document.getElementById('confirm-password-error').textContent = 'Please confirm your password';
                isValid = false;
            } else if (password !== confirmPassword) {
                document.getElementById('confirm-password-error').textContent = 'Passwords do not match';
                isValid = false;
            }
            
            if (!terms) {
                alert('Please accept the Terms of Service and Privacy Policy');
                isValid = false;
            }
            
            if (isValid) {
                const submitBtn = document.querySelector('.signup-submit-btn');
                const originalText = submitBtn.innerHTML;
                submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Creating Account...';
                submitBtn.disabled = true;
                
                setTimeout(() => {
                    submitBtn.innerHTML = originalText;
                    submitBtn.disabled = false;
                    alert('Account created successfully!');
                }, 2000);
            }
        });
    }
});

// Password strength calculation
function calculatePasswordStrength(password) {
    let strength = 0;
    if (password.length >= 8) strength += 1;
    if (password.length >= 12) strength += 1;
    if (/[a-z]/.test(password)) strength += 1;
    if (/[A-Z]/.test(password)) strength += 1;
    if (/\d/.test(password)) strength += 1;
    if (/[^A-Za-z0-9]/.test(password)) strength += 1;
    return Math.min(strength, 4);
}

function updatePasswordStrength(strength, fillElement, textElement) {
    const colors = ['#ef4444', '#f59e0b', '#eab308', '#22c55e', '#16a34a'];
    const texts = ['Very Weak', 'Weak', 'Fair', 'Good', 'Strong'];
    const widths = [20, 40, 60, 80, 100];
    
    if (strength === 0) {
        fillElement.style.width = '0%';
        fillElement.style.backgroundColor = '#e5e7eb';
        textElement.textContent = 'Password strength';
        textElement.style.color = '#6b7280';
    } else {
        fillElement.style.width = widths[strength - 1] + '%';
        fillElement.style.backgroundColor = colors[strength - 1];
        textElement.textContent = texts[strength - 1];
        textElement.style.color = colors[strength - 1];
    }
}
</script>
