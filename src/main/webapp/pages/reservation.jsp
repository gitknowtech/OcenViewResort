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
                                <input type="text" id="guestName" name="guestName" placeholder="Enter your full name" required>
                            </div>
                            <div class="form-group">
                                <label>Email Address *</label>
                                <input type="email" id="email" name="email" placeholder="your@email.com" required>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <label>Contact Number *</label>
                                <input type="tel" id="contactNumber" name="contactNumber" placeholder="+94771234567" required>
                            </div>
                            <div class="form-group">
                                <label>Country</label>
                                <select id="country" name="country">
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
                        
                        <!-- Room Type (Pre-filled from accommodation page) -->
                        <div class="form-row">
                            <div class="form-group">
                                <label>Room Type *</label>
                                <div class="room-display">
                                    <div id="roomTypeDisplay" style="background: #f8f9fa; padding: 15px; border-radius: 8px; border-left: 4px solid #007bff;">
                                        <strong id="displayRoomName">Loading...</strong>
                                        <p id="displayRoomDesc" style="margin: 8px 0 0 0; color: #666; font-size: 14px;"></p>
                                        <p id="displayRoomPrice" style="margin: 8px 0 0 0; color: #007bff; font-weight: bold; font-size: 16px;"></p>
                                    </div>
                                    <input type="hidden" id="roomType" name="roomType">
                                    <input type="hidden" id="roomPrice" name="roomPrice">
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Number of Guests</label>
                                <select id="guests" name="guests" onchange="calculateTotal()">
                                    <option value="1">1 Guest</option>
                                    <option value="2" selected>2 Guests</option>
                                    <option value="3">3 Guests</option>
                                    <option value="4">4 Guests</option>
                                </select>
                            </div>
                        </div>

                        <!-- Check-in / Check-out -->
                        <div class="form-row">
                            <div class="form-group">
                                <label>Check-in Date *</label>
                                <input type="date" id="checkInDate" name="checkInDate" required onchange="calculateTotal()">
                            </div>
                            <div class="form-group">
                                <label>Check-out Date *</label>
                                <input type="date" id="checkOutDate" name="checkOutDate" required onchange="calculateTotal()">
                            </div>
                        </div>

                        <!-- Check-in / Check-out Times -->
                        <div class="form-row">
                            <div class="form-group">
                                <label>Check-in Time</label>
                                <input type="time" id="checkInTime" name="checkInTime">
                            </div>
                            <div class="form-group">
                                <label>Check-out Time</label>
                                <input type="time" id="checkOutTime" name="checkOutTime">
                            </div>
                        </div>

                        <!-- Special Requests -->
                        <div class="form-row full-width">
                            <div class="form-group">
                                <label>Special Requests (Optional)</label>
                                <textarea id="specialRequests" name="specialRequests" rows="4" placeholder="Any special requests or preferences?"></textarea>
                            </div>
                        </div>

                        <div class="form-navigation">
                            <button type="button" class="prev-btn" onclick="prevStep(1)">Previous</button>
                            <button type="submit" class="submit-btn">Complete Booking</button>
                        </div>
                    </div>
                </form>
            </div>

            <!-- Booking Summary -->
            <div class="reservation-info">
                <h3>Booking Summary</h3>
                <div class="booking-summary" id="bookingSummary">
                    <div class="summary-section">
                        <h4>Room Details</h4>
                        <div class="summary-item">
                            <span>Room Type:</span>
                            <span id="summaryRoomType">-</span>
                        </div>
                        <div class="summary-item">
                            <span>Price per Night:</span>
                            <span id="summaryPrice">-</span>
                        </div>
                    </div>

                    <div class="summary-section">
                        <h4>Stay Duration</h4>
                        <div class="summary-item">
                            <span>Check-in:</span>
                            <span id="summaryCheckIn">-</span>
                        </div>
                        <div class="summary-item">
                            <span>Check-out:</span>
                            <span id="summaryCheckOut">-</span>
                        </div>
                        <div class="summary-item">
                            <span>Number of Nights:</span>
                            <span id="summaryNights">-</span>
                        </div>
                    </div>

                    <div class="summary-section">
                        <h4>Guest Information</h4>
                        <div class="summary-item">
                            <span>Guest Name:</span>
                            <span id="summaryGuestName">-</span>
                        </div>
                        <div class="summary-item">
                            <span>Email:</span>
                            <span id="summaryEmail">-</span>
                        </div>
                        <div class="summary-item">
                            <span>Contact:</span>
                            <span id="summaryContact">-</span>
                        </div>
                    </div>

                    <div class="summary-section total">
                        <div class="summary-item">
                            <span>Total Amount:</span>
                            <span id="summaryTotal">LKR 0</span>
                        </div>
                    </div>
                </div>
                
                <div class="info-item">
                    <i class="fas fa-info-circle"></i>
                    <div>
                        <h4>Booking Confirmation</h4>
                        <p>A confirmation email will be sent to your email address with booking details and reservation number.</p>
                    </div>
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
    margin-bottom: 30px;
}

