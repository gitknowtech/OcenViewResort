<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="css/events/whale-watching.css">

<div class="section active" id="whale-watching">
    <div class="container">
        <a href="#" class="back-to-events" data-page="events">
            <i class="fas fa-arrow-left"></i>
            Back to Events
        </a>
        
        <div class="section-title">Whale Watching Experience</div>
        
        <div class="event-detail-container">
            <div class="event-hero">
                <img src="https://images.unsplash.com/photo-1559827260-dc66d52bef19?ixlib=rb-4.0.3&auto=format&fit=crop&w=2070&q=80" alt="Whale Watching" class="event-hero-image">
                <div class="event-hero-overlay">
                    <h1>Blue Whale Watching</h1>
                    <p>Witness the majestic giants of the ocean</p>
                </div>
            </div>
            
            <div class="event-content">
                <div class="event-info">
                    <div class="event-description">
                        <h3>About This Experience</h3>
                        <p>Join us for an unforgettable whale watching adventure off the coast of Mirissa. Sri Lanka is one of the best places in the world to see blue whales, the largest animals on Earth.</p>
                        
                        <h4>What You'll See</h4>
                        <ul>
                            <li>Blue Whales (world's largest mammals)</li>
                            <li>Sperm Whales</li>
                            <li>Pilot Whales</li>
                            <li>Dolphins (Spinner, Bottlenose, Striped)</li>
                            <li>Flying Fish</li>
                            <li>Sea Turtles</li>
                        </ul>
                        
                        <h4>Best Time to Visit</h4>
                        <p>November to April is the peak season for whale watching in Mirissa, with the highest chances of sightings.</p>
                    </div>
                    
                    <div class="event-details">
                        <div class="detail-card">
                            <i class="fas fa-clock"></i>
                            <h4>Duration</h4>
                            <p>4-5 hours</p>
                        </div>
                        
                        <div class="detail-card">
                            <i class="fas fa-users"></i>
                            <h4>Group Size</h4>
                            <p>Max 20 people</p>
                        </div>
                        
                        <div class="detail-card">
                            <i class="fas fa-calendar"></i>
                            <h4>Schedule</h4>
                            <p>6:30 AM - 11:30 AM<br>1:00 PM - 6:00 PM</p>
                        </div>
                        
                        <div class="detail-card">
                            <i class="fas fa-rupee-sign"></i>
                            <h4>Price</h4>
                            <p>LKR 18,750 per person</p>
                        </div>
                    </div>
                </div>
                
                <div class="booking-section">
                    <div class="price-card">
                        <h3>Book Your Adventure</h3>
                        <div class="price-display">
                            <span class="price">LKR 18,750</span>
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
                                <strong>Total: <span class="total-price" id="total-price">LKR 18,750</span></strong>
                            </div>
                            
                            <button class="event-book-btn cta-button" data-event="whale-watching">
                                <i class="fas fa-calendar-check"></i>
                                Book Now
                            </button>
                        </div>
                        
                        <div class="includes">
                            <h4>Package Includes:</h4>
                            <ul>
                                <li>Professional guide</li>
                                <li>Life jackets & safety equipment</li>
                                <li>Light refreshments</li>
                                <li>Binoculars</li>
                                <li>Hotel pickup (Mirissa area)</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="event-gallery">
                <h3>Experience Gallery</h3>
                <div class="gallery-grid">
                    <div class="gallery-item">
                        <img src="https://images.unsplash.com/photo-1544551763-46a013bb70d5?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Blue Whale">
                    </div>
                    <div class="gallery-item">
                        <img src="https://images.unsplash.com/photo-1583212292454-1fe6229603b7?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Whale Watching Boat">
                    </div>
                    <div class="gallery-item">
                        <img src="https://images.unsplash.com/photo-1591025207163-942350e47db2?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Dolphins">
                    </div>
                    <div class="gallery-item">
                        <img src="https://images.unsplash.com/photo-1535025639604-9a804c092faa?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Ocean Adventure">
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
    
    const pricePerPerson = 18750;
    let currentCount = 1;
    const maxParticipants = 20;
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
