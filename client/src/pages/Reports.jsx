import { useState } from 'react';
import { useQuery } from '@tanstack/react-query';
import api from '../api/axios.js';

const today = new Date().toISOString().slice(0, 10);
const thirtyDaysAgo = new Date(Date.now() - 30 * 86400000).toISOString().slice(0, 10);

export default function Reports() {
  const [tab, setTab] = useState('sales');
  const [from, setFrom] = useState(thirtyDaysAgo);
  const [to, setTo] = useState(today);

  const salesQ = useQuery({
    queryKey: ['report-sales', from, to],
    queryFn: () => api.get(`/reports/sales?from=${from}&to=${to}`).then((r) => r.data.data),
    enabled: tab === 'sales',
  });

  const itemsQ = useQuery({
    queryKey: ['report-items', from, to],
    queryFn: () => api.get(`/reports/items?from=${from}&to=${to}`).then((r) => r.data.data),
    enabled: tab === 'items',
  });

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <h1 className="text-2xl font-bold text-gray-900">Reports</h1>
      </div>

      {/* Date range */}
      <div className="card p-4 flex flex-wrap items-end gap-4">
        <div>
          <label className="form-label">From</label>
          <input type="date" className="form-input" value={from} max={to} onChange={(e) => setFrom(e.target.value)} />
        </div>
        <div>
          <label className="form-label">To</label>
          <input type="date" className="form-input" value={to} min={from} max={today} onChange={(e) => setTo(e.target.value)} />
        </div>
      </div>

      {/* Tabs */}
      <div className="border-b border-gray-200">
        <nav className="flex gap-6">
          {[['sales', 'Sales Report'], ['items', 'Item Report']].map(([key, label]) => (
            <button key={key} onClick={() => setTab(key)} className={`pb-3 text-sm font-medium border-b-2 transition-colors ${tab === key ? 'border-blue-600 text-blue-600' : 'border-transparent text-gray-500 hover:text-gray-700'}`}>
              {label}
            </button>
          ))}
        </nav>
      </div>

      {(salesQ.isLoading || itemsQ.isLoading) && (
        <div className="flex items-center justify-center h-40"><div className="w-8 h-8 border-4 border-blue-600 border-t-transparent rounded-full animate-spin" /></div>
      )}

      {tab === 'sales' && salesQ.data && (
        <div className="space-y-4">
          {/* Summary */}
          <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
            <div className="card p-5">
              <p className="text-sm text-gray-500">Total Revenue</p>
              <p className="text-3xl font-bold text-green-600 mt-1">${Number(salesQ.data.summary?.total ?? 0).toFixed(2)}</p>
            </div>
            <div className="card p-5">
              <p className="text-sm text-gray-500">Total Orders</p>
              <p className="text-3xl font-bold text-blue-600 mt-1">{salesQ.data.summary?.count ?? 0}</p>
            </div>
            <div className="card p-5">
              <p className="text-sm text-gray-500">Total Tax</p>
              <p className="text-3xl font-bold text-purple-600 mt-1">${Number(salesQ.data.summary?.taxAmount ?? 0).toFixed(2)}</p>
            </div>
          </div>

          {/* Orders table */}
          <div className="card overflow-hidden">
            <div className="px-4 py-3 border-b border-gray-200">
              <h3 className="font-semibold text-gray-700">Orders ({salesQ.data.orders?.length ?? 0})</h3>
            </div>
            <div className="overflow-x-auto">
              <table className="w-full">
                <thead className="bg-gray-50 border-b border-gray-200">
                  <tr>
                    <th className="table-header">Order #</th>
                    <th className="table-header">Table</th>
                    <th className="table-header">Customer</th>
                    <th className="table-header">Total</th>
                    <th className="table-header">Date</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-gray-100">
                  {salesQ.data.orders?.map((order) => (
                    <tr key={order.id} className="hover:bg-gray-50">
                      <td className="table-cell font-mono">{order.orderNumber}</td>
                      <td className="table-cell">{order.table?.tableName ?? '—'}</td>
                      <td className="table-cell">{order.customer?.name ?? '—'}</td>
                      <td className="table-cell font-medium">${Number(order.total).toFixed(2)}</td>
                      <td className="table-cell text-xs text-gray-500">{new Date(order.createdAt).toLocaleDateString()}</td>
                    </tr>
                  ))}
                  {!salesQ.data.orders?.length && (
                    <tr><td colSpan={5} className="table-cell text-center py-6 text-gray-400">No data for selected range</td></tr>
                  )}
                </tbody>
              </table>
            </div>
          </div>
        </div>
      )}

      {tab === 'items' && itemsQ.data && (
        <div className="card overflow-hidden">
          <div className="px-4 py-3 border-b border-gray-200">
            <h3 className="font-semibold text-gray-700">Top Items</h3>
          </div>
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="bg-gray-50 border-b border-gray-200">
                <tr>
                  <th className="table-header">#</th>
                  <th className="table-header">Item</th>
                  <th className="table-header">Qty Sold</th>
                  <th className="table-header">Revenue</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-100">
                {itemsQ.data
                  .sort((a, b) => (b._sum?.quantity ?? 0) - (a._sum?.quantity ?? 0))
                  .map((row, i) => (
                  <tr key={row.menuItemId ?? i} className="hover:bg-gray-50">
                    <td className="table-cell text-gray-400">{i + 1}</td>
                    <td className="table-cell font-medium">{row.name}</td>
                    <td className="table-cell">{row._sum?.quantity ?? 0}</td>
                    <td className="table-cell font-medium">${Number(row._sum?.price ?? 0).toFixed(2)}</td>
                  </tr>
                ))}
                {!itemsQ.data?.length && (
                  <tr><td colSpan={4} className="table-cell text-center py-6 text-gray-400">No data for selected range</td></tr>
                )}
              </tbody>
            </table>
          </div>
        </div>
      )}
    </div>
  );
}
