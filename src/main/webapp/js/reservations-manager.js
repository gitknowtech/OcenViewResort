// ✅ RESERVATIONS MANAGER - reservations-manager.js

const RES_BASE_URL = window.location.origin;
const RES_CONTEXT_PATH = '/OceanViewResort';

function showResMsg(text, type) {
    const msg = document.getElementById('msg');
    if (!msg) return;
    msg.textContent = text;
    msg.className = 'msg ' + type + ' show';
    setTimeout(() => msg.classList.remove('show'), 4000);
}

function loadReservations() {
    const url = RES_BASE_URL + RES_CONTEXT_PATH + '/reservations?action=getAll';
    console.log('📥 Loading reservations from:', url);
    
    fetch(url)
        .then(r => {
            console.log('Response status:', r.status);
            if (!r.ok) throw new Error('HTTP ' + r.status);
            return r.json();
        })
        .then(data => {
            console.log('✅ Reservations data:', data);
            let html = '';
            if (data && data.length > 0) {
                data.forEach(res => {
                    const statusColor = res.status === 'confirmed' ? '#10b981' : res.status === 'cancelled' ? '#ef4444' : '#f59e0b';
                    const paymentColor = res.payment_status === 'paid' ? '#10b981' : res.payment_status === 'partial' ? '#f59e0b' : '#ef4444';
                    
                    html += '<tr>';
                    html += '<td><strong>#' + res.id + '</strong></td>';
                    html += '<td>' + res.customer_name + '</td>';
                    html += '<td>' + res.room_number + '</td>';
                    html += '<td>' + res.check_in_date + '<br><small>' + res.check_in_time + ' - ' + res.check_out_time + '</small></td>';
                    html += '<td><strong>' + res.hours + ' hrs</strong></td>';
                    html += '<td>' + res.total_amount.toFixed(2) + '</td>';
                    html += '<td><span style="background:' + statusColor + '; color:white; padding:4px 8px; border-radius:4px; font-size:11px; font-weight:600;">' + res.status.toUpperCase() + '</span></td>';
                    html += '<td><span style="background:' + paymentColor + '; color:white; padding:4px 8px; border-radius:4px; font-size:11px; font-weight:600;">' + res.payment_status.toUpperCase() + '</span></td>';
                    html += '<td>';
                    html += '<button class="btn btn-small btn-view" onclick="viewReservation(' + res.id + ')" title="View"><i class="fas fa-eye"></i></button>';
                    html += '<button class="btn btn-small btn-edit" onclick="editReservation(' + res.id + ')" title="Edit"><i class="fas fa-edit"></i></button>';
                    html += '<button class="btn btn-small btn-print" onclick="generateBill(' + res.id + ')" title="Print Bill"><i class="fas fa-receipt"></i></button>';
                    html += '<button class="btn btn-small btn-delete" onclick="deleteReservation(' + res.id + ')" title="Delete"><i class="fas fa-trash"></i></button>';
                    html += '</td>';
                    html += '</tr>';
                });
            } else {
                html = '<tr><td colspan="9" style="text-align: center; padding: 40px;">No reservations found</td></tr>';
            }
            document.getElementById('reservationsTable').innerHTML = html;
        })
        .catch(e => {
            console.error('❌ Error loading reservations:', e);
            showResMsg('❌ Error loading reservations: ' + e.message, 'error');
            document.getElementById('reservationsTable').innerHTML = '<tr><td colspan="9" style="text-align: center; padding: 40px;">Error loading reservations</td></tr>';
        });
}

