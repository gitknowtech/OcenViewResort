<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ocean View Beach Resort - Kalpitiya, Sri Lanka</title>
    
    <!-- CSS Files in Order -->
    <link rel="stylesheet" href="css/common.css">
    <link rel="stylesheet" href="css/index/navbar.css">
    <link rel="stylesheet" href="css/index/footer.css">
    <link rel="stylesheet" href="css/index/pages.css">
    
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <!-- Navbar Spacing Fix + User Menu Styles -->
    <style>
        /* ============================================
           NAVBAR SPACING FIX - Prevent content overlap
           ============================================ */
        
        /* Reset body padding */
        body {
            padding-top: 0;
            margin: 0;
        }
        
        /* Main content spacing to account for fixed navbar */
        .main-content {
            padding-top: 85px; /* Space for navbar */
            min-height: calc(100vh - 85px);
            position: relative;
        }
        
        /* Loading spinner positioning */
        .common-loading-spinner {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            z-index: 9999;
            background: rgba(255, 255, 255, 0.95);
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            text-align: center;
            backdrop-filter: blur(10px);
        }
        
        .common-spinner {
            width: 40px;
            height: 40px;
            border: 4px solid #f3f3f3;
            border-top: 4px solid #003366;
            border-radius: 50%;
            animation: spin 1s linear infinite;
            margin: 0 auto 15px;
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        /* Hero sections - if you have any */
        .hero-section {
            margin-top: -85px;
            padding-top: 125px;
            min-height: 100vh;
        }
        
        /* Page headers */
        .page-header {
            padding-top: 110px;
            margin-bottom: 30px;
        }
        
        /* Content sections */
        .content-section {
            padding-top: 20px;
        }
        
        /* Ensure dropdown menus appear above content */
        .navbar-dropdown-menu {
            z-index: 1001;
        }
        
        /* Smooth scrolling */
        html {
            scroll-behavior: smooth;
        }
        
        /* Fix for any modals or overlays */
        .modal, .overlay, .lightbox {
            z-index: 1050;
        }
        
        /* ============================================
           USER MENU STYLES - UPDATED WITH USERNAME
           ============================================ */
        
        /* User menu dropdown */
        .navbar-user-menu {
            position: relative;
        }
        
        .navbar-user-toggle {
            display: flex;
            align-items: center;
            gap: 8px;
            background: rgba(255, 255, 255, 0.1);
            border: 2px solid rgba(255, 255, 255, 0.2);
            border-radius: 25px;
            padding: 8px 15px;
            color: white !important;
            transition: all 0.3s ease;
            cursor: pointer;
            font-weight: 500;
        }
        
        .navbar-user-toggle:hover {
            background: rgba(255, 255, 255, 0.15);
            border-color: rgba(255, 255, 255, 0.3);
            transform: translateY(-1px);
        }
        
        .navbar-user-avatar {
            width: 28px;
            height: 28px;
            background: linear-gradient(135deg, #10b981, #059669);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 13px;
            color: white;
            font-weight: bold;
            border: 2px solid rgba(255, 255, 255, 0.3);
        }
        
        .navbar-user-info {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            min-width: 120px;
        }
        
        .navbar-user-name {
            font-size: 14px;
            font-weight: 600;
            line-height: 1.2;
            margin-bottom: 1px;
        }
        
        .navbar-user-username {
            font-size: 11px;
            opacity: 0.85;
            line-height: 1;
            margin-bottom: 1px;
            color: rgba(255, 255, 255, 0.9);
            font-weight: 400;
        }
        
        .navbar-user-email {
            font-size: 10px;
            opacity: 0.75;
            line-height: 1;
            color: rgba(255, 255, 255, 0.8);
            font-weight: 300;
        }
        
        .navbar-user-dropdown {
            position: absolute;
            top: 100%;
            right: 0;
            background: white;
            min-width: 250px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
            border-radius: 12px;
            padding: 12px 0;
            opacity: 0;
            visibility: hidden;
            transform: translateY(-10px);
            transition: all 0.3s ease;
            z-index: 1000;
            border: 1px solid #e9ecef;
            margin-top: 8px;
        }
        
        .navbar-user-menu:hover .navbar-user-dropdown {
            opacity: 1;
            visibility: visible;
            transform: translateY(0);
        }
        
        .navbar-user-dropdown::before {
            content: '';
            position: absolute;
            top: -6px;
            right: 20px;
            width: 12px;
            height: 12px;
            background: white;
            border: 1px solid #e9ecef;
            border-bottom: none;
            border-right: none;
            transform: rotate(45deg);
        }
        
        .navbar-user-dropdown-header {
            padding: 15px 20px;
            border-bottom: 1px solid #f1f3f4;
            margin-bottom: 8px;
            background: linear-gradient(135deg, #f8f9fa, #e9ecef);
        }
        
        .navbar-user-dropdown-name {
            font-weight: 600;
            color: #333;
            font-size: 15px;
            margin-bottom: 4px;
        }
        
        .navbar-user-dropdown-username {
            font-weight: 500;
            color: #10b981;
            font-size: 13px;
            margin-bottom: 4px;
        }
        
        .navbar-user-dropdown-email {
            color: #666;
            font-size: 12px;
            font-weight: 400;
        }
        
        .navbar-user-dropdown-item {
            display: block;
            padding: 12px 20px;
            color: #555;
            text-decoration: none;
            transition: all 0.2s ease;
            font-size: 13px;
            border-bottom: 1px solid #f8f9fa;
            cursor: pointer;
        }
        
        .navbar-user-dropdown-item:hover {
            background: #f8f9fa;
            color: #007bff;
            padding-left: 24px;
        }
        
        .navbar-user-dropdown-item i {
            width: 18px;
            margin-right: 10px;
            text-align: center;
            font-size: 14px;
        }
        
        .navbar-user-dropdown-divider {
            height: 1px;
            background: #e9ecef;
            margin: 8px 0;
        }
        
        .navbar-user-dropdown-logout {
            color: #dc3545 !important;
            font-weight: 500;
        }
        
        .navbar-user-dropdown-logout:hover {
            background: #f8d7da !important;
            color: #721c24 !important;
        }
        
        /* Hide login button when user is logged in */
        .navbar-login-section.logged-in .navbar-btn-login {
            display: none;
        }
        
        .navbar-login-section.logged-out .navbar-user-menu {
            display: none;
        }
        
        /* ============================================
           RESPONSIVE USER MENU
           ============================================ */
        
        @media (max-width: 768px) {
            .navbar-user-toggle {
                padding: 6px 12px;
                border-radius: 20px;
            }
            
            .navbar-user-avatar {
                width: 24px;
                height: 24px;
                font-size: 11px;
            }
            
            .navbar-user-info {
                min-width: 100px;
            }
            
            .navbar-user-name {
                font-size: 12px;
            }
            
            .navbar-user-username {
                font-size: 10px;
            }
            
            .navbar-user-email {
                font-size: 9px;
            }
            
            .navbar-user-dropdown {
                position: static;
                opacity: 1;
                visibility: visible;
                transform: none;
                box-shadow: none;
                background: rgba(255, 255, 255, 0.95);
                margin: 8px 0 0 0;
                border-radius: 8px;
                min-width: 200px;
            }
            
            .navbar-user-dropdown::before {
                display: none;
            }
        }
        
        /* ============================================
           RESPONSIVE NAVBAR SPACING
           ============================================ */
        
        /* Tablet screens */
        @media (max-width: 768px) {
            .main-content {
                padding-top: 75px;
                min-height: calc(100vh - 75px);
            }
            
            .hero-section {
                margin-top: -75px;
                padding-top: 115px;
            }
            
            .page-header {
                padding-top: 95px;
            }
        }
        
        /* Mobile screens */
        @media (max-width: 480px) {
            .main-content {
                padding-top: 70px;
                min-height: calc(100vh - 70px);
            }
            
            .hero-section {
                margin-top: -70px;
                padding-top: 105px;
            }
            
            .page-header {
                padding-top: 90px;
            }
        }
        
        /* Very small screens */
        @media (max-width: 320px) {
            .main-content {
                padding-top: 65px;
                min-height: calc(100vh - 65px);
            }
            
            .hero-section {
                margin-top: -65px;
                padding-top: 100px;
            }
            
            .page-header {
                padding-top: 85px;
            }
        }
        
        /* ============================================
           ADDITIONAL IMPROVEMENTS
           ============================================ */
        
        /* Error message styling */
        .error-message {
            margin-top: 20px;
            animation: fadeIn 0.5s ease-in;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        /* Page transition effects */
        .main-content {
            transition: opacity 0.3s ease-in-out;
        }
        
        /* Ensure footer doesn't overlap */
        .footer-main {
            margin-top: 50px;
            position: relative;
            z-index: 1;
        }
        
        /* Mobile menu adjustments */
        @media (max-width: 768px) {
            .navbar-menu.active {
                top: 75px;
            }
        }
        
        @media (max-width: 480px) {
            .navbar-menu.active {
                top: 70px;
            }
        }
        
        @media (max-width: 320px) {
            .navbar-menu.active {
                top: 65px;
            }
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-main">
        <div class="navbar-container">
            <div class="navbar-logo">
                <img src="images/logo.png" alt="Ocean View Resort" class="navbar-logo-img" onerror="this.style.display='none'">
                <span class="navbar-logo-text">Ocean View</span>
            </div>
            
            <ul class="navbar-menu" id="nav-menu">
                <li class="navbar-item">
                    <a href="#" class="navbar-link navbar-link-active" data-page="home">HOME</a>
                </li>
                <li class="navbar-item">
                    <a href="#" class="navbar-link" data-page="accommodation">ACCOMMODATION</a>
                </li>
                <li class="navbar-item navbar-dropdown">
                    <a href="#" class="navbar-link navbar-dropdown-toggle" data-page="events">
                        EVENTS <i class="fas fa-chevron-down"></i>
                    </a>
                    <ul class="navbar-dropdown-menu">
                        <li><a href="#" class="navbar-dropdown-link" data-page="events">All Events</a></li>
                        <li><hr class="navbar-dropdown-divider"></li>
                        <li><a href="#" class="navbar-dropdown-link" data-page="events/wilpattu-safari">🦁 Wilpattu Safari</a></li>
                        <li><a href="#" class="navbar-dropdown-link" data-page="events/kitesurfing">🏄 Kitesurfing</a></li>
                        <li><a href="#" class="navbar-dropdown-link" data-page="events/whale-watching">🐋 Whale Watching</a></li>
                        <li><a href="#" class="navbar-dropdown-link" data-page="events/dolphin-watching">🐬 Dolphin Watching</a></li>
                        <li><a href="#" class="navbar-dropdown-link" data-page="events/island-boat-tour">⛵ Island Boat Tour</a></li>
                        <li><a href="#" class="navbar-dropdown-link" data-page="events/snorkeling">🤿 Snorkeling</a></li>
                    </ul>
                </li>
                <li class="navbar-item">
                    <a href="#" class="navbar-link" data-page="gallery">GALLERY</a>
                </li>
                <li class="navbar-item">
                    <a href="#" class="navbar-link" data-page="contact">CONTACT US</a>
                </li>
                
                <!-- LOGIN/USER SECTION - UPDATED WITH USERNAME -->
                <li class="navbar-item navbar-login-section logged-out" id="navbarLoginSection">
                    <!-- LOGIN BUTTON (shown when not logged in) -->
                    <a href="#" class="navbar-link navbar-btn-login" data-page="login/login" id="navbarLoginBtn">
                        <i class="fas fa-sign-in-alt"></i> LOGIN
                    </a>
                    
                    <!-- USER MENU (shown when logged in) -->
                    <div class="navbar-user-menu" id="navbarUserMenu">
                        <div class="navbar-user-toggle" id="navbarUserToggle">
                            <div class="navbar-user-avatar" id="navbarUserAvatar">U</div>
                            <div class="navbar-user-info">
                                <div class="navbar-user-name" id="navbarUserName">User Name</div>
                                <div class="navbar-user-username" id="navbarUserUsername">@username</div>
                                <div class="navbar-user-email" id="navbarUserEmail">user@example.com</div>
                            </div>
                            <i class="fas fa-chevron-down" style="font-size: 10px; margin-left: 4px;"></i>
                        </div>
                        
                        <div class="navbar-user-dropdown">
                            <div class="navbar-user-dropdown-header">
                                <div class="navbar-user-dropdown-name" id="navbarUserDropdownName">User Name</div>
                                <div class="navbar-user-dropdown-username" id="navbarUserDropdownUsername">@username</div>
                                <div class="navbar-user-dropdown-email" id="navbarUserDropdownEmail">user@example.com</div>
                            </div>
                            
                            <!-- ✅ UPDATED LINKS -->
                            <a href="#" class="navbar-user-dropdown-item" data-page="profile">
                                <i class="fas fa-user"></i> My Profile
                            </a>
                            <a href="#" class="navbar-user-dropdown-item" data-page="booking-view">
                                <i class="fas fa-calendar-alt"></i> My Bookings
                            </a>
                            <a href="#" class="navbar-user-dropdown-item" data-page="bookings">
                                <i class="fas fa-plus-circle"></i> New Booking
                            </a>
                            
                            <div class="navbar-user-dropdown-divider"></div>
                            
                            <a href="#" class="navbar-user-dropdown-item" data-page="settings">
                                <i class="fas fa-cog"></i> Settings
                            </a>
                            <a href="#" class="navbar-user-dropdown-item" data-page="help">
                                <i class="fas fa-question-circle"></i> Help & Support
                            </a>
                            
                            <div class="navbar-user-dropdown-divider"></div>
                            
                            <a href="#" class="navbar-user-dropdown-item navbar-user-dropdown-logout" onclick="logoutUser()">
                                <i class="fas fa-sign-out-alt"></i> Logout
                            </a>
                        </div>
                    </div>
                </li>
                
                <!-- ✅ UPDATED BOOK NOW BUTTON -->
                <li class="navbar-item">
                   <a href="#" class="navbar-link navbar-btn-book" data-page="bookings">BOOK NOW</a>
                </li>
            </ul>
            
            <div class="navbar-hamburger" id="hamburger">
                <span class="navbar-hamburger-bar"></span>
                <span class="navbar-hamburger-bar"></span>
                <span class="navbar-hamburger-bar"></span>
            </div>
        </div>
    </nav>

    <!-- Loading Spinner -->
    <div id="loading" class="common-loading-spinner" style="display: none;">
        <div class="common-spinner"></div>
        <p>Loading...</p>
    </div>

    <!-- Main Content -->
    <main id="main-content" class="main-content">
        <!-- Content loaded dynamically -->
    </main>

  <footer class="footer footer-main">
    <div class="footer-wrapper">
        <div class="container">
            <div class="footer-content">
                <div class="footer-section footer-section-about">
                    <h3 class="footer-section-title">Ocean View Beach Resort</h3>
                    <p class="footer-section-desc">Experience luxury and heritage in beautiful Galle, Sri Lanka</p>
                    <div class="footer-contact">
                        <p class="footer-contact-item">
                            <i class="fas fa-phone"></i> +94 91 123 4567
                        </p>
                        <p class="footer-contact-item">
                            <i class="fas fa-envelope"></i> info@oceanviewresort.lk
                        </p>
                        <p class="footer-contact-item">
                            <i class="fas fa-map-marker-alt"></i> Galle, Sri Lanka
                        </p>
                    </div>
                </div>

                <div class="footer-section footer-section-links">
                    <h4 class="footer-section-subtitle">Quick Links</h4>
                    <ul class="footer-links-list">
                        <li><a href="#" data-page="home">Home</a></li>
                        <li><a href="#" data-page="accommodation">Accommodation</a></li>
                        <li><a href="#" data-page="events">Events</a></li>
                        <li><a href="#" data-page="cuisine">Cuisine</a></li>
                        <li><a href="#" data-page="contact">Contact</a></li>
                    </ul>
                </div>

                <div class="footer-section footer-section-events">
                    <h4 class="footer-section-subtitle">Popular Events</h4>
                    <ul class="footer-links-list">
                        <li><a href="#" data-page="events/galle-fort-tour">Galle Fort Tour</a></li>
                        <li><a href="#" data-page="events/whale-watching">Whale Watching</a></li>
                        <li><a href="#" data-page="events/turtle-hatchery">Turtle Hatchery Visit</a></li>
                        <li><a href="#" data-page="events/surfing">Surfing Lessons</a></li>
                    </ul>
                </div>

                <div class="footer-section footer-section-social">
                    <h4 class="footer-section-subtitle">Follow Us</h4>
                    <div class="footer-social-links">
                        <a href="#" class="footer-social-link" title="Facebook"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" class="footer-social-link" title="Instagram"><i class="fab fa-instagram"></i></a>
                        <a href="#" class="footer-social-link" title="Twitter"><i class="fab fa-twitter"></i></a>
                        <a href="#" class="footer-social-link" title="YouTube"><i class="fab fa-youtube"></i></a>
                    </div>
                    
                    <div class="footer-newsletter">
                        <h5 class="footer-newsletter-title">Newsletter</h5>
                        <p class="footer-newsletter-desc">Subscribe for updates</p>
                        <form class="footer-newsletter-form">
                            <input type="email" class="footer-newsletter-input" placeholder="Your email" required>
                            <button type="submit" class="footer-newsletter-btn">
                                <i class="fas fa-paper-plane"></i>
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <div class="footer-bottom">
            <div class="container">
                <div class="footer-bottom-content">
                    <p class="footer-bottom-text">&copy; 2026 Ocean View Beach Resort. All rights reserved.</p>
                    <div class="footer-bottom-links">
                        <a href="#">Privacy Policy</a>
                        <a href="#">Terms of Service</a>
                        <a href="#">Sitemap</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</footer>

    <!-- Scripts -->
    <script src="js/navbar-scroll.js"></script>
    <script src="js/main.js"></script>
</body>
</html>
