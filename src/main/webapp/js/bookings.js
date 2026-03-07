console.log('🚀 Bookings.js - Room Booking System Loaded');

// ✅ GLOBAL BOOKING STATE
let bookingState = {
    selectedRoom: null,
    allRooms: [],
    currentUser: null,
    initialized: false
};

// ========== INITIALIZE BOOKING PAGE ==========
function initializeBookingPage() {
    console.log('📄 Initializing booking page...');
    console.log('🔍 Searching for user in global scope...');
    
    // ✅ TRY TO GET USER FROM MULTIPLE SOURCES
    let user = null;
    
    // Try 1: window.currentUser (from main.js)
    if (typeof window.currentUser !== 'undefined' && window.currentUser) {
        user = window.currentUser;
        console.log('✅ Found window.currentUser:', user);
    }
    // Try 2: window.currentNavbarUser (from index.jsp)
    else if (typeof window.currentNavbarUser !== 'undefined' && window.currentNavbarUser) {
        user = window.currentNavbarUser;
        console.log('✅ Found window.currentNavbarUser:', user);
    }
    // Try 3: Check session via fetch
    else {
        console.log('⚠️ No user in window scope, fetching from server...');
        fetch('checkUser')
            .then(r => r.json())
            .then(data => {
                if (data.loggedIn && data.user) {
                    window.currentUser = data.user;
                    bookingState.currentUser = data.user;
                    console.log('✅ User fetched from server:', data.user);
                    proceedWithBooking();
                } else {
                    showUserNotLoggedIn();
                }
            })
            .catch(e => {
                console.error('❌ Error fetching user:', e);
                showUserNotLoggedIn();
            });
        return;
    }
    
    // If user found, proceed
    if (user && user.id) {
        bookingState.currentUser = user;
        proceedWithBooking();
    } else {
        showUserNotLoggedIn();
    }
}

// ========== PROCEED WITH BOOKING ==========
function proceedWithBooking() {
    console.log('✅ User authenticated, proceeding with booking...');
    console.log('👤 User data:', bookingState.currentUser);
    
    // Set default dates
    setDefaultDates();
    
    // Load rooms
    loadAllRooms();
    
    // Attach event listeners
    attachAllEventListeners();
    
    bookingState.initialized = true;
    console.log('✅ Booking page fully initialized');
}

// ========== SHOW USER NOT LOGGED IN ==========
function showUserNotLoggedIn() {
    console.error('❌ NO USER FOUND - User must be logged in');
    showMessage('❌ Please login first to make a booking', 'error');
    setTimeout(() => {
        if (typeof loadPage === 'function') {
            loadPage('login/login');
        } else {
            window.location.href = 'index.jsp';
        }
    }, 1500);
}

// ========== SET DEFAULT DATES ==========
function setDefaultDates() {
    const today = new Date();
    const tomorrow = new Date(today);
    tomorrow.setDate(tomorrow.getDate() + 1);

    const checkInInput = document.getElementById('checkInDate');
    const checkOutInput = document.getElementById('checkOutDate');

    if (checkInInput) {
        checkInInput.valueAsDate = today;
    }
    if (checkOutInput) {
        checkOutInput.valueAsDate = tomorrow;
    }
    
    console.log('📅 Default dates set');
}

// ========== LOAD ALL ROOMS ==========
function loadAllRooms() {
    console.log('📥 Loading all rooms...');
    
    const baseUrl = window.location.origin;
    const contextPath = '/OceanViewResort';
    const url = baseUrl + contextPath + '/rooms?action=getAll';
    
    console.log('🔗 Fetching from:', url);
    
    fetch(url)
        .then(response => {
            console.log('📊 Response status:', response.status);
            if (!response.ok) {
                throw new Error('HTTP Error: ' + response.status);
            }
            return response.json();
        })
        .then(rooms => {
            console.log('✅ Rooms received:', rooms);
            console.log('📊 Total rooms:', rooms.length);
            
            if (Array.isArray(rooms) && rooms.length > 0) {
                bookingState.allRooms = rooms;
                displayAllRooms(rooms);
            } else {
                showNoRoomsMessage();
            }
        })
        .catch(error => {
            console.error('❌ Error loading rooms:', error);
            showErrorMessage('Failed to load rooms: ' + error.message);
        });
}

