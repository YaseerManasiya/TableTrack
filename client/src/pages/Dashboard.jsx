import { useQuery } from '@tanstack/react-query';
import { Link } from 'react-router-dom';
import api from '../api/axios.js';

const STATUS_COLORS = {
  pending: 'bg-yellow-100 text-yellow-700',
  in_progress: 'bg-blue-100 text-blue-700',
  completed: 'bg-green-100 text-green-700',
  cancelled: 'bg-red-100 text-red-700',
};

function StatCard({ label, value, icon, color, to }) {
  const colors = {
    blue: 'bg-blue-50 text-blue-600',
    green: 'bg-green-50 text-green-600',
    yellow: 'bg-yellow-50 text-yellow-600',
    purple: 'bg-purple-50 text-purple-600',
    pink: 'bg-pink-50 text-pink-600',
  };
  const inner = (
    <div className="card p-6 hover:shadow-md transition-shadow">
      <div className="flex items-center justify-between">
        <div>
          <p className="text-sm text-gray-500 font-medium">{label}</p>
          <p className="text-3xl font-bold text-gray-900 mt-1">{value ?? '—'}</p>
        </div>
        <div className={`w-12 h-12 rounded-xl flex items-center justify-center text-2xl ${colors[color]}`}>
          {icon}
        </div>
      </div>
    </div>
  );
  return to ? <Link to={to}>{inner}</Link> : inner;
}

function TableStatusCard({ stats }) {
  return (
    <div className="card p-6">
      <h3 className="text-sm font-semibold text-gray-700 mb-4">Table Status</h3>
      <div className="grid grid-cols-3 gap-3">
        <div className="text-center">
          <p className="text-2xl font-bold text-green-600">{stats?.available ?? 0}</p>
          <p className="text-xs text-gray-500 mt-1">Available</p>
        </div>
        <div className="text-center">
          <p className="text-2xl font-bold text-blue-600">{stats?.running ?? 0}</p>
          <p className="text-xs text-gray-500 mt-1">Running</p>
        </div>
        <div className="text-center">
          <p className="text-2xl font-bold text-yellow-600">{stats?.reserved ?? 0}</p>
          <p className="text-xs text-gray-500 mt-1">Reserved</p>
        </div>
      </div>
    </div>
  );
}

export default function Dashboard() {
  const { data, isLoading, error } = useQuery({
    queryKey: ['dashboard-stats'],
    queryFn: () => api.get('/dashboard/stats').then((r) => r.data.data),
    refetchInterval: 30_000,
  });

  if (isLoading) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="w-8 h-8 border-4 border-blue-600 border-t-transparent rounded-full animate-spin" />
      </div>
    );
  }

  if (error) {
    return (
      <div className="card p-6 text-center text-red-600">
        Failed to load dashboard stats. Please refresh.
      </div>
    );
  }

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold text-gray-900">Dashboard</h1>
        <p className="text-gray-500 text-sm mt-1">Today's overview at a glance</p>
      </div>

      {/* Stats row */}
      <div className="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-5 gap-4">
        <StatCard label="Orders Today" value={data?.ordersToday} icon="📋" color="blue" to="/orders" />
        <StatCard
          label="Revenue Today"
          value={`$${Number(data?.revenueToday ?? 0).toFixed(2)}`}
          icon="💰"
          color="green"
          to="/payments"
        />
        <StatCard label="Pending KOTs" value={data?.pendingKots} icon="🍳" color="yellow" to="/kots" />
        <StatCard
          label="Total Tables"
          value={
            (data?.tableStats?.available ?? 0) +
            (data?.tableStats?.running ?? 0) +
            (data?.tableStats?.reserved ?? 0)
          }
          icon="🪑"
          color="purple"
          to="/tables"
        />
        <StatCard label="New Customers" value={data?.customersToday} icon="👥" color="pink" to="/customers" />
      </div>

      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
        {/* Table Status */}
        <TableStatusCard stats={data?.tableStats} />

        {/* Quick Actions */}
        <div className="card p-6">
          <h3 className="text-sm font-semibold text-gray-700 mb-4">Quick Actions</h3>
          <div className="grid grid-cols-2 gap-3">
            {[
              { href: '/pos', label: 'New Order', icon: '🖥️', bg: 'bg-blue-600' },
              { href: '/orders', label: 'View Orders', icon: '📋', bg: 'bg-indigo-600' },
              { href: '/kots', label: 'KOT Board', icon: '🍳', bg: 'bg-orange-500' },
              { href: '/reservations', label: 'Reservations', icon: '📅', bg: 'bg-green-600' },
            ].map(({ href, label, icon, bg }) => (
              <Link
                key={href}
                to={href}
                className={`${bg} text-white rounded-xl p-4 flex flex-col items-center gap-2 hover:opacity-90 transition-opacity text-center`}
              >
                <span className="text-2xl">{icon}</span>
                <span className="text-xs font-medium">{label}</span>
              </Link>
            ))}
          </div>
        </div>

        {/* More Quick Actions */}
        <div className="card p-6">
          <h3 className="text-sm font-semibold text-gray-700 mb-4">Management</h3>
          <div className="grid grid-cols-2 gap-3">
            {[
              { href: '/payments', label: 'Payments', icon: '💳', bg: 'bg-teal-600' },
              { href: '/waiter-requests', label: 'Waiter Req.', icon: '🔔', bg: 'bg-yellow-500' },
              { href: '/expenses', label: 'Expenses', icon: '💰', bg: 'bg-red-500' },
              { href: '/reports', label: 'Reports', icon: '📈', bg: 'bg-purple-600' },
            ].map(({ href, label, icon, bg }) => (
              <Link
                key={href}
                to={href}
                className={`${bg} text-white rounded-xl p-4 flex flex-col items-center gap-2 hover:opacity-90 transition-opacity text-center`}
              >
                <span className="text-2xl">{icon}</span>
                <span className="text-xs font-medium">{label}</span>
              </Link>
            ))}
          </div>
        </div>
      </div>

      {/* Recent Orders */}
      {data?.recentOrders?.length > 0 && (
        <div className="card overflow-hidden">
          <div className="px-4 py-3 border-b border-gray-200 flex items-center justify-between">
            <h3 className="font-semibold text-gray-700">Recent Orders</h3>
            <Link to="/orders" className="text-blue-600 text-xs hover:underline">View all →</Link>
          </div>
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="bg-gray-50 border-b border-gray-200">
                <tr>
                  <th className="table-header">Order #</th>
                  <th className="table-header">Table</th>
                  <th className="table-header">Customer</th>
                  <th className="table-header">Total</th>
                  <th className="table-header">Status</th>
                  <th className="table-header">Time</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-100">
                {data.recentOrders.map((order) => (
                  <tr key={order.id} className="hover:bg-gray-50">
                    <td className="table-cell font-mono font-medium">{order.orderNumber}</td>
                    <td className="table-cell">{order.table?.tableName ?? '—'}</td>
                    <td className="table-cell">{order.customer?.name ?? '—'}</td>
                    <td className="table-cell font-medium">${Number(order.total).toFixed(2)}</td>
                    <td className="table-cell">
                      <span className={`text-xs px-2 py-1 rounded-full font-medium ${STATUS_COLORS[order.status] || 'bg-gray-100 text-gray-600'}`}>
                        {order.status}
                      </span>
                    </td>
                    <td className="table-cell text-xs text-gray-500">{new Date(order.createdAt).toLocaleTimeString()}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      )}
    </div>
  );
}

