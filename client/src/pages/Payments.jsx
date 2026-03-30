import { useState } from 'react';
import { useQuery, useQueryClient } from '@tanstack/react-query';
import toast from 'react-hot-toast';
import api from '../api/axios.js';
import Modal from '../components/Modal.jsx';
import Pagination from '../components/Pagination.jsx';

const PAYMENT_METHODS = ['cash', 'card', 'online', 'bank_transfer', 'other'];

const STATUS_COLORS = {
  completed: 'bg-green-100 text-green-700',
  pending: 'bg-yellow-100 text-yellow-700',
  failed: 'bg-red-100 text-red-700',
};

export default function Payments() {
  const qc = useQueryClient();
  const [tab, setTab] = useState('payments');
  const [page, setPage] = useState(1);
  const [duePage, setDuePage] = useState(1);
  const [payModal, setPayModal] = useState(null); // { orderId, orderNumber, total }
  const [payForm, setPayForm] = useState({ amount: '', method: 'cash' });

  // ── Queries ──────────────────────────────────────────────────────────────
  const paymentsQ = useQuery({
    queryKey: ['payments', page],
    queryFn: () => api.get(`/payments?page=${page}`).then((r) => r.data),
    enabled: tab === 'payments',
  });

  const dueQ = useQuery({
    queryKey: ['payments-due', duePage],
    queryFn: () => api.get(`/payments/due/list?page=${duePage}`).then((r) => r.data),
    enabled: tab === 'due',
  });

  const payments = paymentsQ.data?.data ?? [];
  const payMeta = paymentsQ.data?.meta;
  const dueOrders = dueQ.data?.data ?? [];
  const dueMeta = dueQ.data?.meta;

  // ── Record payment ────────────────────────────────────────────────────────
  const openPayModal = (order) => {
    setPayForm({ amount: Number(order.dueAmount ?? order.total).toFixed(2), method: 'cash' });
    setPayModal({ orderId: order.id, orderNumber: order.orderNumber, total: order.total, due: order.dueAmount ?? order.total });
  };

  const recordPayment = async () => {
    if (!payForm.amount || !payForm.method) {
      toast.error('Amount and method required');
      return;
    }
    try {
      await api.post('/payments', {
        orderId: payModal.orderId,
        amount: payForm.amount,
        method: payForm.method,
        status: 'completed',
      });
      toast.success('Payment recorded!');
      qc.invalidateQueries({ queryKey: ['payments'] });
      qc.invalidateQueries({ queryKey: ['payments-due'] });
      qc.invalidateQueries({ queryKey: ['orders'] });
      setPayModal(null);
    } catch (e) {
      toast.error(e.response?.data?.message || 'Failed to record payment');
    }
  };

  const deletePayment = async (id) => {
    if (!confirm('Delete this payment record?')) return;
    try {
      await api.delete(`/payments/${id}`);
      qc.invalidateQueries({ queryKey: ['payments'] });
      toast.success('Deleted');
    } catch (e) {
      toast.error(e.response?.data?.message || 'Error');
    }
  };

  const totalRevenue = payments.reduce((s, p) => s + (p.status === 'completed' ? Number(p.amount) : 0), 0);

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <h1 className="text-2xl font-bold text-gray-900">Payments</h1>
      </div>

      {/* Tabs */}
      <div className="border-b border-gray-200">
        <nav className="flex gap-6">
          {[
            { key: 'payments', label: 'All Payments' },
            { key: 'due', label: 'Due Payments' },
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

      {/* All Payments Tab */}
      {tab === 'payments' && (
        <>
          {/* Summary */}
          <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
            <div className="card p-4">
              <p className="text-xs text-gray-500 uppercase tracking-wide">Total (this page)</p>
              <p className="text-2xl font-bold text-green-600 mt-1">{totalRevenue.toFixed(2)}</p>
            </div>
            <div className="card p-4">
              <p className="text-xs text-gray-500 uppercase tracking-wide">Records</p>
              <p className="text-2xl font-bold text-gray-900 mt-1">{payMeta?.total ?? 0}</p>
            </div>
            <div className="card p-4">
              <p className="text-xs text-gray-500 uppercase tracking-wide">On This Page</p>
              <p className="text-2xl font-bold text-gray-900 mt-1">{payments.length}</p>
            </div>
          </div>

          <div className="card overflow-hidden">
            <div className="overflow-x-auto">
              <table className="w-full">
                <thead className="bg-gray-50 border-b border-gray-200">
                  <tr>
                    <th className="table-header">Order #</th>
                    <th className="table-header">Table</th>
                    <th className="table-header">Customer</th>
                    <th className="table-header">Amount</th>
                    <th className="table-header">Method</th>
                    <th className="table-header">Status</th>
                    <th className="table-header">Date</th>
                    <th className="table-header">Actions</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-gray-100">
                  {paymentsQ.isLoading ? (
                    <tr><td colSpan={8} className="table-cell text-center py-10 text-gray-400">Loading…</td></tr>
                  ) : payments.length === 0 ? (
                    <tr><td colSpan={8} className="table-cell text-center py-10 text-gray-400">No payments found</td></tr>
                  ) : payments.map((p) => (
                    <tr key={p.id} className="hover:bg-gray-50">
                      <td className="table-cell font-mono font-medium">{p.order?.orderNumber ?? '—'}</td>
                      <td className="table-cell">{p.order?.table?.tableName ?? '—'}</td>
                      <td className="table-cell">{p.order?.customer?.name ?? '—'}</td>
                      <td className="table-cell font-semibold">{Number(p.amount).toFixed(2)}</td>
                      <td className="table-cell capitalize">{p.method.replace('_', ' ')}</td>
                      <td className="table-cell">
                        <span className={`text-xs px-2 py-1 rounded-full font-medium ${STATUS_COLORS[p.status] || 'bg-gray-100 text-gray-600'}`}>
                          {p.status}
                        </span>
                      </td>
                      <td className="table-cell text-xs text-gray-500">{new Date(p.createdAt).toLocaleString()}</td>
                      <td className="table-cell">
                        <button onClick={() => deletePayment(p.id)} className="text-red-600 hover:underline text-xs">Delete</button>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
            {payMeta && (
              <Pagination page={page} lastPage={payMeta.last_page} total={payMeta.total} perPage={payMeta.per_page} onPageChange={setPage} />
            )}
          </div>
        </>
      )}

      {/* Due Payments Tab */}
      {tab === 'due' && (
        <div className="card overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="bg-gray-50 border-b border-gray-200">
                <tr>
                  <th className="table-header">Order #</th>
                  <th className="table-header">Table</th>
                  <th className="table-header">Customer</th>
                  <th className="table-header">Total</th>
                  <th className="table-header">Paid</th>
                  <th className="table-header">Due</th>
                  <th className="table-header">Status</th>
                  <th className="table-header">Actions</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-100">
                {dueQ.isLoading ? (
                  <tr><td colSpan={8} className="table-cell text-center py-10 text-gray-400">Loading…</td></tr>
                ) : dueOrders.length === 0 ? (
                  <tr><td colSpan={8} className="table-cell text-center py-10 text-gray-400">No due payments 🎉</td></tr>
                ) : dueOrders.map((order) => (
                  <tr key={order.id} className="hover:bg-gray-50">
                    <td className="table-cell font-mono font-medium">{order.orderNumber}</td>
                    <td className="table-cell">{order.table?.tableName ?? '—'}</td>
                    <td className="table-cell">{order.customer?.name ?? '—'}</td>
                    <td className="table-cell font-medium">{Number(order.total).toFixed(2)}</td>
                    <td className="table-cell text-green-600">{Number(order.paidAmount).toFixed(2)}</td>
                    <td className="table-cell font-bold text-red-600">{Number(order.dueAmount).toFixed(2)}</td>
                    <td className="table-cell">
                      <span className="text-xs px-2 py-1 rounded-full bg-yellow-100 text-yellow-700 font-medium capitalize">
                        {order.status}
                      </span>
                    </td>
                    <td className="table-cell">
                      <button onClick={() => openPayModal(order)} className="text-blue-600 hover:underline text-xs font-medium">
                        Pay Now
                      </button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
          {dueMeta && (
            <Pagination page={duePage} lastPage={dueMeta.last_page} total={dueMeta.total} perPage={dueMeta.per_page} onPageChange={setDuePage} />
          )}
        </div>
      )}

      {/* Record Payment Modal */}
      <Modal open={!!payModal} onClose={() => setPayModal(null)} title={`Record Payment — Order ${payModal?.orderNumber}`}>
        <div className="space-y-4">
          <div className="bg-gray-50 rounded-lg p-3 text-sm">
            <div className="flex justify-between">
              <span className="text-gray-600">Order Total</span>
              <span className="font-semibold">{Number(payModal?.total ?? 0).toFixed(2)}</span>
            </div>
            <div className="flex justify-between mt-1">
              <span className="text-gray-600">Amount Due</span>
              <span className="font-bold text-red-600">{Number(payModal?.due ?? 0).toFixed(2)}</span>
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
          <button onClick={() => setPayModal(null)} className="btn-secondary">Cancel</button>
          <button onClick={recordPayment} className="btn-primary">Record Payment</button>
        </div>
      </Modal>
    </div>
  );
}
