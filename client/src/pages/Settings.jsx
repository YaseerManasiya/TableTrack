import { useState, useEffect } from 'react';
import { useQuery, useQueryClient } from '@tanstack/react-query';
import toast from 'react-hot-toast';
import api from '../api/axios.js';

export default function Settings() {
  const qc = useQueryClient();
  const [form, setForm] = useState(null);
  const [loading, setLoading] = useState(false);

  const settingsQ = useQuery({
    queryKey: ['settings'],
    queryFn: () => api.get('/settings/restaurant').then((r) => r.data.data),
  });

  useEffect(() => {
    if (settingsQ.data) {
      setForm({
        name: settingsQ.data.name ?? '',
        email: settingsQ.data.email ?? '',
        phone_number: settingsQ.data.phoneNumber ?? '',
        currency: '',
        address: '',
        theme_color: '#2563eb',
      });
    }
  }, [settingsQ.data]);

  const save = async () => {
    setLoading(true);
    try {
      await api.put('/settings/restaurant', { name: form.name, email: form.email, phoneNumber: form.phone_number });
      qc.invalidateQueries({ queryKey: ['settings'] });
      toast.success('Settings saved!');
    } catch (e) { toast.error(e.response?.data?.message || 'Failed to save settings'); }
    finally { setLoading(false); }
  };

  if (settingsQ.isLoading || !form) {
    return <div className="flex items-center justify-center h-40"><div className="w-8 h-8 border-4 border-blue-600 border-t-transparent rounded-full animate-spin" /></div>;
  }

  return (
    <div className="space-y-6 max-w-2xl">
      <h1 className="text-2xl font-bold text-gray-900">Settings</h1>

      <div className="card p-6 space-y-5">
        <h2 className="font-semibold text-gray-800">Restaurant Information</h2>
        <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
          <div>
            <label className="form-label">Restaurant Name</label>
            <input className="form-input" value={form.name} onChange={(e) => setForm((f) => ({ ...f, name: e.target.value }))} />
          </div>
          <div>
            <label className="form-label">Email</label>
            <input type="email" className="form-input" value={form.email} onChange={(e) => setForm((f) => ({ ...f, email: e.target.value }))} />
          </div>
          <div>
            <label className="form-label">Phone</label>
            <input className="form-input" value={form.phone_number} onChange={(e) => setForm((f) => ({ ...f, phone_number: e.target.value }))} />
          </div>
          <div>
            <label className="form-label">Currency</label>
            <input className="form-input" value={form.currency} onChange={(e) => setForm((f) => ({ ...f, currency: e.target.value }))} placeholder="USD" />
          </div>
        </div>
        <div>
          <label className="form-label">Address</label>
          <textarea className="form-input resize-none" rows={2} value={form.address} onChange={(e) => setForm((f) => ({ ...f, address: e.target.value }))} />
        </div>
        <div>
          <label className="form-label">Theme Color</label>
          <div className="flex items-center gap-3">
            <input type="color" className="w-10 h-10 rounded border border-gray-300 p-1 cursor-pointer" value={form.theme_color} onChange={(e) => setForm((f) => ({ ...f, theme_color: e.target.value }))} />
            <input className="form-input" value={form.theme_color} onChange={(e) => setForm((f) => ({ ...f, theme_color: e.target.value }))} />
          </div>
        </div>
        <div className="pt-2">
          <button onClick={save} disabled={loading} className="btn-primary">
            {loading ? 'Saving…' : 'Save Settings'}
          </button>
        </div>
      </div>
    </div>
  );
}