.reservation-container {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 40px;
    margin-top: 40px;
}

.reservation-form {
    background: white;
    padding: 30px;
    border-radius: 12px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
}

.reservation-form h3 {
    color: #333;
    margin-bottom: 25px;
    font-size: 1.5rem;
}

.form-step h4 {
    color: #007bff;
    margin-bottom: 20px;
    font-size: 1.2rem;
    border-bottom: 2px solid #007bff;
    padding-bottom: 10px;
}

.form-row {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 20px;
    margin-bottom: 20px;
}

.form-row.full-width {
    grid-template-columns: 1fr;
}

.form-group {
    display: flex;
    flex-direction: column;
}

.form-group label {
    margin-bottom: 8px;
    font-weight: 600;
    color: #333;
    font-size: 14px;
}

.form-group input,
.form-group select,
.form-group textarea {
    padding: 12px;
    border: 1px solid #e9ecef;
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
    box-shadow: 0 0 0 3px rgba(0,123,255,0.1);
    background: #f8fbff;
}

.room-display {
    margin-top: 8px;
}

.form-navigation {
    display: flex;
    gap: 15px;
    margin-top: 30px;
}

.next-btn,
.prev-btn,
.submit-btn {
    flex: 1;
    padding: 12px 25px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-weight: 600;
    transition: all 0.3s ease;
    font-size: 14px;
}