// ✅ LOAD CUSTOMERS FOR DROPDOWN
function loadCustomers() {
    const userSelect = document.getElementById('user_id');
    if (!userSelect) {
        console.warn('⚠️ user_id element not found');
        return;
    }
    
    const url = RES_BASE_URL + RES_CONTEXT_PATH + '/users?action=getAll';
    console.log('📥 Loading customers from:', url);
    
    fetch(url)
        .then(r => r.json())
        .then(data => {
            console.log('✅ Customers loaded:', data);
            let html = '<option value="">Select Customer</option>';
            if (data && data.length > 0) {
                data.forEach(user => {
                    html += '<option value="' + user.id + '">' + user.first_name + ' ' + user.last_name + ' (' + user.email + ')</option>';
                });
            }
            userSelect.innerHTML = html;
        })
        .catch(e => {
            console.error('❌ Error loading customers:', e);
            showResMsg('❌ Error loading customers: ' + e.message, 'error');
        });
}

// ✅ LOAD ALL ROOMS (NOT FILTERED BY DATE YET)
function loadAllRooms() {
    const roomSelect = document.getElementById('room_id');
    if (!roomSelect) {
        console.warn('⚠️ room_id element not found');
        return;
    }
    
    const url = RES_BASE_URL + RES_CONTEXT_PATH + '/rooms?action=getAll';
    console.log('📥 Loading all rooms from:', url);
    
    fetch(url)
        .then(r => r.json())
        .then(data => {
            console.log('✅ All rooms loaded:', data);
            let html = '<option value="">Select Room</option>';
            if (data && data.length > 0) {
                data.forEach(room => {
                    html += '<option value="' + room.id + '" data-price="' + room.room_price + '">' + room.room_number + ' - ' + room.room_type + ' (' + room.room_price.toFixed(2) + '/hr)</option>';
                });
            }
            roomSelect.innerHTML = html;
        })
        .catch(e => {
            console.error('❌ Error loading rooms:', e);
            showResMsg('❌ Error loading rooms: ' + e.message, 'error');
        });
}

// ✅ LOAD AVAILABLE ROOMS BY DATE
function loadAvailableRooms() {
    const date = document.getElementById('check_in_date').value;
    if (!date) {
        console.warn('⚠️ Please select a date first');
        return;
    }
    
    const roomSelect = document.getElementById('room_id');
    if (!roomSelect) {
        console.warn('⚠️ room_id element not found');
        return;
    }
    
    const url = RES_BASE_URL + RES_CONTEXT_PATH + '/reservations?action=getAvailableRooms&date=' + date;
    console.log('📥 Loading available rooms for date:', date);
    
    fetch(url)
        .then(r => r.json())
        .then(data => {
            console.log('✅ Available rooms:', data);
            let html = '<option value="">Select Room</option>';
            if (data && data.length > 0) {
                data.forEach(room => {
                    html += '<option value="' + room.id + '" data-price="' + room.room_price + '">' + room.room_number + ' - ' + room.room_type + ' (' + room.room_price.toFixed(2) + '/hr)</option>';
                });
            } else {
                html = '<option value="">No rooms available</option>';
            }
            roomSelect.innerHTML = html;
            calculateTotal();
        })
        .catch(e => {
            console.error('❌ Error loading available rooms:', e);
            showResMsg('❌ Error: ' + e.message, 'error');
        });
}

// ✅ CALCULATE TOTAL AMOUNT
function calculateTotal() {
    const hours = parseInt(document.getElementById('hours').value) || 0;
    const hourlyRateInput = document.getElementById('hourly_rate');
    
    let hourlyRate = parseFloat(hourlyRateInput.value) || 0;
    
    if (hourlyRate === 0) {
        const roomSelect = document.getElementById('room_id');
        const selectedOption = roomSelect.options[roomSelect.selectedIndex];
        hourlyRate = parseFloat(selectedOption.dataset.price) || 0;
    }
    
    const total = hours * hourlyRate;
    
    const totalDisplay = document.getElementById('totalDisplay');
    if (totalDisplay) {
        totalDisplay.textContent = '$' + total.toFixed(2);
    }
    
    const totalAmountInput = document.getElementById('total_amount');
    if (totalAmountInput) {
        totalAmountInput.value = total.toFixed(2);
    }
    
    console.log('💰 Total calculated:', { hours, hourlyRate, total: total.toFixed(2) });
}

