console.log('🚀 Booking View JS Loaded');

// Global state
let bookingViewState = {
    allBookings: [],
    filteredBookings: [],
    currentUser: null,
    currentFilter: 'all',
    initialized: false
};

// ========== INITIALIZE BOOKING VIEW ==========
function initializeBookingView() {
    console.log('📄 Initializing booking view...');
    
    // Get current user
    let user = null;
    if (typeof window.currentUser !== 'undefined' && window.currentUser) {
        user = window.currentUser;
    } else if (typeof window.currentNavbarUser !== 'undefined' && window.currentNavbarUser) {
        user = window.currentNavbarUser;
    }
    
    if (!user || !user.id) {
        console.error('❌ NO USER FOUND');
        alert('❌ Please login first to view your bookings');
        if (typeof loadPage === 'function') {
            loadPage('login/login');
        }
        return;
    }
    
    bookingViewState.currentUser = user;
    console.log('✅ User authenticated:', user);
    
    // Load bookings
    loadUserBookings();
    
    // Attach event listeners
    attachFilterListeners();
    
    bookingViewState.initialized = true;
}

// ========== LOAD USER BOOKINGS ==========
function loadUserBookings() {
    console.log('📥 Loading user bookings...');
    
    const userId = bookingViewState.currentUser.id;
    const baseUrl = window.location.origin;
    const contextPath = '/OceanViewResort';
    const url = baseUrl + contextPath + '/getBookings?userId=' + userId;
    
    console.log('🔗 Fetching from:', url);
    
    showLoadingMessage();
    
    fetch(url)
        .then(response => {
            console.log('📊 Response status:', response.status);
            if (!response.ok) {
                throw new Error('HTTP Error: ' + response.status);
            }
            return response.json();
        })
        .then(bookings => {
            console.log('✅ Bookings received:', bookings);
            
            if (Array.isArray(bookings) && bookings.length > 0) {
                bookingViewState.allBookings = bookings;
                filterBookings('all');
                displayBookings(bookingViewState.filteredBookings);
            } else {
                showEmptyState();
            }
        })
        .catch(error => {
            console.error('❌ Error loading bookings:', error);
            showErrorMessage('Failed to load bookings: ' + error.message);
        });
}

// ========== FILTER BOOKINGS ==========
function filterBookings(status) {
    console.log('🔍 Filtering bookings by status:', status);
    
    bookingViewState.currentFilter = status;
    
    if (status === 'all') {
        bookingViewState.filteredBookings = bookingViewState.allBookings;
    } else {
        bookingViewState.filteredBookings = bookingViewState.allBookings.filter(booking => 
            booking.bookingStatus === status
        );
    }
    
    console.log('📊 Filtered bookings count:', bookingViewState.filteredBookings.length);
    
    if (bookingViewState.filteredBookings.length === 0) {
        showEmptyState();
    } else {
        displayBookings(bookingViewState.filteredBookings);
    }
}

// ========== DISPLAY BOOKINGS ==========
function displayBookings(bookings) {
    console.log('🎨 Displaying bookings...');
    
    const container = document.getElementById('bookingsContainer');
    const emptyState = document.getElementById('emptyState');
    
    if (!container) {
        console.error('❌ bookingsContainer not found');
        return;
    }
    
    // Clear container
    container.innerHTML = '';
    emptyState.style.display = 'none';
    
    // Create booking cards
    bookings.forEach((booking, index) => {
        const card = createBookingCard(booking);
        container.appendChild(card);
    });
    
    console.log(`✅ Displayed ${bookings.length} bookings`);
}

