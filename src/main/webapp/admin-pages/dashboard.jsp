<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
    .grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 25px; margin-bottom: 40px; }
    .card { background: white; padding: 30px; border-radius: 12px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); border-top: 4px solid #3b82f6; }
    .card.success { border-top-color: #10b981; }
    .card.warning { border-top-color: #f59e0b; }
    .card.danger { border-top-color: #ef4444; }
    .stat-title { font-size: 13px; color: #6b7280; font-weight: 600; text-transform: uppercase; }
    .stat-value { font-size: 36px; font-weight: 700; color: #0f172a; margin: 10px 0; }
    .stat-footer { font-size: 12px; color: #9ca3af; }
</style>

<div class="grid">
    <div class="card">
        <div class="stat-title">👔 Total Staff</div>
        <div class="stat-value">24</div>
        <div class="stat-footer">Active staff members</div>
    </div>
    
    <div class="card success">
        <div class="stat-title">👥 Total Customers</div>
        <div class="stat-value">156</div>
        <div class="stat-footer">Registered customers</div>
    </div>
    
    <div class="card warning">
        <div class="stat-title">🚪 Total Rooms</div>
        <div class="stat-value">48</div>
        <div class="stat-footer">Available rooms</div>
    </div>
    
    <div class="card danger">
        <div class="stat-title">📅 Reservations</div>
        <div class="stat-value">18</div>
        <div class="stat-footer">Active bookings</div>
    </div>
</div>
