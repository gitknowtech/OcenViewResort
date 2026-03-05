<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="css/events/kitesurfing.css">

<div class="section active" id="kitesurfing">
    <div class="container">
        <a href="#" class="back-to-events" data-page="events">
            <i class="fas fa-arrow-left"></i>
            Back to Events
        </a>
        
        <div class="section-title">Kitesurfing Lessons</div>
        
        <div class="event-detail-container">
            <div class="event-hero">
                <img src="https://images.unsplash.com/photo-1544551763-46a013bb70d5?ixlib=rb-4.0.3&auto=format&fit=crop&w=2070&q=80" alt="Kitesurfing" class="event-hero-image">
                <div class="event-hero-overlay">
                    <h1>Learn Kitesurfing</h1>
                    <p>Master the waves with professional instruction</p>
                </div>
            </div>
            
            <div class="event-content">
                <div class="event-info">
                    <div class="event-description">
                        <h3>About This Experience</h3>
                        <p>Learn the exciting sport of kitesurfing with our certified instructors at Mirissa Beach. Perfect wind conditions and shallow waters make this the ideal location for beginners and advanced riders alike.</p>
                        
                        <h4>What You'll Learn</h4>
                        <ul>
                            <li>Kite setup and safety</li>
                            <li>Wind theory and weather reading</li>
                            <li>Body dragging techniques</li>
                            <li>Board skills and water starts</li>
                            <li>Riding and basic maneuvers</li>
                        </ul>
                        
                        <h4>Skill Levels</h4>
                        <p>We offer lessons for all levels from complete beginners to advanced riders looking to improve their technique.</p>
                        
                        <h4>Best Conditions</h4>
                        <p>Mirissa offers consistent wind conditions from May to September, making it perfect for learning and practicing kitesurfing skills.</p>
                    </div>
                    
                    <div class="event-details">
                        <div class="detail-card">
                            <i class="fas fa-clock"></i>
                            <h4>Duration</h4>
                            <p>2-3 hours</p>
                        </div>
                        
                        <div class="detail-card">
                            <i class="fas fa-users"></i>
                            <h4>Group Size</h4>
                            <p>Max 4 people</p>
                        </div>
                        
                        <div class="detail-card">
                            <i class="fas fa-calendar"></i>
                            <h4>Schedule</h4>
                            <p>9:00 AM - 12:00 PM<br>2:00 PM - 5:00 PM</p>
                        </div>
                        
                        <div class="detail-card">
                            <i class="fas fa-rupee-sign"></i>
                            <h4>Price</h4>
                            <p>LKR 20,000 per person</p>
                        </div>
                    </div>
                </div>
                
                <div class="booking-section">
                    <div class="price-card">
                        <h3>Book Your Lesson</h3>
                        <div class="price-display">
                            <span class="price">LKR 20,000</span>
                            <span class="per">per person</span>
                        </div>
                        
                        <div class="booking-form">
                            <div class="participant-selector">
                                <span>Participants:</span>
                                <div class="participant-controls">
                                    <button type="button" class="participant-btn" id="decrease-btn">-</button>
                                    <span class="participant-count" id="participant-count">1</span>
                                    <button type="button" class="participant-btn" id="increase-btn">+</button>
                                </div>
                            </div>
                            
                            <div class="experience-selector">
                                <label>Experience Level</label>
                                <select id="experience-level">
                                    <option value="beginner">Complete Beginner</option>
                                    <option value="intermediate">Some Experience</option>
                                    <option value="advanced">Advanced</option>
                                </select>
                            </div>
                            
                            <div class="total-price-display">
                                <strong>Total: <span class="total-price" id="total-price">LKR 20,000</span></strong>
                            </div>
                            
                            <button class="event-book-btn cta-button" data-event="kitesurfing">
                                <i class="fas fa-wind"></i>
                                Book Now
                            </button>
                        </div>
                        
                        <div class="includes">
                            <h4>Package Includes:</h4>
                            <ul>
                                <li>Professional IKO certified instructor</li>
                                <li>All equipment (kite, board, harness)</li>
                                <li>Safety briefing</li>
                                <li>Completion certificate</li>
                                <li>Photos of your session</li>
                                <li>Wetsuit and helmet</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="event-gallery">
                <h3>Experience Gallery</h3>
                <div class="gallery-grid">
                    <div class="gallery-item">
                        <img src="https://img.freepik.com/free-photo/person-surfing-flying-parachute-same-time-kitesurfing-bonaire-caribbean_181624-11389.jpg" alt="Kitesurfing Action">
                    </div>
                    <div class="gallery-item">
                        <img src="https://lirp.cdn-website.com/0c81bee3/dms3rep/multi/opt/FXBKS_240411-31-590caabf-fc4aa8d4-c43e5d00-640w.jpg" alt="Kite Setup">
                    </div>
                    <div class="gallery-item">
                        <img src="https://www.machutravelperu.com/wp-content/uploads/2025/06/kitesurfing-peru-beaches-1.webp" alt="Kitesurfing Lesson">
                    </div>
                    <div class="gallery-item">
                        <img src="https://www.surfersisland.net/cdn/shop/articles/top-10-kitesurfing-tips-every-beginner-should-know-4556413_1024x1024.jpg?v=1752661734" alt="Beach Training">
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const decreaseBtn = document.getElementById('decrease-btn');
    const increaseBtn = document.getElementById('increase-btn');
    const participantCount = document.getElementById('participant-count');
    const totalPriceElement = document.getElementById('total-price');
    const experienceLevel = document.getElementById('experience-level');
    
    const pricePerPerson = 20000; // LKR
    let currentCount = 1;
    const maxParticipants = 4;
    const minParticipants = 1;
    
    function updateDisplay() {
        participantCount.textContent = currentCount;
        const totalPrice = currentCount * pricePerPerson;
        totalPriceElement.textContent = LKR ${totalPrice.toLocaleString()};
        
        decreaseBtn.disabled = currentCount <= minParticipants;
        increaseBtn.disabled = currentCount >= maxParticipants;
    }
    
    decreaseBtn.addEventListener('click', function() {
        if (currentCount > minParticipants) {
            currentCount--;
            updateDisplay();
        }
    });
    
    increaseBtn.addEventListener('click', function() {
        if (currentCount < maxParticipants) {
            currentCount++;
            updateDisplay();
        }
    });
    
    // Experience level change handler (for future pricing variations)
    experienceLevel.addEventListener('change', function() {
        console.log('Experience level changed to:', this.value);
        // You can add different pricing based on experience level here
    });
    
    updateDisplay();
});
</script>