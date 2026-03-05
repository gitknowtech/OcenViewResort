<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Reservation Section -->
<section class="section active">
    <div class="container">
        <h2 class="section-title">🏨 MAKE A RESERVATION</h2>
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
                        
                        <!-- ROOM SELECTION PANELS -->
                        <div class="form-row full-width">
                            <div class="form-group">
                                <label>Select Room *</label>
                                <div id="roomsContainer" class="rooms-grid">
                                    <div style="text-align: center; padding: 20px; color: #999; grid-column: 1/-1;">
                                        <i class="fas fa-spinner fa-spin"></i> Loading rooms...
                                    </div>
                                </div>
                                <input type="hidden" id="roomId" name="roomId" required>
                                <input type="hidden" id="roomPrice" name="roomPrice">
                                <input type="hidden" id="roomType" name="roomType">
                            </div>
                        </div>

                        <!-- Check-in / Check-out Dates -->
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

                        <!-- Number of Guests -->
                        <div class="form-row">
                            <div class="form-group">
                                <label>Number of Guests *</label>
                                <select id="guests" name="guests" required onchange="calculateTotal()">
                                    <option value="">Select</option>
                                    <option value="1">1 Guest</option>
                                    <option value="2" selected>2 Guests</option>
                                    <option value="3">3 Guests</option>
                                    <option value="4">4 Guests</option>
                                </select>
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
                <h3>📋 Booking Summary</h3>
                <div class="booking-summary" id="bookingSummary">
                    <div class="summary-section">
                        <h4>Room Details</h4>
                        <div class="summary-item">
                            <span>Room #:</span>
                            <span id="summaryRoomNumber">-</span>
                        </div>
                        <div class="summary-item">
                            <span>Room Type:</span>
                            <span id="summaryRoomType">-</span>
                        </div>
                        <div class="summary-item">
                            <span>Capacity:</span>
                            <span id="summaryCapacity">-</span>
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

/* ✅ ROOM PANELS GRID */
.rooms-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(80px, 1fr));
    gap: 12px;
    margin-top: 15px;
    padding: 15px;
    background: #f9fafb;
    border-radius: 8px;
    border: 1px solid #e5e7eb;
}

/* ✅ ROOM PANEL CARD */
.room-panel {
    padding: 15px;
    border-radius: 8px;
    text-align: center;
    cursor: pointer;
    transition: all 0.3s ease;
    border: 2px solid transparent;
    font-weight: 600;
    position: relative;
}

