const success = (res, data, message = 'Success', status = 200) =>
  res.status(status).json({ success: true, message, data });

const paginated = (res, data, total, page, perPage) =>
  res.json({ success: true, data, meta: { total, page: Number(page), per_page: Number(perPage), last_page: Math.ceil(total / perPage) } });

const error = (res, message = 'Error', status = 400) =>
  res.status(status).json({ success: false, message });

module.exports = { success, paginated, error };
