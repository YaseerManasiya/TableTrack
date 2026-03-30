import { useState } from 'react';
import { useQuery, useQueryClient } from '@tanstack/react-query';
import toast from 'react-hot-toast';
import api from '../api/axios.js';
import Modal from '../components/Modal.jsx';
import Pagination from '../components/Pagination.jsx';

const empty = { name: '', email: '', phoneNumber: '', address: '' };

const STATUS_COLORS = {
  pending: 'bg-yellow-100 text-yellow-700',
  in_progress: 'bg-blue-100 text-blue-700',
  completed: 'bg-green-100 text-green-700',
  cancelled: 'bg-red-100 text-red-700',
};

function CustomerOrdersModal({ customer, onClose }) {
  const [ordersPage, setOrdersPage] = useState(1);
  const ordersQ = useQuery({
    queryKey: ['customer-orders', customer.id, ordersPage],
    queryFn: () => api.get(`/customers/${customer.id}/orders?page=${ordersPage}`).then((r) => r.data),
  });
  const orders = ordersQ.data?.data ?? [];
  const meta = ordersQ.data?.meta;

  return (
    <Modal open onClose={onClose} title={`Orders — ${customer.name}`} size="lg">
      <div className="space-y-3">
        {ordersQ.isLoading ? (
          <p className="text-center py-8 text-gray-400">Loading…</p>
        ) : orders.length === 0 ? (
          <p className="text-center py-8 text-gray-400">No orders found for this customer.</p>
        ) : (
          <>
            <div className="overflow-x-auto">
              <table className="w-full">
                <thead className="bg-gray-50 border-b border-gray-200">
                  <tr>
                    <th className="table-header">Order #</th>
                    <th className="table-header">Type</th>
                    <th className="table-header">Table</th>
                    <th className="table-header">Total</th>
                    <th className="table-header">Status</th>
                    <th className="table-header">Date</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-gray-100">
                  {orders.map((order) => (
                    <tr key={order.id} className="hover:bg-gray-50">
                      <td className="table-cell font-mono font-medium">{order.orderNumber}</td>
                      <td className="table-cell capitalize text-gray-500">{order.orderType?.replace('_', ' ')}</td>
                      <td className="table-cell text-gray-500">{order.table?.tableName ?? '—'}</td>
                      <td className="table-cell font-medium">${Number(order.total).toFixed(2)}</td>
                      <td className="table-cell">
                        <span className={`text-xs px-2 py-1 rounded-full font-medium ${STATUS_COLORS[order.status] ?? 'bg-gray-100 text-gray-600'}`}>
                          {order.status}
                        </span>
                      </td>
                      <td className="table-cell text-xs text-gray-500">{new Date(order.createdAt).toLocaleDateString()}</td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
            {meta && (
              <Pagination
                page={ordersPage}
                lastPage={meta.last_page}
                total={meta.total}
                perPage={meta.per_page}
                onPageChange={setOrdersPage}
              />
            )}
          </>
        )}
        <div className="flex justify-end mt-2">
          <button onClick={onClose} className="btn-secondary">Close</button>
        </div>
      </div>
    </Modal>
  );
}

export default function CustomerManagement() {
  const qc = useQueryClient();
  const [page, setPage] = useState(1);
  const [search, setSearch] = useState('');
  const [modal, setModal] = useState(null);
  const [form, setForm] = useState(empty);
  const [ordersCustomer, setOrdersCustomer] = useState(null);

  const customersQ = useQuery({
    queryKey: ['customers', page, search],
    queryFn: () => api.get(`/customers?page=${page}&q=${search}`).then((r) => r.data),
  });

  const customers = customersQ.data?.data ?? [];
  const meta = customersQ.data?.meta;

  const save = async () => {
    try {
      if (modal.type === 'create') await api.post('/customers', form);
      else await api.put(`/customers/${modal.id}`, form);
      qc.invalidateQueries({ queryKey: ['customers'] });
      toast.success(modal.type === 'create' ? 'Customer added!' : 'Customer updated!');
      setModal(null);
    } catch (e) { toast.error(e.response?.data?.message || 'Error'); }
  };

  const handleDelete = async (id) => {
    if (!confirm('Delete this customer?')) return;
    try {
      await api.delete(`/customers/${id}`);
      qc.invalidateQueries({ queryKey: ['customers'] });
      toast.success('Deleted');
    } catch (e) { toast.error(e.response?.data?.message || 'Error'); }
  };

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <h1 className="text-2xl font-bold text-gray-900">Customers</h1>
        <button onClick={() => { setForm(empty); setModal({ type: 'create' }); }} className="btn-primary">+ Add Customer</button>
      </div>

      <input
        className="form-input max-w-xs"
        placeholder="Search by name or phone…"
        value={search}
        onChange={(e) => { setSearch(e.target.value); setPage(1); }}
      />

      <div className="card overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full">
            <thead className="bg-gray-50 border-b border-gray-200">
              <tr>
                <th className="table-header">Name</th>
                <th className="table-header">Email</th>
                <th className="table-header">Phone</th>
                <th className="table-header">Address</th>
                <th className="table-header">Actions</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-100">
              {customersQ.isLoading ? (
                <tr><td colSpan={5} className="table-cell text-center py-10 text-gray-400">Loading…</td></tr>
              ) : customers.length === 0 ? (
                <tr><td colSpan={5} className="table-cell text-center py-10 text-gray-400">No customers found</td></tr>
              ) : customers.map((c) => (
                <tr key={c.id} className="hover:bg-gray-50">
                  <td className="table-cell font-medium">{c.name}</td>
                  <td className="table-cell text-gray-500">{c.email ?? '—'}</td>
                  <td className="table-cell text-gray-500">{c.phoneNumber ?? '—'}</td>
                  <td className="table-cell text-gray-500 max-w-xs truncate">{c.address ?? '—'}</td>
                  <td className="table-cell">
                    <div className="flex gap-2">
                      <button onClick={() => setOrdersCustomer(c)} className="text-green-600 hover:underline text-xs">Orders</button>
                      <button onClick={() => { setForm({ name: c.name, email: c.email ?? '', phoneNumber: c.phoneNumber ?? '', address: c.address ?? '' }); setModal({ type: 'edit', id: c.id }); }} className="text-blue-600 hover:underline text-xs">Edit</button>
                      <button onClick={() => handleDelete(c.id)} className="text-red-600 hover:underline text-xs">Delete</button>
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
        {meta && <Pagination page={page} lastPage={meta.last_page} total={meta.total} perPage={meta.per_page} onPageChange={setPage} />}
      </div>

      <Modal open={!!modal} onClose={() => setModal(null)} title={`${modal?.type === 'create' ? 'Add' : 'Edit'} Customer`} size="sm">
        <div className="space-y-4">
          <div>
            <label className="form-label">Name *</label>
            <input className="form-input" value={form.name} onChange={(e) => setForm((f) => ({ ...f, name: e.target.value }))} />
          </div>
          <div>
            <label className="form-label">Email</label>
            <input type="email" className="form-input" value={form.email} onChange={(e) => setForm((f) => ({ ...f, email: e.target.value }))} />
          </div>
          <div>
            <label className="form-label">Phone</label>
            <input className="form-input" value={form.phoneNumber} onChange={(e) => setForm((f) => ({ ...f, phoneNumber: e.target.value }))} />
          </div>
          <div>
            <label className="form-label">Address</label>
            <textarea className="form-input resize-none" rows={2} value={form.address} onChange={(e) => setForm((f) => ({ ...f, address: e.target.value }))} />
          </div>
        </div>
        <div className="flex justify-end gap-3 mt-6">
          <button onClick={() => setModal(null)} className="btn-secondary">Cancel</button>
          <button onClick={save} className="btn-primary">Save</button>
        </div>
      </Modal>

      {ordersCustomer && (
        <CustomerOrdersModal customer={ordersCustomer} onClose={() => setOrdersCustomer(null)} />
      )}
    </div>
  );
}


export default function CustomerManagement() {
  const qc = useQueryClient();
  const [page, setPage] = useState(1);
  const [search, setSearch] = useState('');
  const [modal, setModal] = useState(null);
  const [form, setForm] = useState(empty);

  const customersQ = useQuery({
    queryKey: ['customers', page, search],
    queryFn: () => api.get(`/customers?page=${page}&q=${search}`).then((r) => r.data),
  });

  const customers = customersQ.data?.data ?? [];
  const meta = customersQ.data?.meta;

  const save = async () => {
    try {
      if (modal.type === 'create') await api.post('/customers', form);
      else await api.put(`/customers/${modal.id}`, form);
      qc.invalidateQueries({ queryKey: ['customers'] });
      toast.success(modal.type === 'create' ? 'Customer added!' : 'Customer updated!');
      setModal(null);
    } catch (e) { toast.error(e.response?.data?.message || 'Error'); }
  };

  const handleDelete = async (id) => {
    if (!confirm('Delete this customer?')) return;
    try {
      await api.delete(`/customers/${id}`);
      qc.invalidateQueries({ queryKey: ['customers'] });
      toast.success('Deleted');
    } catch (e) { toast.error(e.response?.data?.message || 'Error'); }
  };

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <h1 className="text-2xl font-bold text-gray-900">Customers</h1>
        <button onClick={() => { setForm(empty); setModal({ type: 'create' }); }} className="btn-primary">+ Add Customer</button>
      </div>

      <input
        className="form-input max-w-xs"
        placeholder="Search by name or phone…"
        value={search}
        onChange={(e) => { setSearch(e.target.value); setPage(1); }}
      />

      <div className="card overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full">
            <thead className="bg-gray-50 border-b border-gray-200">
              <tr>
                <th className="table-header">Name</th>
                <th className="table-header">Email</th>
                <th className="table-header">Phone</th>
                <th className="table-header">Address</th>
                <th className="table-header">Actions</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-100">
              {customersQ.isLoading ? (
                <tr><td colSpan={5} className="table-cell text-center py-10 text-gray-400">Loading…</td></tr>
              ) : customers.length === 0 ? (
                <tr><td colSpan={5} className="table-cell text-center py-10 text-gray-400">No customers found</td></tr>
              ) : customers.map((c) => (
                <tr key={c.id} className="hover:bg-gray-50">
                  <td className="table-cell font-medium">{c.name}</td>
                  <td className="table-cell text-gray-500">{c.email ?? '—'}</td>
                  <td className="table-cell text-gray-500">{c.phoneNumber ?? '—'}</td>
                  <td className="table-cell text-gray-500 max-w-xs truncate">{c.address ?? '—'}</td>
                  <td className="table-cell">
                    <div className="flex gap-2">
                      <button onClick={() => { setForm({ name: c.name, email: c.email ?? '', phoneNumber: c.phoneNumber ?? '', address: c.address ?? '' }); setModal({ type: 'edit', id: c.id }); }} className="text-blue-600 hover:underline text-xs">Edit</button>
                      <button onClick={() => handleDelete(c.id)} className="text-red-600 hover:underline text-xs">Delete</button>
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
        {meta && <Pagination page={page} lastPage={meta.last_page} total={meta.total} perPage={meta.per_page} onPageChange={setPage} />}
      </div>

      <Modal open={!!modal} onClose={() => setModal(null)} title={`${modal?.type === 'create' ? 'Add' : 'Edit'} Customer`} size="sm">
        <div className="space-y-4">
          <div>
            <label className="form-label">Name *</label>
            <input className="form-input" value={form.name} onChange={(e) => setForm((f) => ({ ...f, name: e.target.value }))} />
          </div>
          <div>
            <label className="form-label">Email</label>
            <input type="email" className="form-input" value={form.email} onChange={(e) => setForm((f) => ({ ...f, email: e.target.value }))} />
          </div>
          <div>
            <label className="form-label">Phone</label>
            <input className="form-input" value={form.phoneNumber} onChange={(e) => setForm((f) => ({ ...f, phoneNumber: e.target.value }))} />
          </div>
          <div>
            <label className="form-label">Address</label>
            <textarea className="form-input resize-none" rows={2} value={form.address} onChange={(e) => setForm((f) => ({ ...f, address: e.target.value }))} />
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
