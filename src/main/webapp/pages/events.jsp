<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="css/events.css">

<div class="section active" id="events">
    <div class="container">
        <div class="section-title">Ocean Adventures & Experiences</div>
        <div class="section-subtitle">Discover the magic of Mirissa's marine world</div>
        
        <!-- Search and Filter -->
        <div class="events-controls">
            <div class="search-container">
                <input type="text" class="event-search" placeholder="Search experiences...">
                <i class="fas fa-search"></i>
            </div>
            
            <div class="filter-container">
                <button class="event-filter active" data-filter="all">
                    <i class="fas fa-globe"></i>
                    All Experiences
                </button>
                <button class="event-filter" data-filter="water">
                    <i class="fas fa-swimmer"></i>
                    Water Sports
                </button>
                <button class="event-filter" data-filter="wildlife">
                    <i class="fas fa-paw"></i>
                    Wildlife
                </button>
                <button class="event-filter" data-filter="adventure">
                    <i class="fas fa-mountain"></i>
                    Adventure
                </button>
            </div>
        </div>
        
        <!-- Events Grid -->
        <div class="events-grid">
            <!-- Whale Watching -->
            <div class="event-card" data-category="wildlife">
                <div class="event-image">
                    <img src="https://images.unsplash.com/photo-1544551763-46a013bb70d5?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Whale Watching">
                    <div class="event-badge popular">Popular</div>
                    <div class="event-overlay">
                        <div class="event-rating">
                            <i class="fas fa-star"></i>
                            <span>4.9</span>
                        </div>
                    </div>
                </div>
                <div class="event-content">
                    <div class="event-header">
                        <h3 class="event-title">Whale Watching</h3>
                        <div class="event-category-tag wildlife">Wildlife</div>
                    </div>
                    <p class="event-description">Experience the majestic blue whales in their natural habitat with our expert marine biologists.</p>
                    
                    <div class="event-highlights">
                        <span class="highlight">🐋 Blue Whales</span>
                        <span class="highlight">📸 Photography</span>
                        <span class="highlight">🎓 Expert Guide</span>
                    </div>
                    
                    <div class="event-meta">
                        <div class="meta-item">
                            <i class="fas fa-clock"></i>
                            <span>4-5 hours</span>
                        </div>
                        <div class="meta-item">
                            <i class="fas fa-users"></i>
                            <span>Max 20</span>
                        </div>
                        <div class="meta-item">
                            <i class="fas fa-calendar"></i>
                            <span>Daily</span>
                        </div>
                    </div>
                    
                    <div class="event-footer">
                        <div class="event-price">
                            <span class="price">LKR 18,750</span>
                            <span class="per">per person</span>
                        </div>
                        
                        <div class="event-actions">
                            <button class="event-details-btn" data-event-id="whale-watching">
                                <i class="fas fa-info-circle"></i>
                                Details
                            </button>
                            <button class="event-book-btn cta-button" data-event="whale-watching">
                                <i class="fas fa-ticket-alt"></i>
                                Book Now
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Kitesurfing -->
            <div class="event-card" data-category="water">
                <div class="event-image">
                    <img src="https://images.unsplash.com/photo-1544551763-77ef2d0cfc6c?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Kitesurfing">
                    <div class="event-badge adventure">Adventure</div>
                    <div class="event-overlay">
                        <div class="event-rating">
                            <i class="fas fa-star"></i>
                            <span>4.8</span>
                        </div>
                    </div>
                </div>
                <div class="event-content">
                    <div class="event-header">
                        <h3 class="event-title">Kitesurfing Lessons</h3>
                        <div class="event-category-tag water">Water Sports</div>
                    </div>
                    <p class="event-description">Learn kitesurfing with IKO certified instructors in perfect wind conditions at Mirissa Beach.</p>
                    
                    <div class="event-highlights">
                        <span class="highlight">🪁 IKO Certified</span>
                        <span class="highlight">🌊 Perfect Winds</span>
                        <span class="highlight">📋 All Levels</span>
                    </div>
                    
                    <div class="event-meta">
                        <div class="meta-item">
                            <i class="fas fa-clock"></i>
                            <span>2-3 hours</span>
                        </div>
                        <div class="meta-item">
                            <i class="fas fa-users"></i>
                            <span>Max 4</span>
                        </div>
                        <div class="meta-item">
                            <i class="fas fa-wind"></i>
                            <span>May-Sep</span>
                        </div>
                    </div>
                    
                    <div class="event-footer">
                        <div class="event-price">
                            <span class="price">LKR 20,000</span>
                            <span class="per">per person</span>
                        </div>
                        
                        <div class="event-actions">
                            <button class="event-details-btn" data-event-id="kitesurfing">
                                <i class="fas fa-info-circle"></i>
                                Details
                            </button>
                            <button class="event-book-btn cta-button" data-event="kitesurfing">
                                <i class="fas fa-ticket-alt"></i>
                                Book Now
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Dolphin Watching -->
            <div class="event-card" data-category="wildlife">
                <div class="event-image">
                    <img src="https://images.unsplash.com/photo-1583212292454-1fe6229603b7?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Dolphin Watching">
                    <div class="event-overlay">
                        <div class="event-rating">
                            <i class="fas fa-star"></i>
                            <span>4.7</span>
                        </div>
                    </div>
                </div>
                <div class="event-content">
                    <div class="event-header">
                        <h3 class="event-title">Dolphin Watching</h3>
                        <div class="event-category-tag wildlife">Wildlife</div>
                    </div>
                    <p class="event-description">Get up close with playful spinner dolphins in crystal clear waters of the Indian Ocean.</p>
                    
                    <div class="event-highlights">
                        <span class="highlight">🐬 Spinner Dolphins</span>
                        <span class="highlight">🌅 Sunrise Tours</span>
                        <span class="highlight">📱 Photo Ops</span>
                    </div>
                    
                    <div class="event-meta">
                        <div class="meta-item">
                            <i class="fas fa-clock"></i>
                            <span>3 hours</span>
                        </div>
                        <div class="meta-item">
                            <i class="fas fa-users"></i>
                            <span>Max 15</span>
                        </div>
                        <div class="meta-item">
                            <i class="fas fa-sun"></i>
                            <span>6:30 AM</span>
                        </div>
                    </div>
                    
                    <div class="event-footer">
                        <div class="event-price">
                            <span class="price">LKR 12,500</span>
                            <span class="per">per person</span>
                        </div>
                        
                        <div class="event-actions">
                            <button class="event-details-btn" data-event-id="dolphin-watching">
                                <i class="fas fa-info-circle"></i>
                                Details
                            </button>
                            <button class="event-book-btn cta-button" data-event="dolphin-watching">
                                <i class="fas fa-ticket-alt"></i>
                                Book Now
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Snorkeling -->
            <div class="event-card" data-category="water">
                <div class="event-image">
                    <img src="https://images.unsplash.com/photo-1559827260-dc66d52bef19?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Snorkeling">
                    <div class="event-overlay">
                        <div class="event-rating">
                            <i class="fas fa-star"></i>
                            <span>4.6</span>
                        </div>
                    </div>
                </div>
                <div class="event-content">
                    <div class="event-header">
                        <h3 class="event-title">Snorkeling Adventure</h3>
                        <div class="event-category-tag water">Water Sports</div>
                    </div>
                    <p class="event-description">Explore vibrant coral reefs and tropical marine life in crystal-clear waters around Snake Island.</p>
                    
                    <div class="event-highlights">
                        <span class="highlight">🐠 Coral Reefs</span>
                        <span class="highlight">🐢 Sea Turtles</span>
                        <span class="highlight">📷 Underwater Cam</span>
                    </div>
                    
                    <div class="event-meta">
                        <div class="meta-item">
                            <i class="fas fa-clock"></i>
                            <span>3-4 hours</span>
                        </div>
                        <div class="meta-item">
                            <i class="fas fa-users"></i>
                            <span>Max 8</span>
                        </div>
                        <div class="meta-item">
                            <i class="fas fa-swimming-pool"></i>
                            <span>All Levels</span>
                        </div>
                    </div>
                    
                    <div class="event-footer">
                        <div class="event-price">
                            <span class="price">LKR 8,500</span>
                            <span class="per">per person</span>
                        </div>
                        
                        <div class="event-actions">
                            <button class="event-details-btn" data-event-id="snorkeling">
                                <i class="fas fa-info-circle"></i>
                                Details
                            </button>
                            <button class="event-book-btn cta-button" data-event="snorkeling">
                                <i class="fas fa-ticket-alt"></i>
                                Book Now
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Island Boat Tour -->
            <div class="event-card" data-category="adventure">
                <div class="event-image">
                    <img src="https://images.unsplash.com/photo-1535025639604-9a804c092faa?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Island Boat Tour">
                    <div class="event-overlay">
                        <div class="event-rating">
                            <i class="fas fa-star"></i>
                            <span>4.8</span>
                        </div>
                    </div>
                </div>
                <div class="event-content">
                    <div class="event-header">
                        <h3 class="event-title">Island Boat Tour</h3>
                        <div class="event-category-tag adventure">Adventure</div>
                    </div>
                    <p class="event-description">Discover hidden coves, pristine beaches, and secret lagoons around the tropical islands.</p>
                    
                    <div class="event-highlights">
                        <span class="highlight">🏝️ Hidden Islands</span>
                        <span class="highlight">🏖️ Secret Beaches</span>
                        <span class="highlight">🍹 Refreshments</span>
                    </div>
                    
                    <div class="event-meta">
                        <div class="meta-item">
                            <i class="fas fa-clock"></i>
                            <span>4-8 hours</span>
                        </div>
                        <div class="meta-item">
                            <i class="fas fa-users"></i>
                            <span>Max 12</span>
                        </div>
                        <div class="meta-item">
                            <i class="fas fa-ship"></i>
                            <span>Multiple Tours</span>
                        </div>
                    </div>
                    
                    <div class="event-footer">
                        <div class="event-price">
                            <span class="price">From LKR 15,000</span>
                            <span class="per">per person</span>
                        </div>
                        
                        <div class="event-actions">
                            <button class="event-details-btn" data-event-id="island-boat-tour">
                                <i class="fas fa-info-circle"></i>
                                Details
                            </button>
                            <button class="event-book-btn cta-button" data-event="island-boat-tour">
                                <i class="fas fa-ticket-alt"></i>
                                Book Now
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Wilpattu Safari -->
            <div class="event-card" data-category="wildlife">
                <div class="event-image">
                    <img src="https://images.unsplash.com/photo-1549366021-9f761d040a94?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Wilpattu Safari">
                    <div class="event-badge full-day">Full Day</div>
                    <div class="event-overlay">
                        <div class="event-rating">
                            <i class="fas fa-star"></i>
                            <span>4.9</span>
                        </div>
                    </div>
                </div>
                <div class="event-content">
                    <div class="event-header">
                        <h3 class="event-title">Wilpattu Safari</h3>
                        <div class="event-category-tag wildlife">Wildlife</div>
                    </div>
                    <p class="event-description">Explore Sri Lanka's largest national park and spot leopards, elephants, and diverse wildlife.</p>
                    
                    <div class="event-highlights">
                        <span class="highlight">🐆 Leopards</span>
                        <span class="highlight">🐘 Elephants</span>
                        <span class="highlight">🦅 200+ Birds</span>
                    </div>
                    
                    <div class="event-meta">
                        <div class="meta-item">
                            <i class="fas fa-clock"></i>
                            <span>6-7 hours</span>
                        </div>
                        <div class="meta-item">
                            <i class="fas fa-users"></i>
                            <span>Max 6</span>
                        </div>
                        <div class="meta-item">
                            <i class="fas fa-binoculars"></i>
                            <span>4WD Vehicle</span>
                        </div>
                    </div>
                    
                    <div class="event-footer">
                        <div class="event-price">
                            <span class="price">LKR 25,000</span>
                            <span class="per">per person</span>
                        </div>
                        
                        <div class="event-actions">
                            <button class="event-details-btn" data-event-id="wilpattu-safari">
                                <i class="fas fa-info-circle"></i>
                                Details
                            </button>
                            <button class="event-book-btn cta-button" data-event="wilpattu-safari">
                                <i class="fas fa-ticket-alt"></i>
                                Book Now
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Load More Button -->
        <div class="load-more-container">
            <button class="load-more-btn">
                <i class="fas fa-plus-circle"></i>
                Load More Experiences
            </button>
        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Filter functionality
    const filterButtons = document.querySelectorAll('.event-filter');
    const eventCards = document.querySelectorAll('.event-card');
    const searchInput = document.querySelector('.event-search');
    
    filterButtons.forEach(button => {
        button.addEventListener('click', function() {
            // Remove active class from all buttons
            filterButtons.forEach(btn => btn.classList.remove('active'));
            // Add active class to clicked button
            this.classList.add('active');
            
            const filter = this.getAttribute('data-filter');
            
            eventCards.forEach(card => {
                if (filter === 'all' || card.getAttribute('data-category') === filter) {
                    card.style.display = 'block';
                    card.style.animation = 'fadeInUp 0.5s ease forwards';
                } else {
                    card.style.display = 'none';
                }
            });
        });
    });
    
    // Search functionality
    searchInput.addEventListener('input', function() {
        const searchTerm = this.value.toLowerCase();
        
        eventCards.forEach(card => {
            const title = card.querySelector('.event-title').textContent.toLowerCase();
            const description = card.querySelector('.event-description').textContent.toLowerCase();
            
            if (title.includes(searchTerm) || description.includes(searchTerm)) {
                card.style.display = 'block';
            } else {
                card.style.display = 'none';
            }
        });
    });
    
    // Event details navigation
    const detailButtons = document.querySelectorAll('.event-details-btn');
    detailButtons.forEach(button => {
        button.addEventListener('click', function() {
            const eventId = this.getAttribute('data-event-id');
            // Navigate to event detail page
            window.navigateToPage(eventId);
        });
    });
});
</script>
