<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Accommodation Section -->
<section class="section active">
    <div class="container">
        <h2 class="section-title">ACCOMMODATION PACKAGES</h2>
        <p class="section-subtitle">Experience luxury and comfort with our exclusive packages in Sri Lankan Rupees</p>
        
        <!-- Package Type Selector -->
        <div class="package-selector">
            <button class="package-btn active" onclick="showPackages('night')">Night Packages</button>
            <button class="package-btn" onclick="showPackages('day')">Day Packages</button>
            <button class="package-btn" onclick="showPackages('combo')">Day & Night Combo</button>
        </div>

        <!-- Night Packages (3 packages) -->
        <div class="accommodation-grid" id="night-packages">
            <div class="room-card">
                <img src="images/deluxe-room.jpg" alt="Deluxe Room" onerror="this.src='https://via.placeholder.com/400x300/007bff/ffffff?text=Deluxe+Room'">
                <div class="room-info">
                    <h3>Deluxe Ocean View</h3>
                    <p>Spacious rooms with stunning ocean views, featuring modern amenities and comfortable furnishing. Perfect for a peaceful night's rest.</p>
                    <ul class="room-amenities">
                        <li><i class="fas fa-wifi"></i> Free WiFi</li>
                        <li><i class="fas fa-tv"></i> Smart TV</li>
                        <li><i class="fas fa-snowflake"></i> Air Conditioning</li>
                        <li><i class="fas fa-bath"></i> Private Bathroom</li>
                        <li><i class="fas fa-bed"></i> King Size Bed</li>
                        <li><i class="fas fa-coffee"></i> Welcome Drink</li>
                    </ul>
                    <div class="room-price">LKR 15,000<span>/night</span></div>
                    <div class="package-includes">
                        <small>Includes: Accommodation + Breakfast + WiFi + Welcome Drink</small>
                    </div>
                    <button class="book-btn" data-room="deluxe-night" data-price="15000" data-page="reservation">Book Night Package</button>
                </div>
            </div>

            <div class="room-card popular">
                <div class="premium-badge">Popular</div>
                <img src="images/suite.jpg" alt="Premium Suite" onerror="this.src='https://via.placeholder.com/400x300/28a745/ffffff?text=Premium+Suite'">
                <div class="room-info">
                    <h3>Premium Suite</h3>
                    <p>Luxury suite with private balcony overlooking the ocean, perfect for romantic getaways and special occasions.</p>
                    <ul class="room-amenities">
                        <li><i class="fas fa-wifi"></i> Free WiFi</li>
                        <li><i class="fas fa-tv"></i> Smart TV</li>
                        <li><i class="fas fa-snowflake"></i> Air Conditioning</li>
                        <li><i class="fas fa-bath"></i> Jacuzzi</li>
                        <li><i class="fas fa-utensils"></i> Mini Bar</li>
                        <li><i class="fas fa-balcony"></i> Private Balcony</li>
                        <li><i class="fas fa-wine-glass"></i> Complimentary Wine</li>
                    </ul>
                    <div class="room-price">LKR 35,000<span>/night</span></div>
                    <div class="package-includes">
                        <small>Includes: Suite + Breakfast + Dinner + Mini Bar + Spa Access + Wine</small>
                    </div>
                    <button class="book-btn" data-room="suite-night" data-price="35000" data-page="reservation">Book Night Package</button>
                </div>
            </div>

            <div class="room-card premium">
                <div class="premium-badge">Luxury</div>
                <img src="images/villa.jpg" alt="Luxury Villa" onerror="this.src='https://via.placeholder.com/400x300/ffd700/333333?text=Luxury+Villa'">
                <div class="room-info">
                    <h3>Luxury Ocean Villa</h3>
                    <p>Ultimate luxury experience with private pool, personal butler service, and panoramic ocean views.</p>
                    <ul class="room-amenities">
                        <li><i class="fas fa-wifi"></i> Free WiFi</li>
                        <li><i class="fas fa-tv"></i> 65" Smart TV</li>
                        <li><i class="fas fa-snowflake"></i> Climate Control</li>
                        <li><i class="fas fa-swimming-pool"></i> Private Pool</li>
                        <li><i class="fas fa-user-tie"></i> Butler Service</li>
                        <li><i class="fas fa-car"></i> Airport Transfer</li>
                        <li><i class="fas fa-spa"></i> In-room Spa</li>
                    </ul>
                    <div class="room-price">LKR 75,000<span>/night</span></div>
                    <div class="package-includes">
                        <small>Includes: Villa + All Meals + Butler + Spa + Activities + Transfers</small>
                    </div>
                    <button class="book-btn" data-room="villa-night" data-price="75000" data-page="reservation">Book Night Package</button>
                </div>
            </div>
        </div>

        <!-- Day Packages (3 packages) -->
        <div class="accommodation-grid" id="day-packages" style="display: none;">
            <div class="room-card">
                <img src="images/day-deluxe.jpg" alt="Day Use Deluxe" onerror="this.src='https://via.placeholder.com/400x300/17a2b8/ffffff?text=Day+Deluxe'">
                <div class="room-info">
                    <h3>Deluxe Day Use</h3>
                    <p>Perfect for day relaxation with room access from 9 AM to 6 PM. Ideal for business travelers or day trips.</p>
                    <ul class="room-amenities">
                        <li><i class="fas fa-clock"></i> 9 Hours Access (9AM-6PM)</li>
                        <li><i class="fas fa-wifi"></i> Free WiFi</li>
                        <li><i class="fas fa-tv"></i> Smart TV</li>
                        <li><i class="fas fa-snowflake"></i> Air Conditioning</li>
                        <li><i class="fas fa-utensils"></i> Lunch Included</li>
                        <li><i class="fas fa-swimming-pool"></i> Pool Access</li>
                    </ul>
                    <div class="room-price">LKR 8,000<span>/day</span></div>
                    <div class="package-includes">
                        <small>Includes: Room (9AM-6PM) + Lunch + Pool Access + WiFi</small>
                    </div>
                    <button class="book-btn" data-room="deluxe-day" data-price="8000" data-page="reservation">Book Day Package</button>
                </div>
            </div>

            <div class="room-card popular">
                <div class="premium-badge">Best Value</div>
                <img src="images/day-suite.jpg" alt="Premium Day Suite" onerror="this.src='https://via.placeholder.com/400x300/28a745/ffffff?text=Premium+Day+Suite'">
                <div class="room-info">
                    <h3>Premium Day Suite</h3>
                    <p>Luxury day experience with suite access, perfect for special occasions or business meetings.</p>
                    <ul class="room-amenities">
                        <li><i class="fas fa-clock"></i> 10 Hours Access (8AM-6PM)</li>
                        <li><i class="fas fa-wifi"></i> Free WiFi</li>
                        <li><i class="fas fa-tv"></i> Smart TV</li>
                        <li><i class="fas fa-snowflake"></i> Air Conditioning</li>
                        <li><i class="fas fa-utensils"></i> Lunch + High Tea</li>
                        <li><i class="fas fa-spa"></i> 2 Hour Spa</li>
                        <li><i class="fas fa-cocktail"></i> Welcome Drinks</li>
                    </ul>
                    <div class="room-price">LKR 20,000<span>/day</span></div>
                    <div class="package-includes">
                        <small>Includes: Suite (8AM-6PM) + Meals + 2Hr Spa + All Facilities</small>
                    </div>
                    <button class="book-btn" data-room="suite-day" data-price="20000" data-page="reservation">Book Day Package</button>
                </div>
            </div>

            <div class="room-card premium">
                <div class="premium-badge">VIP</div>
                <img src="images/vip-day.jpg" alt="VIP Day Experience" onerror="this.src='https://via.placeholder.com/400x300/ffd700/333333?text=VIP+Day+Experience'">
                <div class="room-info">
                    <h3>VIP Day Experience</h3>
                    <p>Ultimate day luxury with private villa access, personal service, and exclusive amenities.</p>
                    <ul class="room-amenities">
                        <li><i class="fas fa-clock"></i> 12 Hours Access (7AM-7PM)</li>
                        <li><i class="fas fa-swimming-pool"></i> Private Pool</li>
                        <li><i class="fas fa-user-tie"></i> Personal Butler</li>
                        <li><i class="fas fa-utensils"></i> Gourmet Meals</li>
                        <li><i class="fas fa-spa"></i> Full Spa Treatment</li>
                        <li><i class="fas fa-car"></i> Chauffeur Service</li>
                        <li><i class="fas fa-champagne-glasses"></i> Premium Bar</li>
                    </ul>
                    <div class="room-price">LKR 45,000<span>/day</span></div>
                    <div class="package-includes">
                        <small>Includes: Private Villa + Butler + Full Spa + Gourmet Dining + Transport</small>
                    </div>
                    <button class="book-btn" data-room="vip-day" data-price="45000" data-page="reservation">Book Day Package</button>
                </div>
            </div>
        </div>

        <!-- Day & Night Combo Packages (3 packages) -->
        <div class="accommodation-grid" id="combo-packages" style="display: none;">
            <div class="room-card">
                <img src="images/combo-deluxe.jpg" alt="Deluxe Combo" onerror="this.src='https://via.placeholder.com/400x300/6f42c1/ffffff?text=Deluxe+24Hr+Combo'">
                <div class="room-info">
                    <h3>Deluxe 24-Hour Experience</h3>
                    <p>Complete day and night package with full access to all facilities and services for 24 hours.</p>
                    <ul class="room-amenities">
                        <li><i class="fas fa-clock"></i> 24 Hours Full Access</li>
                        <li><i class="fas fa-bed"></i> Overnight Stay</li>
                        <li><i class="fas fa-utensils"></i> All Meals Included</li>
                        <li><i class="fas fa-swimming-pool"></i> Pool Access</li>
                        <li><i class="fas fa-spa"></i> Spa Credit LKR 5,000</li>
                        <li><i class="fas fa-wifi"></i> Premium WiFi</li>
                    </ul>
                    <div class="room-price">LKR 20,000<span>/24hrs</span></div>
                    <div class="savings">Save LKR 3,000!</div>
                    <div class="package-includes">
                        <small>Includes: Day Use + Night Stay + All Meals + LKR 5,000 Spa Credit</small>
                    </div>
                    <button class="book-btn" data-room="deluxe-combo" data-price="20000" data-page="reservation">Book Combo Package</button>
                </div>
            </div>

            <div class="room-card popular">
                <div class="premium-badge">Most Popular</div>
                <img src="images/combo-suite.jpg" alt="Suite Combo" onerror="this.src='https://via.placeholder.com/400x300/28a745/ffffff?text=Premium+Suite+Combo'">
                <div class="room-info">
                    <h3>Premium Suite 24-Hour</h3>
                    <p>Luxury suite experience with comprehensive day and night services and premium amenities.</p>
                    <ul class="room-amenities">
                        <li><i class="fas fa-clock"></i> 24 Hours Suite Access</li>
                        <li><i class="fas fa-bed"></i> Luxury Suite Stay</li>
                        <li><i class="fas fa-utensils"></i> Gourmet Dining</li>
                        <li><i class="fas fa-spa"></i> Full Spa Package</li>
                        <li><i class="fas fa-cocktail"></i> Premium Bar Access</li>
                        <li><i class="fas fa-concierge-bell"></i> Concierge Service</li>
                    </ul>
                    <div class="room-price">LKR 50,000<span>/24hrs</span></div>
                    <div class="savings">Save LKR 5,000!</div>
                    <div class="package-includes">
                        <small>Includes: Day + Night Suite + Full Spa + Gourmet Dining + Premium Services</small>
                    </div>
                    <button class="book-btn" data-room="suite-combo" data-price="50000" data-page="reservation">Book Combo Package</button>
                </div>
            </div>

            <div class="room-card premium">
                <div class="premium-badge">Ultimate Luxury</div>
                <img src="images/combo-villa.jpg" alt="Villa Combo" onerror="this.src='https://via.placeholder.com/400x300/ffd700/333333?text=Luxury+Villa+Combo'">
                <div class="room-info">
                    <h3>Luxury Villa 24-Hour</h3>
                    <p>Ultimate luxury experience combining the best of day and night packages with exclusive VIP perks.</p>
                    <ul class="room-amenities">
                        <li><i class="fas fa-clock"></i> 24+ Hours Villa Access</li>
                        <li><i class="fas fa-swimming-pool"></i> Private Pool</li>
                        <li><i class="fas fa-user-tie"></i> 24/7 Butler Service</li>
                        <li><i class="fas fa-utensils"></i> Chef's Special Menu</li>
                        <li><i class="fas fa-spa"></i> Unlimited Spa Services</li>
                        <li><i class="fas fa-car"></i> Luxury Transport</li>
                        <li><i class="fas fa-gift"></i> Exclusive Experiences</li>
                    </ul>
                    <div class="room-price">LKR 100,000<span>/24hrs</span></div>
                    <div class="savings">Save LKR 20,000!</div>
                    <div class="package-includes">
                        <small>Ultimate Package: Villa + Butler + Unlimited Spa + Chef + Experiences + Transport</small>
                    </div>
                    <button class="book-btn" data-room="villa-combo" data-price="100000" data-page="reservation">Book Combo Package</button>
                </div>
            </div>
        </div>

        <!-- Special Offers Section -->
        <div class="special-offers">
            <h3>🎉 Special Offers & Discounts</h3>
            <div class="offers-grid">
                <div class="offer-card">
                    <h4>🌅 Early Bird Special</h4>
                    <p>Book 30 days in advance and save 15% on all packages</p>
                    <span class="offer-code">Code: EARLY15</span>
                </div>
                <div class="offer-card">
                    <h4>🌙 Weekend Getaway</h4>
                    <p>Stay 2 nights on weekends and get 20% off the second night</p>
                    <span class="offer-code">Code: WEEKEND20</span>
                </div>
                <div class="offer-card">
                    <h4>👥 Group Booking</h4>
                    <p>Book 3+ rooms and receive complimentary group activities</p>
                    <span class="offer-code">Code: GROUP3</span>
                </div>
            </div>
        </div>
    </div>