function viewReservation(id) {
    console.log('👁️ Viewing reservation:', id);
    const url = RES_BASE_URL + RES_CONTEXT_PATH + '/reservations?action=getById&id=' + id;
    
    fetch(url)
        .then(r => r.json())
        .then(d => {
            if (d.success) {
                const res = d.reservation;
                alert('📅 RESERVATION DETAILS\n\nID: ' + res.id + '\nRoom: #' + res.room_id + '\nDate: ' + res.check_in_date + '\nTime: ' + res.check_in_time + ' - ' + res.check_out_time + '\nDuration: ' + res.hours + ' hours\nRate: $' + res.hourly_rate.toFixed(2) + '/hr\nTotal: ' + res.total_amount.toFixed(2) + '\nStatus: ' + res.status + '\nPayment: ' + res.payment_status + '\nNotes: ' + (res.notes || 'N/A'));
            } else {
                showResMsg('❌ Error loading reservation', 'error');
            }
        })
        .catch(e => {
            console.error('Error:', e);
            showResMsg('❌ Error: ' + e.message, 'error');
        });
}

function editReservation(id) {
    console.log('✏️ Editing reservation:', id);
    const url = RES_BASE_URL + RES_CONTEXT_PATH + '/reservations?action=getById&id=' + id;
    
    fetch(url)
        .then(r => r.json())
        .then(d => {
            if (d.success) {
                const res = d.reservation;
                document.getElementById('reservationId').value = res.id;
                document.getElementById('resMode').value = 'edit';
                document.getElementById('status').value = res.status;
                document.getElementById('payment_status').value = res.payment_status;
                document.getElementById('notes').value = res.notes || '';
                document.getElementById('formTitle').textContent = '✏️ Edit Reservation #' + res.id;
                document.getElementById('submitBtn').innerHTML = '<i class="fas fa-save"></i> Update';
                document.getElementById('bookingForm').style.display = 'none';
                document.getElementById('editForm').style.display = 'block';
                showResMsg('📝 Editing Reservation #' + res.id, 'success');
                document.querySelector('.card:last-child').scrollIntoView({ behavior: 'smooth' });
            } else {
                showResMsg('❌ Error loading reservation', 'error');
            }
        })
        .catch(e => {
            console.error('Error:', e);
            showResMsg('❌ Error: ' + e.message, 'error');
        });
}

function deleteReservation(id) {
    if (!confirm('⚠️ Are you sure you want to delete this reservation?')) return;
    console.log('🗑️ Deleting reservation:', id);
    
    const params = new URLSearchParams();
    params.append('action', 'delete');
    params.append('id', id);
    
    const url = RES_BASE_URL + RES_CONTEXT_PATH + '/reservations';
    
    fetch(url, { 
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: params.toString()
    })
        .then(r => r.json())
        .then(d => {
            if (d.success) {
                showResMsg('✅ Reservation deleted successfully!', 'success');
                loadReservations();
            } else {
                showResMsg('❌ ' + (d.message || 'Error deleting'), 'error');
            }
        })
        .catch(e => {
            console.error('Error:', e);
            showResMsg('❌ Error deleting: ' + e.message, 'error');
        });
}

function submitReservationForm() {
    const resMode = document.getElementById('resMode').value;
    
    if (resMode === 'edit') {
        submitEditForm();
    } else {
        submitBookingForm();
    }
}

