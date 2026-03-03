<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="css/events/dolphin-watching.css">

<div class="section active" id="dolphin-watching">
    <div class="container">
        <a href="#" class="back-to-events" data-page="events">
            <i class="fas fa-arrow-left"></i>
            Back to Events
        </a>
        
        <div class="section-title">Dolphin Watching Tour</div>
        
        <div class="event-detail-container">
            <div class="event-hero">
                <img src="https://images.unsplash.com/photo-1591025207163-942350e47db2?ixlib=rb-4.0.3&auto=format&fit=crop&w=2070&q=80" alt="Dolphin Watching" class="event-hero-image">
                <div class="event-hero-overlay">
                    <h1>Dolphin Encounters</h1>
                    <p>Meet playful dolphins in their natural habitat</p>
                </div>
            </div>
            
            <div class="event-content">
                <div class="event-info">
                    <div class="event-description">
                        <h3>About This Experience</h3>
                        <p>Experience the joy of watching playful dolphins in the crystal clear waters around Mirissa. These intelligent marine mammals often approach our boats, providing incredible photo opportunities and unforgettable memories.</p>
                        
                        <h4>What You'll See</h4>
                        <ul>
                            <li>Spinner Dolphins</li>
                            <li>Bottlenose Dolphins</li>
                            <li>Striped Dolphins</li>
                            <li>Risso's Dolphins</li>
                            <li>Sea Turtles</li>
                            <li>Tropical Fish</li>
                        </ul>
                        
                        <h4>Best Time to Visit</h4>
                        <p>Dolphins can be spotted year-round, but the best visibility is during calm weather conditions from December to March.</p>
                        
                        <h4>What to Expect</h4>
                        <p>Our dolphin watching tours take you to the shallow coastal waters where dolphins are frequently seen. These playful creatures often swim alongside the boat and perform acrobatic displays.</p>
                    </div>
                    
                    <div class="event-details">
                        <div class="detail-card">
                            <i class="fas fa-clock"></i>
                            <h4>Duration</h4>
                            <p>3 hours</p>
                        </div>
                        
                        <div class="detail-card">
                            <i class="fas fa-users"></i>
                            <h4>Group Size</h4>
                            <p>Max 15 people</p>
                        </div>
                        
                        <div class="detail-card">
                            <i class="fas fa-calendar"></i>
                            <h4>Schedule</h4>
                            <p>8:00 AM - 11:00 AM<br>2:30 PM - 5:30 PM</p>
                        </div>
                        
                        <div class="detail-card">
                            <i class="fas fa-rupee-sign"></i>
                            <h4>Price</h4>
                            <p>LKR 12,500 per person</p>
                        </div>
                    </div>
                </div>
                
                <div class="booking-section">
                    <div class="price-card">
                        <h3>Book Your Tour</h3>
                        <div class="price-display">
                            <span class="price">LKR 12,500</span>
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
                            
                            <div class="total-price-display">
                                <strong>Total: <span class="total-price" id="total-price">LKR 12,500</span></strong>
                            </div>
                            
                            <button class="event-book-btn cta-button" data-event="dolphin-watching">
                                <i class="fas fa-calendar-check"></i>
                                Book Now
                            </button>
                        </div>
                        
                        <div class="includes">
                            <h4>Package Includes:</h4>
                            <ul>
                                <li>Boat ride</li>
                                <li>Snorkeling equipment</li>
                                <li>Light snacks & drinks</li>
                                <li>Professional photos</li>
                                <li>Marine life guide</li>
                                <li>Life jackets</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="event-gallery">
                <h3>Experience Gallery</h3>
                <div class="gallery-grid">
                    <div class="gallery-item">
                        <img src="https://images.unsplash.com/photo-1591025207163-942350e47db2?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Dolphins Playing">
                    </div>
                    <div class="gallery-item">
                        <img src="https://images.unsplash.com/photo-1583212292454-1fe6229603b7?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Dolphin Watching Boat">
                    </div>
                    <div class="gallery-item">
                        <img src="https://images.unsplash.com/photo-1559827260-dc66d52bef19?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Ocean Adventure">
                    </div>
                    <div class="gallery-item">
                        <img src="https://images.unsplash.com/photo-1535025639604-9a804c092faa?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Marine Life">
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
    
    const pricePerPerson = 12500; // LKR
    let currentCount = 1;
    const maxParticipants = 15;
    const minParticipants = 1;
    
    function updateDisplay() {
        participantCount.textContent = currentCount;
        const totalPrice = currentCount * pricePerPerson;
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
    
    updateDisplay();
});
</script>
