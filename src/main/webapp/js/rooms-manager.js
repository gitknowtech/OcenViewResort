// ✅ ROOMS MANAGER - rooms-manager.js

const ROOMS_BASE_URL = window.location.origin;
const ROOMS_CONTEXT_PATH = '/OceanViewResort';

function showRoomsMsg(text, type) {
    const msg = document.getElementById('msg');
    if (!msg) return;
    msg.textContent = text;
    msg.className = 'msg ' + type + ' show';
    setTimeout(() => msg.classList.remove('show'), 4000);
}

function loadRooms() {
    const url = ROOMS_BASE_URL + ROOMS_CONTEXT_PATH + '/rooms?action=getAll';
    console.log('📥 Loading rooms from:', url);
    
    fetch(url)
        .then(r => {
            console.log('Response status:', r.status);
            if (!r.ok) throw new Error('HTTP ' + r.status);
            return r.json();
        })
        .then(data => {
            console.log('✅ Rooms data:', data);
            let html = '';
            if (data && data.length > 0) {
                data.forEach(room => {
                    html += '<tr>';
                    html += '<td><strong>#' + room.id + '</strong></td>';
                    html += '<td>' + room.room_number + '</td>';
                    html += '<td>' + room.room_type + '</td>';
                    html += '<td>' + room.capacity + '</td>';
                    html += '<td>' + room.room_price.toFixed(2) + '</td>';
                    html += '<td><span class="badge badge-' + room.status + '">' + room.status.toUpperCase() + '</span></td>';
                    html += '<td><span class="badge badge-' + room.maintenance + '">' + room.maintenance.toUpperCase() + '</span></td>';
                    html += '<td><span class="badge badge-' + room.booking_status + '">' + room.booking_status.toUpperCase() + '</span></td>';
                    html += '<td>';
                    html += '<button class="btn btn-small btn-view" onclick="viewRoom(' + room.id + ')" title="View"><i class="fas fa-eye"></i></button>';
                    html += '<button class="btn btn-small btn-edit" onclick="editRoom(' + room.id + ')" title="Edit"><i class="fas fa-edit"></i></button>';
                    html += '<button class="btn btn-small btn-delete" onclick="deleteRoom(' + room.id + ')" title="Delete"><i class="fas fa-trash"></i></button>';
                    html += '</td>';
                    html += '</tr>';
                });
            } else {
                html = '<tr><td colspan="9" style="text-align: center; padding: 40px;">No rooms found</td></tr>';
            }
            document.getElementById('roomsTable').innerHTML = html;
        })
        .catch(e => {
            console.error('❌ Error loading rooms:', e);
            showRoomsMsg('❌ Error loading rooms: ' + e.message, 'error');
            document.getElementById('roomsTable').innerHTML = '<tr><td colspan="9" style="text-align: center; padding: 40px;">Error loading rooms</td></tr>';
        });
}

function viewRoom(id) {
    console.log('👁️ Viewing room:', id);
    const url = ROOMS_BASE_URL + ROOMS_CONTEXT_PATH + '/rooms?action=getById&id=' + id;
    
    fetch(url)
        .then(r => r.json())
        .then(d => {
            if (d.success) {
                const room = d.room;
                alert('🚪 ROOM DETAILS\n\nID: ' + room.id + '\nRoom #: ' + room.room_number + '\nType: ' + room.room_type + '\nCapacity: ' + room.capacity + '\nPrice: $' + room.room_price + '\nStatus: ' + room.status + '\nMaintenance: ' + room.maintenance + '\nBooking: ' + room.booking_status + '\nDescription: ' + (room.description || 'N/A'));
            } else {
                showRoomsMsg('❌ Error loading room', 'error');
            }
        })
        .catch(e => {
            console.error('Error:', e);
            showRoomsMsg('❌ Error: ' + e.message, 'error');
        });
}

function editRoom(id) {
    console.log('✏️ Editing room:', id);
    const url = ROOMS_BASE_URL + ROOMS_CONTEXT_PATH + '/rooms?action=getById&id=' + id;
    
    fetch(url)
        .then(r => r.json())
        .then(d => {
            if (d.success) {
                const room = d.room;
                document.getElementById('roomId').value = room.id;
                document.getElementById('mode').value = 'edit';
                document.getElementById('room_number').value = room.room_number;
                document.getElementById('room_number').disabled = true;
                document.getElementById('room_type').value = room.room_type;
                document.getElementById('capacity').value = room.capacity;
                document.getElementById('room_price').value = room.room_price;
                document.getElementById('status').value = room.status;
                document.getElementById('maintenance').value = room.maintenance;
                document.getElementById('booking_status').value = room.booking_status;
                document.getElementById('description').value = room.description || '';
                document.getElementById('formTitle').textContent = '✏️ Edit - Room ' + room.room_number;
                document.getElementById('submitBtn').innerHTML = '<i class="fas fa-save"></i> Update Room';
                showRoomsMsg('📝 Editing: Room ' + room.room_number, 'success');
                document.querySelector('.card:last-child').scrollIntoView({ behavior: 'smooth' });
            } else {
                showRoomsMsg('❌ Error loading room', 'error');
            }
        })
        .catch(e => {
            console.error('Error:', e);
            showRoomsMsg('❌ Error: ' + e.message, 'error');
        });
}