function submitBookingForm() {
    const user_id = document.getElementById('user_id').value.trim();
    const room_id = document.getElementById('room_id').value.trim();
    const check_in_date = document.getElementById('check_in_date').value.trim();
    const check_in_time = document.getElementById('check_in_time').value.trim();
    const hours = document.getElementById('hours').value.trim();
    const hourly_rate = document.getElementById('hourly_rate').value.trim();
    const notes = document.getElementById('notes').value.trim();
    
    console.log('📝 Booking form:', { user_id, room_id, check_in_date, check_in_time, hours, hourly_rate });
    
    if (!user_id || !room_id || !check_in_date || !check_in_time || !hours || !hourly_rate) {
        showResMsg('❌ All required fields must be filled (including Hourly Rate)', 'error');
        return;
    }
    
    const params = new URLSearchParams();
    params.append('action', 'add');
    params.append('user_id', user_id);
    params.append('room_id', room_id);
    params.append('check_in_date', check_in_date);
    params.append('check_in_time', check_in_time);
    params.append('hours', hours);
    params.append('hourly_rate', hourly_rate);
    params.append('notes', notes);
    
    const url = RES_BASE_URL + RES_CONTEXT_PATH + '/reservations';
    
    fetch(url, { 
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: params.toString()
    })
        .then(r => r.json())
        .then(d => {
            console.log('✅ Response:', d);
            if (d.success) {
                showResMsg('✅ Reservation created! Total: $' + d.total_amount.toFixed(2), 'success');
                resetReservationForm();
                loadReservations();
            } else {
                showResMsg('❌ ' + (d.message || 'Error'), 'error');
            }
        })
        .catch(e => {
            console.error('❌ Error:', e);
            showResMsg('❌ Error: ' + e.message, 'error');
        });
}

function submitEditForm() {
    const reservationId = document.getElementById('reservationId').value;
    const status = document.getElementById('status').value;
    const payment_status = document.getElementById('payment_status').value;
    const notes = document.getElementById('notes').value.trim();
    
    const params = new URLSearchParams();
    params.append('action', 'update');
    params.append('id', reservationId);
    params.append('status', status);
    params.append('payment_status', payment_status);
    params.append('notes', notes);
    
    const url = RES_BASE_URL + RES_CONTEXT_PATH + '/reservations';
    
    fetch(url, { 
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: params.toString()
    })
        .then(r => r.json())
        .then(d => {
            if (d.success) {
                showResMsg('✅ Reservation updated successfully!', 'success');
                resetReservationForm();
                loadReservations();
            } else {
                showResMsg('❌ ' + (d.message || 'Error'), 'error');
            }
        })
        .catch(e => {
            console.error('❌ Error:', e);
            showResMsg('❌ Error: ' + e.message, 'error');
        });
}

function resetReservationForm() {
    document.getElementById('reservationId').value = '';
    document.getElementById('resMode').value = 'add';
    document.getElementById('user_id').value = '';
    document.getElementById('check_in_date').value = '';
    document.getElementById('check_in_time').value = '';
    document.getElementById('hours').value = '1';
    document.getElementById('hourly_rate').value = '';
    document.getElementById('total_amount').value = '';
    
    const totalDisplay = document.getElementById('totalDisplay');
    if (totalDisplay) {
        totalDisplay.textContent = '$0.00';
    }
    
    document.getElementById('status').value = 'pending';
    document.getElementById('payment_status').value = 'unpaid';
    document.getElementById('notes').value = '';
    document.getElementById('formTitle').textContent = '➕ Book Room';
    document.getElementById('submitBtn').innerHTML = '<i class="fas fa-save"></i> Create Reservation';
    document.getElementById('bookingForm').style.display = 'block';
    document.getElementById('editForm').style.display = 'none';
    
    loadAllRooms();
    
    showResMsg('✅ Form cleared', 'success');
}

