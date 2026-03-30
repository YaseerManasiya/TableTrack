import { useState } from 'react';
import { useQuery, useQueryClient } from '@tanstack/react-query';
import toast from 'react-hot-toast';
import api from '../api/axios.js';
import Modal from '../components/Modal.jsx';
import Pagination from '../components/Pagination.jsx';

const emptyExecutive = { name: '', phoneNumber: '', isActive: true };

export default function DeliveryExecutives() {
  const qc = useQueryClient();
  const [page, setPage] = useState(1);
  const [modal, setModal] = useState(null);
  const [form, setForm] = useState(emptyExecutive);

  const executivesQ = useQuery({
    queryKey: ['delivery-executives', page],
    queryFn: () => api.get(`/delivery-executives?page=${page}`).then((r) => r.data),
  });

  const executives = executivesQ.data?.data ?? [];
  const meta = executivesQ.data?.meta;

  const save = async () => {
    try {
      if (modal?.type === 'create') {
        await api.post('/delivery-executives', form);
        toast.success('Delivery executive added!');
      } else {
        await api.put(`/delivery-executives/${modal.id}`, form);
        toast.success('Delivery executive updated!');
      }
      qc.invalidateQueries({ queryKey: ['delivery-executives'] });
      setModal(null);
    } catch (e) {
      toast.error(e.response?.data?.message || 'Error saving');
    }
  };

  const handleDelete = async (id) => {
    if (!confirm('Delete this delivery executive?')) return;
    try {
      await api.delete(`/delivery-executives/${id}`);
      qc.invalidateQueries({ queryKey: ['delivery-executives'] });
      toast.success('Deleted');
    } catch (e) {
      toast.error(e.response?.data?.message || 'Error');
    }
  };

  const toggleActive = async (exec) => {
    try {
      await api.put(`/delivery-executives/${exec.id}`, { isActive: !exec.isActive });
      qc.invalidateQueries({ queryKey: ['delivery-executives'] });
      toast.success(exec.isActive ? 'Marked inactive' : 'Marked active');
    } catch (e) {
      toast.error('Error updating status');
    }
  };

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <h1 className="text-2xl font-bold text-gray-900">Delivery Executives</h1>
        <button
          onClick={() => { setForm(emptyExecutive); setModal({ type: 'create' }); }}
          className="btn-primary"
        >
          + Add Executive
        </button>
      </div>

      <div className="card overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full">
            <thead className="bg-gray-50 border-b border-gray-200">
              <tr>
                <th className="table-header">Name</th>
                <th className="table-header">Phone</th>
                <th className="table-header">Status</th>
                <th className="table-header">Actions</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-100">
              {executivesQ.isLoading ? (
                <tr><td colSpan={4} className="table-cell text-center py-10 text-gray-400">Loading…</td></tr>
              ) : executives.length === 0 ? (
                <tr><td colSpan={4} className="table-cell text-center py-10 text-gray-400">No delivery executives found</td></tr>
              ) : executives.map((exec) => (
                <tr key={exec.id} className="hover:bg-gray-50">
                  <td className="table-cell font-medium">
                    <div className="flex items-center gap-2">
                      <div className="w-7 h-7 rounded-full bg-green-100 text-green-600 flex items-center justify-center text-xs font-bold uppercase">
                        {exec.name[0]}
                      </div>
                      {exec.name}
                    </div>
                  </td>
                  <td className="table-cell text-gray-500">{exec.phoneNumber ?? '—'}</td>
                  <td className="table-cell">
                    <button
                      onClick={() => toggleActive(exec)}
                      className={`text-xs px-2 py-1 rounded-full font-medium ${
                        exec.isActive
                          ? 'bg-green-100 text-green-700 hover:bg-green-200'
                          : 'bg-gray-100 text-gray-500 hover:bg-gray-200'
                      }`}
                    >
                      {exec.isActive ? 'Active' : 'Inactive'}
                    </button>
                  </td>
                  <td className="table-cell">
                    <div className="flex gap-2">
                      <button
                        onClick={() => {
                          setForm({ name: exec.name, phoneNumber: exec.phoneNumber ?? '', isActive: exec.isActive });
                          setModal({ type: 'edit', id: exec.id });
                        }}
                        className="text-blue-600 hover:underline text-xs"
                      >
                        Edit
                      </button>
                      <button onClick={() => handleDelete(exec.id)} className="text-red-600 hover:underline text-xs">Delete</button>
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

      <Modal open={!!modal} onClose={() => setModal(null)} title={`${modal?.type === 'create' ? 'Add' : 'Edit'} Delivery Executive`}>
        <div className="space-y-4">
          <div>
            <label className="form-label">Name *</label>
            <input
              className="form-input"
              value={form.name}
              onChange={(e) => setForm((f) => ({ ...f, name: e.target.value }))}
            />
          </div>
          <div>
            <label className="form-label">Phone Number</label>
            <input
              className="form-input"
              value={form.phoneNumber}
              onChange={(e) => setForm((f) => ({ ...f, phoneNumber: e.target.value }))}
            />
          </div>
          <div className="flex items-center gap-3">
            <input
              id="exec-active"
              type="checkbox"
              className="w-4 h-4 text-blue-600 rounded border-gray-300"
              checked={form.isActive}
              onChange={(e) => setForm((f) => ({ ...f, isActive: e.target.checked }))}
            />
            <label htmlFor="exec-active" className="text-sm text-gray-700">Active</label>
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