// ========== CREATE BOOKING CARD ==========
function createBookingCard(booking) {
    const card = document.createElement('div');
    card.className = 'booking-card ' + booking.bookingStatus;
    
    // Format dates
    const checkInDate = new Date(booking.checkInDate);
    const checkOutDate = new Date(booking.checkOutDate);
    const formattedCheckIn = checkInDate.toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' });
    const formattedCheckOut = checkOutDate.toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' });
    
    // Determine if booking can be cancelled
    const canCancel = booking.bookingStatus === 'confirmed' || booking.bookingStatus === 'pending';
    const isInPast = checkOutDate < new Date();
    const canCancelBooking = canCancel && !isInPast;
    
    // Build HTML
    let html = `
        <div class="booking-info">
            <div class="booking-header">
                <div>
                    <div class="booking-id">Booking #${booking.id}</div>
                    <span class="booking-status ${booking.bookingStatus}">${booking.bookingStatus.toUpperCase()}</span>
                </div>
            </div>
            
            <div class="booking-details">
                <div class="booking-detail">
                    <div class="booking-detail-label">Room</div>
                    <div class="booking-detail-value room-number">#${booking.roomNumber}</div>
                </div>
                <div class="booking-detail">
                    <div class="booking-detail-label">Room Type</div>
                    <div class="booking-detail-value">${booking.roomType}</div>
                </div>
                <div class="booking-detail">
                    <div class="booking-detail-label">Guests</div>
                    <div class="booking-detail-value">${booking.numberOfGuests} ${booking.numberOfGuests === 1 ? 'Guest' : 'Guests'}</div>
                </div>
                <div class="booking-detail">
                    <div class="booking-detail-label">Nights</div>
                    <div class="booking-detail-value highlight">${booking.nights} ${booking.nights === 1 ? 'Night' : 'Nights'}</div>
                </div>
            </div>
            
            <div class="booking-dates">
                <div class="booking-date">
                    <div class="booking-date-label">Check-in</div>
                    <div class="booking-date-value">${formattedCheckIn}</div>
                    <div class="booking-date-time">${booking.checkInTime}</div>
                </div>
                <div class="booking-date-arrow">→</div>
                <div class="booking-date">
                    <div class="booking-date-label">Check-out</div>
                    <div class="booking-date-value">${formattedCheckOut}</div>
                    <div class="booking-date-time">${booking.checkOutTime}</div>
                </div>
            </div>
            
            <div class="booking-summary">
                <div class="booking-summary-row">
                    <span class="booking-summary-row-label">Price per Night:</span>
                    <span class="booking-summary-row-value">LKR ${booking.pricePerNight.toLocaleString()}</span>
                </div>
                <div class="booking-summary-row">
                    <span class="booking-summary-row-label">Subtotal (${booking.nights} nights):</span>
                    <span class="booking-summary-row-value">LKR ${(booking.pricePerNight * booking.nights).toLocaleString()}</span>
                </div>
                <div class="booking-summary-row booking-summary-total">
                    <span>Total Amount:</span>
                    <span>LKR ${booking.totalPrice.toLocaleString()}</span>
                </div>
            </div>
    `;
    
    // Add special requests if available
    if (booking.specialRequests && booking.specialRequests.trim() !== '') {
        html += `
            <div class="booking-special-requests">
                <div class="booking-special-requests-label">📝 Special Requests:</div>
                ${booking.specialRequests}
            </div>
        `;
    }
    
    html += `
        </div>
        
        <div class="booking-actions">
            <button class="booking-action-btn view" onclick="openBookingDetailsModal(${booking.id})">
                <i class="fas fa-eye"></i> View Details
            </button>
    `;
    
    // Add print bill button for confirmed bookings
    if (booking.bookingStatus === 'confirmed') {
        html += `
            <button class="booking-action-btn print" onclick="printBookingBill(${booking.id})">
                <i class="fas fa-print"></i> Print Bill
            </button>
        `;
    }
    
    // Add cancel button only if booking can be cancelled
    if (canCancelBooking) {
        html += `
            <button class="booking-action-btn cancel" onclick="cancelBooking(${booking.id}, '${booking.roomNumber}')">
                <i class="fas fa-times-circle"></i> Cancel
            </button>
        `;
    }
    
    html += `
        </div>
    `;
    
    card.innerHTML = html;
    return card;
}

