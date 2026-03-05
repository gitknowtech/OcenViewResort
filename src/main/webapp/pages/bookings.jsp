<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Booking Section -->
<section class="section active">
    <div class="container">
        <h2 class="section-title">🏨 BOOK YOUR ROOM</h2>
        
        <div class="booking-main-container">
            <!-- Left: Room Selection Panel -->
            <div class="booking-left">
                <h3>📌 Select a Room</h3>
                <div id="roomsContainer" class="rooms-grid">
                    <div style="text-align: center; padding: 20px; color: #999; grid-column: 1/-1;">
                        <i class="fas fa-spinner fa-spin"></i> Loading rooms...
                    </div>
                </div>
            </div>

            <!-- Right: Booking Form -->
            <div class="booking-right">
                <h3>📋 Booking Details</h3>
                <form id="bookingForm">
                    <!-- Selected Room Info -->
                    <div class="form-section">
                        <h4>Selected Room</h4>
                        <div class="room-info-box">
                            <div class="info-row">
                                <span>Room #:</span>
                                <span id="selectedRoomNumber">-</span>
                            </div>
                            <div class="info-row">
                                <span>Type:</span>
                                <span id="selectedRoomType">-</span>
                            </div>
                            <div class="info-row">
                                <span>Price/Night:</span>
                                <span id="selectedRoomPrice">-</span>
                            </div>
                            <div class="info-row">
                                <span>Capacity:</span>
                                <span id="selectedRoomCapacity">-</span>
                            </div>
                        </div>
                    </div>

                    <!-- Dates -->
                    <div class="form-section">
                        <h4>📅 Dates</h4>
                        <div class="form-row">
                            <div class="form-group">
                                <label>Check-in Date *</label>
                                <input type="date" id="checkInDate" required>
                            </div>
                            <div class="form-group">
                                <label>Check-out Date *</label>
                                <input type="date" id="checkOutDate" required>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <label>Check-in Time</label>
                                <input type="time" id="checkInTime" value="14:00">
                            </div>
                            <div class="form-group">
                                <label>Check-out Time</label>
                                <input type="time" id="checkOutTime" value="11:00">
                            </div>
                        </div>
                    </div>

                    <!-- Guest Info -->
                    <div class="form-section">
                        <h4>👥 Guest Information</h4>
                        <div class="form-group">
                            <label>Number of Guests *</label>
                            <select id="numberOfGuests" required>
                                <option value="">Select</option>
                                <option value="1">1 Guest</option>
                                <option value="2" selected>2 Guests</option>
                                <option value="3">3 Guests</option>
                                <option value="4">4 Guests</option>
                                <option value="5">5 Guests</option>
                                <option value="6">6 Guests</option>
                                <option value="7">7 Guests</option>
                                <option value="8">8 Guests</option>
                                <option value="9">9 Guests</option>
                                <option value="10">10 Guests</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Special Requests</label>
                            <textarea id="specialRequests" rows="3" placeholder="Any special requests?"></textarea>
                        </div>
                    </div>

                    <!-- Booking Summary -->
                    <div class="form-section summary-section">
                        <h4>💰 Booking Summary</h4>
                        <div class="summary-row">
                            <span>Number of Nights:</span>
                            <span id="summaryNights">0</span>
                        </div>
                        <div class="summary-row">
                            <span>Price per Night:</span>
                            <span id="summaryPricePerNight">LKR 0</span>
                        </div>
                        <div class="summary-row total">
                            <span>Total Amount:</span>
                            <span id="summaryTotal">LKR 0</span>
                        </div>
                    </div>

                    <!-- Submit Button -->
                    <button type="submit" class="book-btn" id="bookBtn">
                        <i class="fas fa-check-circle"></i> CONFIRM BOOKING
                    </button>
                </form>
            </div>
        </div>
    </div>
</section>

<style>
.section-title {
    text-align: center;
    font-size: 2.5rem;
    color: #333;
    margin-bottom: 40px;
    font-weight: bold;
}

.booking-main-container {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 40px;
    margin-top: 30px;
}

.booking-left, .booking-right {
    background: white;
    padding: 30px;
    border-radius: 12px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
}

.booking-left h3, .booking-right h3 {
    color: #333;
    margin-bottom: 25px;
    font-size: 1.3rem;
    border-bottom: 3px solid #007bff;
    padding-bottom: 10px;
}

#roomsContainer {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(90px, 1fr));
    gap: 15px;
    padding: 15px;
    background: #f9fafb;
    border-radius: 8px;
    border: 2px solid #e5e7eb;
    min-height: 200px;
}

.rooms-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(90px, 1fr));
    gap: 15px;
    padding: 15px;
    background: #f9fafb;
    border-radius: 8px;
    border: 2px solid #e5e7eb;
}

.room-panel {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    padding: 18px;
    border-radius: 10px;
    text-align: center;
    transition: all 0.3s ease;
    border: 3px solid transparent;
    font-weight: 600;
    position: relative;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    min-height: 100px;
    width: 100%;
}

.room-panel.available {
    background: linear-gradient(135deg, #10b981, #059669);
    color: white;
    cursor: pointer;
}

.room-panel.available:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 20px rgba(16, 185, 129, 0.4);
}

