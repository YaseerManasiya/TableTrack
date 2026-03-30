import { useState } from 'react';
import { useQuery, useQueryClient } from '@tanstack/react-query';
import toast from 'react-hot-toast';
import api from '../api/axios.js';
import Modal from '../components/Modal.jsx';
import Pagination from '../components/Pagination.jsx';

const STATUSES = ['pending', 'confirmed', 'cancelled', 'completed'];
const STATUS_COLORS = {
  pending: 'badge-yellow',
  confirmed: 'badge-blue',
  completed: 'badge-green',
  cancelled: 'badge-red',
};

const empty = { tableId: '', customerName: '', customerPhone: '', partySize: 2, reservedAt: '', status: 'pending', notes: '' };

export default function Reservations() {
  const qc = useQueryClient();
  const [page, setPage] = useState(1);
  const [modal, setModal] = useState(null);
  const [form, setForm] = useState(empty);
  const [statusFilter, setStatusFilter] = useState('');

  const reservationsQ = useQuery({
    queryKey: ['reservations', page, statusFilter],
    queryFn: () => api.get(`/reservations?page=${page}${statusFilter ? `&status=${statusFilter}` : ''}`).then((r) => r.data),
  });
  const tablesQ = useQuery({ queryKey: ['tables-list'], queryFn: () => api.get('/tables?per_page=100').then((r) => r.data.data) });

  const reservations = reservationsQ.data?.data ?? [];
  const meta = reservationsQ.data?.meta;
  const tables = tablesQ.data ?? [];

  const save = async () => {
    try {
      if (modal.type === 'create') await api.post('/reservations', form);
      else await api.put(`/reservations/${modal.id}`, form);
      qc.invalidateQueries({ queryKey: ['reservations'] });
      toast.success(modal.type === 'create' ? 'Reservation created!' : 'Updated!');
      setModal(null);
    } catch (e) { toast.error(e.response?.data?.message || 'Error'); }
  };

  const handleDelete = async (id) => {
    if (!confirm('Delete this reservation?')) return;
    try {
      await api.delete(`/reservations/${id}`);
      qc.invalidateQueries({ queryKey: ['reservations'] });
      toast.success('Deleted');
    } catch (e) { toast.error(e.response?.data?.message || 'Error'); }
  };

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <h1 className="text-2xl font-bold text-gray-900">Reservations</h1>
        <button onClick={() => { setForm(empty); setModal({ type: 'create' }); }} className="btn-primary">+ New Reservation</button>
      </div>

      <div className="flex gap-2 flex-wrap">
        {['', ...STATUSES].map((s) => (
          <button key={s} onClick={() => { setStatusFilter(s); setPage(1); }} className={`px-3 py-1.5 rounded-lg text-sm font-medium capitalize transition-colors ${statusFilter === s ? 'bg-blue-600 text-white' : 'bg-white border border-gray-200 text-gray-700 hover:bg-gray-50'}`}>
            {s === '' ? 'All' : s}
          </button>
        ))}
      </div>

      <div className="card overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full">
            <thead className="bg-gray-50 border-b border-gray-200">
              <tr>
                <th className="table-header">Customer</th>
                <th className="table-header">Phone</th>
                <th className="table-header">Table</th>
                <th className="table-header">Party Size</th>
                <th className="table-header">Reserved At</th>
                <th className="table-header">Status</th>
                <th className="table-header">Actions</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-100">
              {reservationsQ.isLoading ? (
                <tr><td colSpan={7} className="table-cell text-center py-10 text-gray-400">Loading…</td></tr>
              ) : reservations.length === 0 ? (
                <tr><td colSpan={7} className="table-cell text-center py-10 text-gray-400">No reservations found</td></tr>
              ) : reservations.map((r) => (
                <tr key={r.id} className="hover:bg-gray-50">
                  <td className="table-cell font-medium">{r.customerName}</td>
                  <td className="table-cell text-gray-500">{r.customerPhone ?? '—'}</td>
                  <td className="table-cell">{r.table?.tableName ?? '—'}</td>
                  <td className="table-cell">{r.partySize}</td>
                  <td className="table-cell text-gray-500 text-xs">{new Date(r.reservedAt).toLocaleString()}</td>
                  <td className="table-cell"><span className={STATUS_COLORS[r.status] || 'badge-gray'}>{r.status}</span></td>
                  <td className="table-cell">
                    <div className="flex gap-2">
                      <button onClick={() => { setForm({ tableId: r.tableId ?? '', customerName: r.customerName, customerPhone: r.customerPhone ?? '', partySize: r.partySize, reservedAt: new Date(r.reservedAt).toISOString().slice(0, 16), status: r.status, notes: r.notes ?? '' }); setModal({ type: 'edit', id: r.id }); }} className="text-blue-600 hover:underline text-xs">Edit</button>
                      <button onClick={() => handleDelete(r.id)} className="text-red-600 hover:underline text-xs">Delete</button>
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
        {meta && <Pagination page={page} lastPage={meta.last_page} total={meta.total} perPage={meta.per_page} onPageChange={setPage} />}
      </div>

      <Modal open={!!modal} onClose={() => setModal(null)} title={`${modal?.type === 'create' ? 'New' : 'Edit'} Reservation`}>
        <div className="space-y-4">
          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className="form-label">Customer Name *</label>
              <input className="form-input" value={form.customerName} onChange={(e) => setForm((f) => ({ ...f, customerName: e.target.value }))} />
            </div>
            <div>
              <label className="form-label">Phone</label>
              <input className="form-input" value={form.customerPhone} onChange={(e) => setForm((f) => ({ ...f, customerPhone: e.target.value }))} />
            </div>
          </div>
          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className="form-label">Table</label>
              <select className="form-input" value={form.tableId} onChange={(e) => setForm((f) => ({ ...f, tableId: e.target.value }))}>
                <option value="">Select table</option>
                {tables.map((t) => <option key={t.id} value={t.id}>{t.tableName}</option>)}
              </select>
            </div>
            <div>
              <label className="form-label">Party Size</label>
              <input type="number" min={1} className="form-input" value={form.partySize} onChange={(e) => setForm((f) => ({ ...f, partySize: e.target.value }))} />
            </div>
          </div>
          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className="form-label">Reserved At *</label>
              <input type="datetime-local" className="form-input" value={form.reservedAt} onChange={(e) => setForm((f) => ({ ...f, reservedAt: e.target.value }))} />
            </div>
            <div>
              <label className="form-label">Status</label>
              <select className="form-input" value={form.status} onChange={(e) => setForm((f) => ({ ...f, status: e.target.value }))}>
                {STATUSES.map((s) => <option key={s} value={s}>{s}</option>)}
              </select>
            </div>
          </div>
          <div>
            <label className="form-label">Notes</label>
            <textarea className="form-input resize-none" rows={2} value={form.notes} onChange={(e) => setForm((f) => ({ ...f, notes: e.target.value }))} />
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