// ========== DISPLAY ALL ROOMS ==========
function displayAllRooms(rooms) {
    console.log('🎨 Displaying rooms...');
    
    const container = document.getElementById('roomsContainer');
    
    if (!container) {
        console.error('❌ roomsContainer element not found!');
        return;
    }
    
    // Clear loading message
    container.innerHTML = '';
    
    // Create room panels
    rooms.forEach((room, index) => {
        const panel = createRoomPanel(room);
        container.appendChild(panel);
    });
    
    console.log(`✅ Displayed ${rooms.length} rooms`);
}

// ========== CREATE ROOM PANEL ==========
function createRoomPanel(room) {
    const panel = document.createElement('div');
    panel.className = 'room-panel';
    
    // ✅ ONLY GREEN FOR AVAILABLE ROOMS
    let statusClass = 'unavailable';
    let isClickable = false;
    
    // Check if room is available (ONLY GREEN)
    if (room.status === 'active' && room.booking_status !== 'booked' && room.maintenance !== 'maintenance') {
        statusClass = 'available';
        isClickable = true;
    }
    
    panel.classList.add(statusClass);
    
    // Set data attributes
    panel.dataset.roomId = room.id;
    panel.dataset.roomNumber = room.room_number;
    panel.dataset.roomType = room.room_type;
    panel.dataset.roomPrice = room.room_price;
    panel.dataset.roomCapacity = room.capacity;
    
    // Set content
    panel.innerHTML = `
        <div class="room-panel-number">#${room.room_number}</div>
        <div class="room-panel-type">${room.room_type}</div>
        <div class="room-panel-price">LKR ${room.room_price}</div>
    `;
    
    // Add click handler ONLY if clickable
    if (isClickable) {
        panel.style.cursor = 'pointer';
        panel.addEventListener('click', function() {
            selectRoom(this);
        });
    } else {
        panel.style.cursor = 'not-allowed';
    }
    
    return panel;
}

// ========== SELECT ROOM ==========
function selectRoom(panel) {
    console.log('✅ Room selected:', panel.dataset.roomNumber);
    
    // Remove selected class from all panels
    document.querySelectorAll('.room-panel').forEach(p => {
        p.classList.remove('selected');
    });
    
    // Add selected class to clicked panel
    panel.classList.add('selected');
    
    // Store selected room
    bookingState.selectedRoom = {
        id: panel.dataset.roomId,
        number: panel.dataset.roomNumber,
        type: panel.dataset.roomType,
        price: panel.dataset.roomPrice,
        capacity: panel.dataset.roomCapacity
    };
    
    // Update form with room details
    updateRoomDetails(panel);
    
    // Update summary
    updateSummary();
    
    // Show success message
    showMessage('✅ Room #' + panel.dataset.roomNumber + ' selected!', 'success');
}

// ========== UPDATE ROOM DETAILS ==========
function updateRoomDetails(panel) {
    console.log('📝 Updating room details...');
    
    const roomNumber = panel.dataset.roomNumber;
    const roomType = panel.dataset.roomType;
    const roomPrice = panel.dataset.roomPrice;
    const roomCapacity = panel.dataset.roomCapacity;
    
    document.getElementById('selectedRoomNumber').textContent = '#' + roomNumber;
    document.getElementById('selectedRoomType').textContent = roomType;
    document.getElementById('selectedRoomPrice').textContent = 'LKR ' + roomPrice;
    document.getElementById('selectedRoomCapacity').textContent = roomCapacity + ' Guests';
    
    console.log('✅ Room details updated');
}

