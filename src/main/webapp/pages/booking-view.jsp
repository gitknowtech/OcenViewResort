<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Booking View Section -->
<section class="section active">
    <div class="container">
        <h2 class="section-title">📅 MY BOOKINGS</h2>
        
        <div class="booking-view-container">
            <!-- Filters -->
            <div class="booking-filters">
                <button class="filter-btn active" data-filter="all">All Bookings</button>
                <button class="filter-btn" data-filter="confirmed">✅ Confirmed</button>
                <button class="filter-btn" data-filter="pending">⏳ Pending</button>
                <button class="filter-btn" data-filter="cancelled">❌ Cancelled</button>
            </div>

            <!-- Bookings List -->
            <div id="bookingsContainer" class="bookings-list">
                <div class="loading-message">
                    <i class="fas fa-spinner fa-spin"></i> Loading your bookings...
                </div>
            </div>

            <!-- Empty State -->
            <div id="emptyState" class="empty-state" style="display: none;">
                <div class="empty-state-icon">
                    <i class="fas fa-calendar-times"></i>
                </div>
                <h3>No Bookings Found</h3>
                <p>You haven't made any bookings yet.</p>
                <a href="#" class="btn btn-primary" onclick="loadPage('reservation')">
                    <i class="fas fa-plus"></i> Make Your First Booking
                </a>
            </div>
        </div>
    </div>
</section>

<!-- Booking Details Modal -->
<div id="bookingDetailsModal" class="booking-modal">
    <div id="bookingDetailsContent" class="booking-modal-content">
        <!-- Content will be loaded here -->
    </div>
</div>

<style>
/* ============================================
   BOOKING VIEW STYLES
   ============================================ */

.section-title {
    text-align: center;
    font-size: 2.5rem;
    color: #333;
    margin-bottom: 40px;
    font-weight: bold;
}

.booking-view-container {
    background: white;
    border-radius: 12px;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
    padding: 30px;
}

/* ============================================
   FILTERS
   ============================================ */

.booking-filters {
    display: flex;
    gap: 12px;
    margin-bottom: 30px;
    flex-wrap: wrap;
    justify-content: center;
}

.filter-btn {
    padding: 10px 20px;
    border: 2px solid #e5e7eb;
    background: white;
    border-radius: 25px;
    cursor: pointer;
    font-weight: 600;
    font-size: 14px;
    transition: all 0.3s ease;
    color: #666;
}

.filter-btn:hover {
    border-color: #007bff;
    color: #007bff;
    transform: translateY(-2px);
}

