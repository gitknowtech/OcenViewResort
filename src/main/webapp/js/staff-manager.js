// ✅ STAFF MANAGER - staff-manager.js

// Get the base URL dynamically
const BASE_URL = window.location.origin;
const CONTEXT_PATH = '/OceanViewResort'; // Change if your project name is different

function showMsg(text, type) {
    const msg = document.getElementById('msg');
    if (!msg) return;
    msg.textContent = text;
    msg.className = 'msg ' + type + ' show';
    setTimeout(() => msg.classList.remove('show'), 4000);
}

function loadStaff() {
    const url = BASE_URL + CONTEXT_PATH + '/staff?action=getAll';
    console.log('📥 Loading staff from:', url);
    
    fetch(url)
        .then(r => {
            console.log('Response status:', r.status);
            if (!r.ok) throw new Error('HTTP ' + r.status);
            return r.json();
        })
        .then(data => {
            console.log('✅ Staff data:', data);
            let html = '';
            if (data && data.length > 0) {
                data.forEach(s => {
                    html += '<tr>';
                    html += '<td><strong>#' + s.id + '</strong></td>';
                    html += '<td>' + s.name + '</td>';
                    html += '<td>' + s.email + '</td>';
                    html += '<td>' + s.phone + '</td>';
                    html += '<td>';
                    html += '<button class="btn btn-small btn-view" onclick="viewStaff(' + s.id + ')" title="View"><i class="fas fa-eye"></i></button>';
                    html += '<button class="btn btn-small btn-edit" onclick="editStaff(' + s.id + ')" title="Edit"><i class="fas fa-edit"></i></button>';
                    html += '<button class="btn btn-small btn-delete" onclick="deleteStaff(' + s.id + ')" title="Delete"><i class="fas fa-trash"></i></button>';
                    html += '</td>';
                    html += '</tr>';
                });
            } else {
                html = '<tr><td colspan="5" style="text-align: center; padding: 40px;">No staff members</td></tr>';
            }
            document.getElementById('staffTable').innerHTML = html;
        })
        .catch(e => {
            console.error('❌ Error loading staff:', e);
            showMsg('❌ Error loading staff: ' + e.message, 'error');
            document.getElementById('staffTable').innerHTML = '<tr><td colspan="5" style="text-align: center; padding: 40px;">Error loading staff</td></tr>';
        });
}

function viewStaff(id) {
    console.log('👁️ Viewing staff:', id);
    const url = BASE_URL + CONTEXT_PATH + '/staff?action=getById&id=' + id;
    
    fetch(url)
        .then(r => r.json())
        .then(d => {
            if (d.success) {
                const s = d.staff;
                alert('👤 STAFF DETAILS\n\nID: ' + s.id + '\nName: ' + s.name + '\nUsername: ' + s.username + '\nEmail: ' + s.email + '\nPhone: ' + s.phone);
            } else {
                showMsg('❌ Error loading staff', 'error');
            }
        })
        .catch(e => {
            console.error('Error:', e);
            showMsg('❌ Error: ' + e.message, 'error');
        });
}

function editStaff(id) {
    console.log('✏️ Editing staff:', id);
    const url = BASE_URL + CONTEXT_PATH + '/staff?action=getById&id=' + id;
    
    fetch(url)
        .then(r => r.json())
        .then(d => {
            if (d.success) {
                const s = d.staff;
                document.getElementById('staffId').value = s.id;
                document.getElementById('mode').value = 'edit';
                document.getElementById('name').value = s.name;
                document.getElementById('username').value = s.username;
                document.getElementById('username').disabled = true;
                document.getElementById('email').value = s.email;
                document.getElementById('phone').value = s.phone;
                document.getElementById('password').value = '';
                document.getElementById('password').required = false;
                document.getElementById('password').placeholder = 'Leave empty to keep current password';
                document.getElementById('formTitle').textContent = '✏️ Edit - ' + s.name;
                document.getElementById('submitBtn').innerHTML = '<i class="fas fa-save"></i> Update Staff';
                showMsg('📝 Editing: ' + s.name, 'success');
                document.querySelector('.card:last-child').scrollIntoView({ behavior: 'smooth' });
            } else {
                showMsg('❌ Error loading staff', 'error');
            }
        })
        .catch(e => {
            console.error('Error:', e);
            showMsg('❌ Error: ' + e.message, 'error');
        });
}

