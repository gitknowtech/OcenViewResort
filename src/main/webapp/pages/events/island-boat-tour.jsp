<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="css/events/island-boat-tour.css">

<div class="section active" id="island-boat-tour">
    <div class="container">
        <a href="#" class="back-to-events" data-page="events">
            <i class="fas fa-arrow-left"></i>
            Back to Events
        </a>
        
        <div class="section-title">Island Boat Tour</div>
        
        <div class="event-detail-container">
            <div class="event-hero">
                <img src="https://images.unsplash.com/photo-1559827260-dc66d52bef19?ixlib=rb-4.0.3&auto=format&fit=crop&w=2070&q=80" alt="Island Boat Tour" class="event-hero-image">
                <div class="event-hero-overlay">
                    <h1>Tropical Island Adventure</h1>
                    <p>Explore pristine islands and hidden beaches</p>
                </div>
            </div>
            
            <div class="event-content">
                <div class="event-info">
                    <div class="event-description">
                        <h3>About This Experience</h3>
                        <p>Embark on an unforgettable island-hopping adventure around the beautiful coastline of Mirissa. Visit secluded beaches, snorkel in crystal-clear waters, and discover the natural beauty of Sri Lanka's southern islands.</p>
                        
                        <h4>Islands You'll Visit</h4>
                        <ul>
                            <li>Snake Island (Kirala Gala)</li>
                            <li>Parrot Rock</li>
                            <li>Coconut Tree Hill Island</li>
                            <li>Secret Beach</li>
                            <li>Turtle Bay</li>
                            <li>Coral Gardens</li>
                        </ul>
                        
                        <h4>Activities Included</h4>
                        <ul>
                            <li>Island hopping</li>
                            <li>Snorkeling</li>
                            <li>Beach relaxation</li>
                            <li>Swimming</li>
                            <li>Photography</li>
                            <li>Marine life spotting</li>
                        </ul>
                        
                        <h4>Best Time to Go</h4>
                        <p>November to April offers the calmest seas and best weather conditions for island hopping and water activities.</p>
                    </div>
                    
                    <div class="event-details">
                        <div class="detail-card">
                            <i class="fas fa-clock"></i>
                            <h4>Duration</h4>
                            <p>4-8 hours</p>
                        </div>
                        
                        <div class="detail-card">
                            <i class="fas fa-users"></i>
                            <h4>Group Size</h4>
                            <p>Max 12 people</p>
                        </div>
                        
                        <div class="detail-card">
                            <i class="fas fa-calendar"></i>
                            <h4>Schedule</h4>
                            <p>8:00 AM - 12:00 PM<br>1:00 PM - 9:00 PM</p>
                        </div>
                        
                        <div class="detail-card">
                            <i class="fas fa-rupee-sign"></i>
                            <h4>Price</h4>
                            <p>From LKR 15,000</p>
                        </div>
                    </div>
                </div>
                
                <div class="booking-section">
                    <div class="price-card">
                        <h3>Book Your Tour</h3>
                        <div class="price-display">
                            <span class="price" id="display-price">LKR 15,000</span>
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
                            
                            <div class="tour-package-selector">
                                <label>Tour Package</label>
                                <select id="tour-package">
                                    <option value="half-day">Half Day Tour (4 hours) - LKR 15,000</option>
                                    <option value="full-day">Full Day Tour (8 hours) - LKR 22,000</option>
                                    <option value="sunset">Sunset Tour (5 hours) - LKR 18,000</option>
                                    <option value="private">Private Charter (8 hours) - LKR 35,000</option>
                                </select>
                            </div>
                            
                            <div class="total-price-display">
                                <strong>Total: <span class="total-price" id="total-price">LKR 15,000</span></strong>
                            </div>
                            
                            <button class="event-book-btn cta-button" data-event="island-boat-tour">
                                <i class="fas fa-ship"></i>
                                Book Tour
                            </button>
                        </div>
                        
                        <div class="includes">
                            <h4>Package Includes:</h4>
                            <ul>
                                <li>Boat transportation</li>
                                <li>Professional captain & crew</li>
                                <li>Snorkeling equipment</li>
                                <li>Life jackets</li>
                                <li>Fresh fruit & refreshments</li>
                                <li>Underwater camera rental</li>
                                <li>Towels</li>
                                <li>Hotel pickup (Mirissa area)</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="event-gallery">
                <h3>Island Tour Gallery</h3>
                <div class="gallery-grid">
                    <div class="gallery-item">
                        <img src="https://images.unsplash.com/photo-1559827260-dc66d52bef19?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Tropical Island">
                    </div>
                    <div class="gallery-item">
                        <img src="https://images.unsplash.com/photo-1544551763-46a013bb70d5?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Snorkeling">
                    </div>
                    <div class="gallery-item">
                        <img src="https://images.unsplash.com/photo-1583212292454-1fe6229603b7?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Boat Tour">
                    </div>
                    <div class="gallery-item">
                        <img src="https://images.unsplash.com/photo-1535025639604-9a804c092faa?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Crystal Waters">
                    </div>
                    <div class="gallery-item">
                        <img src="https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Beach Paradise">
                    </div>
                    <div class="gallery-item">
                        <img src="https://images.unsplash.com/photo-1591025207163-942350e47db2?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Sunset Views">
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
    const displayPriceElement = document.getElementById('display-price');
    const tourPackage = document.getElementById('tour-package');
    
    let currentCount = 1;
    const maxParticipants = 12;
    const minParticipants = 1;
    
    // Package prices in LKR
    const packagePrices = {
        'half-day': 15000,
        'full-day': 22000,
        'sunset': 18000,
        'private': 35000
    };
    
    function updateDisplay() {
        const selectedPackage = tourPackage.value;
        const pricePerPerson = packagePrices[selectedPackage];
        let totalPrice;
        
        // Private charter is fixed price regardless of participants
        if (selectedPackage === 'private') {
            totalPrice = pricePerPerson;
        } else {
            totalPrice = currentCount * pricePerPerson;
        }
        
        participantCount.textContent = currentCount;
        displayPriceElement.textContent = `LKR ${pricePerPerson.toLocaleString()}`;
        totalPriceElement.textContent = `LKR ${totalPrice.toLocaleString()}`;
        
        decreaseBtn.disabled = currentCount <= minParticipants;
        increaseBtn.disabled = currentCount >= maxParticipants;
        
        // Disable participant controls for private charter
        if (selectedPackage === 'private') {
            decreaseBtn.disabled = true;
            increaseBtn.disabled = true;
        }
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
    
    // Tour package change handler
    tourPackage.addEventListener('change', function() {
        // Reset to 1 participant when changing packages
        if (this.value === 'private') {
            currentCount = 1;
        }
        updateDisplay();
    });
    
    updateDisplay();
});
</script>
