// ✅ USERS MANAGER - users-manager.js

const USERS_BASE_URL = window.location.origin;
const USERS_CONTEXT_PATH = '/OceanViewResort';

function showUsersMsg(text, type) {
    const msg = document.getElementById('msg');
    if (!msg) return;
    msg.textContent = text;
    msg.className = 'msg ' + type + ' show';
    setTimeout(() => msg.classList.remove('show'), 4000);
}

function loadUsers() {
    const url = USERS_BASE_URL + USERS_CONTEXT_PATH + '/users?action=getAll';
    console.log('📥 Loading users from:', url);
    
    fetch(url)
        .then(r => {
            console.log('Response status:', r.status);
            if (!r.ok) throw new Error('HTTP ' + r.status);
            return r.json();
        })
        .then(data => {
            console.log('✅ Users data:', data);
            let html = '';
            if (data && data.length > 0) {
                data.forEach(user => {
                    html += '<tr>';
                    html += '<td><strong>#' + user.id + '</strong></td>';
                    html += '<td>' + user.name + '</td>';
                    html += '<td>' + user.email + '</td>';
                    html += '<td>' + user.phone + '</td>';
                    html += '<td>' + (user.city || '-') + '</td>';
                    html += '<td><span class="badge badge-' + user.status + '">' + user.status.toUpperCase() + '</span></td>';
                    html += '<td>';
                    html += '<button class="btn btn-small btn-view" onclick="viewUser(' + user.id + ')" title="View"><i class="fas fa-eye"></i></button>';
                    html += '<button class="btn btn-small btn-edit" onclick="editUser(' + user.id + ')" title="Edit"><i class="fas fa-edit"></i></button>';
                    html += '<button class="btn btn-small btn-delete" onclick="deleteUser(' + user.id + ')" title="Delete"><i class="fas fa-trash"></i></button>';
                    html += '</td>';
                    html += '</tr>';
                });
            } else {
                html = '<tr><td colspan="7" style="text-align: center; padding: 40px;">No users found</td></tr>';
            }
            document.getElementById('usersTable').innerHTML = html;
        })
        .catch(e => {
            console.error('❌ Error loading users:', e);
            showUsersMsg('❌ Error loading users: ' + e.message, 'error');
            document.getElementById('usersTable').innerHTML = '<tr><td colspan="7" style="text-align: center; padding: 40px;">Error loading users</td></tr>';
        });
}

function viewUser(id) {
    console.log('👁️ Viewing user:', id);
    const url = USERS_BASE_URL + USERS_CONTEXT_PATH + '/users?action=getById&id=' + id;
    
    fetch(url)
        .then(r => r.json())
        .then(d => {
            if (d.success) {
                const u = d.user;
                alert('👤 USER DETAILS\n\nID: ' + u.id + '\nName: ' + u.name + '\nEmail: ' + u.email + '\nPhone: ' + u.phone + '\nAddress: ' + (u.address || 'N/A') + '\nCity: ' + (u.city || 'N/A') + '\nCountry: ' + (u.country || 'N/A') + '\nStatus: ' + u.status);
            } else {
                showUsersMsg('❌ Error loading user', 'error');
            }
        })
        .catch(e => {
            console.error('Error:', e);
            showUsersMsg('❌ Error: ' + e.message, 'error');
        });
}

function editUser(id) {
    console.log('✏️ Editing user:', id);
    const url = USERS_BASE_URL + USERS_CONTEXT_PATH + '/users?action=getById&id=' + id;
    
    fetch(url)
        .then(r => r.json())
        .then(d => {
            if (d.success) {
                const u = d.user;
                document.getElementById('userId').value = u.id;
                document.getElementById('mode').value = 'edit';
                document.getElementById('name').value = u.name;
                document.getElementById('email').value = u.email;
                document.getElementById('email').disabled = true;
                document.getElementById('phone').value = u.phone;
                document.getElementById('address').value = u.address || '';
                document.getElementById('city').value = u.city || '';
                document.getElementById('country').value = u.country || '';
                document.getElementById('status').value = u.status;
                document.getElementById('formTitle').textContent = '✏️ Edit - ' + u.name;
                document.getElementById('submitBtn').innerHTML = '<i class="fas fa-save"></i> Update User';
                showUsersMsg('📝 Editing: ' + u.name, 'success');
                document.querySelector('.card:last-child').scrollIntoView({ behavior: 'smooth' });
            } else {
                showUsersMsg('❌ Error loading user', 'error');
            }
        })
        .catch(e => {
            console.error('Error:', e);
            showUsersMsg('❌ Error: ' + e.message, 'error');
        });
}

