import { useState } from 'react';
import { useQuery, useQueryClient } from '@tanstack/react-query';
import toast from 'react-hot-toast';
import api from '../api/axios.js';
import Modal from '../components/Modal.jsx';
import Pagination from '../components/Pagination.jsx';

const emptyMenu = { name: '', description: '', isActive: true };

function MenuForm({ value, onChange }) {
  return (
    <div className="space-y-4">
      <div>
        <label className="form-label">Name *</label>
        <input
          className="form-input"
          value={value.name}
          onChange={(e) => onChange({ ...value, name: e.target.value })}
          required
        />
      </div>
      <div>
        <label className="form-label">Description</label>
        <textarea
          className="form-input resize-none"
          rows={3}
          value={value.description}
          onChange={(e) => onChange({ ...value, description: e.target.value })}
        />
      </div>
      <div className="flex items-center gap-2">
        <input
          type="checkbox"
          id="menu-active"
          checked={value.isActive}
          onChange={(e) => onChange({ ...value, isActive: e.target.checked })}
          className="w-4 h-4 rounded border-gray-300 text-blue-600 focus:ring-blue-500"
        />
        <label htmlFor="menu-active" className="text-sm text-gray-700">Active</label>
      </div>
    </div>
  );
}

function CategoryForm({ value, onChange }) {
  return (
    <div className="space-y-4">
      <div>
        <label className="form-label">Name *</label>
        <input className="form-input" value={value.name} onChange={(e) => onChange({ ...value, name: e.target.value })} required />
      </div>
      <div>
        <label className="form-label">Description</label>
        <textarea className="form-input resize-none" rows={2} value={value.description} onChange={(e) => onChange({ ...value, description: e.target.value })} />
      </div>
      <div>
        <label className="form-label">Order</label>
        <input type="number" className="form-input" value={value.order} onChange={(e) => onChange({ ...value, order: e.target.value })} />
      </div>
      <div className="flex items-center gap-2">
        <input type="checkbox" id="cat-active" checked={value.isActive} onChange={(e) => onChange({ ...value, isActive: e.target.checked })} className="w-4 h-4 rounded border-gray-300 text-blue-600" />
        <label htmlFor="cat-active" className="text-sm text-gray-700">Active</label>
      </div>
    </div>
  );
}

function ItemForm({ value, onChange, menus, categories }) {
  return (
    <div className="space-y-4">
      <div className="grid grid-cols-2 gap-4">
        <div>
          <label className="form-label">Name *</label>
          <input className="form-input" value={value.name} onChange={(e) => onChange({ ...value, name: e.target.value })} required />
        </div>
        <div>
          <label className="form-label">Price *</label>
          <input type="number" step="0.01" className="form-input" value={value.price} onChange={(e) => onChange({ ...value, price: e.target.value })} required />
        </div>
      </div>
      <div className="grid grid-cols-2 gap-4">
        <div>
          <label className="form-label">Menu *</label>
          <select className="form-input" value={value.menuId} onChange={(e) => onChange({ ...value, menuId: e.target.value })}>
            <option value="">Select menu</option>
            {menus?.map((m) => <option key={m.id} value={m.id}>{m.name}</option>)}
          </select>
        </div>
        <div>
          <label className="form-label">Category</label>
          <select className="form-input" value={value.itemCategoryId} onChange={(e) => onChange({ ...value, itemCategoryId: e.target.value })}>
            <option value="">Select category</option>
            {categories?.map((c) => <option key={c.id} value={c.id}>{c.name}</option>)}
          </select>
        </div>
      </div>
      <div>
        <label className="form-label">Description</label>
        <textarea className="form-input resize-none" rows={2} value={value.description} onChange={(e) => onChange({ ...value, description: e.target.value })} />
      </div>
      <div className="grid grid-cols-2 gap-4">
        <div>
          <label className="form-label">Prep Time (mins)</label>
          <input type="number" className="form-input" value={value.preparationTime} onChange={(e) => onChange({ ...value, preparationTime: e.target.value })} />
        </div>
        <div className="flex flex-col gap-3 pt-6">
          <label className="flex items-center gap-2 text-sm">
            <input type="checkbox" checked={value.isActive} onChange={(e) => onChange({ ...value, isActive: e.target.checked })} className="w-4 h-4 rounded border-gray-300 text-blue-600" />
            Active
          </label>
          <label className="flex items-center gap-2 text-sm">
            <input type="checkbox" checked={value.isFeatured} onChange={(e) => onChange({ ...value, isFeatured: e.target.checked })} className="w-4 h-4 rounded border-gray-300 text-blue-600" />
            Featured
          </label>
        </div>
      </div>
    </div>
  );
}