// ========== UPDATE SUMMARY ==========
function updateSummary() {
    console.log('💰 Updating summary...');
    
    const checkInDate = document.getElementById('checkInDate').value;
    const checkOutDate = document.getElementById('checkOutDate').value;
    const pricePerNight = document.getElementById('selectedRoomPrice').textContent;
    
    if (!checkInDate || !checkOutDate) {
        console.log('⚠️ Dates not set');
        return;
    }
    
    const checkIn = new Date(checkInDate);
    const checkOut = new Date(checkOutDate);
    const nights = Math.ceil((checkOut - checkIn) / (1000 * 60 * 60 * 24));
    
    if (nights <= 0) {
        console.log('⚠️ Invalid date range');
        return;
    }
    
    // Extract price number
    const price = parseInt(pricePerNight.replace('LKR ', '').replace(/,/g, '')) || 0;
    const total = nights * price;
    
    document.getElementById('summaryNights').textContent = nights;
    document.getElementById('summaryPricePerNight').textContent = 'LKR ' + price.toLocaleString();
    document.getElementById('summaryTotal').textContent = 'LKR ' + total.toLocaleString();
    
    console.log('✅ Summary updated:', { nights, price, total });
}

// ========== ATTACH ALL EVENT LISTENERS ==========
function attachAllEventListeners() {
    console.log('🔗 Attaching event listeners...');
    
    // Date change listeners
    const checkInInput = document.getElementById('checkInDate');
    const checkOutInput = document.getElementById('checkOutDate');
    
    if (checkInInput) {
        checkInInput.addEventListener('change', updateSummary);
    }
    if (checkOutInput) {
        checkOutInput.addEventListener('change', updateSummary);
    }
    
    // Form submission
    const bookingForm = document.getElementById('bookingForm');
    if (bookingForm) {
        bookingForm.addEventListener('submit', submitBooking);
    }
    
    console.log('✅ Event listeners attached');
}

