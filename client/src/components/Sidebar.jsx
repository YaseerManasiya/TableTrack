import { NavLink } from 'react-router-dom';
import { useAuth } from '../contexts/AuthContext.jsx';

const navItems = [
  { to: '/dashboard', label: 'Dashboard', icon: '📊' },
  { to: '/pos', label: 'POS', icon: '🖥️' },
  { to: '/orders', label: 'Orders', icon: '📋' },
  { to: '/kots', label: 'KOT', icon: '🍳' },
  { to: '/menus', label: 'Menus', icon: '🍽️' },
  { to: '/tables', label: 'Tables', icon: '🪑' },
  { to: '/reservations', label: 'Reservations', icon: '📅' },
  { to: '/customers', label: 'Customers', icon: '👥' },
  { to: '/staff', label: 'Staff', icon: '👨‍💼' },
  { to: '/delivery-executives', label: 'Delivery', icon: '🛵' },
  { to: '/expenses', label: 'Expenses', icon: '💰' },
  { to: '/reports', label: 'Reports', icon: '📈' },
  { to: '/settings', label: 'Settings', icon: '⚙️' },
];

export default function Sidebar({ open }) {
  const { user } = useAuth();

  return (
    <aside
      className={`${
        open ? 'w-64' : 'w-0 overflow-hidden'
      } transition-all duration-300 bg-gray-900 text-white flex flex-col flex-shrink-0`}
    >
      {/* Logo */}
      <div className="flex items-center gap-3 px-5 py-4 border-b border-gray-700">
        <div className="w-8 h-8 bg-blue-600 rounded-lg flex items-center justify-center font-bold text-sm">
          TT
        </div>
        <span className="font-semibold text-lg tracking-tight">TableTrack</span>
      </div>

      {/* Nav */}
      <nav className="flex-1 overflow-y-auto py-4 px-3 space-y-1">
        {navItems.map(({ to, label, icon }) => (
          <NavLink
            key={to}
            to={to}
            className={({ isActive }) =>
              `flex items-center gap-3 px-3 py-2 rounded-lg text-sm font-medium transition-colors ${
                isActive
                  ? 'bg-blue-600 text-white'
                  : 'text-gray-300 hover:bg-gray-800 hover:text-white'
              }`
            }
          >
            <span className="text-base">{icon}</span>
            {label}
          </NavLink>
        ))}
      </nav>

      {/* User */}
      <div className="px-5 py-4 border-t border-gray-700">
        <div className="flex items-center gap-3">
          <div className="w-8 h-8 rounded-full bg-blue-600 flex items-center justify-center text-xs font-semibold uppercase">
            {user?.name?.[0] ?? 'U'}
          </div>
          <div className="min-w-0">
            <p className="text-sm font-medium truncate">{user?.name ?? 'User'}</p>
            <p className="text-xs text-gray-400 truncate">{user?.modelHasRoles?.[0]?.role?.displayName ?? ''}</p>
          </div>
        </div>
      </div>
    </aside>
  );
}
