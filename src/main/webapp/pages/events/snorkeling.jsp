<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="css/snorkeling.css">

<div class="section active" id="snorkeling">
    <div class="container">
        <a href="#" class="back-to-events" data-page="events">
            <i class="fas fa-arrow-left"></i>
            Back to Events
        </a>
        
        <div class="section-title">Snorkeling Adventure</div>
        
        <div class="event-detail-container">
            <div class="event-hero">
                <img src="https://images.unsplash.com/photo-1559827260-dc66d52bef19?ixlib=rb-4.0.3&auto=format&fit=crop&w=2070&q=80" alt="Snorkeling" class="event-hero-image">
                <div class="event-hero-overlay">
                    <h1>Underwater Paradise</h1>
                    <p>Discover vibrant coral reefs and marine life</p>
                </div>
            </div>
            
            <div class="event-content">
                <div class="event-info">
                    <div class="event-description">
                        <h3>About This Experience</h3>
                        <p>Dive into the crystal-clear waters around Mirissa and explore the vibrant underwater world. Our snorkeling adventures take you to the best coral reefs where you can swim alongside tropical fish, sea turtles, and discover the incredible marine biodiversity of Sri Lanka's southern coast.</p>
                        
                        <h4>Marine Life You'll See</h4>
                        <ul>
                            <li>Colorful Tropical Fish</li>
                            <li>Sea Turtles</li>
                            <li>Coral Gardens</li>
                            <li>Angelfish & Butterflyfish</li>
                            <li>Parrotfish</li>
                            <li>Moray Eels</li>
                            <li>Stingrays</li>
                            <li>Reef Sharks (harmless)</li>
                        </ul>
                        
                        <h4>Snorkeling Spots</h4>
                        <ul>
                            <li>Snake Island Reef</li>
                            <li>Parrot Rock</li>
                            <li>Turtle Bay</li>
                            <li>Coral Gardens</li>
                            <li>Hidden Lagoon</li>
                        </ul>
                        
                        <h4>Best Conditions</h4>
                        <p>November to April offers the clearest water visibility (15-25 meters) and calmest sea conditions, perfect for snorkeling adventures.</p>
                        
                        <h4>Safety First</h4>
                        <p>All snorkeling trips include professional guides, safety briefings, and high-quality equipment to ensure a safe and enjoyable underwater experience.</p>
                    </div>
                    
                    <div class="event-details">
                        <div class="detail-card">
                            <i class="fas fa-clock"></i>
                            <h4>Duration</h4>
                            <p>3-4 hours</p>
                        </div>
                        
                        <div class="detail-card">
                            <i class="fas fa-users"></i>
                            <h4>Group Size</h4>
                            <p>Max 8 people</p>
                        </div>
                        
                        <div class="detail-card">
                            <i class="fas fa-calendar"></i>
                            <h4>Schedule</h4>
                            <p>8:00 AM - 12:00 PM<br>1:00 PM - 5:00 PM</p>
                        </div>
                        
                        <div class="detail-card">
                            <i class="fas fa-rupee-sign"></i>
                            <h4>Price</h4>
                            <p>LKR 8,500 per person</p>
                        </div>
                    </div>
                </div>
                
                <div class="booking-section">
                    <div class="price-card">
                        <h3>Book Your Adventure</h3>
                        <div class="price-display">
                            <span class="price">LKR 8,500</span>
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
                                <label>Swimming Level</label>
                                <select id="swimming-level">
                                    <option value="beginner">Beginner (Basic swimming)</option>
                                    <option value="intermediate">Intermediate (Confident swimmer)</option>
                                    <option value="advanced">Advanced (Strong swimmer)</option>
                                    <option value="non-swimmer">Non-swimmer (Life jacket required)</option>
                                </select>
                            </div>
                            
                            <div class="total-price-display">
                                <strong>Total: <span class="total-price" id="total-price">LKR 8,500</span></strong>
                            </div>
                            
                            <button class="event-book-btn cta-button" data-event="snorkeling">
                                <i class="fas fa-swimming-pool"></i>
                                Book Adventure
                            </button>
                        </div>
                        
                        <div class="includes">
                            <h4>Package Includes:</h4>
                            <ul>
                                <li>Professional snorkeling guide</li>
                                <li>High-quality mask & snorkel</li>
                                <li>Fins & life jacket</li>
                                <li>Boat transportation</li>
                                <li>Underwater camera rental</li>
                                <li>Fresh fruit & water</li>
                                <li>Towels</li>
                                <li>Safety briefing</li>
                                <li>Hotel pickup (Mirissa area)</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="event-gallery">
                <h3>Underwater Gallery</h3>
                <div class="gallery-grid">
                    <div class="gallery-item">
                        <img src="https://images.unsplash.com/photo-1559827260-dc66d52bef19?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Coral Reef">
                    </div>
                    <div class="gallery-item">
                        <img src="https://images.unsplash.com/photo-1583212292454-1fe6229603b7?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Sea Turtle">
                    </div>
                    <div class="gallery-item">
                        <img src="https://images.unsplash.com/photo-1535025639604-9a804c092faa?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Tropical Fish">
                    </div>
                    <div class="gallery-item">
                        <img src="https://images.unsplash.com/photo-1544551763-46a013bb70d5?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Snorkeling Adventure">
                    </div>
                    <div class="gallery-item">
                        <img src="https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Underwater World">
                    </div>
                    <div class="gallery-item">
                        <img src="https://images.unsplash.com/photo-1591025207163-942350e47db2?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Marine Life">
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
    const swimmingLevel = document.getElementById('swimming-level');
    
    const pricePerPerson = 8500; // LKR
    let currentCount = 1;
    const maxParticipants = 8;
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
    
    // Swimming level change handler (for safety requirements)
    swimmingLevel.addEventListener('change', function() {
        console.log('Swimming level changed to:', this.value);
        // You can add safety warnings or equipment adjustments here
        if (this.value === 'non-swimmer') {
            console.log('Life jacket will be provided for non-swimmers');
        }
    });
    
    updateDisplay();
});
</script>
