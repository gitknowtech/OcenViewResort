<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Home Section -->
<section class="section active">
    <!-- Hero Section -->
    <div class="hero">
        <div class="hero-overlay"></div>
        <div class="hero-background">
            <img src="https://images.unsplash.com/photo-1506905925346-21bda4d32df4?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&h=1080&q=80" alt="Ocean View Beach Resort">
        </div>
        <div class="hero-content">
            <h1 class="hero-title">OCEAN VIEW BEACH RESORT</h1>
            <h2 class="hero-subtitle">KALPITIYA - SRI LANKA</h2>
            <p class="hero-description">
                Experience paradise at Ocean View Beach Resort, where luxury meets adventure. Located on the pristine coastline of Kalpitiya, 
                our resort offers 6 exclusive beachfront cabanas with breathtaking ocean views. Indulge in world-class amenities while 
                enjoying thrilling water sports, wildlife safaris, and unforgettable experiences.
            </p>
            <div class="hero-buttons">
                <button class="cta-button primary" data-page="reservation">MAKE RESERVATION</button>
                <button class="cta-button secondary" data-page="accommodation">VIEW PACKAGES</button>
            </div>
        </div>
    </div>

    <!-- Quick Stats -->
    <div class="quick-stats">
        <div class="container">
            <div class="stats-grid">
                <div class="stat-item">
                    <i class="fas fa-home"></i>
                    <h3>6</h3>
                    <p>Luxury Cabanas</p>
                </div>
                <div class="stat-item">
                    <i class="fas fa-star"></i>
                    <h3>4.8</h3>
                    <p>Guest Rating</p>
                </div>
                <div class="stat-item">
                    <i class="fas fa-umbrella-beach"></i>
                    <h3>200m</h3>
                    <p>Beach Access</p>
                </div>
                <div class="stat-item">
                    <i class="fas fa-calendar-alt"></i>
                    <h3>365</h3>
                    <p>Days Open</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Special Events Section -->
    <div class="special-events">
        <div class="container">
            <h2 class="section-title">SPECIAL EVENTS & ADVENTURES</h2>
            <p class="section-subtitle">Discover unforgettable experiences at Ocean View Beach Resort</p>
            
            <div class="events-grid">
                <div class="event-card" data-event="wilpattu-safari">
                    <img src="https://images.unsplash.com/photo-1549366021-9f761d040a94?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80" alt="Wilpattu Safari">
                    <div class="event-overlay">
                        <h3>WILPATTU SAFARI</h3>
                        <p>Experience Sri Lanka's largest national park with diverse wildlife including leopards, elephants, and exotic birds.</p>
                        <button class="event-btn">EXPLORE SAFARI</button>
                    </div>
                </div>

                <div class="event-card" data-event="kitesurfing">
                    <img src="https://images.unsplash.com/photo-1544551763-46a013bb70d5?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80" alt="Kitesurfing">
                    <div class="event-overlay">
                        <h3>KITESURFING</h3>
                        <p>Ride the waves with world-class kitesurfing conditions. Perfect winds from April to October.</p>
                        <button class="event-btn">LEARN MORE</button>
                    </div>
                </div>

                <div class="event-card" data-event="whale-watching">
                    <img src="https://images.unsplash.com/photo-1559827260-dc66d52bef19?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80" alt="Whale Watching">
                    <div class="event-overlay">
                        <h3>WHALE WATCHING</h3>
                        <p>Witness majestic blue whales and sperm whales in their natural habitat. Best season: December to April.</p>
                        <button class="event-btn">BOOK TOUR</button>
                    </div>
                </div>

                <div class="event-card" data-event="dolphin-watching">
                    <img src="https://images.unsplash.com/photo-1544551763-77ef2d0cfc6c?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80" alt="Dolphin Watching">
                    <div class="event-overlay">
                        <h3>DOLPHIN WATCHING</h3>
                        <p>Encounter playful dolphins in the crystal-clear waters. Daily tours available year-round.</p>
                        <button class="event-btn">JOIN TOUR</button>
                    </div>
                </div>

                <div class="event-card" data-event="island-boat-tour">
                    <img src="https://images.unsplash.com/photo-1506905925346-21bda4d32df4?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80" alt="Island Boat Tour">
                    <div class="event-overlay">
                        <h3>ISLAND BOAT TOUR</h3>
                        <p>Explore pristine islands, hidden lagoons, and mangrove forests on our exclusive boat tours.</p>
                        <button class="event-btn">DISCOVER ISLANDS</button>
                    </div>
                </div>

                <div class="event-card" data-event="snorkeling">
                    <img src="https://images.unsplash.com/photo-1583212292454-1fe6229603b7?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80" alt="Snorkeling">
                    <div class="event-overlay">
                        <h3>SNORKELING</h3>
                        <p>Dive into underwater paradise with vibrant coral reefs and tropical marine life.</p>
                        <button class="event-btn">DIVE IN</button>
                    </div>
                </div>
            </div>

            <div class="view-all-events">
                <button class="cta-button" data-page="events">VIEW ALL EVENTS</button>
            </div>
        </div>
    </div>

    <!-- Guest Reviews Section -->
    <div class="guest-reviews">
        <div class="container">
            <h2 class="section-title">WHAT OUR GUESTS SAY</h2>
            <div class="reviews-grid">
                <div class="review-card">
                    <div class="review-stars">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                    </div>
                    <p>"Absolutely incredible experience! The kitesurfing was world-class and the staff was so welcoming. The beachfront cabana was perfect with stunning ocean views."</p>
                    <div class="reviewer">
                        <img src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&auto=format&fit=crop&w=100&h=100&q=80" alt="John Smith">
                        <div class="reviewer-info">
                            <h4>John Smith</h4>
                            <p>United Kingdom</p>
                        </div>
                    </div>
                </div>

                <div class="review-card">
                    <div class="review-stars">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                    </div>
                    <p>"The whale watching tour was breathtaking! We saw blue whales up close. The resort's location is perfect for all water activities. Highly recommended!"</p>
                    <div class="reviewer">
                        <img src="https://images.unsplash.com/photo-1494790108755-2616b612b786?ixlib=rb-4.0.3&auto=format&fit=crop&w=100&h=100&q=80" alt="Sarah Johnson">
                        <div class="reviewer-info">
                            <h4>Sarah Johnson</h4>
                            <p>Australia</p>
                        </div>
                    </div>
                </div>

                <div class="review-card">
                    <div class="review-stars">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                    </div>
                    <p>"Wilpattu Safari was amazing! Saw leopards and elephants. The resort arranged everything perfectly. The food was delicious and authentic Sri Lankan cuisine."</p>
                    <div class="reviewer">
                        <img src="https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-4.0.3&auto=format&fit=crop&w=100&h=100&q=80" alt="Michael Chen">
                        <div class="reviewer-info">
                            <h4>Michael Chen</h4>
                            <p>Singapore</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Resort Features -->
    <div class="resort-features">
        <div class="container">
            <h2 class="section-title">RESORT FEATURES</h2>
            <div class="features-grid">
                <div class="feature-item">
                    <i class="fas fa-wifi"></i>
                    <h3>Free WiFi</h3>
                    <p>High-speed internet throughout the resort</p>
                </div>
                <div class="feature-item">
                    <i class="fas fa-swimming-pool"></i>
                    <h3>Infinity Pool</h3>
                    <p>Stunning oceanfront infinity pool</p>
                </div>
                <div class="feature-item">
                    <i class="fas fa-utensils"></i>
                    <h3>Fine Dining</h3>
                    <p>Authentic Sri Lankan and international cuisine</p>
                </div>
                <div class="feature-item">
                    <i class="fas fa-spa"></i>
                    <h3>Spa Services</h3>
                    <p>Relaxing treatments and wellness programs</p>
                </div>
                <div class="feature-item">
                    <i class="fas fa-car"></i>
                    <h3>Airport Transfer</h3>
                    <p>Complimentary pickup and drop-off service</p>
                </div>
                <div class="feature-item">
                    <i class="fas fa-concierge-bell"></i>
                    <h3>24/7 Concierge</h3>
                    <p>Personal assistance for all your needs</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Location & Map -->
    <div class="location-section">
        <div class="container">
            <h2 class="section-title">FIND US IN KALPITIYA</h2>
            <div class="location-content">
                <div class="location-info">
                    <h3>Perfect Location</h3>
                    <p>Located on the pristine coastline of Kalpitiya, our resort offers easy access to:</p>
                    <ul>
                        <li><i class="fas fa-map-marker-alt"></i> 3 hours from Colombo International Airport</li>
                        <li><i class="fas fa-map-marker-alt"></i> 15 minutes from Kalpitiya town center</li>
                        <li><i class="fas fa-map-marker-alt"></i> Direct beach access</li>
                        <li><i class="fas fa-map-marker-alt"></i> Close to all major attractions</li>
                    </ul>
                    <button class="cta-button" data-page="contact">GET DIRECTIONS</button>
                </div>
                <div class="map-container">
                    <iframe 
                        src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3937.2858181234567!2d79.7644444!3d8.2333333!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x0!2zOMKwMTMnNTkuOSJOIDc5wrA0NSc1Mi4wIkU!5e0!3m2!1sen!2slk!4v1234567890123"
                        width="100%" 
                        height="400" 
                        style="border:0; border-radius: 10px;" 
                        allowfullscreen="" 
                        loading="lazy">
                    </iframe>
                </div>
            </div>
        </div>
    </div>

    <!-- Call to Action -->
    <div class="final-cta">
        <div class="container">
            <h2>Ready for Your Dream Vacation?</h2>
            <p>Book now and experience the magic of Ocean View Beach Resort</p>
            <div class="cta-buttons">
                <button class="cta-button primary" data-page="reservation">BOOK NOW</button>
                <button class="cta-button secondary" data-page="contact">CONTACT US</button>
            </div>
        </div>
    </div>
