import { useState } from 'react';
import { useQuery, useQueryClient } from '@tanstack/react-query';
import toast from 'react-hot-toast';
import api from '../api/axios.js';

const STATUS_COLORS = {
  pending: 'bg-yellow-100 border-yellow-300 text-yellow-800',
  in_progress: 'bg-blue-100 border-blue-300 text-blue-800',
  done: 'bg-green-100 border-green-300 text-green-800',
  cancelled: 'bg-red-100 border-red-300 text-red-800',
};

const NEXT_STATUS = {
  pending: 'in_progress',
  in_progress: 'done',
};

const COLUMNS = ['pending', 'in_progress', 'done'];

export default function KOTManagement() {
  const qc = useQueryClient();
  const [filter, setFilter] = useState('');

  const kotsQ = useQuery({
    queryKey: ['kots', filter],
    queryFn: () => api.get(`/kots?per_page=100${filter ? `&status=${filter}` : ''}`).then((r) => r.data.data),
    refetchInterval: 15_000,
  });

  const kots = kotsQ.data ?? [];

  const updateStatus = async (id, status) => {
    try {
      await api.put(`/kots/${id}/status`, { status });
      qc.invalidateQueries({ queryKey: ['kots'] });
      toast.success(`KOT marked as ${status.replace('_', ' ')}`);
    } catch { toast.error('Failed to update'); }
  };

  const grouped = COLUMNS.reduce((acc, col) => {
    acc[col] = kots.filter((k) => k.status === col);
    return acc;
  }, {});

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <h1 className="text-2xl font-bold text-gray-900">KOT Board</h1>
        <div className="flex gap-2">
          {['', ...COLUMNS, 'cancelled'].map((s) => (
            <button
              key={s}
              onClick={() => setFilter(s)}
              className={`px-3 py-1.5 rounded-lg text-xs font-medium capitalize transition-colors ${filter === s ? 'bg-blue-600 text-white' : 'bg-white border border-gray-200 text-gray-600 hover:bg-gray-50'}`}
            >
              {s === '' ? 'All' : s.replace('_', ' ')}
            </button>
          ))}
        </div>
      </div>

      {kotsQ.isLoading ? (
        <div className="flex items-center justify-center h-64"><div className="w-8 h-8 border-4 border-blue-600 border-t-transparent rounded-full animate-spin" /></div>
      ) : filter ? (
        // Flat list when filtered
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-4">
          {kots.length === 0 && <p className="text-gray-400 col-span-4 text-center py-10">No KOTs found</p>}
          {kots.map((kot) => <KOTCard key={kot.id} kot={kot} onUpdateStatus={updateStatus} />)}
        </div>
      ) : (
        // Kanban columns
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          {COLUMNS.map((col) => (
            <div key={col} className="space-y-3">
              <div className="flex items-center justify-between">
                <h3 className="font-semibold text-sm text-gray-700 capitalize">{col.replace('_', ' ')}</h3>
                <span className="bg-gray-200 text-gray-600 text-xs font-semibold px-2 py-0.5 rounded-full">
                  {grouped[col].length}
                </span>
              </div>
              <div className="space-y-3 min-h-24">
                {grouped[col].length === 0 && (
                  <div className="border-2 border-dashed border-gray-200 rounded-xl p-4 text-center text-gray-300 text-sm">Empty</div>
                )}
                {grouped[col].map((kot) => <KOTCard key={kot.id} kot={kot} onUpdateStatus={updateStatus} />)}
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}

function KOTCard({ kot, onUpdateStatus }) {
  const next = NEXT_STATUS[kot.status];
  return (
    <div className={`rounded-xl border p-4 space-y-3 ${STATUS_COLORS[kot.status] || 'bg-gray-50 border-gray-200'}`}>
      <div className="flex items-center justify-between">
        <span className="font-bold text-lg">#{kot.tokenNumber}</span>
        <span className="text-xs opacity-70">{new Date(kot.createdAt).toLocaleTimeString()}</span>
      </div>
      {kot.order?.table && (
        <p className="text-xs font-medium">🪑 {kot.order.table.tableName}</p>
      )}
      <ul className="space-y-1">
        {kot.kotItems?.map((item) => (
          <li key={item.id} className="text-sm flex justify-between">
            <span>{item.name}</span>
            <span className="font-bold">×{item.quantity}</span>
          </li>
        ))}
      </ul>
      {next && (
        <button
          onClick={() => onUpdateStatus(kot.id, next)}
          className="w-full py-1.5 rounded-lg text-xs font-semibold bg-white/60 hover:bg-white transition-colors capitalize"
        >
          Mark {next.replace('_', ' ')} →
        </button>
      )}
      {kot.status !== 'cancelled' && kot.status !== 'done' && (
        <button
          onClick={() => onUpdateStatus(kot.id, 'cancelled')}
          className="w-full py-1 rounded-lg text-xs text-red-600 hover:bg-red-50 transition-colors"
        >
          Cancel
        </button>
      )}
    </div>
  );
}
