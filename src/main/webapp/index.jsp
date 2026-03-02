<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ocean View Beach Resort - Kalpitiya, Sri Lanka</title>
    <link rel="stylesheet" href="css/style.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
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
                    <a href="#home" class="nav-link active" onclick="showSection('home')">HOME</a>
                </li>
                <li class="nav-item">
                    <a href="#accommodation" class="nav-link" onclick="showSection('accommodation')">ACCOMMODATION</a>
                </li>
                <li class="nav-item">
                    <a href="#activities" class="nav-link" onclick="showSection('activities')">THINGS TO DO</a>
                </li>
                <li class="nav-item">
                    <a href="#cuisine" class="nav-link" onclick="showSection('cuisine')">CUISINE</a>
                </li>
                <li class="nav-item">
                    <a href="#gallery" class="nav-link" onclick="showSection('gallery')">GALLERY</a>
                </li>
                <li class="nav-item">
                    <a href="#contact" class="nav-link" onclick="showSection('contact')">CONTACT US</a>
                </li>
                <li class="nav-item">
                    <a href="#reservation" class="nav-link reservation-btn" onclick="showSection('reservation')">BOOK NOW</a>
                </li>
            </ul>
            <div class="hamburger" id="hamburger">
                <span class="bar"></span>
                <span class="bar"></span>
                <span class="bar"></span>
            </div>
        </div>
    </nav>

    <!-- Home Section -->
    <section id="home" class="section active">
        <div class="hero">
            <div class="hero-content">
                <h1 class="hero-title">OCEAN VIEW BEACH RESORT</h1>
                <h2 class="hero-subtitle">KALPITIYA - SRI LANKA</h2>
                <p class="hero-description">
                    The Ocean View Beach Resort is located in Kalpitiya Sri Lanka and adds to the golden age of grace and 
                    elegance. The Ocean View Beach Resort consists of 6 cabanas in the regal edifice and all of those cabanas 
                    are situated near the coast line. To say the least, The Ocean View Beach Resort is a paradise for those who want to stay 
                    happily. Any guest can be easily accessed from the Kalpitiya city with its convenient location. The hotel offers 
                    easy access to the main road. Ocean View hotel provides lots of indelible memories by Kite Surfing, Dolphin 
                    Watching, Snorkeling, Island Boat Tour, Whale Watching, Wilpattu Safari - all these adventures you can attain at 
                    affordable prices.
                </p>
                <button class="cta-button" onclick="showSection('reservation')">MAKE RESERVATION</button>
            </div>
        </div>
        
        <!-- Activities Preview -->
        <div class="activities-preview">
            <div class="activity-card">
                <img src="images/kitesurfing.jpg" alt="Kitesurfing">
                <div class="activity-info">
                    <h3>KITESURFING</h3>
                    <p>APRIL TO OCTOBER</p>
                </div>
            </div>
            <div class="activity-card">
                <img src="images/dolphin.jpg" alt="Dolphin Watching">
                <div class="activity-info">
                    <h3>DOLPHIN WATCHING</h3>
                    <p>OCTOBER TO APRIL</p>
                </div>
            </div>
            <div class="activity-card">
                <img src="images/snorkeling.jpg" alt="Snorkeling">
                <div class="activity-info">
                    <h3>SNORKELING</h3>
                    <p>OCTOBER TO APRIL</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Accommodation Section -->
    <section id="accommodation" class="section">
        <div class="container">
            <h2 class="section-title">ACCOMMODATION</h2>
            <div class="accommodation-grid">
                <div class="room-card">
                    <img src="images/deluxe-room.jpg" alt="Deluxe Room">
                    <div class="room-info">
                        <h3>Deluxe Ocean View</h3>
                        <p>Spacious rooms with stunning ocean views</p>
                        <div class="room-price">$150/night</div>
                    </div>
                </div>
                <div class="room-card">
                    <img src="images/suite.jpg" alt="Suite">
                    <div class="room-info">
                        <h3>Premium Suite</h3>
                        <p>Luxury suite with private balcony</p>
                        <div class="room-price">$250/night</div>
                    </div>
                </div>
                <div class="room-card">
                    <img src="images/cabana.jpg" alt="Beach Cabana">
                    <div class="room-info">
                        <h3>Beach Cabana</h3>
                        <p>Traditional cabana steps from the beach</p>
                        <div class="room-price">$200/night</div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Activities Section -->
    <section id="activities" class="section">
        <div class="container">
            <h2 class="section-title">THINGS TO DO</h2>
            <div class="activities-grid">
                <div class="activity-detail">
                    <i class="fas fa-water"></i>
                    <h3>Water Sports</h3>
                    <p>Kitesurfing, windsurfing, and jet skiing</p>
                </div>
                <div class="activity-detail">
                    <i class="fas fa-fish"></i>
                    <h3>Marine Life</h3>
                    <p>Dolphin watching and whale watching tours</p>
                </div>
                <div class="activity-detail">
                    <i class="fas fa-mask-snorkel"></i>
                    <h3>Underwater</h3>
                    <p>Snorkeling and diving experiences</p>
                </div>
                <div class="activity-detail">
                    <i class="fas fa-ship"></i>
                    <h3>Island Tours</h3>
                    <p>Boat tours to nearby islands</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Cuisine Section -->
    <section id="cuisine" class="section">
        <div class="container">
            <h2 class="section-title">CUISINE</h2>
            <div class="cuisine-content">
                <p>Experience authentic Sri Lankan cuisine and fresh seafood at our beachfront restaurant.</p>
                <div class="cuisine-highlights">
                    <div class="cuisine-item">Fresh Seafood</div>
                    <div class="cuisine-item">Sri Lankan Curry</div>
                    <div class="cuisine-item">International Dishes</div>
                    <div class="cuisine-item">Tropical Fruits</div>
                </div>
            </div>
        </div>
    </section>

    <!-- Gallery Section -->
    <section id="gallery" class="section">
        <div class="container">
            <h2 class="section-title">GALLERY</h2>
            <div class="gallery-grid">
                <div class="gallery-item">
                    <img src="images/gallery1.jpg" alt="Resort View">
                </div>
                <div class="gallery-item">
                    <img src="images/gallery2.jpg" alt="Beach View">
                </div>
                <div class="gallery-item">
                    <img src="images/gallery3.jpg" alt="Room Interior">
                </div>
                <div class="gallery-item">
                    <img src="images/gallery4.jpg" alt="Activities">
                </div>
            </div>
        </div>
    </section>

    <!-- Contact Section -->
    <section id="contact" class="section">
        <div class="container">
            <h2 class="section-title">CONTACT US</h2>
            <div class="contact-content">
                <div class="contact-info">
                    <div class="contact-item">
                        <i class="fas fa-map-marker-alt"></i>
                        <div>
                            <h4>Address</h4>
                            <p>Kalpitiya, North Western Province, Sri Lanka</p>
                        </div>
                    </div>
                    <div class="contact-item">
                        <i class="fas fa-phone"></i>
                        <div>
                            <h4>Phone</h4>
                            <p>+94 77 123 4567</p>
                        </div>
                    </div>
                    <div class="contact-item">
                        <i class="fas fa-envelope"></i>
                        <div>
                            <h4>Email</h4>
                            <p>info@oceanviewresort.lk</p>
                        </div>
                    </div>
                </div>
                <div class="contact-form">
                    <form id="contactForm">
                        <input type="text" placeholder="Your Name" required>
                        <input type="email" placeholder="Your Email" required>
                        <textarea placeholder="Your Message" rows="5" required></textarea>
                        <button type="submit">Send Message</button>
                    </form>
                </div>
            </div>
        </div>
    </section>

    <!-- Reservation Section -->
    <section id="reservation" class="section">
        <div class="container">
            <h2 class="section-title">MAKE A RESERVATION</h2>
            <div class="reservation-form">
                <form id="reservationForm">
                    <div class="form-row">
                        <input type="text" placeholder="Guest Name" required>
                        <input type="email" placeholder="Email" required>
                    </div>
                    <div class="form-row">
                        <input type="tel" placeholder="Contact Number" required>
                        <select required>
                            <option value="">Select Room Type</option>
                            <option value="deluxe">Deluxe Ocean View - $150/night</option>
                            <option value="suite">Premium Suite - $250/night</option>
                            <option value="cabana">Beach Cabana - $200/night</option>
                        </select>
                    </div>
                    <div class="form-row">
                        <input type="date" placeholder="Check-in Date" required>
                        <input type="date" placeholder="Check-out Date" required>
                    </div>
                    <textarea placeholder="Special Requests" rows="3"></textarea>
                    <button type="submit" class="submit-btn">BOOK NOW</button>
                </form>
            </div>
        </div>
    </section>

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
                        <li><a href="#home" onclick="showSection('home')">Home</a></li>
                        <li><a href="#accommodation" onclick="showSection('accommodation')">Rooms</a></li>
                        <li><a href="#activities" onclick="showSection('activities')">Activities</a></li>
                        <li><a href="#contact" onclick="showSection('contact')">Contact</a></li>
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