.room-panel.unavailable {
    background: linear-gradient(135deg, #6b7280, #4b5563);
    color: white;
    cursor: not-allowed;
    opacity: 0.5;
}

.room-panel.selected {
    border-color: #007bff;
    box-shadow: 0 0 0 4px rgba(0, 123, 255, 0.3), 0 4px 12px rgba(0, 123, 255, 0.2);
    transform: scale(1.08);
}

.room-panel.selected::before {
    content: '✓';
    position: absolute;
    top: -12px;
    left: 50%;
    transform: translateX(-50%);
    background: #007bff;
    color: white;
    width: 24px;
    height: 24px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: bold;
    font-size: 14px;
    box-shadow: 0 2px 8px rgba(0, 123, 255, 0.3);
}

.room-panel-number {
    font-size: 20px;
    margin-bottom: 5px;
    font-weight: bold;
}

.room-panel-type {
    font-size: 12px;
    opacity: 0.9;
    margin-bottom: 3px;
}

.room-panel-price {
    font-size: 11px;
    opacity: 0.85;
}

.form-section {
    margin-bottom: 25px;
    padding-bottom: 20px;
    border-bottom: 1px solid #e5e7eb;
}

.form-section:last-child {
    border-bottom: none;
}

.form-section h4 {
    color: #007bff;
    margin-bottom: 15px;
    font-size: 1rem;
    font-weight: 700;
}

.room-info-box {
    background: #f0f9ff;
    padding: 15px;
    border-radius: 8px;
    border-left: 4px solid #007bff;
}

.info-row {
    display: flex;
    justify-content: space-between;
    padding: 8px 0;
    font-size: 14px;
}

.info-row span:first-child {
    font-weight: 600;
    color: #555;
}

.info-row span:last-child {
    color: #333;
    font-weight: 600;
}

.form-row {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 15px;
    margin-bottom: 15px;
}

.form-group {
    display: flex;
    flex-direction: column;
}

.form-group label {
    margin-bottom: 6px;
    font-weight: 600;
    color: #333;
    font-size: 13px;
}

.form-group input,
.form-group select,
.form-group textarea {
    padding: 11px;
    border: 1.5px solid #e5e7eb;
    border-radius: 6px;
    font-size: 14px;
    transition: all 0.3s ease;
    font-family: inherit;
}

.form-group input:focus,
.form-group select:focus,
.form-group textarea:focus {
    outline: none;
    border-color: #007bff;
    box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.1);
    background: #f8fbff;
}

.summary-section {
    background: #f8f9fa;
    padding: 15px;
    border-radius: 8px;
    border: 1px solid #e5e7eb;
}

.summary-row {
    display: flex;
    justify-content: space-between;
    padding: 10px 0;
    font-size: 14px;
    color: #555;
}

.summary-row span:first-child {
    font-weight: 600;
}

.summary-row span:last-child {
    color: #333;
    font-weight: 600;
}
.summary-row.total {
    background: linear-gradient(135deg, #007bff, #0056b3);
    color: white;
    padding: 15px;
    border-radius: 6px;
    margin-top: 10px;
    font-size: 16px;
}

.summary-row.total span {
    color: white;
}

.summary-row.total span:last-child {
    color: white;
    font-weight: bold;
    font-size: 18px;
}

.book-btn {
    width: 100%;
    padding: 14px;
    background: linear-gradient(135deg, #10b981, #059669);
    color: white;
    border: none;
    border-radius: 8px;
    font-size: 16px;
    font-weight: 700;
    cursor: pointer;
    transition: all 0.3s ease;
    margin-top: 20px;
    box-shadow: 0 4px 12px rgba(16, 185, 129, 0.3);
}

.book-btn:hover:not(:disabled) {
    background: linear-gradient(135deg, #059669, #047857);
    transform: translateY(-2px);
    box-shadow: 0 6px 16px rgba(16, 185, 129, 0.4);
}

.book-btn:disabled {
    background: #9ca3af;
    cursor: not-allowed;
    transform: none;
}

.book-btn i {
    margin-right: 8px;
}

@media (max-width: 1024px) {
    .booking-main-container {
        grid-template-columns: 1fr;
        gap: 25px;
    }
}

@media (max-width: 768px) {
    .form-row {
        grid-template-columns: 1fr;
    }
    
    #roomsContainer {
        grid-template-columns: repeat(auto-fill, minmax(75px, 1fr));
    }
    
    .section-title {
        font-size: 2rem;
    }
    
    .booking-left h3, .booking-right h3 {
        font-size: 1.1rem;
    }
}

@media (max-width: 480px) {
    .booking-left, .booking-right {
        padding: 20px;
    }
    
    #roomsContainer {
        grid-template-columns: repeat(auto-fill, minmax(65px, 1fr));
        gap: 10px;
    }
    
    .section-title {
        font-size: 1.5rem;
    }
    
    .book-btn {
        padding: 12px;
        font-size: 14px;
    }
}
</style>

<!-- ✅ LOAD BOOKINGS JS FILE -->
<script src="js/bookings.js"></script>
