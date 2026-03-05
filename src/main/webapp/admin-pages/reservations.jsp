<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- ✅ FONT AWESOME -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

<style>
    .container { display: grid; grid-template-columns: 2fr 1fr; gap: 30px; }
    .card { background: white; border-radius: 12px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); padding: 20px; }
    .card-title { font-size: 18px; font-weight: 700; margin-bottom: 20px; border-bottom: 2px solid #e5e7eb; padding-bottom: 15px; }
    table { width: 100%; border-collapse: collapse; font-size: 11px; }
    th, td { padding: 8px; text-align: left; border-bottom: 1px solid #e5e7eb; }
    th { background: #f9fafb; font-weight: 600; }
    .btn { padding: 8px 12px; border: none; border-radius: 6px; cursor: pointer; font-size: 14px; }
    .btn-primary { background: #3b82f6; color: white; }
    .btn-primary:hover { background: #2563eb; }
    .btn-secondary { background: #e5e7eb; color: #374151; }
    .btn-secondary:hover { background: #d1d5db; }
    .btn-small { width: 32px; height: 32px; padding: 0; display: inline-flex; align-items: center; justify-content: center; border-radius: 6px; margin-right: 4px; font-size: 12px; }
    .btn-view { background: #dbeafe; color: #1d4ed8; }
    .btn-view:hover { background: #bfdbfe; }
    .btn-edit { background: #fef3c7; color: #b45309; }
    .btn-edit:hover { background: #fde68a; }
    .btn-delete { background: #fee2e2; color: #991b1b; }
    .btn-delete:hover { background: #fecaca; }
    .btn-print { background: #8b5cf6; color: white; }
    .btn-print:hover { background: #7c3aed; }
    input, select, textarea { width: 100%; padding: 10px; border: 1px solid #d1d5db; border-radius: 8px; margin-bottom: 15px; font-size: 14px; }
    input:focus, select:focus, textarea:focus { outline: none; border-color: #3b82f6; box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1); }
    .msg { position: fixed; top: 20px; right: 20px; padding: 15px 20px; border-radius: 8px; color: white; display: none; z-index: 9999; font-weight: 600; }
    .msg.success { background: #10b981; }
    .msg.error { background: #ef4444; }
    .msg.show { display: block; animation: slideIn 0.3s ease; }
    @keyframes slideIn { from { transform: translateX(400px); opacity: 0; } to { transform: translateX(0); opacity: 1; } }
    .total-box { background: #f0fdf4; border: 2px solid #10b981; padding: 15px; border-radius: 8px; text-align: center; margin-bottom: 15px; }
    .total-box strong { font-size: 24px; color: #10b981; }
    @media (max-width: 1400px) { .container { grid-template-columns: 1fr; } }
</style>

<div id="msg" class="msg"></div>

<div class="container">
    <div class="card">
        <div class="card-title">📅 Reservations</div>
        <input type="text" id="search" placeholder="🔍 Search...">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Customer</th>
                    <th>Room</th>
                    <th>Date & Time</th>
                    <th>Hours</th>
                    <th>Total</th>
                    <th>Status</th>
                    <th>Payment</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody id="reservationsTable">
                <tr><td colspan="9" style="text-align: center; padding: 40px;">Loading...</td></tr>
            </tbody>
        </table>
    </div>
    
    <div class="card">
        <div class="card-title" id="formTitle">➕ Book Room</div>
        <input type="hidden" id="reservationId">
        <input type="hidden" id="resMode" value="add">
        
        <!-- BOOKING FORM -->
        <div id="bookingForm">
            <select id="user_id" required>
                <option value="">Select Customer</option>
            </select>
            
            <input type="date" id="check_in_date" required>
            <input type="time" id="check_in_time" required>
            
            <select id="room_id" required>
                <option value="">Select Room</option>
            </select>
            
            <select id="hours" required>
                <option value="1">1 Hour</option>
                <option value="2">2 Hours</option>
                <option value="3">3 Hours</option>
                <option value="4">4 Hours</option>
                <option value="5">5 Hours</option>
                <option value="6">6 Hours (Max)</option>
            </select>
            
            <input type="number" id="hourly_rate" placeholder="Hourly Rate ($)" step="0.01" min="0" required>
            
            <input type="hidden" id="total_amount">
            
            <div class="total-box">
                <strong id="totalDisplay">$0.00</strong>
            </div>
            
            <textarea id="notes" placeholder="Notes (Optional)" rows="2"></textarea>
        </div>
        
        <!-- EDIT FORM -->
        <div id="editForm" style="display: none;">
            <select id="status" required>
                <option value="pending">Pending</option>
                <option value="confirmed">Confirmed</option>
                <option value="checked-in">Checked-In</option>
                <option value="checked-out">Checked-Out</option>
                <option value="cancelled">Cancelled</option>
            </select>
            
            <select id="payment_status" required>
                <option value="unpaid">Unpaid</option>
                <option value="partial">Partial</option>
                <option value="paid">Paid</option>
            </select>
            
            <textarea id="notes" placeholder="Notes (Optional)" rows="2"></textarea>
        </div>
        
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 10px;">
            <button class="btn btn-primary" id="submitBtn"><i class="fas fa-save"></i> Create Reservation</button>
            <button class="btn btn-secondary" id="resetBtn"><i class="fas fa-redo"></i> Clear</button>
        </div>
    </div>
</div>

<script>
function loadCustomers() {
    const url = window.location.origin + '/OceanViewResort/users?action=getAll';
    fetch(url)
        .then(r => r.json())
        .then(data => {
            let html = '<option value="">Select Customer</option>';
            if (data && data.length > 0) {
                data.forEach(user => {
                    html += '<option value="' + user.id + '">' + user.first_name + ' ' + user.last_name + ' (' + user.email + ')</option>';
                });
            }
            document.getElementById('user_id').innerHTML = html;
        })
        .catch(e => console.error('Error loading customers:', e));
}

function loadRoomsForBooking() {
    const url = window.location.origin + '/OceanViewResort/rooms?action=getAll';
    fetch(url)
        .then(r => r.json())
        .then(data => {
            let html = '<option value="">Select Room</option>';
            if (data && data.length > 0) {
                data.forEach(room => {
                    html += '<option value="' + room.id + '" data-price="' + room.room_price + '">' + room.room_number + ' - ' + room.room_type + ' ($' + room.room_price.toFixed(2) + '/hr)</option>';
                });
            }
            document.getElementById('room_id').innerHTML = html;
        })
        .catch(e => console.error('Error loading rooms:', e));
}

document.addEventListener('DOMContentLoaded', function() {
    loadCustomers();
    loadRoomsForBooking();
    initReservationsPage();
});
</script>