function deleteStaff(id) {
    if (!confirm('⚠️ Are you sure you want to delete this staff member?')) return;
    console.log('🗑️ Deleting staff:', id);
    
    const params = new URLSearchParams();
    params.append('action', 'delete');
    params.append('id', id);
    
    const url = BASE_URL + CONTEXT_PATH + '/staff';
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
                showMsg('✅ Staff deleted successfully!', 'success');
                loadStaff();
            } else {
                showMsg('❌ ' + (d.message || 'Error deleting'), 'error');
            }
        })
        .catch(e => {
            console.error('Error:', e);
            showMsg('❌ Error deleting: ' + e.message, 'error');
        });
}

function submitForm() {
    const mode = document.getElementById('mode').value;
    const name = document.getElementById('name').value.trim();
    const username = document.getElementById('username').value.trim();
    const email = document.getElementById('email').value.trim();
    const password = document.getElementById('password').value.trim();
    const phone = document.getElementById('phone').value.trim();
    
    console.log('📝 Submitting form:', { mode, name, username, email, phone });
    
    if (!name || !username || !email || !phone) {
        showMsg('❌ All fields required', 'error');
        return;
    }
    if (mode === 'add' && !password) {
        showMsg('❌ Password required for new staff', 'error');
        return;
    }
    
    const params = new URLSearchParams();
    params.append('action', mode === 'add' ? 'add' : 'update');
    params.append('name', name);
    params.append('username', username);
    params.append('email', email);
    params.append('phone', phone);
    if (mode === 'add' || password) params.append('password', password);
    if (mode === 'edit') params.append('id', document.getElementById('staffId').value);
    
    const url = BASE_URL + CONTEXT_PATH + '/staff';
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
                showMsg('✅ ' + (d.message || 'Operation successful'), 'success');
                resetForm();
                loadStaff();
            } else {
                showMsg('❌ ' + (d.message || 'Error'), 'error');
            }
        })
        .catch(e => {
            console.error('❌ Error:', e);
            showMsg('❌ Error: ' + e.message, 'error');
        });
}

function resetForm() {
    document.getElementById('staffId').value = '';
    document.getElementById('mode').value = 'add';
    document.getElementById('name').value = '';
    document.getElementById('username').value = '';
    document.getElementById('username').disabled = false;
    document.getElementById('email').value = '';
    document.getElementById('phone').value = '';
    document.getElementById('password').value = '';
    document.getElementById('password').required = true;
    document.getElementById('password').placeholder = 'Password';
    document.getElementById('formTitle').textContent = '➕ Add Staff';
    document.getElementById('submitBtn').innerHTML = '<i class="fas fa-save"></i> Add Staff';
    showMsg('✅ Form cleared', 'success');
}

function initStaffPage() {
    console.log('🔧 Initializing Staff page...');
    const submitBtn = document.getElementById('submitBtn');
    const resetBtn = document.getElementById('resetBtn');
    const searchInput = document.getElementById('search');
    
    if (submitBtn) submitBtn.addEventListener('click', submitForm);
    if (resetBtn) resetBtn.addEventListener('click', resetForm);
    if (searchInput) {
        searchInput.addEventListener('keyup', function() {
            const term = this.value.toLowerCase();
            const rows = document.querySelectorAll('#staffTable tr');
            rows.forEach(row => {
                if (!row) return;
                const text = row.textContent || '';
                row.style.display = text.toLowerCase().includes(term) ? '' : 'none';
            });
        });
    }
    
    console.log('✅ Staff page initialized');
    loadStaff();
}
