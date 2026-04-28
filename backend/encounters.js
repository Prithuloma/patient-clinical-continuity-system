const router = require('express').Router();
const db     = require('./db');

// POST add encounter
router.post('/', async (req, res) => {
  const { patient_id, provider_name, facility_name, encounter_type,
          admission_date, discharge_date, chief_complaint, notes } = req.body;
  if (!patient_id || !provider_name || !facility_name || !encounter_type || !admission_date)
    return res.status(400).json({ error: 'patient_id, provider_name, facility_name, encounter_type, admission_date are required' });
  try {
    const [result] = await db.query(
      `INSERT INTO clinical_encounter
       (patient_id, provider_name, facility_name, encounter_type, admission_date, discharge_date, chief_complaint, notes)
       VALUES (?,?,?,?,?,?,?,?)`,
      [patient_id, provider_name, facility_name, encounter_type,
       admission_date, discharge_date||null, chief_complaint||null, notes||null]
    );
    res.status(201).json({ encounter_id: result.insertId, message: 'Encounter added' });
  } catch (e) { res.status(500).json({ error: e.message }); }
});

// GET encounters for a patient
router.get('/patient/:pid', async (req, res) => {
  try {
    const [rows] = await db.query(
      'SELECT * FROM clinical_encounter WHERE patient_id = ? ORDER BY admission_date DESC',
      [req.params.pid]
    );
    res.json(rows);
  } catch (e) { res.status(500).json({ error: e.message }); }
});

module.exports = router;
