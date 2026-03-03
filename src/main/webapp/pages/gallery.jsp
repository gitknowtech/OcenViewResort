<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Gallery Section -->
<section class="section active">
    <div class="container">
        <h2 class="section-title">GALLERY</h2>
        <div class="gallery-categories">
            <button class="gallery-filter active" data-filter="all">All</button>
            <button class="gallery-filter" data-filter="rooms">Rooms</button>
            <button class="gallery-filter" data-filter="activities">Activities</button>
            <button class="gallery-filter" data-filter="dining">Dining</button>
            <button class="gallery-filter" data-filter="beach">Beach</button>
        </div>
        
        <div class="gallery-grid">
            <div class="gallery-item" data-category="rooms">
                <img src="images/gallery1.jpg" alt="Deluxe Room Interior">
                <div class="gallery-overlay">
                    <h4>Deluxe Room</h4>
                    <p>Comfortable and spacious accommodation</p>
                </div>
            </div>
            <div class="gallery-item" data-category="beach">
                <img src="images/gallery2.jpg" alt="Beach View">
                <div class="gallery-overlay">
                    <h4>Pristine Beach</h4>
                    <p>Crystal clear waters and golden sand</p>
                </div>
            </div>
            <div class="gallery-item" data-category="activities">
                <img src="images/gallery3.jpg" alt="Kitesurfing">
                <div class="gallery-overlay">
                    <h4>Water Sports</h4>
                    <p>Thrilling kitesurfing adventures</p>
                </div>
            </div>
            <div class="gallery-item" data-category="dining">
                <img src="images/gallery4.jpg" alt="Restaurant">
                <div class="gallery-overlay">
                    <h4>Beachfront Dining</h4>
                    <p>Delicious meals with ocean views</p>
                </div>
            </div>
            <div class="gallery-item" data-category="activities">
                <img src="images/gallery5.jpg" alt="Dolphin Watching">
                <div class="gallery-overlay">
                    <h4>Dolphin Tours</h4>
                    <p>Unforgettable marine life encounters</p>
                </div>
            </div>
            <div class="gallery-item" data-category="rooms">
                <img src="images/gallery6.jpg" alt="Suite Balcony">
                <div class="gallery-overlay">
                    <h4>Suite Balcony</h4>
                    <p>Private ocean view balcony</p>
                </div>
            </div>
        </div>
    </div>
</section>
