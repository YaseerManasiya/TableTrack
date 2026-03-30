import { useState } from 'react';
import { useQuery, useQueryClient } from '@tanstack/react-query';
import toast from 'react-hot-toast';
import api from '../api/axios.js';
import Modal from '../components/Modal.jsx';
import Pagination from '../components/Pagination.jsx';

const STATUS_COLORS = {
  pending: 'badge-yellow',
  in_progress: 'badge-blue',
  completed: 'badge-green',
  cancelled: 'badge-red',
  paid: 'badge-green',
};

const ORDER_STATUSES = ['pending', 'in_progress', 'completed', 'cancelled'];
const PAYMENT_METHODS = ['cash', 'card', 'online', 'bank_transfer', 'other'];

export default function OrderManagement() {
  const qc = useQueryClient();
  const [page, setPage] = useState(1);
  const [status, setStatus] = useState('');
  const [selected, setSelected] = useState(null);
  const [payModal, setPayModal] = useState(false);
  const [payForm, setPayForm] = useState({ amount: '', method: 'cash' });
  const [payLoading, setPayLoading] = useState(false);

  const ordersQ = useQuery({
    queryKey: ['orders', page, status],
    queryFn: () => api.get(`/orders?page=${page}&per_page=20${status ? `&status=${status}` : ''}`).then((r) => r.data),
  });

  const orders = ordersQ.data?.data ?? [];
  const meta = ordersQ.data?.meta;

  const updateStatus = async (id, newStatus) => {
    try {
      await api.put(`/orders/${id}/status`, { status: newStatus });
      qc.invalidateQueries({ queryKey: ['orders'] });
      if (selected?.id === id) {
        setSelected((s) => ({ ...s, status: newStatus }));
      }
      toast.success('Status updated');
    } catch (e) { toast.error('Failed'); }
  };

  const viewOrder = async (id) => {
    try {
      const { data } = await api.get(`/orders/${id}`);
      setSelected(data.data);
    } catch { toast.error('Failed to load order'); }
  };

  const openPayModal = () => {
    const paid = (selected?.payments ?? [])
      .filter((p) => p.status === 'completed')
      .reduce((s, p) => s + Number(p.amount), 0);
    const due = Math.max(0, Number(selected?.total ?? 0) - paid);
    setPayForm({ amount: due.toFixed(2), method: 'cash' });
    setPayModal(true);
  };

  const recordPayment = async () => {
    if (!payForm.amount || !payForm.method) { toast.error('Amount and method required'); return; }
    setPayLoading(true);
    try {
      await api.post('/payments', {
        orderId: selected.id,
        amount: payForm.amount,
        method: payForm.method,
        status: 'completed',
      });
      toast.success('Payment recorded!');
      // Refresh order detail
      const { data } = await api.get(`/orders/${selected.id}`);
      setSelected(data.data);
      qc.invalidateQueries({ queryKey: ['orders'] });
      qc.invalidateQueries({ queryKey: ['payments'] });
      setPayModal(false);
    } catch (e) {
      toast.error(e.response?.data?.message || 'Failed to record payment');
    } finally {
      setPayLoading(false);
    }
  };

  const paidAmount = (selected?.payments ?? [])
    .filter((p) => p.status === 'completed')
    .reduce((s, p) => s + Number(p.amount), 0);
  const dueAmount = Math.max(0, Number(selected?.total ?? 0) - paidAmount);

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <h1 className="text-2xl font-bold text-gray-900">Order Management</h1>
      </div>

      {/* Filters */}
      <div className="flex gap-2 flex-wrap">
        {['', ...ORDER_STATUSES].map((s) => (
          <button
            key={s}
            onClick={() => { setStatus(s); setPage(1); }}
            className={`px-3 py-1.5 rounded-lg text-sm font-medium transition-colors capitalize ${status === s ? 'bg-blue-600 text-white' : 'bg-white border border-gray-200 text-gray-700 hover:bg-gray-50'}`}
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
                <th className="table-header">Order #</th>
                <th className="table-header">Table</th>
                <th className="table-header">Customer</th>
                <th className="table-header">Type</th>
                <th className="table-header">Total</th>
                <th className="table-header">Status</th>
                <th className="table-header">Date</th>
                <th className="table-header">Actions</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-100">
              {ordersQ.isLoading ? (
                <tr><td colSpan={8} className="table-cell text-center py-10 text-gray-400">Loading…</td></tr>
              ) : orders.length === 0 ? (
                <tr><td colSpan={8} className="table-cell text-center py-10 text-gray-400">No orders found</td></tr>
              ) : orders.map((o) => (
                <tr key={o.id} className="hover:bg-gray-50">
                  <td className="table-cell font-mono font-medium">{o.orderNumber}</td>
                  <td className="table-cell">{o.table?.tableName ?? '—'}</td>
                  <td className="table-cell">{o.customer?.name ?? '—'}</td>
                  <td className="table-cell capitalize">{o.orderType?.replace('_', ' ')}</td>
                  <td className="table-cell font-medium">${Number(o.total).toFixed(2)}</td>
                  <td className="table-cell">
                    <span className={STATUS_COLORS[o.status] || 'badge-gray'}>{o.status}</span>
                  </td>
                  <td className="table-cell text-gray-500 text-xs">{new Date(o.createdAt).toLocaleString()}</td>
                  <td className="table-cell">
                    <button onClick={() => viewOrder(o.id)} className="text-blue-600 hover:underline text-xs mr-2">View</button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
        {meta && <Pagination page={page} lastPage={meta.last_page} total={meta.total} perPage={meta.per_page} onPageChange={setPage} />}
      </div>

      {/* Order Detail Modal */}
      <Modal open={!!selected} onClose={() => setSelected(null)} title={`Order ${selected?.orderNumber}`} size="lg">
        {selected && (
          <div className="space-y-4">
            <div className="grid grid-cols-2 gap-4 text-sm">
              <div><span className="text-gray-500">Table:</span> <span className="font-medium ml-1">{selected.table?.tableName ?? '—'}</span></div>
              <div><span className="text-gray-500">Type:</span> <span className="font-medium ml-1 capitalize">{selected.orderType}</span></div>
              <div><span className="text-gray-500">Customer:</span> <span className="font-medium ml-1">{selected.customer?.name ?? '—'}</span></div>
              <div><span className="text-gray-500">Status:</span> <span className={`ml-1 ${STATUS_COLORS[selected.status] || 'badge-gray'}`}>{selected.status}</span></div>
            </div>

            {/* Order items */}
            <div className="border border-gray-200 rounded-lg overflow-hidden">
              <table className="w-full text-sm">
                <thead className="bg-gray-50">
                  <tr>
                    <th className="table-header">Item</th>
                    <th className="table-header">Qty</th>
                    <th className="table-header">Price</th>
                    <th className="table-header">Subtotal</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-gray-100">
                  {selected.orderItems?.map((item) => (
                    <tr key={item.id}>
                      <td className="table-cell">
                        {item.name}
                        {item.notes && <p className="text-xs text-gray-400 mt-0.5">{item.notes}</p>}
                      </td>
                      <td className="table-cell">{item.quantity}</td>
                      <td className="table-cell">${Number(item.price).toFixed(2)}</td>
                      <td className="table-cell font-medium">${(item.price * item.quantity).toFixed(2)}</td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>

            {/* Totals */}
            <div className="space-y-1 text-sm text-right">
              <p>Subtotal: <span className="font-medium ml-2">${Number(selected.subtotal).toFixed(2)}</span></p>
              {(selected.orderTaxes?.length > 0) && selected.orderTaxes.map((t) => (
                <p key={t.id} className="text-gray-600">
                  {t.name} ({t.type === 'percentage' ? `${t.rate}%` : 'fixed'}):
                  <span className="font-medium ml-2">+${Number(t.amount).toFixed(2)}</span>
                </p>
              ))}
              {!(selected.orderTaxes?.length > 0) && Number(selected.taxAmount) > 0 && (
                <p>Tax: <span className="font-medium ml-2">${Number(selected.taxAmount).toFixed(2)}</span></p>
              )}
              {(selected.orderCharges?.length > 0) && selected.orderCharges.map((c, i) => (
                <p key={i} className="text-gray-600">
                  {c.name}:
                  <span className="font-medium ml-2">+${Number(c.amount).toFixed(2)}</span>
                </p>
              ))}
              {Number(selected.discount) > 0 && (
                <p>Discount: <span className="font-medium ml-2 text-green-600">-${Number(selected.discount).toFixed(2)}</span></p>
              )}
              <p className="text-base font-bold border-t pt-1 mt-1">Total: <span className="ml-2">${Number(selected.total).toFixed(2)}</span></p>
            </div>

            {/* Payment summary */}
            {(selected.payments?.length > 0 || dueAmount > 0) && (
              <div className="bg-gray-50 rounded-lg p-3 text-sm space-y-1">
                <p className="font-semibold text-gray-700 mb-2">Payment Status</p>
                {selected.payments?.map((p) => (
                  <div key={p.id} className="flex justify-between">
                    <span className="text-gray-600 capitalize">{p.method.replace('_', ' ')} ({p.status})</span>
                    <span className="font-medium">${Number(p.amount).toFixed(2)}</span>
                  </div>
                ))}
                <div className="flex justify-between border-t pt-1 mt-1">
                  <span className="font-medium">Paid</span>
                  <span className="font-bold text-green-600">${paidAmount.toFixed(2)}</span>
                </div>
                {dueAmount > 0 && (
                  <div className="flex justify-between">
                    <span className="font-medium">Due</span>
                    <span className="font-bold text-red-600">${dueAmount.toFixed(2)}</span>
                  </div>
                )}
              </div>
            )}

            {/* Status update */}
            <div>
              <label className="form-label">Update Status</label>
              <div className="flex gap-2 flex-wrap">
                {ORDER_STATUSES.map((s) => (
                  <button
                    key={s}
                    onClick={() => updateStatus(selected.id, s)}
                    disabled={selected.status === s}
                    className={`px-3 py-1.5 rounded-lg text-xs font-medium capitalize transition-colors ${selected.status === s ? 'bg-gray-200 text-gray-400 cursor-not-allowed' : 'bg-blue-600 text-white hover:bg-blue-700'}`}
                  >
                    {s.replace('_', ' ')}
                  </button>
                ))}
              </div>
            </div>

            {/* Record payment button */}
            {selected.status !== 'cancelled' && dueAmount > 0 && (
              <div className="pt-2 border-t border-gray-200">
                <button onClick={openPayModal} className="btn-primary w-full justify-center">
                  💳 Record Payment (${dueAmount.toFixed(2)} due)
                </button>
              </div>
            )}
          </div>
        )}
      </Modal>

      {/* Payment recording modal */}
      <Modal open={payModal} onClose={() => setPayModal(false)} title={`Record Payment — ${selected?.orderNumber}`}>
        <div className="space-y-4">
          <div className="bg-gray-50 rounded-lg p-3 text-sm">
            <div className="flex justify-between">
              <span className="text-gray-600">Order Total</span>
              <span className="font-semibold">${Number(selected?.total ?? 0).toFixed(2)}</span>
            </div>
            <div className="flex justify-between mt-1">
              <span className="text-gray-600">Amount Due</span>
              <span className="font-bold text-red-600">${dueAmount.toFixed(2)}</span>
            </div>
          </div>
          <div>
            <label className="form-label">Amount *</label>
            <input
              type="number"
              step="0.01"
              min="0"
              className="form-input"
              value={payForm.amount}
              onChange={(e) => setPayForm((f) => ({ ...f, amount: e.target.value }))}
            />
          </div>
          <div>
            <label className="form-label">Payment Method *</label>
            <select
              className="form-input"
              value={payForm.method}
              onChange={(e) => setPayForm((f) => ({ ...f, method: e.target.value }))}
            >
              {PAYMENT_METHODS.map((m) => (
                <option key={m} value={m}>{m.replace('_', ' ')}</option>
              ))}
            </select>
          </div>
        </div>
        <div className="flex justify-end gap-3 mt-6">
          <button onClick={() => setPayModal(false)} className="btn-secondary">Cancel</button>
          <button onClick={recordPayment} disabled={payLoading} className="btn-primary">
            {payLoading ? 'Recording…' : 'Record Payment'}
          </button>
        </div>
      </Modal>
    </div>
  );
}