</section>

<style>
/* Hero Section */
.hero {
    position: relative;
    height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
}

.hero-background {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    z-index: -2;
}

.hero-background img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.hero-overlay {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.4);
    z-index: -1;
}

.hero-content {
    text-align: center;
    color: white;
    max-width: 800px;
    padding: 0 20px;
    animation: fadeInUp 1s ease-out;
}

.hero-title {
    font-size: 4rem;
    font-weight: bold;
    margin-bottom: 10px;
    text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
}

.hero-subtitle {
    font-size: 1.8rem;
    margin-bottom: 30px;
    color: #ffd700;
    text-shadow: 1px 1px 2px rgba(0,0,0,0.5);
}

.hero-description {
    font-size: 1.2rem;
    line-height: 1.6;
    margin-bottom: 40px;
    text-shadow: 1px 1px 2px rgba(0,0,0,0.5);
}

.hero-buttons {
    display: flex;
    gap: 20px;
    justify-content: center;
    flex-wrap: wrap;
}

.cta-button {
    padding: 15px 30px;
    border: none;
    border-radius: 30px;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    transition: all 0.3s ease;
    text-transform: uppercase;
}

.cta-button.primary {
    background: linear-gradient(135deg, #007bff, #0056b3);
    color: white;
}

.cta-button.secondary {
    background: transparent;
    color: white;
    border: 2px solid white;
}

.cta-button:hover {
    transform: translateY(-3px);
    box-shadow: 0 10px 20px rgba(0,0,0,0.2);
}

/* Quick Stats */
.quick-stats {
    background: #f8f9fa;
    padding: 60px 0;
}

.stats-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 40px;
    text-align: center;
}

