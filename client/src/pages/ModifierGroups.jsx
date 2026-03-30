import { useState } from 'react';
import { useQuery, useQueryClient } from '@tanstack/react-query';
import toast from 'react-hot-toast';
import api from '../api/axios.js';
import Modal from '../components/Modal.jsx';
import Pagination from '../components/Pagination.jsx';

// ── Helpers ───────────────────────────────────────────────────────────────────

const emptyGroup = { name: '' };
const emptyOption = { name: '', price: '' };

// ── Option management sub-panel ───────────────────────────────────────────────

function OptionsPanel({ group, onClose }) {
  const qc = useQueryClient();
  const [optModal, setOptModal] = useState(null); // { type: 'create'|'edit', id? }
  const [optForm, setOptForm] = useState(emptyOption);

  const optionsQ = useQuery({
    queryKey: ['modifier-options', group.id],
    queryFn: () => api.get(`/modifier-groups/${group.id}/options`).then((r) => r.data.data),
  });
  const options = optionsQ.data ?? [];

  const openCreate = () => {
    setOptForm(emptyOption);
    setOptModal({ type: 'create' });
  };

  const openEdit = (opt) => {
    setOptForm({ name: opt.name, price: String(opt.price) });
    setOptModal({ type: 'edit', id: opt.id });
  };

  const saveOption = async () => {
    if (!optForm.name.trim()) { toast.error('Name is required'); return; }
    try {
      if (optModal.type === 'create') {
        await api.post(`/modifier-groups/${group.id}/options`, {
          name: optForm.name,
          price: Number(optForm.price || 0),
        });
      } else {
        await api.put(`/modifier-groups/${group.id}/options/${optModal.id}`, {
          name: optForm.name,
          price: Number(optForm.price || 0),
        });
      }
      qc.invalidateQueries({ queryKey: ['modifier-options', group.id] });
      qc.invalidateQueries({ queryKey: ['modifier-groups'] });
      toast.success(optModal.type === 'create' ? 'Option added!' : 'Option updated!');
      setOptModal(null);
    } catch (e) {
      toast.error(e.response?.data?.message || 'Error');
    }
  };

  const deleteOption = async (id) => {
    if (!confirm('Delete this option?')) return;
    try {
      await api.delete(`/modifier-groups/${group.id}/options/${id}`);
      qc.invalidateQueries({ queryKey: ['modifier-options', group.id] });
      qc.invalidateQueries({ queryKey: ['modifier-groups'] });
      toast.success('Deleted');
    } catch (e) {
      toast.error(e.response?.data?.message || 'Error');
    }
  };

  return (
    <>
      <Modal open onClose={onClose} title={`Options — ${group.name}`} size="md">
        <div className="space-y-4">
          <div className="flex justify-end">
            <button onClick={openCreate} className="btn-primary text-xs">+ Add Option</button>
          </div>

          {optionsQ.isLoading ? (
            <p className="text-center py-6 text-gray-400">Loading…</p>
          ) : options.length === 0 ? (
            <p className="text-center py-6 text-gray-400">No options yet. Add one above.</p>
          ) : (
            <table className="w-full">
              <thead className="bg-gray-50 border-b border-gray-200">
                <tr>
                  <th className="table-header">Name</th>
                  <th className="table-header">Extra Price</th>
                  <th className="table-header w-24">Actions</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-100">
                {options.map((opt) => (
                  <tr key={opt.id} className="hover:bg-gray-50">
                    <td className="table-cell font-medium">{opt.name}</td>
                    <td className="table-cell">${Number(opt.price).toFixed(2)}</td>
                    <td className="table-cell">
                      <div className="flex gap-2">
                        <button onClick={() => openEdit(opt)} className="text-blue-600 hover:underline text-xs">Edit</button>
                        <button onClick={() => deleteOption(opt.id)} className="text-red-600 hover:underline text-xs">Delete</button>
                      </div>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          )}

          <div className="flex justify-end mt-2">
            <button onClick={onClose} className="btn-secondary">Close</button>
          </div>
        </div>
      </Modal>

      {/* Option create/edit modal */}
      {optModal && (
        <Modal open onClose={() => setOptModal(null)} title={`${optModal.type === 'create' ? 'Add' : 'Edit'} Option`} size="sm">
          <div className="space-y-4">
            <div>
              <label className="form-label">Name *</label>
              <input
                className="form-input"
                value={optForm.name}
                onChange={(e) => setOptForm((f) => ({ ...f, name: e.target.value }))}
                placeholder="e.g. Extra Cheese"
              />
            </div>
            <div>
              <label className="form-label">Extra Price</label>
              <input
                type="number"
                step="0.01"
                min="0"
                className="form-input"
                value={optForm.price}
                onChange={(e) => setOptForm((f) => ({ ...f, price: e.target.value }))}
                placeholder="0.00"
              />
            </div>
          </div>
          <div className="flex justify-end gap-3 mt-6">
            <button onClick={() => setOptModal(null)} className="btn-secondary">Cancel</button>
            <button onClick={saveOption} className="btn-primary">Save</button>
          </div>
        </Modal>
      )}
    </>
  );
}

// ── Main Page ─────────────────────────────────────────────────────────────────

export default function ModifierGroups() {
  const qc = useQueryClient();
  const [page, setPage] = useState(1);
  const [modal, setModal] = useState(null); // { type: 'create'|'edit', id? }
  const [form, setForm] = useState(emptyGroup);
  const [optionsGroup, setOptionsGroup] = useState(null); // group being managed

  const groupsQ = useQuery({
    queryKey: ['modifier-groups', page],
    queryFn: () => api.get(`/modifier-groups?page=${page}`).then((r) => r.data),
  });

  const groups = groupsQ.data?.data ?? [];
  const meta = groupsQ.data?.meta;

  const openCreate = () => {
    setForm(emptyGroup);
    setModal({ type: 'create' });
  };

  const openEdit = (group) => {
    setForm({ name: group.name });
    setModal({ type: 'edit', id: group.id });
  };

  const save = async () => {
    if (!form.name.trim()) { toast.error('Name is required'); return; }
    try {
      if (modal.type === 'create') {
        await api.post('/modifier-groups', form);
      } else {
        await api.put(`/modifier-groups/${modal.id}`, form);
      }
      qc.invalidateQueries({ queryKey: ['modifier-groups'] });
      toast.success(modal.type === 'create' ? 'Group created!' : 'Group updated!');
      setModal(null);
    } catch (e) {
      toast.error(e.response?.data?.message || 'Error');
    }
  };

  const handleDelete = async (id) => {
    if (!confirm('Delete this modifier group and all its options?')) return;
    try {
      await api.delete(`/modifier-groups/${id}`);
      qc.invalidateQueries({ queryKey: ['modifier-groups'] });
      toast.success('Deleted');
    } catch (e) {
      toast.error(e.response?.data?.message || 'Error');
    }
  };

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold text-gray-900">Modifier Groups</h1>
          <p className="text-sm text-gray-500 mt-0.5">Manage add-on options for menu items (e.g. sizes, toppings, sauces)</p>
        </div>
        <button onClick={openCreate} className="btn-primary">+ Add Group</button>
      </div>

      <div className="card overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full">
            <thead className="bg-gray-50 border-b border-gray-200">
              <tr>
                <th className="table-header">Group Name</th>
                <th className="table-header">Options</th>
                <th className="table-header">Created</th>
                <th className="table-header w-36">Actions</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-100">
              {groupsQ.isLoading ? (
                <tr><td colSpan={4} className="table-cell text-center py-10 text-gray-400">Loading…</td></tr>
              ) : groups.length === 0 ? (
                <tr><td colSpan={4} className="table-cell text-center py-10 text-gray-400">No modifier groups found</td></tr>
              ) : groups.map((g) => (
                <tr key={g.id} className="hover:bg-gray-50">
                  <td className="table-cell font-medium">{g.name}</td>
                  <td className="table-cell">
                    <span className="badge-blue">{g.modifierOptions?.length ?? 0} options</span>
                  </td>
                  <td className="table-cell text-xs text-gray-500">{new Date(g.createdAt).toLocaleDateString()}</td>
                  <td className="table-cell">
                    <div className="flex gap-2">
                      <button
                        onClick={() => setOptionsGroup(g)}
                        className="text-green-600 hover:underline text-xs"
                      >
                        Options
                      </button>
                      <button onClick={() => openEdit(g)} className="text-blue-600 hover:underline text-xs">Edit</button>
                      <button onClick={() => handleDelete(g.id)} className="text-red-600 hover:underline text-xs">Delete</button>
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
        {meta && (
          <Pagination
            page={page}
            lastPage={meta.last_page}
            total={meta.total}
            perPage={meta.per_page}
            onPageChange={setPage}
          />
        )}
      </div>

      {/* Create / Edit group modal */}
      <Modal
        open={!!modal}
        onClose={() => setModal(null)}
        title={`${modal?.type === 'create' ? 'Add' : 'Edit'} Modifier Group`}
        size="sm"
      >
        <div className="space-y-4">
          <div>
            <label className="form-label">Group Name *</label>
            <input
              className="form-input"
              value={form.name}
              onChange={(e) => setForm({ name: e.target.value })}
              placeholder="e.g. Size, Toppings, Sauce"
            />
          </div>
        </div>
        <div className="flex justify-end gap-3 mt-6">
          <button onClick={() => setModal(null)} className="btn-secondary">Cancel</button>
          <button onClick={save} className="btn-primary">Save</button>
        </div>
      </Modal>

      {/* Options management panel */}
      {optionsGroup && (
        <OptionsPanel
          group={optionsGroup}
          onClose={() => setOptionsGroup(null)}
        />
      )}
    </div>
  );
}
