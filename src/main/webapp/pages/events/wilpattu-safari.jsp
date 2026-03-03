<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="css/wilpattu-safari.css">

<div class="section active" id="wilpattu-safari">
    <div class="container">
        <a href="#" class="back-to-events" data-page="events">
            <i class="fas fa-arrow-left"></i>
            Back to Events
        </a>
        
        <div class="section-title">Wilpattu National Park Safari</div>
        
        <div class="event-detail-container">
            <div class="event-hero">
                <img src="https://images.unsplash.com/photo-1549366021-9f761d040a94?ixlib=rb-4.0.3&auto=format&fit=crop&w=2070&q=80" alt="Wilpattu Safari" class="event-hero-image">
                <div class="event-hero-overlay">
                    <h1>Wilpattu Wildlife Safari</h1>
                    <p>Discover Sri Lanka's largest national park</p>
                </div>
            </div>
            
            <div class="event-content">
                <div class="event-info">
                    <div class="event-description">
                        <h3>About This Experience</h3>
                        <p>Explore Wilpattu National Park, Sri Lanka's largest and oldest national park. Known for its unique "Willus" (natural lakes) and diverse wildlife, Wilpattu offers an authentic safari experience with excellent opportunities to spot leopards, elephants, and many other species.</p>
                        
                        <h4>Wildlife You'll See</h4>
                        <ul>
                            <li>Sri Lankan Leopards</li>
                            <li>Asian Elephants</li>
                            <li>Sloth Bears</li>
                            <li>Water Buffalo</li>
                            <li>Spotted Deer</li>
                            <li>Crocodiles</li>
                            <li>Over 200 bird species</li>
                        </ul>
                        
                        <h4>Best Time to Visit</h4>
                        <p>February to October is ideal for wildlife viewing when animals gather around water sources during the dry season.</p>
                        
                        <h4>What Makes Wilpattu Special</h4>
                        <p>Wilpattu is famous for its natural lakes called "Willus" and has the highest leopard density in Sri Lanka. The park covers 1,317 square kilometers of diverse ecosystems including forests, grasslands, and wetlands.</p>
                    </div>
                    
                    <div class="event-details">
                        <div class="detail-card">
                            <i class="fas fa-clock"></i>
                            <h4>Duration</h4>
                            <p>6-7 hours</p>
                        </div>
                        
                        <div class="detail-card">
                            <i class="fas fa-users"></i>
                            <h4>Group Size</h4>
                            <p>Max 6 people</p>
                        </div>
                        
                        <div class="detail-card">
                            <i class="fas fa-calendar"></i>
                            <h4>Schedule</h4>
                            <p>5:30 AM - 12:30 PM<br>1:30 PM - 8:30 PM</p>
                        </div>
                        
                        <div class="detail-card">
                            <i class="fas fa-rupee-sign"></i>
                            <h4>Price</h4>
                            <p>LKR 25,000 per person</p>
                        </div>
                    </div>
                </div>
                
                <div class="booking-section">
                    <div class="price-card">
                        <h3>Book Your Safari</h3>
                        <div class="price-display">
                            <span class="price">LKR 25,000</span>
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
                            
                            <div class="safari-time-selector">
                                <label>Safari Time</label>
                                <select id="safari-time">
                                    <option value="morning">Morning Safari (5:30 AM - 12:30 PM)</option>
                                    <option value="evening">Evening Safari (1:30 PM - 8:30 PM)</option>
                                    <option value="full-day">Full Day Safari (5:30 AM - 6:00 PM)</option>
                                </select>
                            </div>
                            
                            <div class="total-price-display">
                                <strong>Total: <span class="total-price" id="total-price">LKR 25,000</span></strong>
                            </div>
                            
                            <button class="event-book-btn cta-button" data-event="wilpattu-safari">
                                <i class="fas fa-binoculars"></i>
                                Book Safari
                            </button>
                        </div>
                        
                        <div class="includes">
                            <h4>Package Includes:</h4>
                            <ul>
                                <li>4WD safari vehicle with driver</li>
                                <li>Professional wildlife tracker</li>
                                <li>Park entrance fees</li>
                                <li>Breakfast & lunch (full day)</li>
                                <li>Bottled water & snacks</li>
                                <li>Binoculars</li>
                                <li>Wildlife photography tips</li>
                                <li>Hotel pickup & drop-off</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="event-gallery">
                <h3>Safari Gallery</h3>
                <div class="gallery-grid">
                    <div class="gallery-item">
                        <img src="https://images.unsplash.com/photo-1549366021-9f761d040a94?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Sri Lankan Leopard">
                    </div>
                    <div class="gallery-item">
                        <img src="https://images.unsplash.com/photo-1564349683136-77e08dba1ef7?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Asian Elephant">
                    </div>
                    <div class="gallery-item">
                        <img src="https://images.unsplash.com/photo-1551969014-7d2c4cddf0b6?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Safari Vehicle">
                    </div>
                    <div class="gallery-item">
                        <img src="https://images.unsplash.com/photo-1516426122078-c23e76319801?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Wilpattu Landscape">
                    </div>
                    <div class="gallery-item">
                        <img src="https://images.unsplash.com/photo-1551969014-7d2c4cddf0b6?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Water Buffalo">
                    </div>
                    <div class="gallery-item">
                        <img src="https://images.unsplash.com/photo-1549366021-9f761d040a94?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Bird Watching">
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
    const safariTime = document.getElementById('safari-time');
    
    const basePricePerPerson = 25000; // LKR
    let currentCount = 1;
    const maxParticipants = 6;
    const minParticipants = 1;
    
    // Price multipliers for different safari times
    const priceMultipliers = {
        'morning': 1,
        'evening': 1,
        'full-day': 1.5
    };
    
    function updateDisplay() {
        const selectedTime = safariTime.value;
        const pricePerPerson = basePricePerPerson * priceMultipliers[selectedTime];
        const totalPrice = currentCount * pricePerPerson;
        
        participantCount.textContent = currentCount;
        totalPriceElement.textContent = `LKR ${totalPrice.toLocaleString()}`;
        
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
    
    // Safari time change handler
    safariTime.addEventListener('change', function() {
        updateDisplay();
    });
    
    updateDisplay();
});
</script>