// ========== SUBMIT BOOKING ==========
function submitBooking(e) {
    e.preventDefault();
    console.log('📤 Submitting booking...');
    console.log('👤 Current user:', bookingState.currentUser);
    
    // ✅ VALIDATE USER
    if (!bookingState.currentUser || !bookingState.currentUser.id) {
        console.error('❌ USER VALIDATION FAILED');
        showMessage('❌ User not found. Please login again.', 'error');
        setTimeout(() => {
            if (typeof loadPage === 'function') {
                loadPage('login/login');
            }
        }, 1500);
        return;
    }
    
    console.log('✅ USER VALIDATION PASSED');
    console.log('   - ID: ' + bookingState.currentUser.id);
    console.log('   - Username: ' + bookingState.currentUser.username);
    console.log('   - Email: ' + bookingState.currentUser.email);
    
    // Get selected room
    const selectedPanel = document.querySelector('.room-panel.selected');
    if (!selectedPanel) {
        showMessage('❌ Please select a room', 'error');
        return;
    }
    
    // Get form values
    const checkInDate = document.getElementById('checkInDate').value;
    const checkOutDate = document.getElementById('checkOutDate').value;
    const checkInTime = document.getElementById('checkInTime').value;
    const checkOutTime = document.getElementById('checkOutTime').value;
    const numberOfGuests = document.getElementById('numberOfGuests').value;
    const specialRequests = document.getElementById('specialRequests').value;
    
    // Validate
    if (!checkInDate || !checkOutDate || !numberOfGuests) {
        showMessage('❌ Please fill all required fields', 'error');
        return;
    }
    
    // Validate guest count
    const guestCount = parseInt(numberOfGuests);
    if (guestCount < 1 || guestCount > 10) {
        showMessage('❌ Guest count must be between 1 and 10', 'error');
        return;
    }
    
    // Disable button
    const bookBtn = document.getElementById('bookBtn');
    bookBtn.disabled = true;
    bookBtn.textContent = '⏳ Processing...';
    
    // ✅ PREPARE DATA WITH USER ID
    const params = new URLSearchParams();
    
    // ✅ USER DATA - ONLY user_id, username, email
    console.log('📝 Adding user data to params...');
    params.append('userId', String(bookingState.currentUser.id));
    params.append('username', String(bookingState.currentUser.username));
    params.append('email', String(bookingState.currentUser.email));
    
    // Room data
    console.log('📝 Adding room data to params...');
    params.append('roomId', String(selectedPanel.dataset.roomId));
    params.append('roomNumber', String(selectedPanel.dataset.roomNumber));
    params.append('roomType', String(selectedPanel.dataset.roomType));
    params.append('pricePerNight', String(selectedPanel.dataset.roomPrice));
    
    // Booking dates
    console.log('📝 Adding booking dates to params...');
    params.append('checkInDate', checkInDate);
    params.append('checkOutDate', checkOutDate);
    params.append('checkInTime', checkInTime);
    params.append('checkOutTime', checkOutTime);
    
    // Guest info
    console.log('📝 Adding guest info to params...');
    params.append('numberOfGuests', String(numberOfGuests));
    params.append('specialRequests', specialRequests);
    
    // Calculate total (nights calculation)
    const checkIn = new Date(checkInDate);
    const checkOut = new Date(checkOutDate);
    const nights = Math.ceil((checkOut - checkIn) / (1000 * 60 * 60 * 24));
    const totalPrice = nights * parseInt(selectedPanel.dataset.roomPrice);
    
    console.log('📋 FINAL BOOKING DATA:');
    console.log('   userId: ' + bookingState.currentUser.id);
    console.log('   username: ' + bookingState.currentUser.username);
    console.log('   email: ' + bookingState.currentUser.email);
    console.log('   roomId: ' + selectedPanel.dataset.roomId);
    console.log('   checkInDate: ' + checkInDate);
    console.log('   checkOutDate: ' + checkOutDate);
    console.log('   numberOfGuests: ' + numberOfGuests);
    console.log('   nights: ' + nights);
    console.log('   totalPrice: ' + totalPrice);
    
    // Submit
    const baseUrl = window.location.origin;
    const contextPath = '/OceanViewResort';
    const url = baseUrl + contextPath + '/bookRoom';
    
    console.log('🔗 Submitting to:', url);
    console.log('📤 Params:', params.toString());
    
    fetch(url, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: params.toString()
    })
    .then(response => {
        console.log('📊 Response status:', response.status);
        return response.text();
    })
    .then(text => {
        console.log('📥 Raw response:', text);
        
        try {
            const data = JSON.parse(text);
            console.log('✅ Parsed response:', data);
            
            if (data.success) {
                console.log('🎉 BOOKING SUCCESSFUL!');
                
                // ✅ SHOW SUCCESS MESSAGE WITH EMAIL CONFIRMATION
                showBookingSuccessModal(
                    data.bookingId,
                    data.totalPrice,
                    data.nights,
                    bookingState.currentUser.email,
                    selectedPanel.dataset.roomNumber,
                    selectedPanel.dataset.roomType
                );
                
                // Reset
                document.getElementById('bookingForm').reset();
                bookingState.selectedRoom = null;
                document.querySelectorAll('.room-panel').forEach(p => p.classList.remove('selected'));
                
                // Reload
                loadAllRooms();
                
                // Redirect after delay
                setTimeout(() => {
                    if (typeof loadPage === 'function') {
                        loadPage('booking-view');
                    }
                }, 4000);
            } else {
                console.error('❌ Booking failed:', data.message);
                showMessage('❌ Booking Failed: ' + (data.message || 'Unknown error'), 'error');
                bookBtn.disabled = false;
                bookBtn.textContent = '✓ CONFIRM BOOKING';
            }
        } catch (parseError) {
            console.error('❌ JSON Parse Error:', parseError);
            console.error('Response was:', text);
            showMessage('⚠️ Server error: Invalid response format', 'error');
            bookBtn.disabled = false;
            bookBtn.textContent = '✓ CONFIRM BOOKING';
        }
    })
    .catch(error => {
        console.error('❌ Network Error:', error);
        showMessage('⚠️ Network error: ' + error.message, 'error');
        bookBtn.disabled = false;
        bookBtn.textContent = '✓ CONFIRM BOOKING';
    });
}