</section>

<style>
.section-title {
    text-align: center;
    font-size: 2.5rem;
    color: #333;
    margin-bottom: 10px;
}

.section-subtitle {
    text-align: center;
    color: #666;
    margin-bottom: 30px;
    font-size: 1.1rem;
}

.package-selector {
    text-align: center;
    margin-bottom: 40px;
}

.package-btn {
    background: #f8f9fa;
    border: 2px solid #007bff;
    color: #007bff;
    padding: 12px 25px;
    margin: 0 10px;
    border-radius: 25px;
    cursor: pointer;
    transition: all 0.3s ease;
    font-weight: 600;
    font-size: 16px;
}

.package-btn.active,
.package-btn:hover {
    background: #007bff;
    color: white;
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(0,123,255,0.3);
}

.accommodation-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
    gap: 30px;
    margin-bottom: 40px;
}

.room-card {
    position: relative;
    background: white;
    border-radius: 15px;
    box-shadow: 0 8px 25px rgba(0,0,0,0.1);
    overflow: hidden;
    transition: all 0.3s ease;
    border: 1px solid #e9ecef;
}

.room-card:hover {
    transform: translateY(-8px);
    box-shadow: 0 15px 35px rgba(0,0,0,0.15);
}

.room-card.popular {
    border: 3px solid #28a745;
}

