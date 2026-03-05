<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link href="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.js"></script>

<style>
    .dashboard-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 20px;
        margin-bottom: 30px;
    }
    
    .stat-card {
        background: white;
        border-radius: 12px;
        padding: 20px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        border-left: 4px solid #3b82f6;
        transition: all 0.3s ease;
    }
    
    .stat-card:hover {
        transform: translateY(-4px);
        box-shadow: 0 4px 16px rgba(0,0,0,0.12);
    }
    
    .stat-card.success { border-left-color: #10b981; }
    .stat-card.warning { border-left-color: #f59e0b; }
    .stat-card.danger { border-left-color: #ef4444; }
    .stat-card.info { border-left-color: #3b82f6; }
    
    .stat-icon {
        font-size: 32px;
        margin-bottom: 12px;
    }
    
    .stat-label {
        font-size: 12px;
        color: #9ca3af;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        margin-bottom: 8px;
    }
    
    .stat-value {
        font-size: 28px;
        font-weight: 700;
        color: #1f2937;
    }
    
    .stat-change {
        font-size: 12px;
        margin-top: 8px;
        color: #10b981;
    }
    
    .charts-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
        gap: 20px;
        margin-bottom: 30px;
    }
    
    .chart-card {
        background: white;
        border-radius: 12px;
        padding: 20px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.08);
    }
    
    .chart-title {
        font-size: 16px;
        font-weight: 700;
        color: #1f2937;
        margin-bottom: 20px;
        padding-bottom: 12px;
        border-bottom: 2px solid #f3f4f6;
    }
    
    .chart-container {
        position: relative;
        height: 300px;
    }
    
    .loading-spinner {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 300px;
        color: #9ca3af;
    }
    
    .spinner {
        border: 3px solid #e5e7eb;
        border-top: 3px solid #3b82f6;
        border-radius: 50%;
        width: 32px;
        height: 32px;
        animation: spin 0.8s linear infinite;
    }
    
    @keyframes spin {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
    }
    
    @media (max-width: 768px) {
        .dashboard-grid {
            grid-template-columns: 1fr;
        }
        
        .charts-grid {
            grid-template-columns: 1fr;
        }
    }
</style>

<!-- Stats Cards -->
<div class="dashboard-grid">
    <div class="stat-card info">
        <div class="stat-icon">📅</div>
        <div class="stat-label">Total Reservations</div>
        <div class="stat-value" id="totalReservations">0</div>
        <div class="stat-change">✅ All time</div>
    </div>
    
    <div class="stat-card success">
        <div class="stat-icon">✅</div>
        <div class="stat-label">Confirmed</div>
        <div class="stat-value" id="confirmedReservations">0</div>
        <div class="stat-change">📊 Active</div>
    </div>
    
    <div class="stat-card info">
        <div class="stat-icon">👥</div>
        <div class="stat-label">Total Customers</div>
        <div class="stat-value" id="totalUsers">0</div>
        <div class="stat-change">👤 Registered</div>
    </div>
    
    <div class="stat-card warning">
        <div class="stat-icon">🚪</div>
        <div class="stat-label">Total Rooms</div>
        <div class="stat-value" id="totalRooms">0</div>
        <div class="stat-change">📍 Available: <span id="availableRooms">0</span></div>
    </div>
    
    <div class="stat-card info">
        <div class="stat-icon">👔</div>
        <div class="stat-label">Staff Members</div>
        <div class="stat-value" id="totalStaff">0</div>
        <div class="stat-change">💼 Team</div>
    </div>
    
    <div class="stat-card success">
        <div class="stat-icon">💰</div>
        <div class="stat-label">Total Revenue</div>
        <div class="stat-value" id="totalRevenue">$0</div>
        <div class="stat-change">💵 Paid</div>
    </div>
    
    <div class="stat-card danger">
        <div class="stat-icon">⏳</div>
        <div class="stat-label">Pending Payments</div>
        <div class="stat-value" id="pendingPayments">0</div>
        <div class="stat-change">⚠️ Awaiting</div>
    </div>
</div>

<!-- Charts -->
<div class="charts-grid">
    <!-- Reservation Status Chart -->
    <div class="chart-card">
        <div class="chart-title">📊 Reservation Status</div>
        <div class="chart-container" id="reservationChartContainer">
            <div class="loading-spinner">
                <div class="spinner"></div>
            </div>
        </div>
        <canvas id="reservationChart" style="display:none;"></canvas>
    </div>
    
    <!-- Room Occupancy Chart -->
    <div class="chart-card">
        <div class="chart-title">🏨 Room Occupancy</div>
        <div class="chart-container" id="occupancyChartContainer">
            <div class="loading-spinner">
                <div class="spinner"></div>
            </div>
        </div>
        <canvas id="occupancyChart" style="display:none;"></canvas>
    </div>
    
    <!-- Payment Status Chart -->
    <div class="chart-card">
        <div class="chart-title">💳 Payment Status</div>
        <div class="chart-container" id="paymentChartContainer">
            <div class="loading-spinner">
                <div class="spinner"></div>
            </div>
        </div>
        <canvas id="paymentChart" style="display:none;"></canvas>
    </div>
    
    <!-- Revenue Chart -->
    <div class="chart-card">
        <div class="chart-title">📈 Revenue Trend (Last 7 Days)</div>
        <div class="chart-container" id="revenueChartContainer">
            <div class="loading-spinner">
                <div class="spinner"></div>
            </div>
        </div>
        <canvas id="revenueChart" style="display:none;"></canvas>
    </div>
</div>

<script>
    let reservationChartInstance = null;
    let occupancyChartInstance = null;
    let paymentChartInstance = null;
    let revenueChartInstance = null;

    function loadDashboardData() {
        console.log('📊 Loading dashboard data...');
        
        // Load stats
        fetch('/OceanViewResort/dashboard?action=getStats')
            .then(r => r.json())
            .then(data => {
                if (data.success) {
                    document.getElementById('totalReservations').textContent = data.totalReservations || 0;
                    document.getElementById('confirmedReservations').textContent = data.confirmedReservations || 0;
                    document.getElementById('totalUsers').textContent = data.totalUsers || 0;
                    document.getElementById('totalRooms').textContent = data.totalRooms || 0;
                    document.getElementById('availableRooms').textContent = data.availableRooms || 0;
                    document.getElementById('totalStaff').textContent = data.totalStaff || 0;
                    document.getElementById('totalRevenue').textContent = '$' + (data.totalRevenue || 0).toFixed(2);
                    document.getElementById('pendingPayments').textContent = data.pendingPayments || 0;
                    console.log('✅ Stats loaded');
                }
            })
            .catch(e => console.error('❌ Error loading stats:', e));
        
        // Load charts
        loadReservationChart();
        loadOccupancyChart();
        loadPaymentChart();
        loadRevenueChart();
    }

    function loadReservationChart() {
        fetch('/OceanViewResort/dashboard?action=getReservationChart')
            .then(r => r.json())
            .then(data => {
                if (data.success) {
                    document.getElementById('reservationChartContainer').innerHTML = '<canvas id="reservationChart"></canvas>';
                    
                    if (reservationChartInstance) reservationChartInstance.destroy();
                    
                    reservationChartInstance = new Chart(document.getElementById('reservationChart'), {
                        type: 'doughnut',
                        data: {
                            labels: data.labels,
                            datasets: [{
                                data: data.data,
                                backgroundColor: data.colors,
                                borderColor: '#fff',
                                borderWidth: 2
                            }]
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
                            plugins: {
                                legend: {
                                    position: 'bottom',
                                    labels: {
                                        padding: 15,
                                        font: { size: 12, weight: '600' }
                                    }
                                }
                            }
                        }
                    });
                    console.log('✅ Reservation chart loaded');
                }
            })
            .catch(e => console.error('❌ Error loading reservation chart:', e));
    }

    function loadOccupancyChart() {
        fetch('/OceanViewResort/dashboard?action=getRoomOccupancy')
            .then(r => r.json())
            .then(data => {
                if (data.success) {
                    document.getElementById('occupancyChartContainer').innerHTML = '<canvas id="occupancyChart"></canvas>';
                    
                    if (occupancyChartInstance) occupancyChartInstance.destroy();
                    
                    occupancyChartInstance = new Chart(document.getElementById('occupancyChart'), {
                        type: 'pie',
                        data: {
                            labels: data.labels,
                            datasets: [{
                                data: data.data,
                                backgroundColor: ['#10b981', '#ef4444'],
                                borderColor: '#fff',
                                borderWidth: 2
                            }]
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
                            plugins: {
                                legend: {
                                    position: 'bottom',
                                    labels: {
                                        padding: 15,
                                        font: { size: 12, weight: '600' }
                                    }
                                }
                            }
                        }
                    });
                    console.log('✅ Occupancy chart loaded');
                }
            })
            .catch(e => console.error('❌ Error loading occupancy chart:', e));
    }

    function loadPaymentChart() {
        fetch('/OceanViewResort/dashboard?action=getPaymentStatus')
            .then(r => r.json())
            .then(data => {
                if (data.success) {
                    document.getElementById('paymentChartContainer').innerHTML = '<canvas id="paymentChart"></canvas>';
                    
                    if (paymentChartInstance) paymentChartInstance.destroy();
                    
                    paymentChartInstance = new Chart(document.getElementById('paymentChart'), {
                        type: 'doughnut',
                        data: {
                            labels: data.labels,
                            datasets: [{
                                data: data.data,
                                backgroundColor: data.colors,
                                borderColor: '#fff',
                                borderWidth: 2
                            }]
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
                            plugins: {
                                legend: {
                                    position: 'bottom',
                                    labels: {
                                        padding: 15,
                                        font: { size: 12, weight: '600' }
                                    }
                                }
                            }
                        }
                    });
                    console.log('✅ Payment chart loaded');
                }
            })
            .catch(e => console.error('❌ Error loading payment chart:', e));
    }

    function loadRevenueChart() {
        fetch('/OceanViewResort/dashboard?action=getRevenueChart')
            .then(r => r.json())
            .then(data => {
                if (data.success) {
                    document.getElementById('revenueChartContainer').innerHTML = '<canvas id="revenueChart"></canvas>';
                    
                    if (revenueChartInstance) revenueChartInstance.destroy();
                    
                    revenueChartInstance = new Chart(document.getElementById('revenueChart'), {
                        type: 'line',
                        data: {
                            labels: data.labels,
                            datasets: [{
                                label: 'Revenue ($)',
                                data: data.data,
                                borderColor: '#3b82f6',
                                backgroundColor: 'rgba(59, 130, 246, 0.1)',
                                borderWidth: 2,
                                fill: true,
                                tension: 0.4,
                                pointRadius: 5,
                                pointBackgroundColor: '#3b82f6',
                                pointBorderColor: '#fff',
                                pointBorderWidth: 2
                            }]
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
                            plugins: {
                                legend: {
                                    labels: {
                                        padding: 15,
                                        font: { size: 12, weight: '600' }
                                    }
                                }
                            },
                            scales: {
                                y: {
                                    beginAtZero: true,
                                    ticks: {
                                        callback: function(value) {
                                            return '$' + value;
                                        }
                                    }
                                }
                            }
                        }
                    });
                    console.log('✅ Revenue chart loaded');
                }
            })
            .catch(e => console.error('❌ Error loading revenue chart:', e));
    }

    // ✅ THIS IS THE KEY - FUNCTION THAT ADMIN DASHBOARD WILL CALL
    function initDashboardPage() {
        console.log('🔧 Initializing Dashboard page...');
        loadDashboardData();
        // Refresh every 30 seconds
        setInterval(loadDashboardData, 30000);
    }
</script>