// ========== OPEN BOOKING DETAILS MODAL ==========
function openBookingDetailsModal(bookingId) {
    console.log('👁️ Opening booking details modal for ID:', bookingId);
    
    const booking = bookingViewState.allBookings.find(b => b.id === bookingId);
    
    if (!booking) {
        console.error('❌ Booking not found:', bookingId);
        return;
    }
    
    console.log('📋 Booking details:', booking);
    
    const modal = document.getElementById('bookingDetailsModal');
    const modalContent = document.getElementById('bookingDetailsContent');
    
    if (!modal || !modalContent) {
        console.error('❌ Modal elements not found');
        return;
    }
    
    // Format dates
    const checkInDate = new Date(booking.checkInDate);
    const checkOutDate = new Date(booking.checkOutDate);
    const formattedCheckIn = checkInDate.toLocaleDateString('en-US', { weekday: 'long', month: 'long', day: 'numeric', year: 'numeric' });
    const formattedCheckOut = checkOutDate.toLocaleDateString('en-US', { weekday: 'long', month: 'long', day: 'numeric', year: 'numeric' });
    
    // Build modal content
    let content = `
        <div class="modal-header">
            <h3>Booking Details - #${booking.id}</h3>
            <button class="modal-close" onclick="closeBookingDetailsModal()">
                <i class="fas fa-times"></i>
            </button>
        </div>
        
        <div class="modal-body">
            <div class="details-section">
                <h4>Guest Information</h4>
                <div class="detail-row">
                    <span class="detail-label">Name:</span>
                    <span class="detail-value">${booking.guestName || 'N/A'}</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Email:</span>
                    <span class="detail-value">${booking.guestEmail || 'N/A'}</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Phone:</span>
                    <span class="detail-value">${booking.guestPhone || 'N/A'}</span>
                </div>
            </div>
            
            <div class="details-section">
                <h4>Room Information</h4>
                <div class="detail-row">
                    <span class="detail-label">Room Number:</span>
                    <span class="detail-value">#${booking.roomNumber}</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Room Type:</span>
                    <span class="detail-value">${booking.roomType}</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Capacity:</span>
                    <span class="detail-value">${booking.numberOfGuests} Guest(s)</span>
                </div>
            </div>
            
            <div class="details-section">
                <h4>Stay Details</h4>
                <div class="detail-row">
                    <span class="detail-label">Check-in:</span>
                    <span class="detail-value">${formattedCheckIn} at ${booking.checkInTime}</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Check-out:</span>
                    <span class="detail-value">${formattedCheckOut} at ${booking.checkOutTime}</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Number of Nights:</span>
                    <span class="detail-value">${booking.nights}</span>
                </div>
            </div>
            
            <div class="details-section">
                <h4>Pricing Details</h4>
                <div class="detail-row">
                    <span class="detail-label">Price per Night:</span>
                    <span class="detail-value">LKR ${booking.pricePerNight.toLocaleString()}</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Subtotal:</span>
                    <span class="detail-value">LKR ${(booking.pricePerNight * booking.nights).toLocaleString()}</span>
                </div>
                <div class="detail-row detail-total">
                    <span class="detail-label">Total Amount:</span>
                    <span class="detail-value">LKR ${booking.totalPrice.toLocaleString()}</span>
                </div>
            </div>
            
            <div class="details-section">
                <h4>Booking Status</h4>
                <div class="detail-row">
                    <span class="detail-label">Status:</span>
                    <span class="detail-value booking-status-badge ${booking.bookingStatus}">
                        ${booking.bookingStatus.toUpperCase()}
                    </span>
                </div>
            </div>
    `;
    
    // Add special requests if available
    if (booking.specialRequests && booking.specialRequests.trim() !== '') {
        content += `
            <div class="details-section">
                <h4>Special Requests</h4>
                <div class="detail-row">
                    <p>${booking.specialRequests}</p>
                </div>
            </div>
        `;
    }
    
    content += `
        </div>
        
        <div class="modal-footer">
            <button class="btn btn-secondary" onclick="closeBookingDetailsModal()">
                <i class="fas fa-times"></i> Close
            </button>
            <button class="btn btn-primary" onclick="printBookingBill(${booking.id})">
                <i class="fas fa-print"></i> Print Bill
            </button>
        </div>
    `;
    
    modalContent.innerHTML = content;
    modal.style.display = 'flex';
    
    console.log('✅ Modal opened successfully');
}

