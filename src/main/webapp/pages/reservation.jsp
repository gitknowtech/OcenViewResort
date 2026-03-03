<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Reservation Section -->
<section class="section active">
    <div class="container">
        <h2 class="section-title">MAKE A RESERVATION</h2>
        <div class="reservation-container">
            <div class="reservation-form">
                <h3>Book Your Stay</h3>
                <form id="reservationForm">
                    <div class="form-step" id="step1">
                        <h4>Guest Information</h4>
                        <div class="form-row">
                            <div class="form-group">
                                <label>Guest Name *</label>
                                <input type="text" name="guestName" required>
                            </div>
                            <div class="form-group">
                                <label>Email Address *</label>
                                <input type="email" name="email" required>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <label>Contact Number *</label>
                                <input type="tel" name="contactNumber" required>
                            </div>
                            <div class="form-group">
                                <label>Country</label>
                                <select name="country">
                                    <option value="">Select Country</option>
                                    <option value="LK">Sri Lanka</option>
                                    <option value="US">United States</option>
                                    <option value="UK">United Kingdom</option>
                                    <option value="IN">India</option>
                                    <option value="AU">Australia</option>
                                </select>
                            </div>
                        </div>
                        <button type="button" class="next-btn" onclick="nextStep(2)">Next</button>
                    </div>

                    <div class="form-step" id="step2" style="display: none;">
                        <h4>Booking Details</h4>
                        <div class="form-row">
                            <div class="form-group">
                                <label>Room Type *</label>
                                <select name="roomType" required onchange="calculateTotal()">
                                    <option value="">Select Room Type</option>
                                    <option value="deluxe" data-price="150">Deluxe Ocean View - $150/night</option>
                                    <option value="suite" data-price="250">Premium Suite - $250/night</option>
                                    <option value="cabana" data-price="200">Beach Cabana - $200/night</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Number of Guests</label>
                                <select name="guests">
                                    <option value="1">1 Guest</option>
                                    <option value="2" selected>2 Guests</option>
                                    <option value="3">3 Guests</option>
                                    <option value="4">4 Guests</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <label>Check-in Date *</label>
                                <input type="date" name="checkInDate" required onchange="calculateTotal()">
                            </div>
                            <div class="form-group">
                                <label>Check-out Date *</label>
                                <input type="date" name="checkOutDate" required onchange="calculateTotal()">
                            </div>
                        </div>
                        <div class="form-navigation">
                            <button type="button" class="prev-btn" onclick="prevStep(1)">Previous</button>
                            <button type="submit" class="submit-btn">Book Now</button>
                        </div>
                    </div>
                </form>
            </div>

            <div class="reservation-info">
                <h3>Booking Information</h3>
                <div class="booking-summary" id="bookingSummary">
                    <div class="summary-item">
                        <span>Room Rate:</span>
                        <span id="roomRate">Select room type</span>
                    </div>
                    <div class="summary-item">
                        <span>Number of Nights:</span>
                        <span id="totalNights">-</span>
                    </div>
                    <div class="summary-item total">
                        <span>Total Amount:</span>
                        <span id="totalAmount">$0</span>
                    </div>
                </div>
                
                <div class="info-item">
                    <i class="fas fa-clock"></i>
                    <div>
                        <h4>Check-in / Check-out</h4>
                        <p>Check-in: 2:00 PM<br>Check-out: 12:00 PM</p>
                    </div>
                </div>
                <div class="info-item">
                    <i class="fas fa-credit-card"></i>
                    <div>
                        <h4>Payment</h4>
                        <p>Payment can be made at the resort or via bank transfer</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