// ✅ GENERATE AND SHOW BILL IN NEW WINDOW
function generateBill(reservationId) {
    console.log('🧾 Generating bill for reservation:', reservationId);
    const url = window.location.origin + '/OceanViewResort/reservations?action=getById&id=' + reservationId;
    
    fetch(url)
        .then(r => r.json())
        .then(d => {
            if (d.success) {
                const res = d.reservation;
                
                // Get customer info
                const userUrl = window.location.origin + '/OceanViewResort/users?action=getById&id=' + res.user_id;
                fetch(userUrl)
                    .then(r => r.json())
                    .then(userData => {
                        if (userData.success) {
                            const user = userData.user;
                            
                            // Get room info
                            const roomUrl = window.location.origin + '/OceanViewResort/rooms?action=getById&id=' + res.room_id;
                            fetch(roomUrl)
                                .then(r => r.json())
                                .then(roomData => {
                                    if (roomData.success) {
                                        const room = roomData.room;
                                        
                                        // Calculate tax
                                        const subtotal = res.total_amount;
                                        const tax = subtotal * 0.10;
                                        const totalWithTax = subtotal + tax;
                                        
                                        // Format date
                                        const today = new Date();
                                        const dateStr = today.toLocaleDateString('en-US', { year: 'numeric', month: '2-digit', day: '2-digit' });
                                        const timeStr = today.toLocaleTimeString('en-US', { hour: '2-digit', minute: '2-digit', second: '2-digit' });
                                        
                                        // Generate HTML bill
                                        const billHTML = generateBillHTML(res, user, room, subtotal, tax, totalWithTax, dateStr, timeStr);
                                        
                                        // Open in new window
                                        openBillWindow(billHTML, 'Reservation_Bill_' + res.id);
                                        showResMsg('✅ Bill opened in new window!', 'success');
                                    }
                                })
                                .catch(e => {
                                    console.error('Error loading room:', e);
                                    showResMsg('❌ Error loading room', 'error');
                                });
                        }
                    })
                    .catch(e => {
                        console.error('Error loading user:', e);
                        showResMsg('❌ Error loading user', 'error');
                    });
            }
        })
        .catch(e => {
            console.error('Error loading reservation:', e);
            showResMsg('❌ Error loading reservation', 'error');
        });
}