// ========== CLOSE BOOKING DETAILS MODAL ==========
function closeBookingDetailsModal() {
    console.log('❌ Closing booking details modal');
    
    const modal = document.getElementById('bookingDetailsModal');
    if (modal) {
        modal.style.display = 'none';
    }
}

// ========== PRINT BOOKING BILL ==========
function printBookingBill(bookingId) {
    console.log('🖨️ Printing booking bill for ID:', bookingId);
    
    const booking = bookingViewState.allBookings.find(b => b.id === bookingId);
    
    if (!booking) {
        console.error('❌ Booking not found:', bookingId);
        return;
    }
    
    console.log('📄 Bill details:', booking);
    
    // Format dates
    const checkInDate = new Date(booking.checkInDate);
    const checkOutDate = new Date(booking.checkOutDate);
    const formattedCheckIn = checkInDate.toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' });
    const formattedCheckOut = checkOutDate.toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' });
    const printDate = new Date().toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric', hour: '2-digit', minute: '2-digit' });
    
    // Create bill HTML
    const billHTML = `
        <!DOCTYPE html>
        <html>
        <head>
            <meta charset="UTF-8">
            <title>Booking Bill - #${booking.id}</title>
            <style>
                * {
                    margin: 0;
                    padding: 0;
                    box-sizing: border-box;
                }
                
                body {
                    font-family: 'Arial', sans-serif;
                    background: white;
                    padding: 20px;
                }
                
                .bill-container {
                    max-width: 800px;
                    margin: 0 auto;
                    background: white;
                    border: 2px solid #333;
                    padding: 40px;
                }
                
                .bill-header {
                    text-align: center;
                    margin-bottom: 30px;
                    border-bottom: 2px solid #333;
                    padding-bottom: 20px;
                }
                
                .bill-header h1 {
                    font-size: 28px;
                    color: #333;
                    margin-bottom: 5px;
                }
                
                .bill-header p {
                    color: #666;
                    font-size: 14px;
                }
                
                .bill-info {
                    display: grid;
                    grid-template-columns: 1fr 1fr;
                    gap: 30px;
                    margin-bottom: 30px;
                    padding-bottom: 20px;
                    border-bottom: 1px solid #ddd;
                }
                
                .info-section h3 {
                    font-size: 14px;
                    font-weight: bold;
                    color: #333;
                    margin-bottom: 10px;
                    text-transform: uppercase;
                }
                
                .info-row {
                    display: flex;
                    justify-content: space-between;
                    margin-bottom: 8px;
                    font-size: 13px;
                }
                
                .info-label {
                    color: #666;
                    font-weight: 500;
                }
                
                .info-value {
                    color: #333;
                    font-weight: 600;
                }
                
                .bill-details {
                    margin-bottom: 30px;
                }
                
                .bill-details h3 {
                    font-size: 14px;
                    font-weight: bold;
                    color: #333;
                    margin-bottom: 15px;
                    text-transform: uppercase;
                }
                
                table {
                    width: 100%;
                    border-collapse: collapse;
                    margin-bottom: 20px;
                }
                
                table th {
                    background: #f0f0f0;
                    padding: 12px;
                    text-align: left;
                    font-weight: bold;
                    font-size: 13px;
                    border: 1px solid #ddd;
                }
                
                table td {
                    padding: 12px;
                    border: 1px solid #ddd;
                    font-size: 13px;
                }
                
                .bill-summary {
                    margin-bottom: 30px;
                    padding: 20px;
                    background: #f9f9f9;
                    border: 1px solid #ddd;
                }
                
                .summary-row {
                    display: flex;
                    justify-content: space-between;
                    margin-bottom: 10px;
                    font-size: 14px;
                }
                
                .summary-label {
                    color: #666;
                }
                
                .summary-value {
                    color: #333;
                    font-weight: 600;
                }
                
                .summary-total {
                    border-top: 2px solid #333;
                    padding-top: 10px;
                    margin-top: 10px;
                    font-size: 16px;
                    font-weight: bold;
                    color: #007bff;
                }
                
                .bill-footer {
                    text-align: center;
                    padding-top: 20px;
                    border-top: 1px solid #ddd;
                    color: #666;
                    font-size: 12px;
                }
                
                @media print {
                    body {
                        padding: 0;
                    }
                    .bill-container {
                        border: none;
                        max-width: 100%;
                    }
                }
            </style>
        </head>
        <body>
            <div class="bill-container">
                <div class="bill-header">
                    <h1>🏨 OceanView Resort</h1>
                    <p>Booking Invoice</p>
                </div>
                
                <div class="bill-info">
                    <div class="info-section">
                        <h3>Booking Information</h3>
                        <div class="info-row">
                            <span class="info-label">Booking ID:</span>
                            <span class="info-value">#${booking.id}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Status:</span>
                            <span class="info-value">${booking.bookingStatus.toUpperCase()}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Invoice Date:</span>
                            <span class="info-value">${printDate}</span>
                        </div>
                    </div>
                    
                    <div class="info-section">
                        <h3>Guest Information</h3>
                        <div class="info-row">
                            <span class="info-label">Name:</span>
                            <span class="info-value">${booking.guestName || 'N/A'}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Email:</span>
                            <span class="info-value">${booking.guestEmail || 'N/A'}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Phone:</span>
                            <span class="info-value">${booking.guestPhone || 'N/A'}</span>
                        </div>
                    </div>
                </div>
                
                <div class="bill-details">
                    <h3>Room Details</h3>
                    <table>
                        <thead>
                            <tr>
                                <th>Description</th>
                                <th>Details</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Room Number</td>
                                <td>#${booking.roomNumber}</td>
                            </tr>
                            <tr>
                                <td>Room Type</td>
                                <td>${booking.roomType}</td>
                            </tr>
                            <tr>
                                <td>Check-in</td>
                                <td>${formattedCheckIn} at ${booking.checkInTime}</td>
                            </tr>
                            <tr>
                                <td>Check-out</td>
                                <td>${formattedCheckOut} at ${booking.checkOutTime}</td>
                            </tr>
                            <tr>
                                <td>Number of Guests</td>
                                <td>${booking.numberOfGuests}</td>
                            </tr>
                            <tr>
                                <td>Number of Nights</td>
                                <td>${booking.nights}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                
                <div class="bill-summary">
                    <div class="summary-row">
                        <span class="summary-label">Price per Night:</span>
                        <span class="summary-value">LKR ${booking.pricePerNight.toLocaleString()}</span>
                    </div>
                    <div class="summary-row">
                        <span class="summary-label">Number of Nights:</span>
                        <span class="summary-value">${booking.nights}</span>
                    </div>
                    <div class="summary-row">
                        <span class="summary-label">Subtotal:</span>
                        <span class="summary-value">LKR ${(booking.pricePerNight * booking.nights).toLocaleString()}</span>
                    </div>
                    <div class="summary-row summary-total">
                        <span>TOTAL AMOUNT:</span>
                        <span>LKR ${booking.totalPrice.toLocaleString()}</span>
                    </div>
                </div>
                
                <div class="bill-footer">
                    <p>Thank you for choosing OceanView Resort!</p>
                    <p>For inquiries, contact us at info@oceanviewresort.com</p>
                </div>
            </div>
        </body>
        </html>
    `;
    
    console.log('📋 Bill HTML generated');
    console.log('💰 Total Amount: LKR ' + booking.totalPrice.toLocaleString());
    console.log('🛏️ Room: #' + booking.roomNumber);
    console.log('📅 Check-in: ' + formattedCheckIn);
    console.log('📅 Check-out: ' + formattedCheckOut);
    console.log('👥 Guests: ' + booking.numberOfGuests);
    console.log('🌙 Nights: ' + booking.nights);
    
    // Open in new window and print
    const printWindow = window.open('', '', 'height=600,width=800');
    printWindow.document.write(billHTML);
    printWindow.document.close();
    
    setTimeout(() => {
        printWindow.print();
        console.log('✅ Print dialog opened');
    }, 250);
}

