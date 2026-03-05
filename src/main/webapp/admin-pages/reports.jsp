<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
    .reports-container {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: 25px;
    }
    
    .report-card {
        background: white;
        padding: 30px;
        border-radius: 12px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        border-top: 4px solid #3b82f6;
        transition: all 0.3s ease;
        cursor: pointer;
    }
    
    .report-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
    }
    
    .report-card.revenue { border-top-color: #10b981; }
    .report-card.occupancy { border-top-color: #f59e0b; }
    .report-card.guests { border-top-color: #3b82f6; }
    
    .report-icon {
        font-size: 36px;
        margin-bottom: 15px;
    }
    
    .report-title {
        font-size: 16px;
        font-weight: 700;
        color: #0f172a;
        margin-bottom: 10px;
    }
    
    .report-description {
        font-size: 13px;
        color: #6b7280;
        margin-bottom: 20px;
    }
    
    .report-btn {
        background: #3b82f6;
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 8px;
        cursor: pointer;
        font-weight: 600;
        font-size: 13px;
        transition: all 0.3s ease;
    }
    
    .report-btn:hover {
        background: #2563eb;
        transform: translateY(-2px);
    }
    
    .report-card.revenue .report-btn {
        background: #10b981;
    }
    
    .report-card.revenue .report-btn:hover {
        background: #059669;
    }
    
    .report-card.occupancy .report-btn {
        background: #f59e0b;
    }
    
    .report-card.occupancy .report-btn:hover {
        background: #d97706;
    }
</style>

<div class="reports-container">
    <div class="report-card revenue">
        <div class="report-icon">💰</div>
        <div class="report-title">Revenue Report</div>
        <div class="report-description">View detailed revenue analytics and financial performance</div>
        <button class="report-btn">Generate Report</button>
    </div>
    
    <div class="report-card occupancy">
        <div class="report-icon">📊</div>
        <div class="report-title">Occupancy Report</div>
        <div class="report-description">Check room occupancy rates and availability trends</div>
        <button class="report-btn">Generate Report</button>
    </div>
    
    <div class="report-card guests">
        <div class="report-icon">👥</div>
        <div class="report-title">Guest Report</div>
        <div class="report-description">Analyze guest statistics and booking patterns</div>
        <button class="report-btn">Generate Report</button>
    </div>
    
    <div class="report-card">
        <div class="report-icon">📈</div>
        <div class="report-title">Performance Report</div>
        <div class="report-description">Monitor overall business performance metrics</div>
        <button class="report-btn">Generate Report</button>
    </div>
</div>