// ✅ GENERATE BILL HTML
function generateBillHTML(res, user, room, subtotal, tax, totalWithTax, dateStr, timeStr) {
    const statusColor = res.payment_status === 'paid' ? '#d1fae5' : res.payment_status === 'partial' ? '#fef3c7' : '#fee2e2';
    const statusTextColor = res.payment_status === 'paid' ? '#065f46' : res.payment_status === 'partial' ? '#92400e' : '#991b1b';
    
    return `
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reservation Bill #${res.id}</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Courier New', monospace;
            background: #f5f5f5;
            padding: 20px;
            color: #333;
        }
        
        .bill-wrapper {
            max-width: 80mm;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .bill-header {
            text-align: center;
            border-bottom: 2px dashed #333;
            padding-bottom: 15px;
            margin-bottom: 15px;
        }
        
        .hotel-name {
            font-size: 18px;
            font-weight: bold;
            color: #1a1f3a;
            margin-bottom: 5px;
        }
        
        .hotel-info {
            font-size: 10px;
            color: #666;
            line-height: 1.4;
        }
        
        .bill-section {
            margin-bottom: 15px;
        }
        
        .bill-section-title {
            font-weight: bold;
            color: #1a1f3a;
            margin-bottom: 8px;
            font-size: 12px;
            text-transform: uppercase;
            border-bottom: 1px solid #ddd;
            padding-bottom: 5px;
        }
        
        .bill-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 5px;
            font-size: 11px;
        }
        
        .bill-row-label {
            flex: 1;
        }
        
        .bill-row-value {
            text-align: right;
            min-width: 70px;
        }
        
        .bill-divider {
            border-bottom: 1px dashed #333;
            margin: 10px 0;
        }
        
        .charge-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 6px;
            font-size: 11px;
        }
        
        .charge-label {
            flex: 1;
        }
        
        .charge-value {
            text-align: right;
            min-width: 70px;
            font-weight: 500;
        }
        
        .bill-total-box {
            background: #f0fdf4;
            border: 2px solid #10b981;
            padding: 12px;
            border-radius: 6px;
            margin: 15px 0;
            text-align: center;
        }
        
        .bill-total-label {
            font-size: 11px;
            color: #666;
            margin-bottom: 5px;
        }
        
        .bill-total-amount {
            font-size: 24px;
            font-weight: bold;
            color: #10b981;
        }
        
        .bill-status {
            background: ${statusColor};
            color: ${statusTextColor};
            padding: 10px;
            border-radius: 6px;
            text-align: center;
            font-weight: bold;
            margin: 15px 0;
            font-size: 12px;
        }
        
        .bill-footer {
            text-align: center;
            border-top: 2px dashed #333;
            padding-top: 15px;
            margin-top: 15px;
            font-size: 9px;
            color: #666;
            line-height: 1.6;
        }
        
        .print-buttons {
            text-align: center;
            margin-top: 20px;
            padding-top: 15px;
            border-top: 1px solid #ddd;
        }
        
        .print-btn {
            background: #3b82f6;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            margin-right: 10px;
            transition: all 0.3s ease;
        }
        
        .print-btn:hover {
            background: #2563eb;
        }
        
        .close-btn {
            background: #e5e7eb;
            color: #374151;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .close-btn:hover {
            background: #d1d5db;
        }
        
        @media print {
            body {
                background: white;
                padding: 0;
            }
            
            .bill-wrapper {
                box-shadow: none;
                border-radius: 0;
                max-width: 100%;
                margin: 0;
                padding: 0;
            }
            
            .print-buttons {
                display: none;
            }
        }
    </style>
</head>
<body>
    <div class="bill-wrapper">
        <div class="bill-header">
            <div class="hotel-name">🏨 OCEAN VIEW HOTEL</div>
            <div class="hotel-info">
                <div>Colombo, Sri Lanka</div>
                <div>Tel: +94 11 2345678</div>
                <div>Email: info@oceanview.lk</div>
            </div>
        </div>
        
        <div class="bill-section">
            <div class="bill-section-title">Reservation Bill</div>
            <div class="bill-row">
                <div class="bill-row-label">Bill No:</div>
                <div class="bill-row-value"><strong>#${res.id}</strong></div>
            </div>
            <div class="bill-row">
                <div class="bill-row-label">Date:</div>
                <div class="bill-row-value">${dateStr}</div>
            </div>
            <div class="bill-row">
                <div class="bill-row-label">Time:</div>
                <div class="bill-row-value">${timeStr}</div>
            </div>
        </div>
        
        <div class="bill-divider"></div>
        
        <div class="bill-section">
            <div class="bill-section-title">Guest Details</div>
            <div class="bill-row">
                <div class="bill-row-label">Name:</div>
                <div class="bill-row-value">${user.first_name} ${user.last_name}</div>
            </div>
            <div class="bill-row">
                <div class="bill-row-label">Email:</div>
                <div class="bill-row-value" style="font-size: 9px;">${user.email}</div>
            </div>
            <div class="bill-row">
                <div class="bill-row-label">Phone:</div>
                <div class="bill-row-value">${user.phone || 'N/A'}</div>
            </div>
        </div>
        
        <div class="bill-divider"></div>
        
        <div class="bill-section">
            <div class="bill-section-title">Room Details</div>
            <div class="bill-row">
                <div class="bill-row-label">Room No:</div>
                <div class="bill-row-value"><strong>${room.room_number}</strong></div>
            </div>
            <div class="bill-row">
                <div class="bill-row-label">Room Type:</div>
                <div class="bill-row-value">${room.room_type}</div>
            </div>
            <div class="bill-row">
                <div class="bill-row-label">Check-In:</div>
                <div class="bill-row-value">${res.check_in_date}</div>
            </div>
            <div class="bill-row">
                <div class="bill-row-label">Check-In Time:</div>
                <div class="bill-row-value">${res.check_in_time}</div>
            </div>
            <div class="bill-row">
                <div class="bill-row-label">Check-Out Time:</div>
                <div class="bill-row-value">${res.check_out_time}</div>
            </div>
        </div>
        
        <div class="bill-divider"></div>
        
        <div class="bill-section">
            <div class="bill-section-title">Charges</div>
            <div class="charge-row">
                <div class="charge-label">Duration:</div>
                <div class="charge-value">${res.hours} hours</div>
            </div>
            <div class="charge-row">
                <div class="charge-label">Rate/Hour:</div>
                <div class="charge-value">$${res.hourly_rate.toFixed(2)}</div>
            </div>
            <div class="charge-row">
                <div class="charge-label">Subtotal:</div>
                <div class="charge-value">$${subtotal.toFixed(2)}</div>
            </div>
            <div class="charge-row">
                <div class="charge-label">Tax (10%):</div>
                <div class="charge-value">$${tax.toFixed(2)}</div>
            </div>
        </div>
        
        <div class="bill-total-box">
            <div class="bill-total-label">TOTAL AMOUNT</div>
            <div class="bill-total-amount">${totalWithTax.toFixed(2)}</div>
        </div>
        
        <div class="bill-status">
            ${res.payment_status.toUpperCase()} - ${res.status.toUpperCase()}
        </div>
        
        ${res.notes ? `
        <div class="bill-section">
            <div class="bill-section-title">Notes</div>
            <div style="font-size: 10px; line-height: 1.5; color: #666;">
                ${res.notes}
            </div>
        </div>
        ` : ''}
        
        <div class="bill-footer">
            <div>Thank you for your business!</div>
            <div>Please retain this receipt for your records</div>
            <div style="margin-top: 8px; font-size: 8px;">
                Generated: ${new Date().toLocaleString()}
            </div>
        </div>
        
        <div class="print-buttons">
            <button class="print-btn" onclick="window.print()">
                <i class="fas fa-print"></i> Print Bill
            </button>
            <button class="close-btn" onclick="window.close()">
                <i class="fas fa-times"></i> Close
            </button>
        </div>
    </div>
</body>
</html>
    `;
}