// ========== CANCEL BOOKING ==========
function cancelBooking(bookingId, roomNumber) {
    console.log('🔄 Cancelling booking:', bookingId);
    console.log('🚪 Room Number:', roomNumber);
    
    if (!confirm(`Are you sure you want to cancel booking for Room #${roomNumber}?\n\nThis action cannot be undone.`)) {
        console.log('❌ Cancellation cancelled by user');
        return;
    }
    
    const baseUrl = window.location.origin;
    const contextPath = '/OceanViewResort';
    const url = baseUrl + contextPath + '/cancelBooking';
    
    const params = new URLSearchParams();
    params.append('bookingId', bookingId);
    
    console.log('📤 Sending cancellation request to:', url);
    console.log('📋 Booking ID:', bookingId);
    
    fetch(url, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: params.toString()
    })
    .then(response => response.text())
    .then(text => {
        console.log('📥 Response:', text);
        
        try {
            const data = JSON.parse(text);
            
            if (data.success) {
                console.log('✅ Booking cancelled successfully');
                console.log('📊 Updated booking status');
                alert('✅ Booking cancelled successfully!\n\nThe room is now available for other guests.');
                
                // Reload bookings
                loadUserBookings();
            } else {
                console.error('❌ Cancellation failed:', data.message);
                alert('❌ Error: ' + data.message);
            }
        } catch (error) {
            console.error('❌ Parse error:', error);
            alert('⚠️ Server error');
        }
    })
    .catch(error => {
        console.error('❌ Network error:', error);
        alert('⚠️ Network error: ' + error.message);
    });
}