/* 🟢 AVAILABLE ROOM - GREEN */
.room-panel.available {
    background: linear-gradient(135deg, #10b981, #059669);
    color: white;
    box-shadow: 0 4px 12px rgba(16, 185, 129, 0.3);
}

.room-panel.available:hover {
    transform: translateY(-3px);
    box-shadow: 0 6px 16px rgba(16, 185, 129, 0.4);
}

/* 🔴 BOOKED - RED */
.room-panel.booked {
    background: linear-gradient(135deg, #ef4444, #dc2626);
    color: white;
    cursor: not-allowed;
    opacity: 0.7;
}

.room-panel.booked::after {
    content: '🔒';
    position: absolute;
    top: 2px;
    right: 2px;
    font-size: 12px;
}

/* 🔴 MAINTENANCE - RED */
.room-panel.maintenance {
    background: linear-gradient(135deg, #f97316, #ea580c);
    color: white;
    cursor: not-allowed;
    opacity: 0.7;
}

.room-panel.maintenance::after {
    content: '🔧';
    position: absolute;
    top: 2px;
    right: 2px;
    font-size: 12px;
}

/* 🔴 INACTIVE - RED */
.room-panel.inactive {
    background: linear-gradient(135deg, #6b7280, #4b5563);
    color: white;
    cursor: not-allowed;
    opacity: 0.6;
}

.room-panel.inactive::after {
    content: '✕';
    position: absolute;
    top: 2px;
    right: 2px;
    font-size: 14px;
}

/* ✅ SELECTED ROOM */
.room-panel.selected {
    border-color: #007bff;
    box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.3);
    transform: scale(1.05);
}

.room-panel.selected::before {
    content: '✓';
    position: absolute;
    top: -8px;
    left: 50%;
    transform: translateX(-50%);
    background: #007bff;
    color: white;
    width: 20px;
    height: 20px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: bold;
    font-size: 12px;
}

.room-panel-number {
    font-size: 18px;
    margin-bottom: 5px;
}

.room-panel-type {
    font-size: 11px;
    opacity: 0.9;
    margin-bottom: 3px;
}

.room-panel-price {
    font-size: 10px;
    opacity: 0.85;
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
    
    .rooms-grid {
        grid-template-columns: repeat(auto-fill, minmax(70px, 1fr));
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
    
    .rooms-grid {
        grid-template-columns: repeat(auto-fill, minmax(60px, 1fr));
        gap: 8px;
    }
}
</style>

<script>
console.log('🚀 Room Booking Panels - Pure JavaScript');

const RESERVATION_BASE_URL = window.location.origin;
const RESERVATION_CONTEXT_PATH = '/OceanViewResort';

var reservationPageData = {
    allRooms: [],
    selectedRoom: null,
    currentStep: 1,
    initialized: false,
    userId: null
};

// Load rooms
function loadReservationRooms() {
    const url = RESERVATION_BASE_URL + RESERVATION_CONTEXT_PATH + '/rooms?action=getAll';
    console.log('📥 Loading rooms from:', url);
    
    fetch(url)
        .then(r => {
            if (!r.ok) throw new Error('HTTP ' + r.status);
            return r.json();
        })
        .then(data => {
            console.log('✅ Rooms data:', data);
            reservationPageData.allRooms = Array.isArray(data) ? data : [];
            displayReservationRooms();
        })
        .catch(e => {
            console.error('❌ Error:', e);
            alert('❌ Error loading rooms: ' + e.message);
        });
}

// Display rooms as colored panels
function displayReservationRooms() {
    console.log('🎨 Displaying room panels:', reservationPageData.allRooms.length);
    
    const container = document.getElementById('roomsContainer');
    if (!container) return;

    if (!reservationPageData.allRooms || reservationPageData.allRooms.length === 0) {
        container.innerHTML = '<div style="grid-column: 1/-1; text-align: center; padding: 20px; color: #999;">No rooms available</div>';
        return;
    }

    let html = '';
    reservationPageData.allRooms.forEach(room => {
        let panelClass = 'room-panel';
        let isClickable = true;

        // Determine status and color
        if (room.status !== 'active') {
            panelClass += ' inactive';
            isClickable = false;
        } else if (room.booking_status === 'booked') {
            panelClass += ' booked';
            isClickable = false;
        } else if (room.maintenance === 'maintenance') {
            panelClass += ' maintenance';
            isClickable = false;
        } else {
            panelClass += ' available';
        }

        let panelHtml = '<div class="' + panelClass + '"';
        panelHtml += ' data-room-id="' + room.id + '"';
        panelHtml += ' data-room-number="' + room.room_number + '"';
        panelHtml += ' data-room-type="' + room.room_type + '"';
        panelHtml += ' data-room-price="' + room.room_price + '"';
        panelHtml += ' data-room-capacity="' + room.capacity + '"';
        
        if (isClickable) {
            panelHtml += ' onclick="selectReservationRoom(this)"';
        }
        
        panelHtml += '>';
        panelHtml += '<div class="room-panel-number">#' + room.room_number + '</div>';
        panelHtml += '<div class="room-panel-type">' + room.room_type + '</div>';
        panelHtml += '<div class="room-panel-price">LKR ' + room.room_price + '</div>';
        panelHtml += '</div>';
        
        html += panelHtml;
    });
    
    container.innerHTML = html;
}

// Select room
function selectReservationRoom(panel) {
    console.log('✅ Room selected');

    const roomId = panel.dataset.roomId;
    const roomNumber = panel.dataset.roomNumber;
    const roomType = panel.dataset.roomType;
    const roomPrice = panel.dataset.roomPrice;
    const capacity = panel.dataset.roomCapacity;

    reservationPageData.selectedRoom = { roomId, roomNumber, roomType, roomPrice, capacity };

    document.getElementById('roomId').value = roomId;
    document.getElementById('roomPrice').value = roomPrice;
    document.getElementById('roomType').value = roomType;

    document.querySelectorAll('.room-panel').forEach(p => {
        p.classList.remove('selected');
    });
    panel.classList.add('selected');

    updateReservationSummary();
    calculateReservationTotal();
}

// Initialize
function initializeReservationPage() {
    console.log('📄 Initializing reservation page...');
    
    if (reservationPageData.initialized) return;
    
    try {
        const today = new Date();
        const tomorrow = new Date(today);
        tomorrow.setDate(tomorrow.getDate() + 1);
        
        const checkInDateInput = document.getElementById('checkInDate');
        const checkOutDateInput = document.getElementById('checkOutDate');
        
        if (checkInDateInput && checkOutDateInput) {
            checkInDateInput.valueAsDate = today;
            checkOutDateInput.valueAsDate = tomorrow;
        }
        
        loadReservationRooms();
        checkReservationLoggedInUser();
        attachReservationEventListeners();
        updateReservationSummary();
        calculateReservationTotal();
        
        reservationPageData.initialized = true;
        console.log('✅ Reservation page initialized');
        
    } catch (error) {
        console.error('❌ Error:', error);
    }
}

// Check logged in user
function checkReservationLoggedInUser() {
    if (typeof currentUser !== 'undefined' && currentUser) {
        const firstName = currentUser.firstName || '';
        const lastName = currentUser.lastName || '';
        const fullName = (firstName + ' ' + lastName).trim() || currentUser.username || currentUser.email.split('@')[0];
        
        const guestNameInput = document.getElementById('guestName');
        const emailInput = document.getElementById('email');
        const contactInput = document.getElementById('contactNumber');
        
        if (guestNameInput && fullName) guestNameInput.value = fullName;
        if (emailInput && currentUser.email) emailInput.value = currentUser.email;
        if (contactInput && currentUser.phone) contactInput.value = currentUser.phone;
        
        reservationPageData.userId = currentUser.id;
    }
}

// Attach event listeners
function attachReservationEventListeners() {
    const reservationForm = document.getElementById('reservationForm');
    if (reservationForm) {
        reservationForm.addEventListener('submit', function(e) {
            e.preventDefault();
            submitReservation();
        });
    }
    
    const inputs = [
        document.getElementById('guestName'),
        document.getElementById('email'),
        document.getElementById('contactNumber')
    ];
    
    inputs.forEach(input => {
        if (input) {
            input.addEventListener('change', updateReservationSummary);
            input.addEventListener('input', updateReservationSummary);
        }
    });
    
    const dateInputs = [
        document.getElementById('checkInDate'),
        document.getElementById('checkOutDate')
    ];
    
    dateInputs.forEach(input => {
        if (input) {
            input.addEventListener('change', calculateReservationTotal);
        }
    });
}

// Calculate total
function calculateReservationTotal() {
    const checkInDateInput = document.getElementById('checkInDate');
    const checkOutDateInput = document.getElementById('checkOutDate');
    const roomPriceInput = document.getElementById('roomPrice');
    
    if (!checkInDateInput || !checkOutDateInput || !roomPriceInput) return;
    
    const checkInDate = new Date(checkInDateInput.value);
    const checkOutDate = new Date(checkOutDateInput.value);
    const price = parseFloat(roomPriceInput.value) || 0;
    
    if (checkInDate && checkOutDate && checkInDate < checkOutDate && price > 0) {
        const nights = Math.ceil((checkOutDate - checkInDate) / (1000 * 60 * 60 * 24));
        const total = price * nights;
        
        const summaryNights = document.getElementById('summaryNights');
        const summaryTotal = document.getElementById('summaryTotal');
        
        if (summaryNights) {
            summaryNights.textContent = nights + ' night' + (nights > 1 ? 's' : '');
        }
        if (summaryTotal) {
            summaryTotal.textContent = 'LKR ' + total.toLocaleString();
        }
    }
    
    updateReservationSummary();
}

// Update summary
function updateReservationSummary() {
    const guestNameInput = document.getElementById('guestName');
    const emailInput = document.getElementById('email');
    const contactInput = document.getElementById('contactNumber');
    const checkInDateInput = document.getElementById('checkInDate');
    const checkOutDateInput = document.getElementById('checkOutDate');
    const checkInTimeInput = document.getElementById('checkInTime');
    const checkOutTimeInput = document.getElementById('checkOutTime');
    
    document.getElementById('summaryGuestName').textContent = guestNameInput ? guestNameInput.value || '-' : '-';
    document.getElementById('summaryEmail').textContent = emailInput ? emailInput.value || '-' : '-';
    document.getElementById('summaryContact').textContent = contactInput ? contactInput.value || '-' : '-';
    
    if (checkInDateInput && checkInDateInput.value) {
        const checkInObj = new Date(checkInDateInput.value);
        const checkInTime = checkInTimeInput ? checkInTimeInput.value || '' : '';
        document.getElementById('summaryCheckIn').textContent = checkInObj.toLocaleDateString() + ' ' + checkInTime;
    }
    
    if (checkOutDateInput && checkOutDateInput.value) {
        const checkOutObj = new Date(checkOutDateInput.value);
        const checkOutTime = checkOutTimeInput ? checkOutTimeInput.value || '' : '';
        document.getElementById('summaryCheckOut').textContent = checkOutObj.toLocaleDateString() + ' ' + checkOutTime;
    }
    
    if (reservationPageData.selectedRoom) {
        document.getElementById('summaryRoomNumber').textContent = '#' + reservationPageData.selectedRoom.roomNumber;
        document.getElementById('summaryRoomType').textContent = reservationPageData.selectedRoom.roomType;
        document.getElementById('summaryCapacity').textContent = reservationPageData.selectedRoom.capacity + ' Guests';
        document.getElementById('summaryPrice').textContent = 'LKR ' + reservationPageData.selectedRoom.roomPrice.toLocaleString();
    }
}

// Navigate steps
function nextStep(step) {
    if (step === 2) {
        const guestName = document.getElementById('guestName').value.trim();
        const email = document.getElementById('email').value.trim();
        const contact = document.getElementById('contactNumber').value.trim();
        
        if (!guestName || !email || !contact) {
            alert('❌ Please fill all required fields');
            return;
        }
    }
    
    document.getElementById('step1').style.display = step === 1 ? 'block' : 'none';
    document.getElementById('step2').style.display = step === 2 ? 'block' : 'none';
    
    reservationPageData.currentStep = step;
}

function prevStep(step) {
    nextStep(step);
}

// Submit reservation
function submitReservation() {
    console.log('📤 Submitting reservation...');
    
    const guestName = document.getElementById('guestName').value.trim();
    const email = document.getElementById('email').value.trim();
    const contactNumber = document.getElementById('contactNumber').value.trim();
    const roomId = document.getElementById('roomId').value;
    const checkInDate = document.getElementById('checkInDate').value;
    const checkOutDate = document.getElementById('checkOutDate').value;
    const checkInTime = document.getElementById('checkInTime').value;
    const checkOutTime = document.getElementById('checkOutTime').value;
    const guests = document.getElementById('guests').value;
    const specialRequests = document.getElementById('specialRequests').value;
    
    if (!guestName || !email || !contactNumber || !roomId || !checkInDate || !checkOutDate || !guests) {
        alert('❌ Please fill all required fields and select a room');
        return;
    }
    
    const params = new URLSearchParams();
    params.append('guestName', guestName);
    params.append('email', email);
    params.append('contactNumber', contactNumber);
    params.append('roomId', roomId);
    params.append('checkInDate', checkInDate);
    params.append('checkOutDate', checkOutDate);
    params.append('checkInTime', checkInTime);
    params.append('checkOutTime', checkOutTime);
    params.append('guests', guests);
    params.append('specialRequests', specialRequests);
    
    const url = RESERVATION_BASE_URL + RESERVATION_CONTEXT_PATH + '/createReservation';
    fetch(url, { 
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: params.toString()
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) {
            alert('✅ Reservation created!\nReservation #: ' + data.reservationNumber);
            if (typeof loadPage === 'function') {
                loadPage('home');
            } else {
                window.location.href = 'index.jsp';
            }
        } else {
            alert('❌ ' + (data.message || 'Failed'));
        }
    })
    .catch(e => {
        console.error('❌ Error:', e);
        alert('⚠️ Network error');
    });
}

// Initialize
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initializeReservationPage);
} else {
    initializeReservationPage();
}

console.log('✅ Room Booking Panels Ready');
</script>
