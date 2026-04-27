const router = require('express').Router();
const db     = require('./db');

// GET full patient history
router.get('/:patient_id', async (req, res) => {
  const pid = req.params.patient_id;
  try {
    const [[patient]] = await db.query('SELECT * FROM patient WHERE patient_id = ?', [pid]);
    if (!patient) return res.status(404).json({ error: 'Patient not found' });

    const [encounters]  = await db.query('SELECT * FROM clinical_encounter WHERE patient_id = ? ORDER BY admission_date DESC', [pid]);
    const [diagnoses]   = await db.query('SELECT * FROM diagnosis         WHERE patient_id = ? ORDER BY diagnosed_date DESC',  [pid]);
    const [medications] = await db.query('SELECT * FROM medication_record WHERE patient_id = ? ORDER BY start_date DESC',      [pid]);
    const [allergies]   = await db.query('SELECT * FROM allergy           WHERE patient_id = ?',                               [pid]);
    const [tests]       = await db.query('SELECT * FROM test_results      WHERE patient_id = ? ORDER BY test_date DESC',       [pid]);

    res.json({ patient, encounters, diagnoses, medications, allergies, tests });
  } catch (e) { res.status(500).json({ error: e.message }); }
});

module.exports = router;
