import { useState } from 'react';
import { useQuery, useQueryClient } from '@tanstack/react-query';
import toast from 'react-hot-toast';
import api from '../api/axios.js';
import Modal from '../components/Modal.jsx';
import Pagination from '../components/Pagination.jsx';

const emptyStaff = { name: '', email: '', phone_number: '', password: '', roleId: '' };

export default function StaffManagement() {
  const qc = useQueryClient();
  const [page, setPage] = useState(1);
  const [modal, setModal] = useState(null);
  const [form, setForm] = useState(emptyStaff);

  const staffQ = useQuery({
    queryKey: ['staff', page],
    queryFn: () => api.get(`/staff?page=${page}`).then((r) => r.data),
  });

  const rolesQ = useQuery({
    queryKey: ['roles'],
    queryFn: () => api.get('/settings/roles').then((r) => r.data.data),
  });

  const staff = staffQ.data?.data ?? [];
  const meta = staffQ.data?.meta;
  const roles = rolesQ.data ?? [];

  const save = async () => {
    try {
      if (modal.type === 'create') await api.post('/staff', form);
      else await api.put(`/staff/${modal.id}`, form);
      qc.invalidateQueries({ queryKey: ['staff'] });
      toast.success(modal.type === 'create' ? 'Staff member added!' : 'Staff member updated!');
      setModal(null);
    } catch (e) { toast.error(e.response?.data?.message || 'Error'); }
  };

  const handleDelete = async (id) => {
    if (!confirm('Delete this staff member?')) return;
    try {
      await api.delete(`/staff/${id}`);
      qc.invalidateQueries({ queryKey: ['staff'] });
      toast.success('Deleted');
    } catch (e) { toast.error(e.response?.data?.message || 'Error'); }
  };

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <h1 className="text-2xl font-bold text-gray-900">Staff Management</h1>
        <button onClick={() => { setForm(emptyStaff); setModal({ type: 'create' }); }} className="btn-primary">+ Add Staff</button>
      </div>

      <div className="card overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full">
            <thead className="bg-gray-50 border-b border-gray-200">
              <tr>
                <th className="table-header">Name</th>
                <th className="table-header">Email</th>
                <th className="table-header">Phone</th>
                <th className="table-header">Role</th>
                <th className="table-header">Joined</th>
                <th className="table-header">Actions</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-100">
              {staffQ.isLoading ? (
                <tr><td colSpan={6} className="table-cell text-center py-10 text-gray-400">Loading…</td></tr>
              ) : staff.length === 0 ? (
                <tr><td colSpan={6} className="table-cell text-center py-10 text-gray-400">No staff found</td></tr>
              ) : staff.map((s) => (
                <tr key={s.id} className="hover:bg-gray-50">
                  <td className="table-cell font-medium">
                    <div className="flex items-center gap-2">
                      <div className="w-7 h-7 rounded-full bg-blue-100 text-blue-600 flex items-center justify-center text-xs font-bold uppercase">
                        {s.name[0]}
                      </div>
                      {s.name}
                    </div>
                  </td>
                  <td className="table-cell text-gray-500">{s.email}</td>
                  <td className="table-cell text-gray-500">{s.phoneNumber ?? '—'}</td>
                  <td className="table-cell">
                    <span className="badge-blue">{s.modelHasRoles?.[0]?.role?.displayName ?? '—'}</span>
                  </td>
                  <td className="table-cell text-gray-500 text-xs">{new Date(s.createdAt).toLocaleDateString()}</td>
                  <td className="table-cell">
                    <div className="flex gap-2">
                      <button onClick={() => { setForm({ name: s.name, email: s.email, phone_number: s.phoneNumber, roleId: s.modelHasRoles?.[0]?.roleId ?? '', password: '' }); setModal({ type: 'edit', id: s.id }); }} className="text-blue-600 hover:underline text-xs">Edit</button>
                      <button onClick={() => handleDelete(s.id)} className="text-red-600 hover:underline text-xs">Delete</button>
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
        {meta && <Pagination page={page} lastPage={meta.last_page} total={meta.total} perPage={meta.per_page} onPageChange={setPage} />}
      </div>

      <Modal open={!!modal} onClose={() => setModal(null)} title={`${modal?.type === 'create' ? 'Add' : 'Edit'} Staff Member`}>
        <div className="space-y-4">
          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className="form-label">Name *</label>
              <input className="form-input" value={form.name} onChange={(e) => setForm((f) => ({ ...f, name: e.target.value }))} />
            </div>
            <div>
              <label className="form-label">Email *</label>
              <input type="email" className="form-input" value={form.email} onChange={(e) => setForm((f) => ({ ...f, email: e.target.value }))} />
            </div>
          </div>
          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className="form-label">Phone</label>
              <input className="form-input" value={form.phone_number} onChange={(e) => setForm((f) => ({ ...f, phone_number: e.target.value }))} />
            </div>
            <div>
              <label className="form-label">Role *</label>
              <select className="form-input" value={form.roleId} onChange={(e) => setForm((f) => ({ ...f, roleId: e.target.value }))}>
                <option value="">Select role</option>
                {roles.map((r) => <option key={r.id} value={r.id}>{r.displayName}</option>)}
              </select>
            </div>
          </div>
          <div>
            <label className="form-label">{modal?.type === 'create' ? 'Password *' : 'New Password (leave blank to keep)'}</label>
            <input type="password" className="form-input" value={form.password} onChange={(e) => setForm((f) => ({ ...f, password: e.target.value }))} />
          </div>
        </div>
        <div className="flex justify-end gap-3 mt-6">
          <button onClick={() => setModal(null)} className="btn-secondary">Cancel</button>
          <button onClick={save} className="btn-primary">Save</button>
        </div>
      </Modal>
    </div>
  );
}
