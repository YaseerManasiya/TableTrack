import { useState, useEffect } from 'react';
import { useQuery, useQueryClient } from '@tanstack/react-query';
import toast from 'react-hot-toast';
import api from '../api/axios.js';
import Modal from '../components/Modal.jsx';

const emptyTax = { name: '', rate: '', type: 'percentage', isActive: true };
const emptyCharge = { name: '', amount: '', type: 'fixed', orderType: '', isActive: true };

export default function Settings() {
  const qc = useQueryClient();
  const [tab, setTab] = useState('restaurant');
  const [form, setForm] = useState(null);
  const [loading, setLoading] = useState(false);

  // Tax state
  const [taxModal, setTaxModal] = useState(null);
  const [taxForm, setTaxForm] = useState(emptyTax);

  // Charge state
  const [chargeModal, setChargeModal] = useState(null);
  const [chargeForm, setChargeForm] = useState(emptyCharge);

  // ── Queries ───────────────────────────────────────────────────────────────
  const settingsQ = useQuery({
    queryKey: ['settings'],
    queryFn: () => api.get('/settings/restaurant').then((r) => r.data.data),
  });

  const taxesQ = useQuery({
    queryKey: ['settings-taxes'],
    queryFn: () => api.get('/settings/taxes').then((r) => r.data.data),
  });

  const chargesQ = useQuery({
    queryKey: ['settings-charges'],
    queryFn: () => api.get('/settings/charges').then((r) => r.data.data),
  });

  useEffect(() => {
    if (settingsQ.data) {
      setForm({
        name: settingsQ.data.name ?? '',
        email: settingsQ.data.email ?? '',
        phone_number: settingsQ.data.phoneNumber ?? '',
      });
    }
  }, [settingsQ.data]);

  // ── Restaurant save ───────────────────────────────────────────────────────
  const saveRestaurant = async () => {
    setLoading(true);
    try {
      await api.put('/settings/restaurant', { name: form.name, email: form.email, phoneNumber: form.phone_number });
      qc.invalidateQueries({ queryKey: ['settings'] });
      toast.success('Settings saved!');
    } catch (e) {
      toast.error(e.response?.data?.message || 'Failed to save settings');
    } finally {
      setLoading(false);
    }
  };

  // ── Tax handlers ──────────────────────────────────────────────────────────
  const saveTax = async () => {
    try {
      if (taxModal?.type === 'create') {
        await api.post('/settings/taxes', taxForm);
        toast.success('Tax created!');
      } else {
        await api.put(`/settings/taxes/${taxModal.id}`, taxForm);
        toast.success('Tax updated!');
      }
      qc.invalidateQueries({ queryKey: ['settings-taxes'] });
      setTaxModal(null);
    } catch (e) {
      toast.error(e.response?.data?.message || 'Error');
    }
  };

  const deleteTax = async (id) => {
    if (!confirm('Delete this tax?')) return;
    try {
      await api.delete(`/settings/taxes/${id}`);
      qc.invalidateQueries({ queryKey: ['settings-taxes'] });
      toast.success('Deleted');
    } catch (e) {
      toast.error(e.response?.data?.message || 'Error');
    }
  };

  // ── Charge handlers ───────────────────────────────────────────────────────
  const saveCharge = async () => {
    try {
      if (chargeModal?.type === 'create') {
        await api.post('/settings/charges', chargeForm);
        toast.success('Charge created!');
      } else {
        await api.put(`/settings/charges/${chargeModal.id}`, chargeForm);
        toast.success('Charge updated!');
      }
      qc.invalidateQueries({ queryKey: ['settings-charges'] });
      setChargeModal(null);
    } catch (e) {
      toast.error(e.response?.data?.message || 'Error');
    }
  };

  const deleteCharge = async (id) => {
    if (!confirm('Delete this charge?')) return;
    try {
      await api.delete(`/settings/charges/${id}`);
      qc.invalidateQueries({ queryKey: ['settings-charges'] });
      toast.success('Deleted');
    } catch (e) {
      toast.error(e.response?.data?.message || 'Error');
    }
  };

  const taxes = taxesQ.data ?? [];
  const charges = chargesQ.data ?? [];

  if (settingsQ.isLoading || !form) {
    return (
      <div className="flex items-center justify-center h-40">
        <div className="w-8 h-8 border-4 border-blue-600 border-t-transparent rounded-full animate-spin" />
      </div>
    );
  }

  return (
    <div className="space-y-6">
      <h1 className="text-2xl font-bold text-gray-900">Settings</h1>

      {/* Tabs */}
      <div className="border-b border-gray-200">
        <nav className="flex gap-6">
          {[
            { key: 'restaurant', label: 'Restaurant' },
            { key: 'taxes', label: 'Taxes' },
            { key: 'charges', label: 'Charges' },
          ].map(({ key, label }) => (
            <button
              key={key}
              onClick={() => setTab(key)}
              className={`pb-3 text-sm font-medium border-b-2 transition-colors ${
                tab === key ? 'border-blue-600 text-blue-600' : 'border-transparent text-gray-500 hover:text-gray-700'
              }`}
            >
              {label}
            </button>
          ))}
        </nav>
      </div>

      {/* Restaurant Tab */}
      {tab === 'restaurant' && (
        <div className="card p-6 space-y-5 max-w-2xl">
          <h2 className="font-semibold text-gray-800">Restaurant Information</h2>
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
            <div>
              <label className="form-label">Restaurant Name</label>
              <input className="form-input" value={form.name} onChange={(e) => setForm((f) => ({ ...f, name: e.target.value }))} />
            </div>
            <div>
              <label className="form-label">Email</label>
              <input type="email" className="form-input" value={form.email} onChange={(e) => setForm((f) => ({ ...f, email: e.target.value }))} />
            </div>
            <div>
              <label className="form-label">Phone</label>
              <input className="form-input" value={form.phone_number} onChange={(e) => setForm((f) => ({ ...f, phone_number: e.target.value }))} />
            </div>
          </div>
          <div className="pt-2">
            <button onClick={saveRestaurant} disabled={loading} className="btn-primary">
              {loading ? 'Saving…' : 'Save Settings'}
            </button>
          </div>
        </div>
      )}

      {/* Taxes Tab */}
      {tab === 'taxes' && (
        <div className="space-y-4">
          <div className="flex justify-end">
            <button onClick={() => { setTaxForm(emptyTax); setTaxModal({ type: 'create' }); }} className="btn-primary">+ Add Tax</button>
          </div>
          <div className="card overflow-hidden">
            <div className="overflow-x-auto">
              <table className="w-full">
                <thead className="bg-gray-50 border-b border-gray-200">
                  <tr>
                    <th className="table-header">Name</th>
                    <th className="table-header">Rate</th>
                    <th className="table-header">Type</th>
                    <th className="table-header">Status</th>
                    <th className="table-header">Actions</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-gray-100">
                  {taxesQ.isLoading ? (
                    <tr><td colSpan={5} className="table-cell text-center py-10 text-gray-400">Loading…</td></tr>
                  ) : taxes.length === 0 ? (
                    <tr><td colSpan={5} className="table-cell text-center py-10 text-gray-400">No taxes configured</td></tr>
                  ) : taxes.map((tax) => (
                    <tr key={tax.id} className="hover:bg-gray-50">
                      <td className="table-cell font-medium">{tax.name}</td>
                      <td className="table-cell">{Number(tax.rate).toFixed(2)}{tax.type === 'percentage' ? '%' : ''}</td>
                      <td className="table-cell capitalize text-gray-500">{tax.type}</td>
                      <td className="table-cell">
                        <span className={`text-xs px-2 py-1 rounded-full font-medium ${tax.isActive ? 'bg-green-100 text-green-700' : 'bg-gray-100 text-gray-500'}`}>
                          {tax.isActive ? 'Active' : 'Inactive'}
                        </span>
                      </td>
                      <td className="table-cell">
                        <div className="flex gap-2">
                          <button onClick={() => { setTaxForm({ name: tax.name, rate: tax.rate, type: tax.type, isActive: tax.isActive }); setTaxModal({ type: 'edit', id: tax.id }); }} className="text-blue-600 hover:underline text-xs">Edit</button>
                          <button onClick={() => deleteTax(tax.id)} className="text-red-600 hover:underline text-xs">Delete</button>
                        </div>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </div>
        </div>
      )}

      {/* Charges Tab */}
      {tab === 'charges' && (
        <div className="space-y-4">
          <div className="flex justify-end">
            <button onClick={() => { setChargeForm(emptyCharge); setChargeModal({ type: 'create' }); }} className="btn-primary">+ Add Charge</button>
          </div>
          <div className="card overflow-hidden">
            <div className="overflow-x-auto">
              <table className="w-full">
                <thead className="bg-gray-50 border-b border-gray-200">
                  <tr>
                    <th className="table-header">Name</th>
                    <th className="table-header">Amount</th>
                    <th className="table-header">Type</th>
                    <th className="table-header">Order Type</th>
                    <th className="table-header">Status</th>
                    <th className="table-header">Actions</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-gray-100">
                  {chargesQ.isLoading ? (
                    <tr><td colSpan={6} className="table-cell text-center py-10 text-gray-400">Loading…</td></tr>
                  ) : charges.length === 0 ? (
                    <tr><td colSpan={6} className="table-cell text-center py-10 text-gray-400">No charges configured</td></tr>
                  ) : charges.map((charge) => (
                    <tr key={charge.id} className="hover:bg-gray-50">
                      <td className="table-cell font-medium">{charge.name}</td>
                      <td className="table-cell">{Number(charge.amount).toFixed(2)}{charge.type === 'percentage' ? '%' : ''}</td>
                      <td className="table-cell capitalize text-gray-500">{charge.type}</td>
                      <td className="table-cell text-gray-500">{charge.orderType ?? 'All'}</td>
                      <td className="table-cell">
                        <span className={`text-xs px-2 py-1 rounded-full font-medium ${charge.isActive ? 'bg-green-100 text-green-700' : 'bg-gray-100 text-gray-500'}`}>
                          {charge.isActive ? 'Active' : 'Inactive'}
                        </span>
                      </td>
                      <td className="table-cell">
                        <div className="flex gap-2">
                          <button onClick={() => { setChargeForm({ name: charge.name, amount: charge.amount, type: charge.type, orderType: charge.orderType ?? '', isActive: charge.isActive }); setChargeModal({ type: 'edit', id: charge.id }); }} className="text-blue-600 hover:underline text-xs">Edit</button>
                          <button onClick={() => deleteCharge(charge.id)} className="text-red-600 hover:underline text-xs">Delete</button>
                        </div>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </div>
        </div>
      )}

      {/* Tax Modal */}
      <Modal open={!!taxModal} onClose={() => setTaxModal(null)} title={`${taxModal?.type === 'create' ? 'Add' : 'Edit'} Tax`}>
        <div className="space-y-4">
          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className="form-label">Name *</label>
              <input className="form-input" value={taxForm.name} onChange={(e) => setTaxForm((f) => ({ ...f, name: e.target.value }))} />
            </div>
            <div>
              <label className="form-label">Rate *</label>
              <input type="number" step="0.01" min="0" className="form-input" value={taxForm.rate} onChange={(e) => setTaxForm((f) => ({ ...f, rate: e.target.value }))} />
            </div>
          </div>
          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className="form-label">Type</label>
              <select className="form-input" value={taxForm.type} onChange={(e) => setTaxForm((f) => ({ ...f, type: e.target.value }))}>
                <option value="percentage">Percentage</option>
                <option value="fixed">Fixed</option>
              </select>
            </div>
            <div className="flex items-end pb-1">
              <label className="flex items-center gap-2 cursor-pointer">
                <input type="checkbox" className="w-4 h-4 text-blue-600 rounded border-gray-300" checked={taxForm.isActive} onChange={(e) => setTaxForm((f) => ({ ...f, isActive: e.target.checked }))} />
                <span className="text-sm text-gray-700">Active</span>
              </label>
            </div>
          </div>
        </div>
        <div className="flex justify-end gap-3 mt-6">
          <button onClick={() => setTaxModal(null)} className="btn-secondary">Cancel</button>
          <button onClick={saveTax} className="btn-primary">Save</button>
        </div>
      </Modal>

      {/* Charge Modal */}
      <Modal open={!!chargeModal} onClose={() => setChargeModal(null)} title={`${chargeModal?.type === 'create' ? 'Add' : 'Edit'} Charge`}>
        <div className="space-y-4">
          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className="form-label">Name *</label>
              <input className="form-input" value={chargeForm.name} onChange={(e) => setChargeForm((f) => ({ ...f, name: e.target.value }))} />
            </div>
            <div>
              <label className="form-label">Amount *</label>
              <input type="number" step="0.01" min="0" className="form-input" value={chargeForm.amount} onChange={(e) => setChargeForm((f) => ({ ...f, amount: e.target.value }))} />
            </div>
          </div>
          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className="form-label">Type</label>
              <select className="form-input" value={chargeForm.type} onChange={(e) => setChargeForm((f) => ({ ...f, type: e.target.value }))}>
                <option value="fixed">Fixed</option>
                <option value="percentage">Percentage</option>
              </select>
            </div>
            <div>
              <label className="form-label">Order Type</label>
              <select className="form-input" value={chargeForm.orderType} onChange={(e) => setChargeForm((f) => ({ ...f, orderType: e.target.value }))}>
                <option value="">All</option>
                <option value="dine_in">Dine In</option>
                <option value="takeaway">Takeaway</option>
                <option value="delivery">Delivery</option>
              </select>
            </div>
          </div>
          <div>
            <label className="flex items-center gap-2 cursor-pointer">
              <input type="checkbox" className="w-4 h-4 text-blue-600 rounded border-gray-300" checked={chargeForm.isActive} onChange={(e) => setChargeForm((f) => ({ ...f, isActive: e.target.checked }))} />
              <span className="text-sm text-gray-700">Active</span>
            </label>
          </div>
        </div>
        <div className="flex justify-end gap-3 mt-6">
          <button onClick={() => setChargeModal(null)} className="btn-secondary">Cancel</button>
          <button onClick={saveCharge} className="btn-primary">Save</button>
        </div>
      </Modal>
    </div>
  );
}

