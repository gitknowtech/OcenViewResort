<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ocean View Beach Resort - Kalpitiya, Sri Lanka</title>
    <link rel="stylesheet" href="css/style.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar">
        <div class="nav-container">
            <div class="nav-logo">
                <img src="images/logo.png" alt="Ocean View Resort" class="logo">
                <span class="logo-text">Ocean View</span>
            </div>
            <ul class="nav-menu" id="nav-menu">
                <li class="nav-item">
                    <a href="#" class="nav-link active" data-page="pages/home">HOME</a>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link" data-page="accommodation">ACCOMMODATION</a>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link" data-page="activities">THINGS TO DO</a>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link" data-page="cuisine">CUISINE</a>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link" data-page="gallery">GALLERY</a>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link" data-page="contact">CONTACT US</a>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link reservation-btn" data-page="reservation">BOOK NOW</a>
                </li>
            </ul>
            <div class="hamburger" id="hamburger">
                <span class="bar"></span>
                <span class="bar"></span>
                <span class="bar"></span>
            </div>
        </div>
    </nav>

    <!-- Loading Spinner -->
    <div id="loading" class="loading-spinner" style="display: none;">
        <div class="spinner"></div>
    </div>

    <!-- Main Content Container -->
    <main id="main-content" class="main-content">
        <!-- Content will be loaded here dynamically -->
    </main>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="footer-content">
                <div class="footer-section">
                    <h3>Ocean View Beach Resort</h3>
                    <p>Experience luxury and adventure in beautiful Kalpitiya, Sri Lanka</p>
                </div>
                <div class="footer-section">
                    <h4>Quick Links</h4>
                    <ul>
                        <li><a href="#" data-page="home">Home</a></li>
                        <li><a href="#" data-page="accommodation">Rooms</a></li>
                        <li><a href="#" data-page="activities">Activities</a></li>
                        <li><a href="#" data-page="contact">Contact</a></li>
                    </ul>
                </div>
                <div class="footer-section">
                    <h4>Follow Us</h4>
                    <div class="social-links">
                        <a href="#"><i class="fab fa-facebook"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                    </div>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2026 Ocean View Beach Resort. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <script src="js/main.js"></script>
</body>
</html>
