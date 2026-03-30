import { useQuery } from '@tanstack/react-query';
import api from '../api/axios.js';

function StatCard({ label, value, icon, color }) {
  const colors = {
    blue: 'bg-blue-50 text-blue-600',
    green: 'bg-green-50 text-green-600',
    yellow: 'bg-yellow-50 text-yellow-600',
    purple: 'bg-purple-50 text-purple-600',
  };
  return (
    <div className="card p-6">
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

      <div className="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-4 gap-4">
        <StatCard label="Orders Today" value={data?.ordersToday} icon="📋" color="blue" />
        <StatCard
          label="Revenue Today"
          value={`$${Number(data?.revenueToday ?? 0).toFixed(2)}`}
          icon="💰"
          color="green"
        />
        <StatCard label="Pending KOTs" value={data?.pendingKots} icon="🍳" color="yellow" />
        <StatCard
          label="Active Tables"
          value={
            (data?.tableStats?.available ?? 0) +
            (data?.tableStats?.running ?? 0) +
            (data?.tableStats?.reserved ?? 0)
          }
          icon="🪑"
          color="purple"
        />
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        <TableStatusCard stats={data?.tableStats} />
        <div className="card p-6">
          <h3 className="text-sm font-semibold text-gray-700 mb-4">Quick Actions</h3>
          <div className="grid grid-cols-2 gap-3">
            {[
              { href: '/pos', label: 'New Order', icon: '🖥️', bg: 'bg-blue-600' },
              { href: '/orders', label: 'View Orders', icon: '📋', bg: 'bg-indigo-600' },
              { href: '/kots', label: 'KOT Board', icon: '🍳', bg: 'bg-orange-500' },
              { href: '/reservations', label: 'Reservations', icon: '📅', bg: 'bg-green-600' },
            ].map(({ href, label, icon, bg }) => (
              <a
                key={href}
                href={href}
                className={`${bg} text-white rounded-xl p-4 flex flex-col items-center gap-2 hover:opacity-90 transition-opacity text-center`}
              >
                <span className="text-2xl">{icon}</span>
                <span className="text-xs font-medium">{label}</span>
              </a>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
}
