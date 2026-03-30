import { useState, useEffect, useCallback } from 'react';
import { useQuery, useQueryClient } from '@tanstack/react-query';
import toast from 'react-hot-toast';
import api from '../api/axios.js';

export default function POS() {
  const qc = useQueryClient();
  const [selectedTable, setSelectedTable] = useState(null);
  const [cart, setCart] = useState([]); // [{menuItem, quantity, notes}]
  const [customer, setCustomer] = useState({ name: '', phone: '' });
  const [orderType, setOrderType] = useState('dine_in');
  const [loading, setLoading] = useState(false);
  const [searchItem, setSearchItem] = useState('');
  const [activeMenu, setActiveMenu] = useState(null);

  const posQ = useQuery({
    queryKey: ['pos-init'],
    queryFn: () => api.get('/pos/init').then((r) => r.data.data),
  });

  const posData = posQ.data ?? {};
  const menus = posData.menus ?? [];
  const tables = posData.tables ?? [];
  const currentMenu = activeMenu ?? menus[0];
  const items = (currentMenu?.menuItems ?? []).filter(
    (i) => i.isActive && (!searchItem || i.name.toLowerCase().includes(searchItem.toLowerCase()))
  );

  const addToCart = useCallback((item) => {
    setCart((c) => {
      const existing = c.find((e) => e.menuItem.id === item.id);
      if (existing) return c.map((e) => e.menuItem.id === item.id ? { ...e, quantity: e.quantity + 1 } : e);
      return [...c, { menuItem: item, quantity: 1, notes: '' }];
    });
  }, []);

  const updateQty = (id, delta) => {
    setCart((c) => c.map((e) => e.menuItem.id === id ? { ...e, quantity: Math.max(0, e.quantity + delta) } : e).filter((e) => e.quantity > 0));
  };

  const subtotal = cart.reduce((sum, e) => sum + e.menuItem.price * e.quantity, 0);

  const placeOrder = async () => {
    if (cart.length === 0) { toast.error('Cart is empty'); return; }
    if (orderType === 'dine_in' && !selectedTable) { toast.error('Select a table'); return; }
    setLoading(true);
    try {
      // Create customer on the fly if name provided
      let customerId = null;
      if (customer.name) {
        const { data: custData } = await api.post('/customers', {
          name: customer.name,
          phoneNumber: customer.phone || null,
        });
        customerId = custData.data?.id;
      }

      const payload = {
        tableId: selectedTable?.id,
        orderType,
        customerId,
        items: cart.map((e) => ({ menuItemId: e.menuItem.id, quantity: e.quantity, price: e.menuItem.price, notes: e.notes, name: e.menuItem.name })),
      };
      const { data } = await api.post('/orders', payload);
      if (data.success) {
        toast.success(`Order #${data.data.orderNumber} created!`);
        setCart([]);
        setSelectedTable(null);
        setCustomer({ name: '', phone: '' });
        qc.invalidateQueries({ queryKey: ['pos-init'] });
      }
    } catch (e) { toast.error(e.response?.data?.message || 'Failed to place order'); }
    finally { setLoading(false); }
  };

  if (posQ.isLoading) {
    return <div className="flex items-center justify-center h-64"><div className="w-8 h-8 border-4 border-blue-600 border-t-transparent rounded-full animate-spin" /></div>;
  }

  return (
    <div className="flex h-full gap-4 -m-6 p-4 bg-gray-100 min-h-screen">
      {/* Left: Tables & Menu */}
      <div className="flex-1 flex flex-col gap-4 min-w-0">
        {/* Order type */}
        <div className="card p-3 flex gap-2">
          {['dine_in', 'takeaway', 'delivery'].map((t) => (
            <button key={t} onClick={() => setOrderType(t)} className={`px-4 py-2 rounded-lg text-sm font-medium capitalize transition-colors ${orderType === t ? 'bg-blue-600 text-white' : 'bg-gray-100 text-gray-700 hover:bg-gray-200'}`}>
              {t.replace('_', ' ')}
            </button>
          ))}
        </div>

        {/* Table selection */}
        {orderType === 'dine_in' && (
          <div className="card p-4">
            <p className="text-sm font-semibold text-gray-700 mb-3">Select Table</p>
            <div className="grid grid-cols-4 sm:grid-cols-6 gap-2">
              {tables.map((t) => (
                <button
                  key={t.id}
                  onClick={() => setSelectedTable(t)}
                  className={`p-2 rounded-lg text-xs font-medium border transition-colors ${
                    selectedTable?.id === t.id ? 'bg-blue-600 text-white border-blue-600' :
                    t.tableStatus === 'available' ? 'bg-green-50 border-green-200 text-green-700 hover:bg-green-100' :
                    t.tableStatus === 'running' ? 'bg-orange-50 border-orange-200 text-orange-700' :
                    'bg-yellow-50 border-yellow-200 text-yellow-700'
                  }`}
                >
                  {t.tableName}
                </button>
              ))}
            </div>
          </div>
        )}

        {/* Menu items */}
        <div className="card flex-1 overflow-hidden flex flex-col">
          <div className="p-4 border-b border-gray-200">
            <div className="flex gap-2 flex-wrap mb-3">
              {menus.map((m) => (
                <button key={m.id} onClick={() => setActiveMenu(m)} className={`px-3 py-1.5 rounded-lg text-xs font-medium transition-colors ${(activeMenu ?? menus[0])?.id === m.id ? 'bg-blue-600 text-white' : 'bg-gray-100 text-gray-700 hover:bg-gray-200'}`}>
                  {m.name}
                </button>
              ))}
            </div>
            <input className="form-input" placeholder="Search items…" value={searchItem} onChange={(e) => setSearchItem(e.target.value)} />
          </div>
          <div className="flex-1 overflow-y-auto p-4">
            <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 gap-3">
              {items.map((item) => (
                <button
                  key={item.id}
                  onClick={() => addToCart(item)}
                  className="card p-3 text-left hover:shadow-md transition-shadow hover:border-blue-200"
                >
                  <p className="text-sm font-semibold text-gray-900 line-clamp-2 mb-1">{item.name}</p>
                  <p className="text-blue-600 font-bold text-sm">${Number(item.price).toFixed(2)}</p>
                  {item.itemCategory && <p className="text-xs text-gray-400 mt-1">{item.itemCategory.name}</p>}
                </button>
              ))}
              {items.length === 0 && <p className="col-span-4 text-gray-400 text-center py-10">No items found</p>}
            </div>
          </div>
        </div>
      </div>

      {/* Right: Cart */}
      <div className="w-80 flex-shrink-0 flex flex-col gap-3">
        <div className="card flex-1 flex flex-col overflow-hidden">
          <div className="p-4 border-b border-gray-200">
            <h3 className="font-bold text-gray-900">Cart</h3>
            {selectedTable && <p className="text-xs text-blue-600 mt-1">Table: {selectedTable.tableName}</p>}
          </div>

          {/* Customer info */}
          <div className="p-3 border-b border-gray-100 space-y-2">
            <input className="form-input text-sm" placeholder="Customer name" value={customer.name} onChange={(e) => setCustomer((c) => ({ ...c, name: e.target.value }))} />
            <input className="form-input text-sm" placeholder="Phone" value={customer.phone} onChange={(e) => setCustomer((c) => ({ ...c, phone: e.target.value }))} />
          </div>

          {/* Cart items */}
          <div className="flex-1 overflow-y-auto p-3 space-y-2">
            {cart.length === 0 && (
              <div className="text-center py-10 text-gray-400">
                <p className="text-3xl mb-2">🛒</p>
                <p className="text-sm">Cart is empty</p>
              </div>
            )}
            {cart.map((entry) => (
              <div key={entry.menuItem.id} className="flex items-center gap-2">
                <div className="flex-1 min-w-0">
                  <p className="text-sm font-medium truncate">{entry.menuItem.name}</p>
                  <p className="text-xs text-gray-500">${Number(entry.menuItem.price).toFixed(2)} each</p>
                </div>
                <div className="flex items-center gap-1">
                  <button onClick={() => updateQty(entry.menuItem.id, -1)} className="w-6 h-6 rounded bg-gray-100 text-sm font-bold hover:bg-gray-200 flex items-center justify-center">−</button>
                  <span className="w-6 text-center text-sm font-bold">{entry.quantity}</span>
                  <button onClick={() => updateQty(entry.menuItem.id, 1)} className="w-6 h-6 rounded bg-gray-100 text-sm font-bold hover:bg-gray-200 flex items-center justify-center">+</button>
                </div>
                <span className="text-sm font-semibold w-14 text-right">${(entry.menuItem.price * entry.quantity).toFixed(2)}</span>
              </div>
            ))}
          </div>

          {/* Total & Place Order */}
          <div className="p-4 border-t border-gray-200 space-y-3">
            <div className="flex justify-between text-sm">
              <span className="text-gray-500">Subtotal</span>
              <span className="font-bold">${subtotal.toFixed(2)}</span>
            </div>
            <button
              onClick={placeOrder}
              disabled={loading || cart.length === 0}
              className="btn-primary w-full justify-center py-3"
            >
              {loading ? 'Placing…' : `Place Order — $${subtotal.toFixed(2)}`}
            </button>
            <button onClick={() => setCart([])} className="btn-secondary w-full justify-center text-xs">Clear Cart</button>
          </div>
        </div>
      </div>
    </div>
  );
}