.filter-btn.active {
    background: linear-gradient(135deg, #007bff, #0056b3);
    color: white;
    border-color: #007bff;
    box-shadow: 0 4px 12px rgba(0, 123, 255, 0.3);
}

/* ============================================
   BOOKINGS LIST
   ============================================ */

.bookings-list {
    display: grid;
    gap: 20px;
}

.loading-message {
    text-align: center;
    padding: 40px 20px;
    color: #999;
    font-size: 16px;
}

.loading-message i {
    margin-right: 10px;
    color: #007bff;
}

/* ============================================
   BOOKING CARD
   ============================================ */

.booking-card {
    border: 2px solid #e5e7eb;
    border-radius: 12px;
    padding: 20px;
    transition: all 0.3s ease;
    background: white;
    display: grid;
    grid-template-columns: 1fr auto;
    gap: 20px;
    align-items: start;
}

.booking-card:hover {
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
    border-color: #007bff;
    transform: translateY(-2px);
}

.booking-card.confirmed {
    border-left: 5px solid #10b981;
}

.booking-card.pending {
    border-left: 5px solid #f59e0b;
}

.booking-card.cancelled {
    border-left: 5px solid #ef4444;
    opacity: 0.7;
}

/* Booking Info */
.booking-info {
    display: grid;
    gap: 15px;
}

.booking-header {
    display: flex;
    justify-content: space-between;
    align-items: start;
    gap: 15px;
}

.booking-id {
    font-size: 14px;
    color: #999;
    font-weight: 500;
}

.booking-status {
    display: inline-block;
    padding: 6px 12px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: 600;
    text-transform: uppercase;
}

.booking-status.confirmed {
    background: #d1fae5;
    color: #065f46;
}

.booking-status.pending {
    background: #fef3c7;
    color: #92400e;
}

.booking-status.cancelled {
    background: #fee2e2;
    color: #991b1b;
}

/* Booking Details Grid */
.booking-details {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 15px;
}

.booking-detail {
    display: flex;
    flex-direction: column;
}

.booking-detail-label {
    font-size: 12px;
    color: #999;
    font-weight: 600;
    text-transform: uppercase;
    margin-bottom: 4px;
}

.booking-detail-value {
    font-size: 16px;
    color: #333;
    font-weight: 600;
}

.booking-detail-value.highlight {
    color: #007bff;
    font-size: 18px;
}

.booking-detail-value.room-number {
    font-size: 20px;
    color: #10b981;
    font-weight: bold;
}

/* Booking Dates */
.booking-dates {
    display: grid;
    grid-template-columns: 1fr auto 1fr;
    gap: 10px;
    align-items: center;
    padding: 12px;
    background: #f8f9fa;
    border-radius: 8px;
}

.booking-date {
    display: flex;
    flex-direction: column;
}

.booking-date-label {
    font-size: 11px;
    color: #999;
    font-weight: 600;
    margin-bottom: 2px;
}

.booking-date-value {
    font-size: 14px;
    color: #333;
    font-weight: 600;
}

.booking-date-time {
    font-size: 12px;
    color: #666;
    margin-top: 2px;
}

.booking-date-arrow {
    text-align: center;
    color: #999;
    font-size: 18px;
}

/* Booking Summary */
.booking-summary {
    background: linear-gradient(135deg, #f0f9ff, #e0f2fe);
    padding: 15px;
    border-radius: 8px;
    border-left: 4px solid #007bff;
}

.booking-summary-row {
    display: flex;
    justify-content: space-between;
    padding: 6px 0;
    font-size: 14px;
}

.booking-summary-row-label {
    color: #666;
    font-weight: 500;
}

.booking-summary-row-value {
    color: #333;
    font-weight: 600;
}

.booking-summary-total {
    border-top: 2px solid rgba(0, 123, 255, 0.2);
    padding-top: 10px;
    margin-top: 10px;
    font-size: 16px;
    font-weight: bold;
    color: #007bff;
}

/* Booking Actions */
.booking-actions {
    display: flex;
    flex-direction: column;
    gap: 10px;
    min-width: 150px;
}

.booking-action-btn {
    padding: 10px 16px;
    border: none;
    border-radius: 8px;
    font-size: 13px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s ease;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 6px;
    text-decoration: none;
    white-space: nowrap;
}

.booking-action-btn i {
    font-size: 14px;
}

/* View Details Button */
.booking-action-btn.view {
    background: linear-gradient(135deg, #007bff, #0056b3);
    color: white;
}

.booking-action-btn.view:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0, 123, 255, 0.3);
}

/* Print Bill Button */
.booking-action-btn.print {
    background: linear-gradient(135deg, #10b981, #059669);
    color: white;
}

.booking-action-btn.print:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(16, 185, 129, 0.3);
}

/* Modify Button */
.booking-action-btn.modify {
    background: linear-gradient(135deg, #f59e0b, #d97706);
    color: white;
}

.booking-action-btn.modify:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(245, 158, 11, 0.3);
}

/* Cancel Button */
.booking-action-btn.cancel {
    background: linear-gradient(135deg, #ef4444, #dc2626);
    color: white;
}

.booking-action-btn.cancel:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
}

/* Disabled Button */
.booking-action-btn:disabled {
    background: #d1d5db;
    color: #9ca3af;
    cursor: not-allowed;
    transform: none;
}

/* ============================================
   BOOKING MODAL
   ============================================ */

.booking-modal {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0, 0, 0, 0.5);
    z-index: 1000;
    align-items: center;
    justify-content: center;
    padding: 20px;
}

.booking-modal-content {
    background: white;
    border-radius: 12px;
    max-width: 600px;
    width: 100%;
    max-height: 90vh;
    overflow-y: auto;
    box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
    animation: slideUp 0.3s ease;
}

@keyframes slideUp {
    from {
        transform: translateY(50px);
        opacity: 0;
    }
    to {
        transform: translateY(0);
        opacity: 1;
    }
}

.modal-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 20px;
    border-bottom: 2px solid #e5e7eb;
    background: linear-gradient(135deg, #007bff, #0056b3);
    color: white;
    border-radius: 12px 12px 0 0;
}

.modal-header h3 {
    font-size: 18px;
    font-weight: 600;
    margin: 0;
}

.modal-close {
    background: none;
    border: none;
    font-size: 24px;
    color: white;
    cursor: pointer;
    transition: all 0.3s ease;
    padding: 0;
    width: 32px;
    height: 32px;
    display: flex;
    align-items: center;
    justify-content: center;
}

.modal-close:hover {
    transform: rotate(90deg);
}

.modal-body {
    padding: 20px;
}

.details-section {
    margin-bottom: 20px;
    padding-bottom: 20px;
    border-bottom: 1px solid #e5e7eb;
}

.details-section:last-child {
    border-bottom: none;
}

.details-section h4 {
    font-size: 14px;
    font-weight: 600;
    color: #333;
    text-transform: uppercase;
    margin-bottom: 12px;
    color: #007bff;
}

.detail-row {
    display: flex;
    justify-content: space-between;
    padding: 8px 0;
    font-size: 14px;
    align-items: center;
}

.detail-label {
    color: #666;
    font-weight: 500;
}

.detail-value {
    color: #333;
    font-weight: 600;
}

