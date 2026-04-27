const router = require('express').Router();
const db = require('./db');

// GET all patients (for dropdowns) — must be registered before '/:id'
router.get('/', async (req, res) => {
  try {
    const [rows] = await db.query('SELECT * FROM patient ORDER BY created_at DESC');
    const list = Array.isArray(rows) ? rows : [];
    console.log(`[patients] GET / → ${list.length} row(s)`);
    res.json(list);
  } catch (e) {
    console.error('[patients] GET / failed:', e.message);
    res.status(500).json({ error: e.message });
  }
});

// GET single patient
router.get('/:id', async (req, res) => {
  try {
    const [rows] = await db.query('SELECT * FROM patient WHERE patient_id = ?', [req.params.id]);
    if (!rows.length) return res.status(404).json({ error: 'Patient not found' });
    res.json(rows[0]);
  } catch (e) {
    console.error('[patients] GET /:id failed:', e.message);
    res.status(500).json({ error: e.message });
  }
});

// POST add patient
router.post('/', async (req, res) => {
  const { first_name, last_name, dob, gender, blood_type, phone, email, address } = req.body;
  if (!first_name || !last_name || !dob || !gender)
    return res.status(400).json({ error: 'first_name, last_name, dob, gender are required' });
  try {
    const [result] = await db.query(
      'INSERT INTO patient (first_name, last_name, dob, gender, blood_type, phone, email, address) VALUES (?,?,?,?,?,?,?,?)',
      [first_name, last_name, dob, gender, blood_type||null, phone||null, email||null, address||null]
    );
    res.status(201).json({ patient_id: result.insertId, message: 'Patient added' });
  } catch (e) {
    console.error('[patients] POST / failed:', e.message);
    res.status(500).json({ error: e.message });
  }
});

module.exports = router;
