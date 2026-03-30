import axios from 'axios';

const api = axios.create({
  baseURL: '/api',
  withCredentials: true,
  headers: { 'Content-Type': 'application/json' },
});

let csrfToken = null;

async function fetchCsrfToken() {
  try {
    const { data } = await axios.get('/api/csrf-token', { withCredentials: true });
    csrfToken = data.csrfToken;
  } catch {
    // Ignore — server may not require CSRF for Bearer token requests
  }
}

// Attach JWT from localStorage (bypasses CSRF check on server) and CSRF header
api.interceptors.request.use(async (config) => {
  const token = localStorage.getItem('token');
  if (token) {
    config.headers.Authorization = `Bearer ${token}`;
  } else {
    // Cookie-based session: fetch CSRF token if we don't have one
    if (!csrfToken && !['GET', 'HEAD', 'OPTIONS'].includes(config.method?.toUpperCase())) {
      await fetchCsrfToken();
    }
    if (csrfToken) config.headers['X-CSRF-Token'] = csrfToken;
  }
  return config;
});

api.interceptors.response.use(
  (response) => response,
  (error) => {
    if (error.response?.status === 401) {
      localStorage.removeItem('token');
      csrfToken = null;
      if (window.location.pathname !== '/login') {
        window.location.href = '/login';
      }
    }
    return Promise.reject(error);
  },
);

export default api;
