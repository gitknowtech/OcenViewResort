<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
    .dashboard-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
        gap: 25px;
        margin-bottom: 40px;
    }
    
    .stat-card {
        background: white;
        padding: 30px;
        border-radius: 12px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        border-top: 4px solid #3b82f6;
        transition: all 0.3s ease;
    }
    
    .stat-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
    }
    
    .stat-card.success {
        border-top-color: #10b981;
    }
    
    .stat-card.warning {
        border-top-color: #f59e0b;
    }
    
    .stat-card.danger {
        border-top-color: #ef4444;
    }
    
    .stat-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 15px;
    }
    
    .stat-title {
        font-size: 13px;
        color: #6b7280;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }
    
    .stat-icon {
        font-size: 24px;
        color: #3b82f6;
    }
    
    .stat-card.success .stat-icon {
        color: #10b981;
    }
    
    .stat-card.warning .stat-icon {
        color: #f59e0b;
    }
    
    .stat-card.danger .stat-icon {
        color: #ef4444;
    }
    
    .stat-value {
        font-size: 36px;
        font-weight: 700;
        color: #0f172a;
        margin: 10px 0;
    }
    
    .stat-footer {
        font-size: 12px;
        color: #9ca3af;
        margin-top: 10px;
    }
    
    .section {
        background: white;
        padding: 30px;
        border-radius: 12px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        margin-bottom: 30px;
    }
    
    .section-title {
        font-size: 20px;
        font-weight: 700;
        color: #0f172a;
        margin-bottom: 25px;
        display: flex;
        align-items: center;
        gap: 10px;
    }
    
    .section-title i {
        color: #3b82f6;
    }
    
    .data-table {
        width: 100%;
        border-collapse: collapse;
    }
    
    .data-table thead {
        background: #f9fafb;
    }
    
    .data-table th {
        padding: 15px;
        text-align: left;
        font-weight: 600;
        color: #374151;
        font-size: 13px;
        border-bottom: 2px solid #e5e7eb;
    }
    
    .data-table td {
        padding: 15px;
        border-bottom: 1px solid #f3f4f6;
        font-size: 14px;
    }
    
    .data-table tbody tr:hover {
        background: #f9fafb;
    }
    
    .badge {
        display: inline-block;
        padding: 6px 12px;
        border-radius: 20px;
        font-size: 12px;
        font-weight: 600;
    }
    
    .badge-success {
        background: #d1fae5;
        color: #065f46;
    }
    
    .badge-warning {
        background: #fef3c7;
        color: #92400e;
    }
    
    .badge-danger {
        background: #fee2e2;
        color: #991b1b;
    }
</style>

<div class="dashboard-grid">
    <!-- Total Staff -->
    <div class="stat-card">
        <div class="stat-header">
            <div class="stat-title">👔 Total Staff</div>
            <div class="stat-icon"><i class="fas fa-users"></i></div>
        </div>
        <div class="stat-value" id="totalStaff">0</div>
        <div class="stat-footer">Active staff members</div>
    </div>
    
    <!-- Total Customers -->
    <div class="stat-card success">
        <div class="stat-header">
            <div class="stat-title">👥 Total Customers</div>
            <div class="stat-icon"><i class="fas fa-user-friends"></i></div>
        </div>
        <div class="stat-value" id="totalCustomers">0</div>
        <div class="stat-footer">Registered customers</div>
    </div>
    
    <!-- Total Rooms -->
    <div class="stat-card warning">
        <div class="stat-header">
            <div class="stat-title">🚪 Total Rooms</div>
            <div class="stat-icon"><i class="fas fa-door-open"></i></div>
        </div>
        <div class="stat-value" id="totalRooms">0</div>
        <div class="stat-footer">Available rooms</div>
    </div>
    
    <!-- Active Reservations -->
    <div class="stat-card danger">
        <div class="stat-header">
            <div class="stat-title">📅 Active Reservations</div>
            <div class="stat-icon"><i class="fas fa-calendar-check"></i></div>
        </div>
        <div class="stat-value" id="activeReservations">0</div>
        <div class="stat-footer">Current bookings</div>
    </div>
</div>

<!-- Recent Staff -->
<div class="section">
    <div class="section-title">
        <i class="fas fa-history"></i>
        Recent Staff Members
    </div>
    <table class="data-table">
        <thead>
            <tr>
                <th>Staff ID</th>
                <th>Name</th>
                <th>Position</th>
                <th>Email</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody id="recentStaffTable">
            <tr>
                <td colspan="5" style="text-align: center; color: #999;">Loading...</td>
            </tr>
        </tbody>
    </table>
</div>

<script>
console.log('📊 Dashboard Page Loaded');

// Load dashboard data
function loadDashboardData() {
    console.log('📥 Loading dashboard data...');
    
    // Load staff count
    $.ajax({
        url: 'staff?action=getAll',
        type: 'GET',
        dataType: 'json',
        success: function(data) {
            console.log('✅ Staff data loaded:', data.length);
            
            // Update total staff
            document.getElementById('totalStaff').textContent = data.length;
            
            // Display recent staff (last 5)
            displayRecentStaff(data.slice(0, 5));
        }
    });
    
    // Mock data for other stats
    document.getElementById('totalCustomers').textContent = '0';
    document.getElementById('totalRooms').textContent = '0';
    document.getElementById('activeReservations').textContent = '0';
}

// Display recent staff
function displayRecentStaff(staff) {
    const tbody = document.getElementById('recentStaffTable');
    
    if (staff.length === 0) {
        tbody.innerHTML = '<tr><td colspan="5" style="text-align: center; color: #999;">No staff members yet</td></tr>';
        return;
    }
    
    let html = '';
    for (let i = 0; i < staff.length; i++) {
        const s = staff[i];
        const badgeClass = (s.status === 'Active') ? 'success' : 'danger';
        
        html += '<tr>';
        html += '<td><strong>' + s.staff_id + '</strong></td>';
        html += '<td>' + s.firstName + ' ' + s.lastName + '</td>';
        html += '<td>' + s.position + '</td>';
        html += '<td>' + s.email + '</td>';
        html += '<td><span class="badge badge-' + badgeClass + '">' + s.status + '</span></td>';
        html += '</tr>';
    }
    
    tbody.innerHTML = html;
}

// Initialize
$(document).ready(function() {
    console.log('✅ Dashboard initialized');
    loadDashboardData();
});
</script>