// ========== ATTACH FILTER LISTENERS ==========
function attachFilterListeners() {
    console.log('🔗 Attaching filter listeners...');
    
    const filterBtns = document.querySelectorAll('.filter-btn');
    filterBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            // Remove active class from all buttons
            filterBtns.forEach(b => b.classList.remove('active'));
            
            // Add active class to clicked button
            this.classList.add('active');
            
            // Filter bookings
            const filter = this.getAttribute('data-filter');
            filterBookings(filter);
        });
    });
    
    console.log('✅ Filter listeners attached');
}

// ========== SHOW LOADING MESSAGE ==========
function showLoadingMessage() {
    const container = document.getElementById('bookingsContainer');
    const emptyState = document.getElementById('emptyState');
    
    if (container) {
        container.innerHTML = `
            <div class="loading-message">
                <i class="fas fa-spinner fa-spin"></i> Loading your bookings...
            </div>
        `;
    }
    if (emptyState) {
        emptyState.style.display = 'none';
    }
}

// ========== SHOW EMPTY STATE ==========
function showEmptyState() {
    const container = document.getElementById('bookingsContainer');
    const emptyState = document.getElementById('emptyState');
    
    if (container) {
        container.innerHTML = '';
    }
    if (emptyState) {
        emptyState.style.display = 'block';
    }
}

// ========== SHOW ERROR MESSAGE ==========
function showErrorMessage(message) {
    const container = document.getElementById('bookingsContainer');
    
    if (container) {
        container.innerHTML = `
            <div class="error-message" style="text-align: center; padding: 40px 20px; color: #ef4444; font-weight: bold;">
                ❌ ${message}
            </div>
        `;
    }
}

// ========== CLOSE MODAL ON OUTSIDE CLICK ==========
document.addEventListener('click', function(event) {
    const modal = document.getElementById('bookingDetailsModal');
    if (modal && event.target === modal) {
        closeBookingDetailsModal();
    }
});

// ========== AUTO INITIALIZE ==========
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initializeBookingView);
} else {
    initializeBookingView();
}

console.log('✅ Booking View JS Ready');