function deleteUser(id) {
    if (!confirm('⚠️ Are you sure you want to delete this user?')) return;
    console.log('🗑️ Deleting user:', id);
    
    const params = new URLSearchParams();
    params.append('action', 'delete');
    params.append('id', id);
    
    const url = USERS_BASE_URL + USERS_CONTEXT_PATH + '/users';
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
                showUsersMsg('✅ User deleted successfully!', 'success');
                loadUsers();
            } else {
                showUsersMsg('❌ ' + (d.message || 'Error deleting'), 'error');
            }
        })
        .catch(e => {
            console.error('Error:', e);
            showUsersMsg('❌ Error deleting: ' + e.message, 'error');
        });
}

function submitUserForm() {
    const mode = document.getElementById('mode').value;
    const name = document.getElementById('name').value.trim();
    const email = document.getElementById('email').value.trim();
    const phone = document.getElementById('phone').value.trim();
    const address = document.getElementById('address').value.trim();
    const city = document.getElementById('city').value.trim();
    const country = document.getElementById('country').value.trim();
    const status = document.getElementById('status').value.trim();
    
    console.log('📝 Submitting form:', { mode, name, email, phone, status });
    
    if (!name || !email || !phone || !status) {
        showUsersMsg('❌ Name, Email, Phone, and Status are required', 'error');
        return;
    }
    
    const params = new URLSearchParams();
    params.append('action', mode === 'add' ? 'add' : 'update');
    params.append('name', name);
    params.append('email', email);
    params.append('phone', phone);
    params.append('address', address);
    params.append('city', city);
    params.append('country', country);
    params.append('status', status);
    if (mode === 'edit') params.append('id', document.getElementById('userId').value);
    
    const url = USERS_BASE_URL + USERS_CONTEXT_PATH + '/users';
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
                showUsersMsg('✅ ' + (d.message || 'Operation successful'), 'success');
                resetUserForm();
                loadUsers();
            } else {
                showUsersMsg('❌ ' + (d.message || 'Error'), 'error');
            }
        })
        .catch(e => {
            console.error('❌ Error:', e);
            showUsersMsg('❌ Error: ' + e.message, 'error');
        });
}

function resetUserForm() {
    document.getElementById('userId').value = '';
    document.getElementById('mode').value = 'add';
    document.getElementById('name').value = '';
    document.getElementById('email').value = '';
    document.getElementById('email').disabled = false;
    document.getElementById('phone').value = '';
    document.getElementById('address').value = '';
    document.getElementById('city').value = '';
    document.getElementById('country').value = '';
    document.getElementById('status').value = 'active';
    document.getElementById('formTitle').textContent = '➕ Add User';
    document.getElementById('submitBtn').innerHTML = '<i class="fas fa-save"></i> Add User';
    showUsersMsg('✅ Form cleared', 'success');
}

function initUsersPage() {
    console.log('🔧 Initializing Users page...');
    const submitBtn = document.getElementById('submitBtn');
    const resetBtn = document.getElementById('resetBtn');
    const searchInput = document.getElementById('search');
    
    if (submitBtn) submitBtn.addEventListener('click', submitUserForm);
    if (resetBtn) resetBtn.addEventListener('click', resetUserForm);
    if (searchInput) {
        searchInput.addEventListener('keyup', function() {
            const term = this.value.toLowerCase();
            const rows = document.querySelectorAll('#usersTable tr');
            rows.forEach(row => {
                if (!row) return;
                const text = row.textContent || '';
                row.style.display = text.toLowerCase().includes(term) ? '' : 'none';
            });
        });
    }
    
    console.log('✅ Users page initialized');
    loadUsers();
}