.room-card.premium {
    border: 3px solid #ffd700;
    background: linear-gradient(135deg, #fff 0%, #fffbf0 100%);
}

.room-card img {
    width: 100%;
    height: 250px;
    object-fit: cover;
}

.premium-badge {
    position: absolute;
    top: 15px;
    right: 15px;
    background: linear-gradient(135deg, #ffd700, #ffed4e);
    color: #333;
    padding: 8px 15px;
    border-radius: 20px;
    font-weight: bold;
    font-size: 12px;
    z-index: 2;
    box-shadow: 0 3px 10px rgba(255,215,0,0.3);
}

.room-card.popular .premium-badge {
    background: linear-gradient(135deg, #28a745, #20c997);
    color: white;
}

.room-info {
    padding: 25px;
}

.room-info h3 {
    color: #333;
    margin-bottom: 15px;
    font-size: 1.4rem;
}

.room-info p {
    color: #666;
    margin-bottom: 20px;
    line-height: 1.6;
}

.room-amenities {
    list-style: none;
    padding: 0;
    margin-bottom: 20px;
}

.room-amenities li {
    padding: 5px 0;
    color: #555;
}

.room-amenities i {
    color: #007bff;
    width: 20px;
    margin-right: 10px;
}

.room-price {
    font-size: 28px;
    font-weight: bold;
    color: #007bff;
    margin: 15px 0 10px 0;
}

.room-price span {
    font-size: 16px;
    color: #666;
    font-weight: normal;
}

.savings {
    background: linear-gradient(135deg, #28a745, #20c997);
    color: white;
    padding: 5px 15px;
    border-radius: 20px;
    display: inline-block;
    font-size: 14px;
    font-weight: bold;
    margin-bottom: 10px;
}

.package-includes {
    color: #666;
    font-style: italic;
    margin-bottom: 20px;
    background: #f8f9fa;
    padding: 10px;
    border-radius: 8px;
    border-left: 4px solid #007bff;
}

.book-btn {
    background: linear-gradient(135deg, #007bff, #0056b3);
    color: white;
    border: none;
    padding: 12px 25px;
    border-radius: 25px;
    cursor: pointer;
    font-weight: 600;
    width: 100%;
    transition: all 0.3s ease;
    font-size: 16px;
}

.book-btn:hover {
    background: linear-gradient(135deg, #0056b3, #004085);
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(0,123,255,0.3);
}

.special-offers {
    margin-top: 60px;
    text-align: center;
    background: linear-gradient(135deg, #f8f9fa, #e9ecef);
    padding: 40px;
    border-radius: 15px;
}

.special-offers h3 {
    color: #333;
    margin-bottom: 30px;
    font-size: 2rem;
}

.offers-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: 25px;
    margin-top: 30px;
}

.offer-card {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    padding: 25px;
    border-radius: 15px;
    text-align: center;
    transition: transform 0.3s ease;
}

.offer-card:hover {
    transform: translateY(-5px);
}

.offer-card h4 {
    margin-bottom: 15px;
    font-size: 1.3rem;
}

.offer-code {
    display: inline-block;
    background: rgba(255,255,255,0.2);
    padding: 8px 20px;
    border-radius: 25px;
    margin-top: 15px;
    font-weight: bold;
    border: 2px solid rgba(255,255,255,0.3);
}

@media (max-width: 768px) {
    .package-btn {
        display: block;
        margin: 10px auto;
        width: 200px;
    }
    
    .accommodation-grid {
        grid-template-columns: 1fr;
    }
    
    .section-title {
        font-size: 2rem;
    }
    
    .room-info {
        padding: 20px;
    }
}

@media (max-width: 480px) {
    .package-btn {
        width: 180px;
        padding: 10px 20px;
        font-size: 14px;
    }
    
    .room-price {
        font-size: 24px;
    }
}
</style>

<script>
function showPackages(packageType) {
    console.log("Showing packages for:", packageType);
    
    // Remove active class from all buttons
    document.querySelectorAll('.package-btn').forEach(btn => {
        btn.classList.remove('active');
    });
    
    // Add active class to clicked button
    event.target.classList.add('active');
    
    // Hide all package grids
    document.querySelectorAll('.accommodation-grid').forEach(grid => {
        grid.style.display = 'none';
    });
    
    // Show selected package grid with fade effect
    const selectedGrid = document.getElementById(packageType + '-packages');
    if (selectedGrid) {
        selectedGrid.style.display = 'grid';
        selectedGrid.style.opacity = '0';
        setTimeout(() => {
            selectedGrid.style.transition = 'opacity 0.3s ease';
            selectedGrid.style.opacity = '1';
        }, 50);
    }
}

// Initialize when page loads
document.addEventListener('DOMContentLoaded', function() {
    console.log("Accommodation page loaded");
    // Show night packages by default
    showPackages('night');
});

// Also initialize when loaded via AJAX
$(document).ready(function() {
    console.log("jQuery ready - accommodation page");
    showPackages('night');
});
</script>
