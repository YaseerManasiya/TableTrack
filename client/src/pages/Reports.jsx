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

  const categoryQ = useQuery({
    queryKey: ['report-category', from, to],
    queryFn: () => api.get(`/reports/category?from=${from}&to=${to}`).then((r) => r.data.data),
    enabled: tab === 'category',
  });

  const expenseQ = useQuery({
    queryKey: ['report-expense', from, to],
    queryFn: () => api.get(`/reports/expense?from=${from}&to=${to}`).then((r) => r.data.data),
    enabled: tab === 'expense',
  });

  const outstandingQ = useQuery({
    queryKey: ['report-outstanding', from, to],
    queryFn: () => api.get(`/reports/outstanding?from=${from}&to=${to}`).then((r) => r.data.data),
    enabled: tab === 'outstanding',
  });

  const isLoading =
    salesQ.isLoading || itemsQ.isLoading || categoryQ.isLoading || expenseQ.isLoading || outstandingQ.isLoading;

  const tabs = [
    ['sales', 'Sales'],
    ['items', 'Items'],
    ['category', 'Category'],
    ['expense', 'Expenses'],
    ['outstanding', 'Outstanding'],
  ];

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
        <nav className="flex gap-6 overflow-x-auto">
          {tabs.map(([key, label]) => (
            <button
              key={key}
              onClick={() => setTab(key)}
              className={`pb-3 text-sm font-medium border-b-2 whitespace-nowrap transition-colors ${
                tab === key ? 'border-blue-600 text-blue-600' : 'border-transparent text-gray-500 hover:text-gray-700'
              }`}
            >
              {label}
            </button>
          ))}
        </nav>
      </div>

      {isLoading && (
        <div className="flex items-center justify-center h-40">
          <div className="w-8 h-8 border-4 border-blue-600 border-t-transparent rounded-full animate-spin" />
        </div>
      )}

      {/* ── Sales Report ──────────────────────────────────────────────────── */}
      {tab === 'sales' && salesQ.data && (
        <div className="space-y-4">
          <div className="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-4 gap-4">
            <div className="card p-5">
              <p className="text-sm text-gray-500">Total Revenue</p>
              <p className="text-3xl font-bold text-green-600 mt-1">{Number(salesQ.data.summary?.total ?? 0).toFixed(2)}</p>
            </div>
            <div className="card p-5">
              <p className="text-sm text-gray-500">Total Orders</p>
              <p className="text-3xl font-bold text-blue-600 mt-1">{salesQ.data.summary?.count ?? 0}</p>
            </div>
            <div className="card p-5">
              <p className="text-sm text-gray-500">Total Tax</p>
              <p className="text-3xl font-bold text-purple-600 mt-1">{Number(salesQ.data.summary?.taxAmount ?? 0).toFixed(2)}</p>
            </div>
            <div className="card p-5">
              <p className="text-sm text-gray-500">Total Discount</p>
              <p className="text-3xl font-bold text-orange-600 mt-1">{Number(salesQ.data.summary?.discount ?? 0).toFixed(2)}</p>
            </div>
          </div>
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
                    <th className="table-header">Type</th>
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
                      <td className="table-cell capitalize text-gray-500">{order.orderType?.replace('_', ' ')}</td>
                      <td className="table-cell font-medium">{Number(order.total).toFixed(2)}</td>
                      <td className="table-cell text-xs text-gray-500">{new Date(order.createdAt).toLocaleDateString()}</td>
                    </tr>
                  ))}
                  {!salesQ.data.orders?.length && (
                    <tr><td colSpan={6} className="table-cell text-center py-6 text-gray-400">No data for selected range</td></tr>
                  )}
                </tbody>
              </table>
            </div>
          </div>
        </div>
      )}

      {/* ── Items Report ──────────────────────────────────────────────────── */}
      {tab === 'items' && itemsQ.data && (
        <div className="card overflow-hidden">
          <div className="px-4 py-3 border-b border-gray-200">
            <h3 className="font-semibold text-gray-700">Top Items ({itemsQ.data.length})</h3>
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
                      <td className="table-cell font-medium">{Number(row._sum?.price ?? 0).toFixed(2)}</td>
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

      {/* ── Category Report ───────────────────────────────────────────────── */}
      {tab === 'category' && categoryQ.data && (
        <div className="card overflow-hidden">
          <div className="px-4 py-3 border-b border-gray-200">
            <h3 className="font-semibold text-gray-700">Sales by Category ({categoryQ.data.length})</h3>
          </div>
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="bg-gray-50 border-b border-gray-200">
                <tr>
                  <th className="table-header">#</th>
                  <th className="table-header">Category</th>
                  <th className="table-header">Items Sold</th>
                  <th className="table-header">Total Revenue</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-100">
                {categoryQ.data.map((row, i) => (
                  <tr key={row.categoryName} className="hover:bg-gray-50">
                    <td className="table-cell text-gray-400">{i + 1}</td>
                    <td className="table-cell font-medium">{row.categoryName}</td>
                    <td className="table-cell">{row.totalQty}</td>
                    <td className="table-cell font-medium">{Number(row.totalRevenue).toFixed(2)}</td>
                  </tr>
                ))}
                {!categoryQ.data?.length && (
                  <tr><td colSpan={4} className="table-cell text-center py-6 text-gray-400">No data for selected range</td></tr>
                )}
              </tbody>
            </table>
          </div>
        </div>
      )}

      {/* ── Expense Report ────────────────────────────────────────────────── */}
      {tab === 'expense' && expenseQ.data && (
        <div className="space-y-4">
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
            <div className="card p-5">
              <p className="text-sm text-gray-500">Total Expenses</p>
              <p className="text-3xl font-bold text-red-600 mt-1">{Number(expenseQ.data.summary?.total ?? 0).toFixed(2)}</p>
            </div>
            <div className="card p-5">
              <p className="text-sm text-gray-500">Number of Records</p>
              <p className="text-3xl font-bold text-gray-700 mt-1">{expenseQ.data.summary?.count ?? 0}</p>
            </div>
          </div>
          <div className="card overflow-hidden">
            <div className="px-4 py-3 border-b border-gray-200">
              <h3 className="font-semibold text-gray-700">Expense Entries ({expenseQ.data.expenses?.length ?? 0})</h3>
            </div>
            <div className="overflow-x-auto">
              <table className="w-full">
                <thead className="bg-gray-50 border-b border-gray-200">
                  <tr>
                    <th className="table-header">Date</th>
                    <th className="table-header">Category</th>
                    <th className="table-header">Amount</th>
                    <th className="table-header">Notes</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-gray-100">
                  {expenseQ.data.expenses?.map((exp) => (
                    <tr key={exp.id} className="hover:bg-gray-50">
                      <td className="table-cell text-sm">{new Date(exp.date).toLocaleDateString()}</td>
                      <td className="table-cell">
                        {exp.expenseCategory ? (
                          <span className="badge-blue">{exp.expenseCategory.name}</span>
                        ) : (
                          <span className="text-gray-400 text-xs">—</span>
                        )}
                      </td>
                      <td className="table-cell font-semibold text-red-600">{Number(exp.amount).toFixed(2)}</td>
                      <td className="table-cell text-gray-500 text-sm">{exp.notes ?? '—'}</td>
                    </tr>
                  ))}
                  {!expenseQ.data.expenses?.length && (
                    <tr><td colSpan={4} className="table-cell text-center py-6 text-gray-400">No expenses for selected range</td></tr>
                  )}
                </tbody>
              </table>
            </div>
          </div>
        </div>
      )}

      {/* ── Outstanding Payments Report ───────────────────────────────────── */}
      {tab === 'outstanding' && outstandingQ.data && (
        <div className="space-y-4">
          <div className="card p-5">
            <p className="text-sm text-gray-500">Total Outstanding</p>
            <p className="text-3xl font-bold text-red-600 mt-1">{Number(outstandingQ.data.totalDue ?? 0).toFixed(2)}</p>
          </div>
          <div className="card overflow-hidden">
            <div className="px-4 py-3 border-b border-gray-200">
              <h3 className="font-semibold text-gray-700">Unpaid Orders ({outstandingQ.data.orders?.length ?? 0})</h3>
            </div>
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
                    <th className="table-header">Date</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-gray-100">
                  {outstandingQ.data.orders?.map((order) => (
                    <tr key={order.id} className="hover:bg-gray-50">
                      <td className="table-cell font-mono font-medium">{order.orderNumber}</td>
                      <td className="table-cell">{order.table?.tableName ?? '—'}</td>
                      <td className="table-cell">{order.customer?.name ?? '—'}</td>
                      <td className="table-cell">{Number(order.total).toFixed(2)}</td>
                      <td className="table-cell text-green-600">{Number(order.paidAmount).toFixed(2)}</td>
                      <td className="table-cell font-bold text-red-600">{Number(order.dueAmount).toFixed(2)}</td>
                      <td className="table-cell text-xs text-gray-500">{new Date(order.createdAt).toLocaleDateString()}</td>
                    </tr>
                  ))}
                  {!outstandingQ.data.orders?.length && (
                    <tr><td colSpan={7} className="table-cell text-center py-6 text-gray-400">No outstanding payments 🎉</td></tr>
                  )}
                </tbody>
              </table>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}

