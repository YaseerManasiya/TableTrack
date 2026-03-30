import { Routes, Route, Navigate } from 'react-router-dom';
import { useAuth } from './contexts/AuthContext.jsx';
import Layout from './components/Layout.jsx';
import Login from './pages/Login.jsx';
import Dashboard from './pages/Dashboard.jsx';
import MenuManagement from './pages/MenuManagement.jsx';
import TableManagement from './pages/TableManagement.jsx';
import OrderManagement from './pages/OrderManagement.jsx';
import KOTManagement from './pages/KOTManagement.jsx';
import POS from './pages/POS.jsx';
import StaffManagement from './pages/StaffManagement.jsx';
import CustomerManagement from './pages/CustomerManagement.jsx';
import Reports from './pages/Reports.jsx';
import Reservations from './pages/Reservations.jsx';
import Settings from './pages/Settings.jsx';
import Expenses from './pages/Expenses.jsx';
import DeliveryExecutives from './pages/DeliveryExecutives.jsx';

function PrivateRoute({ children }) {
  const { user, loading } = useAuth();
  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-gray-50">
        <div className="flex flex-col items-center gap-3">
          <div className="w-10 h-10 border-4 border-blue-600 border-t-transparent rounded-full animate-spin" />
          <p className="text-sm text-gray-500">Loading…</p>
        </div>
      </div>
    );
  }
  return user ? children : <Navigate to="/login" replace />;
}

export default function App() {
  return (
    <Routes>
      <Route path="/login" element={<Login />} />
      <Route
        path="/"
        element={
          <PrivateRoute>
            <Layout />
          </PrivateRoute>
        }
      >
        <Route index element={<Navigate to="/dashboard" replace />} />
        <Route path="dashboard" element={<Dashboard />} />
        <Route path="menus" element={<MenuManagement />} />
        <Route path="tables" element={<TableManagement />} />
        <Route path="orders" element={<OrderManagement />} />
        <Route path="kots" element={<KOTManagement />} />
        <Route path="pos" element={<POS />} />
        <Route path="staff" element={<StaffManagement />} />
        <Route path="customers" element={<CustomerManagement />} />
        <Route path="reports" element={<Reports />} />
        <Route path="reservations" element={<Reservations />} />
        <Route path="expenses" element={<Expenses />} />
        <Route path="delivery-executives" element={<DeliveryExecutives />} />
        <Route path="settings" element={<Settings />} />
      </Route>
      <Route path="*" element={<Navigate to="/dashboard" replace />} />
    </Routes>
  );
}
