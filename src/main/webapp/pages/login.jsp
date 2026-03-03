<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Ocean View Beach Resort</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/login.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar">
        <div class="nav-container">
            <div class="nav-logo">
                <img src="images/logo.png" alt="Ocean View Resort" class="logo" onerror="this.style.display='none'">
                <span class="logo-text">Ocean View</span>
            </div>
            <ul class="nav-menu" id="nav-menu">
                <li class="nav-item">
                    <a href="index.jsp" class="nav-link">HOME</a>
                </li>
                <li class="nav-item">
                    <a href="index.jsp" class="nav-link">ACCOMMODATION</a>
                </li>
                <li class="nav-item">
                    <a href="index.jsp" class="nav-link">EVENTS</a>
                </li>
                <li class="nav-item">
                    <a href="index.jsp" class="nav-link">GALLERY</a>
                </li>
                <li class="nav-item">
                    <a href="index.jsp" class="nav-link">CONTACT US</a>
                </li>
                <li class="nav-item">
                    <a href="login.jsp" class="nav-link login-btn active">
                        <i class="fas fa-sign-in-alt"></i> LOGIN
                    </a>
                </li>
            </ul>
            <div class="hamburger" id="hamburger">
                <span class="bar"></span>
                <span class="bar"></span>
                <span class="bar"></span>
            </div>
        </div>
    </nav>

    <!-- Login Container -->
    <main class="login-page">
        <div class="login-container">
            <!-- Left Side - Branding -->
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

            <!-- Right Side - Login Form -->
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

                        <!-- Divider -->
                        <div class="form-divider">
                            <span>or</span>
                        </div>

                        <!-- Social Login Options -->
                        <div class="social-login">
                            <button type="button" class="social-btn facebook-btn">
                                <i class="fab fa-facebook-f"></i>
                                <span>Facebook</span>
                            </button>
                            <button type="button" class="social-btn google-btn">
                                <i class="fab fa-google"></i>
                                <span>Google</span>
                            </button>
                        </div>

                        <!-- Sign Up Link -->
                        <div class="signup-link">
                            <p>Don't have an account? <a href="signup.jsp">Sign up here</a></p>
                        </div>
                    </form>

                    <!-- Additional Info -->
                    <div class="login-footer">
                        <p>By signing in, you agree to our <a href="#">Terms of Service</a> and <a href="#">Privacy Policy</a></p>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="footer">
        <div class="footer-bottom">
            <p>&copy; 2026 Ocean View Beach Resort. All rights reserved.</p>
            <div class="footer-bottom-links">
                <a href="#">Privacy Policy</a>
                <a href="#">Terms of Service</a>
                <a href="#">Sitemap</a>
            </div>
        </div>
    </footer>

    <script src="js/login.js"></script>
</body>
</html>
