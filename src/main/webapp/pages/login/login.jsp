<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet" href="css/login/login.css">

<!-- Login Page Content -->
<div class="login-page-content">
    <!-- Login Container -->
    <div class="login-container">
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

                <form class="login-form" method="POST" action="loginProcess.jsp">
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
                            <button type="button" class="toggle-password" id="toggle-password">
                                <i class="fas fa-eye"></i>
                            </button>
                        </div>
                        <span class="form-error" id="password-error"></span>
                    </div>

                    <!-- Remember Me & Forgot Password -->
                    <div class="form-options">
                        <label class="remember-me">
                            <input type="checkbox" name="remember" id="remember">
                            <span>Remember me</span>
                        </label>
                        <a href="#" class="forgot-password">Forgot Password?</a>
                    </div>

                    <!-- Login Button -->
                    <button type="submit" class="login-submit-btn">
                        <i class="fas fa-sign-in-alt"></i> Sign In
                    </button>

                    <!-- Sign Up Link -->
                    <div class="signup-link">
                        <p>Don't have an account? <a href="#" data-page="login/signup">Sign up here</a></p>
                    </div>

                    <!-- Footer -->
                    <div class="login-footer">
                        <p>By signing in, you agree to our <a href="#">Terms of Service</a> and <a href="#">Privacy Policy</a></p>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Login JavaScript -->
<script>
document.addEventListener('DOMContentLoaded', function() {
    // Password toggle
    const togglePassword = document.getElementById('toggle-password');
    const passwordInput = document.getElementById('password');
    
    if (togglePassword && passwordInput) {
        togglePassword.addEventListener('click', function() {
            const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
            passwordInput.setAttribute('type', type);
            
            const icon = this.querySelector('i');
            icon.classList.toggle('fa-eye');
            icon.classList.toggle('fa-eye-slash');
        });
    }
    
    // Form validation
    const loginForm = document.querySelector('.login-form');
    if (loginForm) {
        loginForm.addEventListener('submit', function(e) {
            e.preventDefault();
            
            const email = document.getElementById('email').value;
            const password = document.getElementById('password').value;
            
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
            } else if (password.length < 6) {
                document.getElementById('password-error').textContent = 'Password must be at least 6 characters';
                isValid = false;
            }
            
            if (isValid) {
                const submitBtn = document.querySelector('.login-submit-btn');
                const originalText = submitBtn.innerHTML;
                submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Signing In...';
                submitBtn.disabled = true;
                
                setTimeout(() => {
                    submitBtn.innerHTML = originalText;
                    submitBtn.disabled = false;
                    alert('Login successful!');
                }, 2000);
            }
        });
    }
});
</script>
