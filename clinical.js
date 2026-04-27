const router = require('express').Router();
const db     = require('./db');

// ── DIAGNOSIS ────────────────────────────────────────────────
router.post('/diagnosis', async (req, res) => {
  const { encounter_id, patient_id, icd_code, diagnosis_name, severity, status, diagnosed_date, notes } = req.body;
  if (!encounter_id || !patient_id || !diagnosis_name)
    return res.status(400).json({ error: 'encounter_id, patient_id, diagnosis_name required' });
  try {
    const [r] = await db.query(
      'INSERT INTO diagnosis (encounter_id,patient_id,icd_code,diagnosis_name,severity,status,diagnosed_date,notes) VALUES (?,?,?,?,?,?,?,?)',
      [encounter_id, patient_id, icd_code||null, diagnosis_name, severity||'Moderate', status||'Active', diagnosed_date||null, notes||null]
    );
    res.status(201).json({ diagnosis_id: r.insertId, message: 'Diagnosis added' });
  } catch (e) { res.status(500).json({ error: e.message }); }
});

// ── MEDICATION ───────────────────────────────────────────────
router.post('/medication', async (req, res) => {
  const { encounter_id, patient_id, drug_name, dosage, frequency, route, start_date, end_date, prescribed_by, status } = req.body;
  if (!encounter_id || !patient_id || !drug_name)
    return res.status(400).json({ error: 'encounter_id, patient_id, drug_name required' });
  try {
    const [r] = await db.query(
      'INSERT INTO medication_record (encounter_id,patient_id,drug_name,dosage,frequency,route,start_date,end_date,prescribed_by,status) VALUES (?,?,?,?,?,?,?,?,?,?)',
      [encounter_id, patient_id, drug_name, dosage||null, frequency||null, route||null, start_date||null, end_date||null, prescribed_by||null, status||'Active']
    );
    res.status(201).json({ medication_id: r.insertId, message: 'Medication added' });
  } catch (e) { res.status(500).json({ error: e.message }); }
});

// ── ALLERGY ──────────────────────────────────────────────────
router.post('/allergy', async (req, res) => {
  const { patient_id, allergen, reaction, severity, onset_date, status } = req.body;
  if (!patient_id || !allergen)
    return res.status(400).json({ error: 'patient_id, allergen required' });
  try {
    const [r] = await db.query(
      'INSERT INTO allergy (patient_id,allergen,reaction,severity,onset_date,status) VALUES (?,?,?,?,?,?)',
      [patient_id, allergen, reaction||null, severity||'Moderate', onset_date||null, status||'Active']
    );
    res.status(201).json({ allergy_id: r.insertId, message: 'Allergy added' });
  } catch (e) { res.status(500).json({ error: e.message }); }
});

// ── TEST RESULTS ─────────────────────────────────────────────
router.post('/test-result', async (req, res) => {
  const { encounter_id, patient_id, test_name, test_date, result_value, unit, reference_range, status, ordered_by, notes } = req.body;
  if (!encounter_id || !patient_id || !test_name)
    return res.status(400).json({ error: 'encounter_id, patient_id, test_name required' });
  try {
    const [r] = await db.query(
      'INSERT INTO test_results (encounter_id,patient_id,test_name,test_date,result_value,unit,reference_range,status,ordered_by,notes) VALUES (?,?,?,?,?,?,?,?,?,?)',
      [encounter_id, patient_id, test_name, test_date||null, result_value||null, unit||null, reference_range||null, status||'Pending', ordered_by||null, notes||null]
    );
    res.status(201).json({ test_id: r.insertId, message: 'Test result added' });
  } catch (e) { res.status(500).json({ error: e.message }); }
});

module.exports = router;