// ✅ OPEN BILL IN NEW WINDOW
function openBillWindow(htmlContent, fileName) {
    const newWindow = window.open('', '_blank', 'width=400,height=600,scrollbars=yes');
    newWindow.document.write(htmlContent);
    newWindow.document.close();
}

function initReservationsPage() {
    console.log('🔧 Initializing Reservations page...');
    
    setTimeout(() => {
        const submitBtn = document.getElementById('submitBtn');
        const resetBtn = document.getElementById('resetBtn');
        const searchInput = document.getElementById('search');
        const dateInput = document.getElementById('check_in_date');
        const hoursInput = document.getElementById('hours');
        const roomSelect = document.getElementById('room_id');
        const hourlyRateInput = document.getElementById('hourly_rate');
        
        console.log('✅ Elements found:', { 
            submitBtn: !!submitBtn, 
            resetBtn: !!resetBtn, 
            hourlyRateInput: !!hourlyRateInput 
        });
        
        if (submitBtn) submitBtn.addEventListener('click', submitReservationForm);
        if (resetBtn) resetBtn.addEventListener('click', resetReservationForm);
        if (dateInput) dateInput.addEventListener('change', loadAvailableRooms);
        if (hoursInput) hoursInput.addEventListener('change', calculateTotal);
        if (roomSelect) roomSelect.addEventListener('change', calculateTotal);
        if (hourlyRateInput) hourlyRateInput.addEventListener('change', calculateTotal);
        
        if (searchInput) {
            searchInput.addEventListener('keyup', function() {
                const term = this.value.toLowerCase();
                const rows = document.querySelectorAll('#reservationsTable tr');
                rows.forEach(row => {
                    if (!row) return;
                    const text = row.textContent || '';
                    row.style.display = text.toLowerCase().includes(term) ? '' : 'none';
                });
            });
        }
        
        loadReservations();
        loadCustomers();
        loadAllRooms();
        
        console.log('✅ Reservations page initialized');
    }, 200);
}