.detail-total {
    background: #f0f9ff;
    padding: 12px;
    border-radius: 8px;
    margin-top: 8px;
    font-size: 16px;
    font-weight: bold;
    color: #007bff;
}

.booking-status-badge {
    display: inline-block;
    padding: 6px 12px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: 600;
    text-transform: uppercase;
}

.booking-status-badge.confirmed {
    background: #d1fae5;
    color: #065f46;
}

.booking-status-badge.pending {
    background: #fef3c7;
    color: #92400e;
}

.booking-status-badge.cancelled {
    background: #fee2e2;
    color: #991b1b;
}

.modal-footer {
    display: flex;
    gap: 10px;
    padding: 20px;
    border-top: 1px solid #e5e7eb;
    background: #f9f9f9;
    border-radius: 0 0 12px 12px;
}

.modal-footer .btn {
    flex: 1;
    padding: 10px 16px;
    border: none;
    border-radius: 8px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s ease;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
    font-size: 14px;
}

.btn-secondary {
    background: #e5e7eb;
    color: #333;
}

.btn-secondary:hover {
    background: #d1d5db;
    transform: translateY(-2px);
}

.btn-primary {
    background: linear-gradient(135deg, #10b981, #059669);
    color: white;
}

.btn-primary:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(16, 185, 129, 0.3);
}

/* ============================================
   EMPTY STATE
   ============================================ */

.empty-state {
    text-align: center;
    padding: 60px 20px;
}

.empty-state-icon {
    font-size: 64px;
    color: #d1d5db;
    margin-bottom: 20px;
}

.empty-state h3 {
    font-size: 24px;
    color: #333;
    margin-bottom: 10px;
    font-weight: 600;
}

.empty-state p {
    font-size: 16px;
    color: #999;
    margin-bottom: 30px;
}

.btn {
    display: inline-block;
    padding: 12px 24px;
    border-radius: 8px;
    font-weight: 600;
    text-decoration: none;
    transition: all 0.3s ease;
    border: none;
    cursor: pointer;
    font-size: 14px;
}

.btn-primary {
    background: linear-gradient(135deg, #10b981, #059669);
    color: white;
}

.btn-primary:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(16, 185, 129, 0.3);
}

/* ============================================
   SPECIAL REQUESTS
   ============================================ */

.booking-special-requests {
    background: #fef3c7;
    padding: 12px;
    border-radius: 8px;
    border-left: 4px solid #f59e0b;
    font-size: 13px;
    color: #92400e;
    margin-top: 10px;
}

.booking-special-requests-label {
    font-weight: 600;
    margin-bottom: 4px;
}

/* ============================================
   RESPONSIVE DESIGN
   ============================================ */

@media (max-width: 1024px) {
    .booking-card {
        grid-template-columns: 1fr;
    }
    
    .booking-actions {
        flex-direction: row;
        min-width: auto;
    }
}

@media (max-width: 768px) {
    .section-title {
        font-size: 2rem;
    }
    
    .booking-view-container {
        padding: 20px;
    }
    
    .booking-filters {
        gap: 8px;
    }
    
    .filter-btn {
        padding: 8px 16px;
        font-size: 12px;
    }
    
    .booking-details {
        grid-template-columns: repeat(2, 1fr);
    }
    
    .booking-dates {
        grid-template-columns: 1fr;
        gap: 8px;
    }
    
    .booking-date-arrow {
        display: none;
    }
    
    .booking-action-btn {
        padding: 8px 12px;
        font-size: 12px;
    }
    
    .booking-modal-content {
        max-width: 95%;
    }
    
    .modal-footer {
        flex-direction: column;
    }
    
    .detail-row {
        flex-direction: column;
        align-items: flex-start;
    }
}

@media (max-width: 480px) {
    .section-title {
        font-size: 1.5rem;
    }
    
    .booking-view-container {
        padding: 15px;
    }
    
    .booking-card {
        padding: 15px;
    }
    
    .booking-filters {
        gap: 6px;
    }
    
    .filter-btn {
        padding: 6px 12px;
        font-size: 11px;
    }
    
    .booking-details {
        grid-template-columns: 1fr;
    }
    
    .booking-detail-value {
        font-size: 14px;
    }
    
    .booking-action-btn {
        padding: 8px 10px;
        font-size: 11px;
    }
    
    .booking-actions {
        flex-direction: column;
    }
    
    .modal-header {
        padding: 15px;
    }
    
    .modal-header h3 {
        font-size: 16px;
    }
    
    .modal-body {
        padding: 15px;
    }
    
    .modal-footer {
        padding: 15px;
    }
}

/* ============================================
   PRINT STYLES
   ============================================ */

@media print {
    .booking-view-container {
        box-shadow: none;
        border: none;
    }
    
    .booking-filters {
        display: none;
    }
    
    .booking-actions {
        display: none;
    }
}
</style>

<!-- ✅ LOAD BOOKING VIEW JS -->
<script src="js/booking-view.js"></script>