.stat-item i {
    font-size: 3rem;
    color: #007bff;
    margin-bottom: 15px;
}

.stat-item h3 {
    font-size: 2.5rem;
    font-weight: bold;
    color: #333;
    margin-bottom: 10px;
}

.stat-item p {
    color: #666;
    font-size: 1.1rem;
}

/* Special Events */
.special-events {
    padding: 80px 0;
    background: white;
}

.section-title {
    text-align: center;
    font-size: 2.5rem;
    color: #333;
    margin-bottom: 15px;
}

.section-subtitle {
    text-align: center;
    color: #666;
    font-size: 1.2rem;
    margin-bottom: 50px;
}

.events-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
    gap: 30px;
    margin-bottom: 50px;
}

.event-card {
    position: relative;
    height: 300px;
    border-radius: 15px;
    overflow: hidden;
    cursor: pointer;
    transition: transform 0.3s ease;
}

.event-card:hover {
    transform: translateY(-10px);
}

.event-card img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.event-overlay {
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    background: linear-gradient(transparent, rgba(0,0,0,0.8));
    color: white;
    padding: 30px;
    text-align: center;
}

.event-overlay h3 {
    font-size: 1.5rem;
    margin-bottom: 10px;
}

.event-overlay p {
    margin-bottom: 20px;
    line-height: 1.4;
}

