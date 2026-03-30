import { useState } from 'react';
import { useQuery, useQueryClient } from '@tanstack/react-query';
import toast from 'react-hot-toast';
import api from '../api/axios.js';
import Modal from '../components/Modal.jsx';

const STATUS_COLORS = {
  available: 'bg-green-100 text-green-800 border border-green-200',
  running: 'bg-blue-100 text-blue-800 border border-blue-200',
  reserved: 'bg-yellow-100 text-yellow-800 border border-yellow-200',
};

export default function TableManagement() {
  const qc = useQueryClient();
  const [modal, setModal] = useState(null);
  const [form, setForm] = useState({});
  const [areaModal, setAreaModal] = useState(null);
  const [areaForm, setAreaForm] = useState({});
  const [selectedArea, setSelectedArea] = useState('all');

  const areasQ = useQuery({ queryKey: ['areas'], queryFn: () => api.get('/areas').then((r) => r.data.data) });
  const tablesQ = useQuery({
    queryKey: ['tables', selectedArea],
    queryFn: () => api.get(`/tables?per_page=100${selectedArea !== 'all' ? `&areaId=${selectedArea}` : ''}`).then((r) => r.data.data),
  });

  const areas = areasQ.data ?? [];
  const tables = tablesQ.data ?? [];

  const openCreateTable = () => {
    setForm({ areaId: selectedArea !== 'all' ? selectedArea : '', tableName: '', seatingCapacity: 4, isActive: true });
    setModal({ type: 'create' });
  };
  const openEditTable = (t) => { setForm({ ...t, areaId: t.areaId }); setModal({ type: 'edit', id: t.id }); };

  const saveTable = async () => {
    try {
      if (modal.type === 'create') await api.post('/tables', form);
      else await api.put(`/tables/${modal.id}`, form);
      qc.invalidateQueries({ queryKey: ['tables'] });
      toast.success(modal.type === 'create' ? 'Table created' : 'Table updated');
      setModal(null);
    } catch (e) { toast.error(e.response?.data?.message || 'Error'); }
  };

  const deleteTable = async (id) => {
    if (!confirm('Delete this table?')) return;
    try {
      await api.delete(`/tables/${id}`);
      qc.invalidateQueries({ queryKey: ['tables'] });
      toast.success('Deleted');
    } catch (e) { toast.error(e.response?.data?.message || 'Error'); }
  };

  const saveArea = async () => {
    try {
      if (areaModal.type === 'create') await api.post('/areas', areaForm);
      else await api.put(`/areas/${areaModal.id}`, areaForm);
      qc.invalidateQueries({ queryKey: ['areas'] });
      toast.success(areaModal.type === 'create' ? 'Area created' : 'Area updated');
      setAreaModal(null);
    } catch (e) { toast.error(e.response?.data?.message || 'Error'); }
  };

  const deleteArea = async (id) => {
    if (!confirm('Delete this area and all its tables?')) return;
    try {
      await api.delete(`/areas/${id}`);
      qc.invalidateQueries({ queryKey: ['areas'] });
      qc.invalidateQueries({ queryKey: ['tables'] });
      toast.success('Area deleted');
    } catch (e) { toast.error(e.response?.data?.message || 'Error'); }
  };

  const updateTableStatus = async (id, tableStatus) => {
    try {
      await api.put(`/tables/${id}`, { tableStatus });
      qc.invalidateQueries({ queryKey: ['tables'] });
    } catch (e) { toast.error('Failed to update status'); }
  };

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <h1 className="text-2xl font-bold text-gray-900">Table Management</h1>
        <div className="flex gap-2">
          <button onClick={() => { setAreaForm({ areaName: '' }); setAreaModal({ type: 'create' }); }} className="btn-secondary">+ Area</button>
          <button onClick={openCreateTable} className="btn-primary">+ Table</button>
        </div>
      </div>

      {/* Area filter */}
      <div className="flex gap-2 flex-wrap">
        <button
          onClick={() => setSelectedArea('all')}
          className={`px-4 py-2 rounded-lg text-sm font-medium transition-colors ${selectedArea === 'all' ? 'bg-blue-600 text-white' : 'bg-white border border-gray-200 text-gray-700 hover:bg-gray-50'}`}
        >
          All Areas
        </button>
        {areas.map((a) => (
          <button
            key={a.id}
            onClick={() => setSelectedArea(String(a.id))}
            className={`px-4 py-2 rounded-lg text-sm font-medium transition-colors ${selectedArea === String(a.id) ? 'bg-blue-600 text-white' : 'bg-white border border-gray-200 text-gray-700 hover:bg-gray-50'}`}
          >
            {a.areaName}
            <button
              onClick={(e) => { e.stopPropagation(); deleteArea(a.id); }}
              className="ml-2 text-xs opacity-60 hover:opacity-100"
            >✕</button>
          </button>
        ))}
      </div>

      {/* Tables grid */}
      {tablesQ.isLoading ? (
        <div className="flex items-center justify-center h-40"><div className="w-8 h-8 border-4 border-blue-600 border-t-transparent rounded-full animate-spin" /></div>
      ) : tables.length === 0 ? (
        <div className="card p-12 text-center text-gray-400">No tables found. Create one to get started.</div>
      ) : (
        <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 xl:grid-cols-6 gap-4">
          {tables.map((t) => (
            <div key={t.id} className={`card p-4 cursor-pointer hover:shadow-md transition-shadow ${STATUS_COLORS[t.tableStatus]}`}>
              <div className="flex items-start justify-between mb-2">
                <p className="font-semibold text-sm">{t.tableName}</p>
                <button
                  onClick={() => openEditTable(t)}
                  className="text-gray-400 hover:text-gray-600 text-xs"
                >✎</button>
              </div>
              <p className="text-xs opacity-70 mb-3">{t.area?.areaName} · {t.seatingCapacity} seats</p>
              <select
                value={t.tableStatus}
                onChange={(e) => updateTableStatus(t.id, e.target.value)}
                className="w-full text-xs border-0 bg-transparent p-0 font-medium focus:ring-0"
                onClick={(e) => e.stopPropagation()}
              >
                <option value="available">Available</option>
                <option value="running">Running</option>
                <option value="reserved">Reserved</option>
              </select>
            </div>
          ))}
        </div>
      )}

      {/* Table Modal */}
      <Modal open={!!modal} onClose={() => setModal(null)} title={`${modal?.type === 'create' ? 'Add' : 'Edit'} Table`}>
        <div className="space-y-4">
          <div>
            <label className="form-label">Area *</label>
            <select className="form-input" value={form.areaId} onChange={(e) => setForm((f) => ({ ...f, areaId: e.target.value }))}>
              <option value="">Select area</option>
              {areas.map((a) => <option key={a.id} value={a.id}>{a.areaName}</option>)}
            </select>
          </div>
          <div>
            <label className="form-label">Table Name *</label>
            <input className="form-input" value={form.tableName} onChange={(e) => setForm((f) => ({ ...f, tableName: e.target.value }))} />
          </div>
          <div>
            <label className="form-label">Seating Capacity</label>
            <input type="number" className="form-input" value={form.seatingCapacity} onChange={(e) => setForm((f) => ({ ...f, seatingCapacity: e.target.value }))} />
          </div>
          {modal?.type === 'edit' && (
            <div>
              <label className="form-label">Status</label>
              <select className="form-input" value={form.tableStatus} onChange={(e) => setForm((f) => ({ ...f, tableStatus: e.target.value }))}>
                <option value="available">Available</option>
                <option value="running">Running</option>
                <option value="reserved">Reserved</option>
              </select>
            </div>
          )}
          <div className="flex items-center gap-2">
            <input type="checkbox" id="tbl-active" checked={form.isActive} onChange={(e) => setForm((f) => ({ ...f, isActive: e.target.checked }))} className="w-4 h-4 rounded border-gray-300 text-blue-600" />
            <label htmlFor="tbl-active" className="text-sm text-gray-700">Active</label>
          </div>
        </div>
        <div className="flex justify-between mt-6">
          {modal?.type === 'edit' && <button onClick={() => { deleteTable(modal.id); setModal(null); }} className="btn-danger">Delete</button>}
          <div className="flex gap-3 ml-auto">
            <button onClick={() => setModal(null)} className="btn-secondary">Cancel</button>
            <button onClick={saveTable} className="btn-primary">Save</button>
          </div>
        </div>
      </Modal>

      {/* Area Modal */}
      <Modal open={!!areaModal} onClose={() => setAreaModal(null)} title={`${areaModal?.type === 'create' ? 'Add' : 'Edit'} Area`} size="sm">
        <div className="space-y-4">
          <div>
            <label className="form-label">Area Name *</label>
            <input className="form-input" value={areaForm.areaName} onChange={(e) => setAreaForm((f) => ({ ...f, areaName: e.target.value }))} />
          </div>
        </div>
        <div className="flex justify-end gap-3 mt-6">
          <button onClick={() => setAreaModal(null)} className="btn-secondary">Cancel</button>
          <button onClick={saveArea} className="btn-primary">Save</button>
        </div>
      </Modal>
    </div>
  );
}