// ========== SHOW BOOKING SUCCESS MODAL ==========
function showBookingSuccessModal(bookingId, totalPrice, nights, email, roomNumber, roomType) {
    console.log('🎉 Showing success modal...');
    
    // Create modal HTML
    const modalHTML = `
        <div id="bookingSuccessModal" class="booking-modal-overlay">
            <div class="booking-modal-content">
                <!-- Header -->
                <div class="booking-modal-header">
                    <div class="booking-modal-icon">
                        <i class="fas fa-check-circle"></i>
                    </div>
                    <h2>🎉 Booking Confirmed!</h2>
                </div>
                
                <!-- Body -->
                <div class="booking-modal-body">
                    <div class="booking-info-section">
                        <h3>Booking Details</h3>
                        <div class="booking-info-row">
                            <span class="booking-info-label">Booking ID:</span>
                            <span class="booking-info-value">#${bookingId}</span>
                        </div>
                        <div class="booking-info-row">
                            <span class="booking-info-label">Room:</span>
                            <span class="booking-info-value">#${roomNumber} - ${roomType}</span>
                        </div>
                        <div class="booking-info-row">
                            <span class="booking-info-label">Number of Nights:</span>
                            <span class="booking-info-value">${nights}</span>
                        </div>
                        <div class="booking-info-row total">
                            <span class="booking-info-label">Total Amount:</span>
                            <span class="booking-info-value">LKR ${totalPrice.toLocaleString()}</span>
                        </div>
                    </div>
                    
                    <div class="booking-email-section">
                        <div class="booking-email-icon">
                            <i class="fas fa-envelope"></i>
                        </div>
                        <p class="booking-email-text">
                            A confirmation email with your bill has been sent to:<br>
                            <strong>${email}</strong>
                        </p>
                    </div>
                    
                    <div class="booking-message-section">
                        <p>✅ Your booking is confirmed and saved in our system.</p>
                        <p>📧 Check your email for the complete booking details and bill.</p>
                        <p>📞 If you have any questions, contact us at +94 77 123 4567</p>
                    </div>
                </div>
                
                <!-- Footer -->
                <div class="booking-modal-footer">
                    <button class="booking-modal-btn primary" onclick="closeBookingModal(); loadPage('booking-view');">
                        <i class="fas fa-calendar-alt"></i> View My Bookings
                    </button>
                    <button class="booking-modal-btn secondary" onclick="closeBookingModal(); loadPage('home');">
                        <i class="fas fa-home"></i> Back to Home
                    </button>
                </div>
            </div>
        </div>
    `;
    
    // Add modal to page
    document.body.insertAdjacentHTML('beforeend', modalHTML);
    
    // Show modal with animation
    const modal = document.getElementById('bookingSuccessModal');
    setTimeout(() => {
        modal.classList.add('show');
    }, 100);
}

// ========== CLOSE BOOKING MODAL ==========
function closeBookingModal() {
    const modal = document.getElementById('bookingSuccessModal');
    if (modal) {
        modal.classList.remove('show');
        setTimeout(() => {
            modal.remove();
        }, 300);
    }
}

// ========== ERROR MESSAGES ==========
function showErrorMessage(message) {
    const container = document.getElementById('roomsContainer');
    if (container) {
        container.innerHTML = `<div style="grid-column: 1/-1; text-align: center; padding: 20px; color: #ef4444; font-weight: bold;">❌ ${message}</div>`;
    }
}

function showNoRoomsMessage() {
    const container = document.getElementById('roomsContainer');
    if (container) {
        container.innerHTML = `<div style="grid-column: 1/-1; text-align: center; padding: 20px; color: #999;">No rooms available</div>`;
    }
}

// ========== SHOW MESSAGE FUNCTION ==========
function showMessage(text, type = 'info') {
    console.log(`📢 ${type.toUpperCase()}: ${text}`);
    
    const bgColor = type === 'success' ? '#10b981' : 
                   type === 'error' ? '#ef4444' : 
                   type === 'warning' ? '#f59e0b' : '#3b82f6';
    
    const msg = document.createElement('div');
    msg.style.cssText = `
        position: fixed;
        top: 100px;
        right: 20px;
        z-index: 9998;
        padding: 15px 20px;
        border-radius: 8px;
        color: white;
        font-weight: bold;
        background: ${bgColor};
        box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        min-width: 250px;
        animation: slideIn 0.3s ease-out;
    `;
    msg.innerHTML = text;
    document.body.appendChild(msg);
    
    setTimeout(() => {
        msg.style.animation = 'slideOut 0.3s ease-in';
        setTimeout(() => {
            msg.remove();
        }, 300);
    }, 4000);
}

// ========== AUTO INITIALIZE ==========
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initializeBookingPage);
} else {
    initializeBookingPage();
}

console.log('✅ Bookings.js Ready');