function deleteRoom(id) {
    if (!confirm('⚠️ Are you sure you want to delete this room?')) return;
    console.log('🗑️ Deleting room:', id);
    
    const params = new URLSearchParams();
    params.append('action', 'delete');
    params.append('id', id);
    
    const url = ROOMS_BASE_URL + ROOMS_CONTEXT_PATH + '/rooms';
    console.log('📤 Sending DELETE to:', url);
    
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
                showRoomsMsg('✅ Room deleted successfully!', 'success');
                loadRooms();
            } else {
                showRoomsMsg('❌ ' + (d.message || 'Error deleting'), 'error');
            }
        })
        .catch(e => {
            console.error('Error:', e);
            showRoomsMsg('❌ Error deleting: ' + e.message, 'error');
        });
}

function submitRoomForm() {
    const mode = document.getElementById('mode').value;
    const room_number = document.getElementById('room_number').value.trim();
    const room_type = document.getElementById('room_type').value.trim();
    const capacity = document.getElementById('capacity').value.trim();
    const room_price = document.getElementById('room_price').value.trim();
    const status = document.getElementById('status').value.trim();
    const maintenance = document.getElementById('maintenance').value.trim();
    const booking_status = document.getElementById('booking_status').value.trim();
    const description = document.getElementById('description').value.trim();
    
    console.log('📝 Submitting form:', { mode, room_number, room_type, capacity, room_price, status, maintenance, booking_status });
    
    if (!room_number || !room_type || !capacity || !room_price || !status || !maintenance || !booking_status) {
        showRoomsMsg('❌ All fields required', 'error');
        return;
    }
    
    const params = new URLSearchParams();
    params.append('action', mode === 'add' ? 'add' : 'update');
    params.append('room_number', room_number);
    params.append('room_type', room_type);
    params.append('capacity', capacity);
    params.append('room_price', room_price);
    params.append('status', status);
    params.append('maintenance', maintenance);
    params.append('booking_status', booking_status);
    params.append('description', description);
    if (mode === 'edit') params.append('id', document.getElementById('roomId').value);
    
    const url = ROOMS_BASE_URL + ROOMS_CONTEXT_PATH + '/rooms';
    console.log('📤 Sending to:', url);
    
    fetch(url, { 
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: params.toString()
    })
        .then(r => {
            console.log('Response status:', r.status);
            return r.json();
        })
        .then(d => {
            console.log('✅ Response:', d);
            if (d.success) {
                showRoomsMsg('✅ ' + (d.message || 'Operation successful'), 'success');
                resetRoomForm();
                loadRooms();
            } else {
                showRoomsMsg('❌ ' + (d.message || 'Error'), 'error');
            }
        })
        .catch(e => {
            console.error('❌ Error:', e);
            showRoomsMsg('❌ Error: ' + e.message, 'error');
        });
}

function resetRoomForm() {
    document.getElementById('roomId').value = '';
    document.getElementById('mode').value = 'add';
    document.getElementById('room_number').value = '';
    document.getElementById('room_number').disabled = false;
    document.getElementById('room_type').value = '';
    document.getElementById('capacity').value = '';
    document.getElementById('room_price').value = '';
    document.getElementById('status').value = 'active';
    document.getElementById('maintenance').value = 'non-maintenance';
    document.getElementById('booking_status').value = 'non-booked';
    document.getElementById('description').value = '';
    document.getElementById('formTitle').textContent = '➕ Add Room';
    document.getElementById('submitBtn').innerHTML = '<i class="fas fa-save"></i> Add Room';
    showRoomsMsg('✅ Form cleared', 'success');
}

function initRoomsPage() {
    console.log('🔧 Initializing Rooms page...');
    const submitBtn = document.getElementById('submitBtn');
    const resetBtn = document.getElementById('resetBtn');
    const searchInput = document.getElementById('search');
    
    if (submitBtn) submitBtn.addEventListener('click', submitRoomForm);
    if (resetBtn) resetBtn.addEventListener('click', resetRoomForm);
    if (searchInput) {
        searchInput.addEventListener('keyup', function() {
            const term = this.value.toLowerCase();
            const rows = document.querySelectorAll('#roomsTable tr');
            rows.forEach(row => {
                if (!row) return;
                const text = row.textContent || '';
                row.style.display = text.toLowerCase().includes(term) ? '' : 'none';
            });
        });
    }
    
    console.log('✅ Rooms page initialized');
    loadRooms();
}
