// ✅ DASHBOARD MANAGER - dashboard-manager.js

const DASH_BASE_URL = window.location.origin;
const DASH_CONTEXT_PATH = '/OceanViewResort';

let reservationChartInstance = null;
let occupancyChartInstance = null;
let paymentChartInstance = null;
let revenueChartInstance = null;

function loadDashboardStats() {
    console.log('📊 Loading dashboard stats...');
    
    const url = DASH_BASE_URL + DASH_CONTEXT_PATH + '/dashboard?action=getStats';
    
    fetch(url)
        .then(r => r.json())
        .then(data => {
            console.log('✅ Stats response:', data);
            if (data.success) {
                document.getElementById('totalReservations').textContent = data.totalReservations || 0;
                document.getElementById('confirmedReservations').textContent = data.confirmedReservations || 0;
                document.getElementById('totalUsers').textContent = data.totalUsers || 0;
                document.getElementById('totalRooms').textContent = data.totalRooms || 0;
                document.getElementById('availableRooms').textContent = data.availableRooms || 0;
                document.getElementById('totalStaff').textContent = data.totalStaff || 0;
                document.getElementById('totalRevenue').textContent = '' + (data.totalRevenue || 0).toFixed(2);
                document.getElementById('pendingPayments').textContent = data.pendingPayments || 0;
                console.log('✅ Stats loaded successfully');
            } else {
                console.error('❌ Stats error:', data.message);
            }
        })
        .catch(e => console.error('❌ Error loading stats:', e));
}

function loadReservationChart() {
    console.log('📊 Loading reservation chart...');
    
    const url = DASH_BASE_URL + DASH_CONTEXT_PATH + '/dashboard?action=getReservationChart';
    
    fetch(url)
        .then(r => r.json())
        .then(data => {
            console.log('✅ Reservation chart data:', data);
            if (data.success && data.labels && data.data) {
                const container = document.getElementById('reservationChartContainer');
                if (container) {
                    container.innerHTML = '<canvas id="reservationChart"></canvas>';
                    
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
            }
        })
        .catch(e => console.error('❌ Error loading reservation chart:', e));
}

function loadOccupancyChart() {
    console.log('📊 Loading occupancy chart...');
    
    const url = DASH_BASE_URL + DASH_CONTEXT_PATH + '/dashboard?action=getRoomOccupancy';
    
    fetch(url)
        .then(r => r.json())
        .then(data => {
            console.log('✅ Occupancy chart data:', data);
            if (data.success && data.labels && data.data) {
                const container = document.getElementById('occupancyChartContainer');
                if (container) {
                    container.innerHTML = '<canvas id="occupancyChart"></canvas>';
                    
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
            }
        })
        .catch(e => console.error('❌ Error loading occupancy chart:', e));
}

function loadPaymentChart() {
    console.log('📊 Loading payment chart...');
    
    const url = DASH_BASE_URL + DASH_CONTEXT_PATH + '/dashboard?action=getPaymentStatus';
    
    fetch(url)
        .then(r => r.json())
        .then(data => {
            console.log('✅ Payment chart data:', data);
            if (data.success && data.labels && data.data) {
                const container = document.getElementById('paymentChartContainer');
                if (container) {
                    container.innerHTML = '<canvas id="paymentChart"></canvas>';
                    
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
            }
        })
        .catch(e => console.error('❌ Error loading payment chart:', e));
}

function loadRevenueChart() {
    console.log('📊 Loading revenue chart...');
    
    const url = DASH_BASE_URL + DASH_CONTEXT_PATH + '/dashboard?action=getRevenueChart';
    
    fetch(url)
        .then(r => r.json())
        .then(data => {
            console.log('✅ Revenue chart data:', data);
            if (data.success && data.labels && data.data) {
                const container = document.getElementById('revenueChartContainer');
                if (container) {
                    container.innerHTML = '<canvas id="revenueChart"></canvas>';
                    
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
            }
        })
        .catch(e => console.error('❌ Error loading revenue chart:', e));
}

// ✅ THIS FUNCTION IS CALLED BY ADMIN DASHBOARD
function initDashboardPage() {
    console.log('🔧 Initializing Dashboard page...');
    
    // Load all data immediately
    loadDashboardStats();
    loadReservationChart();
    loadOccupancyChart();
    loadPaymentChart();
    loadRevenueChart();
    
    // Refresh every 30 seconds
    setInterval(() => {
        console.log('🔄 Refreshing dashboard data...');
        loadDashboardStats();
        loadReservationChart();
        loadOccupancyChart();
        loadPaymentChart();
        loadRevenueChart();
    }, 30000);
    
    console.log('✅ Dashboard page initialized');
}