// ── Variations panel (shown as a modal when clicking "Variations" on an item) ─

function VariationsPanel({ item, onClose }) {
  const qc = useQueryClient();
  const emptyVariation = { name: '', price: '', isActive: true };
  const [varModal, setVarModal] = useState(null);
  const [varForm, setVarForm] = useState(emptyVariation);

  const variationsQ = useQuery({
    queryKey: ['item-variations', item.id],
    queryFn: () => api.get(`/menu-items/${item.id}/variations`).then((r) => r.data.data),
  });
  const variations = variationsQ.data ?? [];

  const openCreate = () => { setVarForm(emptyVariation); setVarModal({ type: 'create' }); };
  const openEdit = (v) => { setVarForm({ name: v.name, price: String(v.price), isActive: v.isActive }); setVarModal({ type: 'edit', id: v.id }); };

  const save = async () => {
    if (!varForm.name.trim()) { toast.error('Name is required'); return; }
    if (varForm.price === '' || isNaN(Number(varForm.price))) { toast.error('Valid price is required'); return; }
    try {
      if (varModal.type === 'create') {
        await api.post(`/menu-items/${item.id}/variations`, { name: varForm.name, price: Number(varForm.price), isActive: varForm.isActive });
      } else {
        await api.put(`/menu-items/${item.id}/variations/${varModal.id}`, { name: varForm.name, price: Number(varForm.price), isActive: varForm.isActive });
      }
      qc.invalidateQueries({ queryKey: ['item-variations', item.id] });
      qc.invalidateQueries({ queryKey: ['menu-items'] });
      toast.success(varModal.type === 'create' ? 'Variation added!' : 'Variation updated!');
      setVarModal(null);
    } catch (e) { toast.error(e.response?.data?.message || 'Error'); }
  };

  const deleteVar = async (id) => {
    if (!confirm('Delete this variation?')) return;
    try {
      await api.delete(`/menu-items/${item.id}/variations/${id}`);
      qc.invalidateQueries({ queryKey: ['item-variations', item.id] });
      qc.invalidateQueries({ queryKey: ['menu-items'] });
      toast.success('Deleted');
    } catch (e) { toast.error(e.response?.data?.message || 'Error'); }
  };

  return (
    <>
      <Modal open onClose={onClose} title={`Variations — ${item.name}`} size="md">
        <div className="space-y-4">
          <div className="flex justify-end">
            <button onClick={openCreate} className="btn-primary text-xs">+ Add Variation</button>
          </div>
          {variationsQ.isLoading ? (
            <p className="text-center py-6 text-gray-400">Loading…</p>
          ) : variations.length === 0 ? (
            <p className="text-center py-6 text-gray-400">No variations yet. Add one above.</p>
          ) : (
            <table className="w-full">
              <thead className="bg-gray-50 border-b border-gray-200">
                <tr>
                  <th className="table-header">Name</th>
                  <th className="table-header">Price</th>
                  <th className="table-header">Status</th>
                  <th className="table-header w-24">Actions</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-100">
                {variations.map((v) => (
                  <tr key={v.id} className="hover:bg-gray-50">
                    <td className="table-cell font-medium">{v.name}</td>
                    <td className="table-cell">${Number(v.price).toFixed(2)}</td>
                    <td className="table-cell">
                      <span className={v.isActive ? 'badge-green' : 'badge-gray'}>{v.isActive ? 'Active' : 'Inactive'}</span>
                    </td>
                    <td className="table-cell">
                      <div className="flex gap-2">
                        <button onClick={() => openEdit(v)} className="text-blue-600 hover:underline text-xs">Edit</button>
                        <button onClick={() => deleteVar(v.id)} className="text-red-600 hover:underline text-xs">Delete</button>
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

      {varModal && (
        <Modal open onClose={() => setVarModal(null)} title={`${varModal.type === 'create' ? 'Add' : 'Edit'} Variation`} size="sm">
          <div className="space-y-4">
            <div>
              <label className="form-label">Name *</label>
              <input className="form-input" value={varForm.name} onChange={(e) => setVarForm((f) => ({ ...f, name: e.target.value }))} placeholder="e.g. Small, Medium, Large" />
            </div>
            <div>
              <label className="form-label">Price *</label>
              <input type="number" step="0.01" min="0" className="form-input" value={varForm.price} onChange={(e) => setVarForm((f) => ({ ...f, price: e.target.value }))} placeholder="0.00" />
            </div>
            <div className="flex items-center gap-2">
              <input type="checkbox" id="var-active" checked={varForm.isActive} onChange={(e) => setVarForm((f) => ({ ...f, isActive: e.target.checked }))} className="w-4 h-4 rounded border-gray-300 text-blue-600" />
              <label htmlFor="var-active" className="text-sm text-gray-700">Active</label>
            </div>
          </div>
          <div className="flex justify-end gap-3 mt-6">
            <button onClick={() => setVarModal(null)} className="btn-secondary">Cancel</button>
            <button onClick={save} className="btn-primary">Save</button>
          </div>
        </Modal>
      )}
    </>
  );
}

const TABS = ['Menus', 'Categories', 'Items'];

export default function MenuManagement() {
  const qc = useQueryClient();
  const [tab, setTab] = useState('Menus');
  const [page, setPage] = useState(1);
  const [search, setSearch] = useState('');
  const [modal, setModal] = useState(null); // { type, data }
  const [form, setForm] = useState({});
  const [variationsItem, setVariationsItem] = useState(null); // item whose variations to manage

  // Queries
  const menusQ = useQuery({ queryKey: ['menus', page, search], queryFn: () => api.get(`/menus?page=${page}&q=${search}`).then((r) => r.data), enabled: tab === 'Menus' });
  const catsQ = useQuery({ queryKey: ['categories', page], queryFn: () => api.get(`/item-categories?page=${page}`).then((r) => r.data), enabled: tab === 'Categories' });
  const itemsQ = useQuery({ queryKey: ['menu-items', page, search], queryFn: () => api.get(`/menu-items?page=${page}&q=${search}`).then((r) => r.data), enabled: tab === 'Items' });
  const { data: allMenus } = useQuery({ queryKey: ['menus-all'], queryFn: () => api.get('/menus?per_page=100').then((r) => r.data.data) });
  const { data: allCats } = useQuery({ queryKey: ['cats-all'], queryFn: () => api.get('/item-categories?per_page=100').then((r) => r.data.data) });

  const openCreate = () => {
    if (tab === 'Menus') setForm(emptyMenu);
    if (tab === 'Categories') setForm({ name: '', description: '', isActive: true, order: 0 });
    if (tab === 'Items') setForm({ name: '', price: '', menuId: '', itemCategoryId: '', description: '', preparationTime: '', isActive: true, isFeatured: false });
    setModal({ type: 'create' });
  };

  const openEdit = (item) => {
    setForm({ ...item });
    setModal({ type: 'edit', id: item.id });
  };

  const handleSave = async () => {
    try {
      if (tab === 'Menus') {
        if (modal.type === 'create') await api.post('/menus', form);
        else await api.put(`/menus/${modal.id}`, form);
        qc.invalidateQueries({ queryKey: ['menus'] });
      }
      if (tab === 'Categories') {
        if (modal.type === 'create') await api.post('/item-categories', form);
        else await api.put(`/item-categories/${modal.id}`, form);
        qc.invalidateQueries({ queryKey: ['categories'] });
      }
      if (tab === 'Items') {
        if (modal.type === 'create') await api.post(`/menus/${form.menuId}/items`, form);
        else await api.put(`/menu-items/${modal.id}`, form);
        qc.invalidateQueries({ queryKey: ['menu-items'] });
      }
      toast.success(modal.type === 'create' ? 'Created!' : 'Updated!');
      setModal(null);
    } catch (e) {
      toast.error(e.response?.data?.message || 'Error');
    }
  };

  const handleDelete = async (id) => {
    if (!confirm('Delete this item?')) return;
    try {
      if (tab === 'Menus') { await api.delete(`/menus/${id}`); qc.invalidateQueries({ queryKey: ['menus'] }); }
      if (tab === 'Categories') { await api.delete(`/item-categories/${id}`); qc.invalidateQueries({ queryKey: ['categories'] }); }
      if (tab === 'Items') { await api.delete(`/menu-items/${id}`); qc.invalidateQueries({ queryKey: ['menu-items'] }); }
      toast.success('Deleted');
    } catch (e) {
      toast.error(e.response?.data?.message || 'Error');
    }
  };

  const activeQ = tab === 'Menus' ? menusQ : tab === 'Categories' ? catsQ : itemsQ;
  const rows = activeQ.data?.data ?? [];
  const meta = activeQ.data?.meta;

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <h1 className="text-2xl font-bold text-gray-900">Menu Management</h1>
        <button onClick={openCreate} className="btn-primary">+ Add {tab.slice(0, -1)}</button>
      </div>

      {/* Tabs */}
      <div className="border-b border-gray-200">
        <nav className="flex gap-6">
          {TABS.map((t) => (
            <button
              key={t}
              onClick={() => { setTab(t); setPage(1); setSearch(''); }}
              className={`pb-3 text-sm font-medium border-b-2 transition-colors ${t === tab ? 'border-blue-600 text-blue-600' : 'border-transparent text-gray-500 hover:text-gray-700'}`}
            >
              {t}
            </button>
          ))}
        </nav>
      </div>

      {/* Search */}
      {(tab === 'Menus' || tab === 'Items') && (
        <input
          className="form-input max-w-xs"
          placeholder="Search…"
          value={search}
          onChange={(e) => { setSearch(e.target.value); setPage(1); }}
        />
      )}

      {/* Table */}
      <div className="card overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full">
            <thead className="bg-gray-50 border-b border-gray-200">
              <tr>
                <th className="table-header">Name</th>
                {tab === 'Items' && <><th className="table-header">Price</th><th className="table-header">Category</th><th className="table-header">Variations</th></>}
                {tab === 'Menus' && <th className="table-header">Description</th>}
                <th className="table-header">Status</th>
                <th className="table-header w-36">Actions</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-100">
              {activeQ.isLoading ? (
                <tr><td colSpan={6} className="table-cell text-center py-10 text-gray-400">Loading…</td></tr>
              ) : rows.length === 0 ? (
                <tr><td colSpan={6} className="table-cell text-center py-10 text-gray-400">No records found</td></tr>
              ) : rows.map((row) => (
                <tr key={row.id} className="hover:bg-gray-50">
                  <td className="table-cell font-medium">{row.name}</td>
                  {tab === 'Items' && (
                    <>
                      <td className="table-cell">${Number(row.price).toFixed(2)}</td>
                      <td className="table-cell text-gray-500">{row.itemCategory?.name ?? '—'}</td>
                      <td className="table-cell">
                        <span className="badge-blue">{row.variations?.length ?? 0}</span>
                      </td>
                    </>
                  )}
                  {tab === 'Menus' && <td className="table-cell text-gray-500 max-w-xs truncate">{row.description}</td>}
                  <td className="table-cell">
                    <span className={row.isActive ? 'badge-green' : 'badge-gray'}>{row.isActive ? 'Active' : 'Inactive'}</span>
                  </td>
                  <td className="table-cell">
                    <div className="flex gap-2">
                      {tab === 'Items' && (
                        <button onClick={() => setVariationsItem(row)} className="text-green-600 hover:underline text-xs">Variations</button>
                      )}
                      <button onClick={() => openEdit(row)} className="text-blue-600 hover:underline text-xs">Edit</button>
                      <button onClick={() => handleDelete(row.id)} className="text-red-600 hover:underline text-xs">Delete</button>
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
        {meta && <Pagination page={page} lastPage={meta.last_page} total={meta.total} perPage={meta.per_page} onPageChange={setPage} />}
      </div>

      {/* Modal */}
      <Modal
        open={!!modal}
        onClose={() => setModal(null)}
        title={`${modal?.type === 'create' ? 'Add' : 'Edit'} ${tab.slice(0, -1)}`}
      >
        {tab === 'Menus' && <MenuForm value={form} onChange={setForm} />}
        {tab === 'Categories' && <CategoryForm value={form} onChange={setForm} />}
        {tab === 'Items' && <ItemForm value={form} onChange={setForm} menus={allMenus} categories={allCats} />}
        <div className="flex justify-end gap-3 mt-6">
          <button onClick={() => setModal(null)} className="btn-secondary">Cancel</button>
          <button onClick={handleSave} className="btn-primary">Save</button>
        </div>
      </Modal>

      {/* Variations panel */}
      {variationsItem && (
        <VariationsPanel item={variationsItem} onClose={() => setVariationsItem(null)} />
      )}
    </div>
  );
}


function MenuForm({ value, onChange }) {
  return (
    <div className="space-y-4">
      <div>
        <label className="form-label">Name *</label>
        <input
          className="form-input"
          value={value.name}
          onChange={(e) => onChange({ ...value, name: e.target.value })}
          required
        />
      </div>
      <div>
        <label className="form-label">Description</label>
        <textarea
          className="form-input resize-none"
          rows={3}
          value={value.description}
          onChange={(e) => onChange({ ...value, description: e.target.value })}
        />
      </div>
      <div className="flex items-center gap-2">
        <input
          type="checkbox"
          id="menu-active"
          checked={value.isActive}
          onChange={(e) => onChange({ ...value, isActive: e.target.checked })}
          className="w-4 h-4 rounded border-gray-300 text-blue-600 focus:ring-blue-500"
        />
        <label htmlFor="menu-active" className="text-sm text-gray-700">Active</label>
      </div>
    </div>
  );
}

function CategoryForm({ value, onChange }) {
  return (
    <div className="space-y-4">
      <div>
        <label className="form-label">Name *</label>
        <input className="form-input" value={value.name} onChange={(e) => onChange({ ...value, name: e.target.value })} required />
      </div>
      <div>
        <label className="form-label">Description</label>
        <textarea className="form-input resize-none" rows={2} value={value.description} onChange={(e) => onChange({ ...value, description: e.target.value })} />
      </div>
      <div>
        <label className="form-label">Order</label>
        <input type="number" className="form-input" value={value.order} onChange={(e) => onChange({ ...value, order: e.target.value })} />
      </div>
      <div className="flex items-center gap-2">
        <input type="checkbox" id="cat-active" checked={value.isActive} onChange={(e) => onChange({ ...value, isActive: e.target.checked })} className="w-4 h-4 rounded border-gray-300 text-blue-600" />
        <label htmlFor="cat-active" className="text-sm text-gray-700">Active</label>
      </div>
    </div>
  );
}

function ItemForm({ value, onChange, menus, categories }) {
  return (
    <div className="space-y-4">
      <div className="grid grid-cols-2 gap-4">
        <div>
          <label className="form-label">Name *</label>
          <input className="form-input" value={value.name} onChange={(e) => onChange({ ...value, name: e.target.value })} required />
        </div>
        <div>
          <label className="form-label">Price *</label>
          <input type="number" step="0.01" className="form-input" value={value.price} onChange={(e) => onChange({ ...value, price: e.target.value })} required />
        </div>
      </div>
      <div className="grid grid-cols-2 gap-4">
        <div>
          <label className="form-label">Menu *</label>
          <select className="form-input" value={value.menuId} onChange={(e) => onChange({ ...value, menuId: e.target.value })}>
            <option value="">Select menu</option>
            {menus?.map((m) => <option key={m.id} value={m.id}>{m.name}</option>)}
          </select>
        </div>
        <div>
          <label className="form-label">Category</label>
          <select className="form-input" value={value.itemCategoryId} onChange={(e) => onChange({ ...value, itemCategoryId: e.target.value })}>
            <option value="">Select category</option>
            {categories?.map((c) => <option key={c.id} value={c.id}>{c.name}</option>)}
          </select>
        </div>
      </div>
      <div>
        <label className="form-label">Description</label>
        <textarea className="form-input resize-none" rows={2} value={value.description} onChange={(e) => onChange({ ...value, description: e.target.value })} />
      </div>
      <div className="grid grid-cols-2 gap-4">
        <div>
          <label className="form-label">Prep Time (mins)</label>
          <input type="number" className="form-input" value={value.preparationTime} onChange={(e) => onChange({ ...value, preparationTime: e.target.value })} />
        </div>
        <div className="flex flex-col gap-3 pt-6">
          <label className="flex items-center gap-2 text-sm">
            <input type="checkbox" checked={value.isActive} onChange={(e) => onChange({ ...value, isActive: e.target.checked })} className="w-4 h-4 rounded border-gray-300 text-blue-600" />
            Active
          </label>
          <label className="flex items-center gap-2 text-sm">
            <input type="checkbox" checked={value.isFeatured} onChange={(e) => onChange({ ...value, isFeatured: e.target.checked })} className="w-4 h-4 rounded border-gray-300 text-blue-600" />
            Featured
          </label>
        </div>
      </div>
    </div>
  );
}

const TABS = ['Menus', 'Categories', 'Items'];

export default function MenuManagement() {
  const qc = useQueryClient();
  const [tab, setTab] = useState('Menus');
  const [page, setPage] = useState(1);
  const [search, setSearch] = useState('');
  const [modal, setModal] = useState(null); // { type, data }
  const [form, setForm] = useState({});

  // Queries
  const menusQ = useQuery({ queryKey: ['menus', page, search], queryFn: () => api.get(`/menus?page=${page}&q=${search}`).then((r) => r.data), enabled: tab === 'Menus' });
  const catsQ = useQuery({ queryKey: ['categories', page], queryFn: () => api.get(`/item-categories?page=${page}`).then((r) => r.data), enabled: tab === 'Categories' });
  const itemsQ = useQuery({ queryKey: ['menu-items', page, search], queryFn: () => api.get(`/menu-items?page=${page}&q=${search}`).then((r) => r.data), enabled: tab === 'Items' });
  const { data: allMenus } = useQuery({ queryKey: ['menus-all'], queryFn: () => api.get('/menus?per_page=100').then((r) => r.data.data) });
  const { data: allCats } = useQuery({ queryKey: ['cats-all'], queryFn: () => api.get('/item-categories?per_page=100').then((r) => r.data.data) });

  const openCreate = () => {
    if (tab === 'Menus') setForm(emptyMenu);
    if (tab === 'Categories') setForm({ name: '', description: '', isActive: true, order: 0 });
    if (tab === 'Items') setForm({ name: '', price: '', menuId: '', itemCategoryId: '', description: '', preparationTime: '', isActive: true, isFeatured: false });
    setModal({ type: 'create' });
  };

  const openEdit = (item) => {
    setForm({ ...item });
    setModal({ type: 'edit', id: item.id });
  };

  const handleSave = async () => {
    try {
      if (tab === 'Menus') {
        if (modal.type === 'create') await api.post('/menus', form);
        else await api.put(`/menus/${modal.id}`, form);
        qc.invalidateQueries({ queryKey: ['menus'] });
      }
      if (tab === 'Categories') {
        if (modal.type === 'create') await api.post('/item-categories', form);
        else await api.put(`/item-categories/${modal.id}`, form);
        qc.invalidateQueries({ queryKey: ['categories'] });
      }
      if (tab === 'Items') {
        if (modal.type === 'create') await api.post(`/menus/${form.menuId}/items`, form);
        else await api.put(`/menu-items/${modal.id}`, form);
        qc.invalidateQueries({ queryKey: ['menu-items'] });
      }
      toast.success(modal.type === 'create' ? 'Created!' : 'Updated!');
      setModal(null);
    } catch (e) {
      toast.error(e.response?.data?.message || 'Error');
    }
  };

  const handleDelete = async (id) => {
    if (!confirm('Delete this item?')) return;
    try {
      if (tab === 'Menus') { await api.delete(`/menus/${id}`); qc.invalidateQueries({ queryKey: ['menus'] }); }
      if (tab === 'Categories') { await api.delete(`/item-categories/${id}`); qc.invalidateQueries({ queryKey: ['categories'] }); }
      if (tab === 'Items') { await api.delete(`/menu-items/${id}`); qc.invalidateQueries({ queryKey: ['menu-items'] }); }
      toast.success('Deleted');
    } catch (e) {
      toast.error(e.response?.data?.message || 'Error');
    }
  };

  const activeQ = tab === 'Menus' ? menusQ : tab === 'Categories' ? catsQ : itemsQ;
  const rows = activeQ.data?.data ?? [];
  const meta = activeQ.data?.meta;

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <h1 className="text-2xl font-bold text-gray-900">Menu Management</h1>
        <button onClick={openCreate} className="btn-primary">+ Add {tab.slice(0, -1)}</button>
      </div>

      {/* Tabs */}
      <div className="border-b border-gray-200">
        <nav className="flex gap-6">
          {TABS.map((t) => (
            <button
              key={t}
              onClick={() => { setTab(t); setPage(1); setSearch(''); }}
              className={`pb-3 text-sm font-medium border-b-2 transition-colors ${t === tab ? 'border-blue-600 text-blue-600' : 'border-transparent text-gray-500 hover:text-gray-700'}`}
            >
              {t}
            </button>
          ))}
        </nav>
      </div>

      {/* Search */}
      {(tab === 'Menus' || tab === 'Items') && (
        <input
          className="form-input max-w-xs"
          placeholder="Search…"
          value={search}
          onChange={(e) => { setSearch(e.target.value); setPage(1); }}
        />
      )}

      {/* Table */}
      <div className="card overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full">
            <thead className="bg-gray-50 border-b border-gray-200">
              <tr>
                <th className="table-header">Name</th>
                {tab === 'Items' && <><th className="table-header">Price</th><th className="table-header">Category</th></>}
                {tab === 'Menus' && <th className="table-header">Description</th>}
                <th className="table-header">Status</th>
                <th className="table-header w-28">Actions</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-100">
              {activeQ.isLoading ? (
                <tr><td colSpan={5} className="table-cell text-center py-10 text-gray-400">Loading…</td></tr>
              ) : rows.length === 0 ? (
                <tr><td colSpan={5} className="table-cell text-center py-10 text-gray-400">No records found</td></tr>
              ) : rows.map((row) => (
                <tr key={row.id} className="hover:bg-gray-50">
                  <td className="table-cell font-medium">{row.name}</td>
                  {tab === 'Items' && <><td className="table-cell">${Number(row.price).toFixed(2)}</td><td className="table-cell text-gray-500">{row.itemCategory?.name ?? '—'}</td></>}
                  {tab === 'Menus' && <td className="table-cell text-gray-500 max-w-xs truncate">{row.description}</td>}
                  <td className="table-cell">
                    <span className={row.isActive ? 'badge-green' : 'badge-gray'}>{row.isActive ? 'Active' : 'Inactive'}</span>
                  </td>
                  <td className="table-cell">
                    <div className="flex gap-2">
                      <button onClick={() => openEdit(row)} className="text-blue-600 hover:underline text-xs">Edit</button>
                      <button onClick={() => handleDelete(row.id)} className="text-red-600 hover:underline text-xs">Delete</button>
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
        {meta && <Pagination page={page} lastPage={meta.last_page} total={meta.total} perPage={meta.per_page} onPageChange={setPage} />}
      </div>

      {/* Modal */}
      <Modal
        open={!!modal}
        onClose={() => setModal(null)}
        title={`${modal?.type === 'create' ? 'Add' : 'Edit'} ${tab.slice(0, -1)}`}
      >
        {tab === 'Menus' && <MenuForm value={form} onChange={setForm} />}
        {tab === 'Categories' && <CategoryForm value={form} onChange={setForm} />}
        {tab === 'Items' && <ItemForm value={form} onChange={setForm} menus={allMenus} categories={allCats} />}
        <div className="flex justify-end gap-3 mt-6">
          <button onClick={() => setModal(null)} className="btn-secondary">Cancel</button>
          <button onClick={handleSave} className="btn-primary">Save</button>
        </div>
      </Modal>
    </div>
  );
}