.event-btn {
    background: #007bff;
    color: white;
    border: none;
    padding: 10px 20px;
    border-radius: 20px;
    cursor: pointer;
    transition: background 0.3s ease;
}

.event-btn:hover {
    background: #0056b3;
}

.view-all-events {
    text-align: center;
}

/* Guest Reviews */
.guest-reviews {
    background: #f8f9fa;
    padding: 80px 0;
}

.reviews-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 30px;
}

.review-card {
    background: white;
    padding: 30px;
    border-radius: 15px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    text-align: center;
}

.review-stars {
    color: #ffd700;
    font-size: 1.2rem;
    margin-bottom: 20px;
}

.review-card p {
    font-style: italic;
    line-height: 1.6;
    margin-bottom: 25px;
    color: #555;
}

.reviewer {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 15px;
}

.reviewer img {
    width: 60px;
    height: 60px;
    border-radius: 50%;
    object-fit: cover;
}

.reviewer-info h4 {
    color: #333;
    margin-bottom: 5px;
}

.reviewer-info p {
    color: #666;
    font-size: 0.9rem;
    margin: 0;
}

/* Resort Features */
.resort-features {
    padding: 80px 0;
    background: white;
}

.features-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 40px;
    text-align: center;
}

.feature-item i {
    font-size: 3rem;
    color: #007bff;
    margin-bottom: 20px;
}

.feature-item h3 {
    color: #333;
    margin-bottom: 15px;
    font-size: 1.3rem;
}

.feature-item p {
    color: #666;
    line-height: 1.5;
}

/* Location Section */
.location-section {
    background: #f8f9fa;
    padding: 80px 0;
}

.location-content {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 50px;
    align-items: center;
}

.location-info h3 {
    color: #333;
    font-size: 1.8rem;
    margin-bottom: 20px;
}

.location-info p {
    color: #666;
    line-height: 1.6;
    margin-bottom: 25px;
}

.location-info ul {
    list-style: none;
    padding: 0;
    margin-bottom: 30px;
}

.location-info li {
    padding: 10px 0;
    color: #555;
}

.location-info i {
    color: #007bff;
    margin-right: 10px;
}

/* Final CTA */
.final-cta {
    background: linear-gradient(135deg, #007bff, #0056b3);
    color: white;
    padding: 80px 0;
    text-align: center;
}

.final-cta h2 {
    font-size: 2.5rem;
    margin-bottom: 20px;
}

.final-cta p {
    font-size: 1.2rem;
    margin-bottom: 40px;
}

.cta-buttons {
    display: flex;
    gap: 20px;
    justify-content: center;
    flex-wrap: wrap;
}

/* Animations */
@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translateY(30px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

/* Responsive Design */
@media (max-width: 768px) {
    .hero-title {
        font-size: 2.5rem;
    }
    
    .hero-subtitle {
        font-size: 1.3rem;
    }
    
    .hero-description {
        font-size: 1rem;
    }
    
    .hero-buttons {
        flex-direction: column;
        align-items: center;
    }
    
    .location-content {
        grid-template-columns: 1fr;
    }
    
    .events-grid {
        grid-template-columns: 1fr;
    }
    
    .cta-buttons {
        flex-direction: column;
        align-items: center;
    }
}
</style>

<script>
// Event card click handlers
$(document).ready(function() {
    $('.event-card').click(function() {
        const eventType = $(this).data('event');
        console.log('Event clicked:', eventType);
        
        // Load specific event page
        loadPage('events/' + eventType);
        updateNavigation('events');
    });
    
    // Smooth scrolling for internal links
    $('a[href^="#"]').click(function(e) {
        e.preventDefault();
        const target = $($(this).attr('href'));
        if (target.length) {
            $('html, body').animate({
                scrollTop: target.offset().top - 80
            }, 800);
        }
    });
});
</script>
