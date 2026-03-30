import { useState } from 'react';
import { useQuery, useQueryClient } from '@tanstack/react-query';
import toast from 'react-hot-toast';
import api from '../api/axios.js';
import Modal from '../components/Modal.jsx';
import Pagination from '../components/Pagination.jsx';

const STATUS_COLORS = {
  pending: 'bg-yellow-100 text-yellow-700',
  in_progress: 'bg-blue-100 text-blue-700',
  resolved: 'bg-green-100 text-green-700',
};

const STATUSES = ['pending', 'in_progress', 'resolved'];

export default function WaiterRequests() {
  const qc = useQueryClient();
  const [page, setPage] = useState(1);
  const [statusFilter, setStatusFilter] = useState('');
  const [createModal, setCreateModal] = useState(false);
  const [createForm, setCreateForm] = useState({ tableId: '', message: '' });

  // ── Queries ──────────────────────────────────────────────────────────────
  const requestsQ = useQuery({
    queryKey: ['waiter-requests', page, statusFilter],
    queryFn: () =>
      api
        .get(`/waiter-requests?page=${page}${statusFilter ? `&status=${statusFilter}` : ''}`)
        .then((r) => r.data),
    refetchInterval: 20_000,
  });

  const tablesQ = useQuery({
    queryKey: ['tables-simple'],
    queryFn: () => api.get('/tables').then((r) => r.data.data),
  });

  const requests = requestsQ.data?.data ?? [];
  const meta = requestsQ.data?.meta;
  const tables = tablesQ.data ?? [];

  // ── Handlers ─────────────────────────────────────────────────────────────
  const updateStatus = async (id, status) => {
    try {
      await api.put(`/waiter-requests/${id}`, { status });
      qc.invalidateQueries({ queryKey: ['waiter-requests'] });
      toast.success(`Marked as ${status.replace('_', ' ')}`);
    } catch (e) {
      toast.error('Failed to update');
    }
  };

  const deleteRequest = async (id) => {
    if (!confirm('Delete this waiter request?')) return;
    try {
      await api.delete(`/waiter-requests/${id}`);
      qc.invalidateQueries({ queryKey: ['waiter-requests'] });
      toast.success('Deleted');
    } catch (e) {
      toast.error('Error');
    }
  };

  const createRequest = async () => {
    if (!createForm.tableId) { toast.error('Please select a table'); return; }
    try {
      await api.post('/waiter-requests', createForm);
      qc.invalidateQueries({ queryKey: ['waiter-requests'] });
      toast.success('Request created');
      setCreateModal(false);
      setCreateForm({ tableId: '', message: '' });
    } catch (e) {
      toast.error(e.response?.data?.message || 'Error');
    }
  };

  const pendingCount = requests.filter((r) => r.status === 'pending').length;

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold text-gray-900">Waiter Requests</h1>
          {pendingCount > 0 && (
            <p className="text-sm text-yellow-600 mt-0.5 font-medium">
              {pendingCount} pending request{pendingCount > 1 ? 's' : ''}
            </p>
          )}
        </div>
        <button
          onClick={() => { setCreateForm({ tableId: '', message: '' }); setCreateModal(true); }}
          className="btn-primary"
        >
          + New Request
        </button>
      </div>

      {/* Status filters */}
      <div className="flex gap-2 flex-wrap">
        {['', ...STATUSES].map((s) => (
          <button
            key={s}
            onClick={() => { setStatusFilter(s); setPage(1); }}
            className={`px-3 py-1.5 rounded-lg text-sm font-medium capitalize transition-colors ${
              statusFilter === s
                ? 'bg-blue-600 text-white'
                : 'bg-white border border-gray-200 text-gray-700 hover:bg-gray-50'
            }`}
          >
            {s === '' ? 'All' : s.replace('_', ' ')}
          </button>
        ))}
      </div>

      <div className="card overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full">
            <thead className="bg-gray-50 border-b border-gray-200">
              <tr>
                <th className="table-header">Table</th>
                <th className="table-header">Message</th>
                <th className="table-header">Status</th>
                <th className="table-header">Time</th>
                <th className="table-header">Actions</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-100">
              {requestsQ.isLoading ? (
                <tr><td colSpan={5} className="table-cell text-center py-10 text-gray-400">Loading…</td></tr>
              ) : requests.length === 0 ? (
                <tr><td colSpan={5} className="table-cell text-center py-10 text-gray-400">No waiter requests</td></tr>
              ) : requests.map((req) => (
                <tr key={req.id} className={`hover:bg-gray-50 ${req.status === 'pending' ? 'bg-yellow-50/30' : ''}`}>
                  <td className="table-cell font-medium">
                    <div className="flex items-center gap-2">
                      <span className="text-lg">🪑</span>
                      {req.table?.tableName ?? '—'}
                    </div>
                  </td>
                  <td className="table-cell text-gray-600">{req.message ?? <span className="text-gray-400 italic">No message</span>}</td>
                  <td className="table-cell">
                    <span className={`text-xs px-2 py-1 rounded-full font-medium ${STATUS_COLORS[req.status] || 'bg-gray-100 text-gray-600'}`}>
                      {req.status.replace('_', ' ')}
                    </span>
                  </td>
                  <td className="table-cell text-xs text-gray-500">{new Date(req.createdAt).toLocaleString()}</td>
                  <td className="table-cell">
                    <div className="flex gap-2 flex-wrap">
                      {req.status === 'pending' && (
                        <button onClick={() => updateStatus(req.id, 'in_progress')} className="text-blue-600 hover:underline text-xs">
                          Accept
                        </button>
                      )}
                      {req.status === 'in_progress' && (
                        <button onClick={() => updateStatus(req.id, 'resolved')} className="text-green-600 hover:underline text-xs">
                          Resolve
                        </button>
                      )}
                      <button onClick={() => deleteRequest(req.id)} className="text-red-600 hover:underline text-xs">
                        Delete
                      </button>
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
        {meta && (
          <Pagination page={page} lastPage={meta.last_page} total={meta.total} perPage={meta.per_page} onPageChange={setPage} />
        )}
      </div>

      {/* Create Request Modal */}
      <Modal open={createModal} onClose={() => setCreateModal(false)} title="New Waiter Request">
        <div className="space-y-4">
          <div>
            <label className="form-label">Table *</label>
            <select
              className="form-input"
              value={createForm.tableId}
              onChange={(e) => setCreateForm((f) => ({ ...f, tableId: e.target.value }))}
            >
              <option value="">Select a table</option>
              {tables.map((t) => (
                <option key={t.id} value={t.id}>{t.tableName}</option>
              ))}
            </select>
          </div>
          <div>
            <label className="form-label">Message</label>
            <textarea
              className="form-input resize-none"
              rows={3}
              placeholder="E.g. Customer needs extra napkins…"
              value={createForm.message}
              onChange={(e) => setCreateForm((f) => ({ ...f, message: e.target.value }))}
            />
          </div>
        </div>
        <div className="flex justify-end gap-3 mt-6">
          <button onClick={() => setCreateModal(false)} className="btn-secondary">Cancel</button>
          <button onClick={createRequest} className="btn-primary">Create Request</button>
        </div>
      </Modal>
    </div>
  );
}
