import { useState } from 'react';
import { useQuery, useQueryClient } from '@tanstack/react-query';
import toast from 'react-hot-toast';
import api from '../api/axios.js';
import Modal from '../components/Modal.jsx';
import Pagination from '../components/Pagination.jsx';

const emptyExpense = { expenseCategoryId: '', amount: '', notes: '', date: '' };
const emptyCategory = { name: '' };

export default function Expenses() {
  const qc = useQueryClient();
  const [tab, setTab] = useState('expenses');
  const [page, setPage] = useState(1);
  const [modal, setModal] = useState(null);
  const [form, setForm] = useState(emptyExpense);
  const [catModal, setCatModal] = useState(null);
  const [catForm, setCatForm] = useState(emptyCategory);

  // ── Queries ──────────────────────────────────────────────────────────────
  const expensesQ = useQuery({
    queryKey: ['expenses', page],
    queryFn: () => api.get(`/expenses?page=${page}`).then((r) => r.data),
  });

  const categoriesQ = useQuery({
    queryKey: ['expense-categories'],
    queryFn: () => api.get('/expenses/categories').then((r) => r.data.data),
  });

  const expenses = expensesQ.data?.data ?? [];
  const meta = expensesQ.data?.meta;
  const categories = categoriesQ.data ?? [];

  // ── Expense handlers ─────────────────────────────────────────────────────
  const saveExpense = async () => {
    try {
      if (modal?.type === 'create') {
        await api.post('/expenses', form);
        toast.success('Expense added!');
      } else {
        await api.put(`/expenses/${modal.id}`, form);
        toast.success('Expense updated!');
      }
      qc.invalidateQueries({ queryKey: ['expenses'] });
      setModal(null);
    } catch (e) {
      toast.error(e.response?.data?.message || 'Error saving expense');
    }
  };

  const deleteExpense = async (id) => {
    if (!confirm('Delete this expense?')) return;
    try {
      await api.delete(`/expenses/${id}`);
      qc.invalidateQueries({ queryKey: ['expenses'] });
      toast.success('Deleted');
    } catch (e) {
      toast.error(e.response?.data?.message || 'Error');
    }
  };

  const openEditExpense = (exp) => {
    setForm({
      expenseCategoryId: exp.expenseCategoryId ?? '',
      amount: exp.amount ?? '',
      notes: exp.notes ?? '',
      date: exp.date ? exp.date.slice(0, 10) : '',
    });
    setModal({ type: 'edit', id: exp.id });
  };

  // ── Category handlers ─────────────────────────────────────────────────────
  const saveCategory = async () => {
    try {
      if (catModal?.type === 'create') {
        await api.post('/expenses/categories', catForm);
        toast.success('Category added!');
      } else {
        await api.put(`/expenses/categories/${catModal.id}`, catForm);
        toast.success('Category updated!');
      }
      qc.invalidateQueries({ queryKey: ['expense-categories'] });
      setCatModal(null);
    } catch (e) {
      toast.error(e.response?.data?.message || 'Error saving category');
    }
  };

  const deleteCategory = async (id) => {
    if (!confirm('Delete this category?')) return;
    try {
      await api.delete(`/expenses/categories/${id}`);
      qc.invalidateQueries({ queryKey: ['expense-categories'] });
      toast.success('Deleted');
    } catch (e) {
      toast.error(e.response?.data?.message || 'Error');
    }
  };

  const totalAmount = expenses.reduce((s, e) => s + Number(e.amount), 0);

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <h1 className="text-2xl font-bold text-gray-900">Expenses</h1>
        <div className="flex gap-2">
          {tab === 'expenses' && (
            <button
              onClick={() => { setForm({ ...emptyExpense, date: new Date().toISOString().slice(0, 10) }); setModal({ type: 'create' }); }}
              className="btn-primary"
            >
              + Add Expense
            </button>
          )}
          {tab === 'categories' && (
            <button
              onClick={() => { setCatForm(emptyCategory); setCatModal({ type: 'create' }); }}
              className="btn-primary"
            >
              + Add Category
            </button>
          )}
        </div>
      </div>

      {/* Tabs */}
      <div className="border-b border-gray-200">
        <nav className="flex gap-6">
          {['expenses', 'categories'].map((t) => (
            <button
              key={t}
              onClick={() => setTab(t)}
              className={`pb-3 text-sm font-medium border-b-2 transition-colors capitalize ${
                tab === t ? 'border-blue-600 text-blue-600' : 'border-transparent text-gray-500 hover:text-gray-700'
              }`}
            >
              {t === 'expenses' ? 'Expenses' : 'Categories'}
            </button>
          ))}
        </nav>
      </div>

      {/* Expenses Tab */}
      {tab === 'expenses' && (
        <>
          {/* Summary Card */}
          <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
            <div className="card p-4">
              <p className="text-xs text-gray-500 uppercase tracking-wide">Total (this page)</p>
              <p className="text-2xl font-bold text-gray-900 mt-1">
                {totalAmount.toFixed(2)}
              </p>
            </div>
            <div className="card p-4">
              <p className="text-xs text-gray-500 uppercase tracking-wide">Records</p>
              <p className="text-2xl font-bold text-gray-900 mt-1">{meta?.total ?? 0}</p>
            </div>
            <div className="card p-4">
              <p className="text-xs text-gray-500 uppercase tracking-wide">Categories</p>
              <p className="text-2xl font-bold text-gray-900 mt-1">{categories.length}</p>
            </div>
          </div>

          <div className="card overflow-hidden">
            <div className="overflow-x-auto">
              <table className="w-full">
                <thead className="bg-gray-50 border-b border-gray-200">
                  <tr>
                    <th className="table-header">Date</th>
                    <th className="table-header">Category</th>
                    <th className="table-header">Amount</th>
                    <th className="table-header">Notes</th>
                    <th className="table-header">Actions</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-gray-100">
                  {expensesQ.isLoading ? (
                    <tr><td colSpan={5} className="table-cell text-center py-10 text-gray-400">Loading…</td></tr>
                  ) : expenses.length === 0 ? (
                    <tr><td colSpan={5} className="table-cell text-center py-10 text-gray-400">No expenses recorded</td></tr>
                  ) : expenses.map((exp) => (
                    <tr key={exp.id} className="hover:bg-gray-50">
                      <td className="table-cell text-sm">{new Date(exp.date).toLocaleDateString()}</td>
                      <td className="table-cell">
                        {exp.expenseCategory ? (
                          <span className="badge-blue">{exp.expenseCategory.name}</span>
                        ) : (
                          <span className="text-gray-400 text-xs">—</span>
                        )}
                      </td>
                      <td className="table-cell font-semibold">{Number(exp.amount).toFixed(2)}</td>
                      <td className="table-cell text-gray-500 text-sm">{exp.notes ?? '—'}</td>
                      <td className="table-cell">
                        <div className="flex gap-2">
                          <button onClick={() => openEditExpense(exp)} className="text-blue-600 hover:underline text-xs">Edit</button>
                          <button onClick={() => deleteExpense(exp.id)} className="text-red-600 hover:underline text-xs">Delete</button>
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
        </>
      )}

      {/* Categories Tab */}
      {tab === 'categories' && (
        <div className="card overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="bg-gray-50 border-b border-gray-200">
                <tr>
                  <th className="table-header">Name</th>
                  <th className="table-header">Actions</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-100">
                {categoriesQ.isLoading ? (
                  <tr><td colSpan={2} className="table-cell text-center py-10 text-gray-400">Loading…</td></tr>
                ) : categories.length === 0 ? (
                  <tr><td colSpan={2} className="table-cell text-center py-10 text-gray-400">No categories found</td></tr>
                ) : categories.map((cat) => (
                  <tr key={cat.id} className="hover:bg-gray-50">
                    <td className="table-cell font-medium">{cat.name}</td>
                    <td className="table-cell">
                      <div className="flex gap-2">
                        <button onClick={() => { setCatForm({ name: cat.name }); setCatModal({ type: 'edit', id: cat.id }); }} className="text-blue-600 hover:underline text-xs">Edit</button>
                        <button onClick={() => deleteCategory(cat.id)} className="text-red-600 hover:underline text-xs">Delete</button>
                      </div>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      )}

      {/* Expense Modal */}
      <Modal open={!!modal} onClose={() => setModal(null)} title={`${modal?.type === 'create' ? 'Add' : 'Edit'} Expense`}>
        <div className="space-y-4">
          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className="form-label">Amount *</label>
              <input
                type="number"
                step="0.01"
                min="0"
                className="form-input"
                value={form.amount}
                onChange={(e) => setForm((f) => ({ ...f, amount: e.target.value }))}
              />
            </div>
            <div>
              <label className="form-label">Date *</label>
              <input
                type="date"
                className="form-input"
                value={form.date}
                onChange={(e) => setForm((f) => ({ ...f, date: e.target.value }))}
              />
            </div>
          </div>
          <div>
            <label className="form-label">Category</label>
            <select
              className="form-input"
              value={form.expenseCategoryId}
              onChange={(e) => setForm((f) => ({ ...f, expenseCategoryId: e.target.value }))}
            >
              <option value="">No category</option>
              {categories.map((cat) => (
                <option key={cat.id} value={cat.id}>{cat.name}</option>
              ))}
            </select>
          </div>
          <div>
            <label className="form-label">Notes</label>
            <textarea
              className="form-input resize-none"
              rows={2}
              value={form.notes}
              onChange={(e) => setForm((f) => ({ ...f, notes: e.target.value }))}
            />
          </div>
        </div>
        <div className="flex justify-end gap-3 mt-6">
          <button onClick={() => setModal(null)} className="btn-secondary">Cancel</button>
          <button onClick={saveExpense} className="btn-primary">Save</button>
        </div>
      </Modal>

      {/* Category Modal */}
      <Modal open={!!catModal} onClose={() => setCatModal(null)} title={`${catModal?.type === 'create' ? 'Add' : 'Edit'} Category`}>
        <div className="space-y-4">
          <div>
            <label className="form-label">Category Name *</label>
            <input
              className="form-input"
              value={catForm.name}
              onChange={(e) => setCatForm((f) => ({ ...f, name: e.target.value }))}
            />
          </div>
        </div>
        <div className="flex justify-end gap-3 mt-6">
          <button onClick={() => setCatModal(null)} className="btn-secondary">Cancel</button>
          <button onClick={saveCategory} className="btn-primary">Save</button>
        </div>
      </Modal>
    </div>
  );
}