.next-btn,
.submit-btn {
    background: linear-gradient(135deg, #007bff, #0056b3);
    color: white;
}

.next-btn:hover,
.submit-btn:hover {
    background: linear-gradient(135deg, #0056b3, #004085);
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(0,123,255,0.3);
}

.prev-btn {
    background: #6c757d;
    color: white;
}

.prev-btn:hover {
    background: #5a6268;
}

.reservation-info {
    background: linear-gradient(135deg, #f8f9fa, #e9ecef);
    padding: 30px;
    border-radius: 12px;
    height: fit-content;
    position: sticky;
    top: 20px;
}

.reservation-info h3 {
    color: #333;
    margin-bottom: 20px;
    font-size: 1.3rem;
}

.booking-summary {
    background: white;
    padding: 20px;
    border-radius: 8px;
    margin-bottom: 20px;
}

.summary-section {
    margin-bottom: 20px;
    padding-bottom: 15px;
    border-bottom: 1px solid #e9ecef;
}

.summary-section:last-child {
    border-bottom: none;
}

.summary-section h4 {
    color: #007bff;
    font-size: 12px;
    text-transform: uppercase;
    margin-bottom: 10px;
    font-weight: 700;
    letter-spacing: 0.5px;
}

.summary-item {
    display: flex;
    justify-content: space-between;
    padding: 8px 0;
    font-size: 14px;
    color: #555;
}

.summary-item span:first-child {
    font-weight: 600;
}

.summary-item span:last-child {
    text-align: right;
    color: #333;
}

.summary-section.total {
    background: linear-gradient(135deg, #007bff, #0056b3);
    color: white;
    padding: 20px;
    border-radius: 8px;
    margin-top: 20px;
    border: none;
}

.summary-section.total .summary-item {
    color: rgba(255,255,255,0.9);
}

.summary-section.total .summary-item span:first-child {
    color: white;
}

.summary-section.total .summary-item span:last-child {
    color: white;
    font-size: 20px;
    font-weight: bold;
}

.info-item {
    display: flex;
    gap: 15px;
    background: white;
    padding: 15px;
    border-radius: 8px;
    margin-top: 15px;
}

.info-item i {
    color: #007bff;
    font-size: 20px;
    min-width: 30px;
}

.info-item h4 {
    margin: 0 0 5px 0;
    color: #333;
    font-size: 14px;
}

.info-item p {
    margin: 0;
    color: #666;
    font-size: 13px;
    line-height: 1.5;
}

@media (max-width: 1024px) {
    .reservation-container {
        grid-template-columns: 1fr;
    }
    
    .reservation-info {
        position: static;
    }
}

@media (max-width: 768px) {
    .form-row {
        grid-template-columns: 1fr;
    }
    
    .form-navigation {
        flex-direction: column;
    }
    
    .section-title {
        font-size: 2rem;
    }
    
    .reservation-container {
        gap: 20px;
    }
}

@media (max-width: 480px) {
    .section-title {
        font-size: 1.5rem;
    }
    
    .reservation-form {
        padding: 20px;
    }
    
    .reservation-info {
        padding: 20px;
    }
}
</style>

<script>
console.log('🚀 Reservation page script loading...');

// Global variables - using var to avoid redeclaration
var reservationPageData = {
    bookingData: null,
    currentStep: 1,
    initialized: false
};

// Initialize reservation page
function initializeReservationPage() {
    console.log('📄 Initializing reservation page...');
    
    if (reservationPageData.initialized) {
        console.log('⚠️ Page already initialized');
        return;
    }
    
    try {
        // Get booking data from sessionStorage
        const storedData = sessionStorage.getItem('bookingData');
        
        if (storedData) {
            reservationPageData.bookingData = JSON.parse(storedData);
            console.log('📦 Booking data retrieved:', reservationPageData.bookingData);
            
            // Pre-fill room information
            const roomType = document.getElementById('roomType');
            const roomPrice = document.getElementById('roomPrice');
            
            if (roomType && roomPrice) {
                roomType.value = reservationPageData.bookingData.roomType;
                roomPrice.value = reservationPageData.bookingData.price;
                
                document.getElementById('displayRoomName').textContent = reservationPageData.bookingData.roomName;
                document.getElementById('displayRoomDesc').textContent = reservationPageData.bookingData.roomDescription;
                document.getElementById('displayRoomPrice').textContent = 'LKR ' + reservationPageData.bookingData.price + ' (' + reservationPageData.bookingData.packageCategory.toUpperCase() + ')';
                
                // Set check-in and check-out times
                document.getElementById('checkInTime').value = reservationPageData.bookingData.checkInTime;
                document.getElementById('checkOutTime').value = reservationPageData.bookingData.checkOutTime;
            }
        } else {
            console.log('⚠️ No booking data found - using defaults');
        }
        
        // Set default dates
        const today = new Date();
        const tomorrow = new Date(today);
        tomorrow.setDate(tomorrow.getDate() + 1);
        
        const checkInDateInput = document.getElementById('checkInDate');
        const checkOutDateInput = document.getElementById('checkOutDate');
        
        if (checkInDateInput && checkOutDateInput) {
            checkInDateInput.valueAsDate = today;
            checkOutDateInput.valueAsDate = tomorrow;
        }
        
        // Load user data if logged in
        loadUserData();
        
        // Attach event listeners
        attachEventListeners();
        
        // Update summary
        updateSummary();
        calculateTotal();
        
        reservationPageData.initialized = true;
        console.log('✅ Reservation page initialized successfully');
        
    } catch (error) {
        console.error('❌ Error initializing reservation page:', error);
    }
}

// Attach event listeners
function attachEventListeners() {
    console.log('🔗 Attaching event listeners...');
    
    const reservationForm = document.getElementById('reservationForm');
    if (reservationForm) {
        reservationForm.addEventListener('submit', function(e) {
            e.preventDefault();
            submitReservation();
        });
    }
    
    const guestNameInput = document.getElementById('guestName');
    if (guestNameInput) {
        guestNameInput.addEventListener('change', updateSummary);
        guestNameInput.addEventListener('input', updateSummary);
    }
    
    const emailInput = document.getElementById('email');
    if (emailInput) {
        emailInput.addEventListener('change', updateSummary);
        emailInput.addEventListener('input', updateSummary);
    }
    
    const contactInput = document.getElementById('contactNumber');
    if (contactInput) {
        contactInput.addEventListener('change', updateSummary);
        contactInput.addEventListener('input', updateSummary);
    }
    
    const checkInDateInput = document.getElementById('checkInDate');
    if (checkInDateInput) {
        checkInDateInput.addEventListener('change', calculateTotal);
    }
    
    const checkOutDateInput = document.getElementById('checkOutDate');
    if (checkOutDateInput) {
        checkOutDateInput.addEventListener('change', calculateTotal);
    }
}

// Load user data if logged in
function loadUserData() {
    console.log('👤 Loading user data...');
    
    fetch('getProfile')
        .then(response => response.json())
        .then(data => {
            if (data.success && data.user) {
                const user = data.user;
                console.log('✅ User data loaded:', user);
                
                const firstName = user.firstName || '';
                const lastName = user.lastName || '';
                const fullName = (firstName + ' ' + lastName).trim();
                
                const guestNameInput = document.getElementById('guestName');
                const emailInput = document.getElementById('email');
                const contactInput = document.getElementById('contactNumber');
                const countrySelect = document.getElementById('country');
                
                if (guestNameInput) guestNameInput.value = fullName;
                if (emailInput) emailInput.value = user.email || '';
                if (contactInput) contactInput.value = user.phone || '';
                if (countrySelect) countrySelect.value = 'LK';
                
                updateSummary();
            }
        })
        .catch(error => console.log('⚠️ Could not load user data:', error));
}

// Calculate total price
function calculateTotal() {
    console.log('💰 Calculating total...');
    
    const checkInDateInput = document.getElementById('checkInDate');
    const checkOutDateInput = document.getElementById('checkOutDate');
    const roomPriceInput = document.getElementById('roomPrice');
    
    if (!checkInDateInput || !checkOutDateInput || !roomPriceInput) {
        console.log('   Missing input elements');
        return;
    }
    
    const checkInDate = new Date(checkInDateInput.value);
    const checkOutDate = new Date(checkOutDateInput.value);
    const price = parseFloat(roomPriceInput.value) || 0;
    
    if (checkInDate && checkOutDate && checkInDate < checkOutDate && price > 0) {
        const nights = Math.ceil((checkOutDate - checkInDate) / (1000 * 60 * 60 * 24));
        const total = price * nights;
        
        console.log('   Nights:', nights);
        console.log('   Price per night:', price);
        console.log('   Total:', total);
        
        const summaryNights = document.getElementById('summaryNights');
        const summaryTotal = document.getElementById('summaryTotal');
        
        if (summaryNights) {
            summaryNights.textContent = nights + ' night' + (nights > 1 ? 's' : '');
        }
        if (summaryTotal) {
            summaryTotal.textContent = 'LKR ' + total.toLocaleString();
        }
    }
    
    updateSummary();
}

// Update summary display
function updateSummary() {
    console.log('📋 Updating summary...');
    
    const guestNameInput = document.getElementById('guestName');
    const emailInput = document.getElementById('email');
    const contactInput = document.getElementById('contactNumber');
    const checkInDateInput = document.getElementById('checkInDate');
    const checkOutDateInput = document.getElementById('checkOutDate');
    const checkInTimeInput = document.getElementById('checkInTime');
    const checkOutTimeInput = document.getElementById('checkOutTime');
    
    const guestName = guestNameInput ? guestNameInput.value || '-' : '-';
    const email = emailInput ? emailInput.value || '-' : '-';
    const contact = contactInput ? contactInput.value || '-' : '-';
    const checkInDate = checkInDateInput ? checkInDateInput.value || '-' : '-';
    const checkOutDate = checkOutDateInput ? checkOutDateInput.value || '-' : '-';
    const checkInTime = checkInTimeInput ? checkInTimeInput.value || '-' : '-';
    const checkOutTime = checkOutTimeInput ? checkOutTimeInput.value || '-' : '-';
    
    const summaryGuestName = document.getElementById('summaryGuestName');
    const summaryEmail = document.getElementById('summaryEmail');
    const summaryContact = document.getElementById('summaryContact');
    const summaryCheckIn = document.getElementById('summaryCheckIn');
    const summaryCheckOut = document.getElementById('summaryCheckOut');
    
    if (summaryGuestName) summaryGuestName.textContent = guestName;
    if (summaryEmail) summaryEmail.textContent = email;
    if (summaryContact) summaryContact.textContent = contact;
    
    if (checkInDate !== '-' && summaryCheckIn) {
        try {
            const checkInObj = new Date(checkInDate);
            summaryCheckIn.textContent = checkInObj.toLocaleDateString() + ' ' + checkInTime;
        } catch (e) {
            console.log('   Error formatting check-in date');
        }
    }
    
    if (checkOutDate !== '-' && summaryCheckOut) {
        try {
            const checkOutObj = new Date(checkOutDate);
            summaryCheckOut.textContent = checkOutObj.toLocaleDateString() + ' ' + checkOutTime;
        } catch (e) {
            console.log('   Error formatting check-out date');
        }
    }
    
    if (reservationPageData.bookingData) {
        const summaryRoomType = document.getElementById('summaryRoomType');
        const summaryPrice = document.getElementById('summaryPrice');
        
        if (summaryRoomType) summaryRoomType.textContent = reservationPageData.bookingData.roomName;
        if (summaryPrice) summaryPrice.textContent = 'LKR ' + reservationPageData.bookingData.price;
    }
}

// Navigate between steps
function nextStep(step) {
    console.log('➡️ Moving to step:', step);
    
    // Validate step 1
    if (step === 2) {
        const guestNameInput = document.getElementById('guestName');
        const emailInput = document.getElementById('email');
        const contactInput = document.getElementById('contactNumber');
        
        const guestName = guestNameInput ? guestNameInput.value.trim() : '';
        const email = emailInput ? emailInput.value.trim() : '';
        const contact = contactInput ? contactInput.value.trim() : '';
        
        if (!guestName) {
            alert('❌ Please enter guest name');
            return;
        }
        if (!email) {
            alert('❌ Please enter email address');
            return;
        }
        if (!contact) {
            alert('❌ Please enter contact number');
            return;
        }
    }
    
    const step1 = document.getElementById('step1');
    const step2 = document.getElementById('step2');
    
    if (step1) step1.style.display = step === 1 ? 'block' : 'none';
    if (step2) step2.style.display = step === 2 ? 'block' : 'none';
    
    reservationPageData.currentStep = step;
}

function prevStep(step) {
    console.log('⬅️ Moving to step:', step);
    nextStep(step);
}

// Submit reservation
function submitReservation() {
    console.log('📤 Submitting reservation...');
    
    const guestNameInput = document.getElementById('guestName');
    const emailInput = document.getElementById('email');
    const contactInput = document.getElementById('contactNumber');
    const countrySelect = document.getElementById('country');
    const roomTypeInput = document.getElementById('roomType');
    const guestsSelect = document.getElementById('guests');
    const checkInDateInput = document.getElementById('checkInDate');
    const checkOutDateInput = document.getElementById('checkOutDate');
    const checkInTimeInput = document.getElementById('checkInTime');
    const checkOutTimeInput = document.getElementById('checkOutTime');
    const specialRequestsInput = document.getElementById('specialRequests');
    
    const guestName = guestNameInput ? guestNameInput.value.trim() : '';
    const email = emailInput ? emailInput.value.trim() : '';
    const contactNumber = contactInput ? contactInput.value.trim() : '';
    const country = countrySelect ? countrySelect.value : '';
    const roomType = roomTypeInput ? roomTypeInput.value : '';
    const guests = guestsSelect ? guestsSelect.value : '1';
    const checkInDate = checkInDateInput ? checkInDateInput.value : '';
    const checkOutDate = checkOutDateInput ? checkOutDateInput.value : '';
    const checkInTime = checkInTimeInput ? checkInTimeInput.value : '';
    const checkOutTime = checkOutTimeInput ? checkOutTimeInput.value : '';
    const specialRequests = specialRequestsInput ? specialRequestsInput.value : '';
    
    // Validation
    if (!guestName || !email || !contactNumber || !checkInDate || !checkOutDate) {
        alert('❌ Please fill all required fields');
        return;
    }
    
    const params = new URLSearchParams();
    params.append('guestName', guestName);
    params.append('email', email);
    params.append('contactNumber', contactNumber);
    params.append('country', country);
    params.append('roomType', roomType);
    params.append('guests', guests);
    params.append('checkInDate', checkInDate);
    params.append('checkOutDate', checkOutDate);
    params.append('checkInTime', checkInTime);
    params.append('checkOutTime', checkOutTime);
    params.append('specialRequests', specialRequests);
    
    if (reservationPageData.bookingData) {
        params.append('roomPrice', reservationPageData.bookingData.price);
        params.append('packageCategory', reservationPageData.bookingData.packageCategory);
    }
    
    console.log('📤 Sending data:', Object.fromEntries(params));
    
    fetch('createReservation', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: params.toString()
    })
    .then(response => response.json())
    .then(data => {
        console.log('📥 Response:', data);
        
        if (data.success) {
            alert('✅ Reservation created successfully!\nReservation Number: ' + data.reservationNumber);
            
            // Clear booking data
            sessionStorage.removeItem('bookingData');
            
            // Redirect to home or confirmation page
            if (typeof loadPage === 'function') {
                loadPage('home');
            } else {
                window.location.href = 'index.jsp';
            }
        } else {
            alert('❌ ' + (data.message || 'Failed to create reservation'));
        }
    })
    .catch(error => {
        console.error('❌ Error:', error);
        alert('⚠️ Network error occurred');
    });
}

// Initialize when DOM is ready
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initializeReservationPage);
} else {
    initializeReservationPage();
}

console.log('✅ Reservation page script fully loaded');
</script>
