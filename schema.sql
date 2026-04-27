-- ============================================================
-- Patient Centric Clinical Data Continuity System — Schema
-- ============================================================

CREATE DATABASE IF NOT EXISTS patient_cdcs;
USE patient_cdcs;

-- ── TABLES ──────────────────────────────────────────────────

CREATE TABLE IF NOT EXISTS patient (
  patient_id      INT AUTO_INCREMENT PRIMARY KEY,
  first_name      VARCHAR(100) NOT NULL,
  last_name       VARCHAR(100) NOT NULL,
  dob             DATE NOT NULL,
  gender          ENUM('Male','Female','Other') NOT NULL,
  blood_type      VARCHAR(5),
  phone           VARCHAR(20),
  email           VARCHAR(150),
  address         TEXT,
  created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS clinical_encounter (
  encounter_id    INT AUTO_INCREMENT PRIMARY KEY,
  patient_id      INT NOT NULL,
  provider_name   VARCHAR(150) NOT NULL,
  facility_name   VARCHAR(150) NOT NULL,
  encounter_type  ENUM('Inpatient','Outpatient','Emergency','Telehealth') NOT NULL,
  admission_date  DATE NOT NULL,
  discharge_date  DATE,
  chief_complaint TEXT,
  notes           TEXT,
  created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (patient_id) REFERENCES patient(patient_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS diagnosis (
  diagnosis_id    INT AUTO_INCREMENT PRIMARY KEY,
  encounter_id    INT NOT NULL,
  patient_id      INT NOT NULL,
  icd_code        VARCHAR(20),
  diagnosis_name  VARCHAR(255) NOT NULL,
  severity        ENUM('Mild','Moderate','Severe','Critical') DEFAULT 'Moderate',
  status          ENUM('Active','Resolved','Chronic','Suspected') DEFAULT 'Active',
  diagnosed_date  DATE,
  notes           TEXT,
  FOREIGN KEY (encounter_id) REFERENCES clinical_encounter(encounter_id) ON DELETE CASCADE,
  FOREIGN KEY (patient_id)   REFERENCES patient(patient_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS medication_record (
  medication_id   INT AUTO_INCREMENT PRIMARY KEY,
  encounter_id    INT NOT NULL,
  patient_id      INT NOT NULL,
  drug_name       VARCHAR(200) NOT NULL,
  dosage          VARCHAR(100),
  frequency       VARCHAR(100),
  route           VARCHAR(50),
  start_date      DATE,
  end_date        DATE,
  prescribed_by   VARCHAR(150),
  status          ENUM('Active','Discontinued','Completed') DEFAULT 'Active',
  FOREIGN KEY (encounter_id) REFERENCES clinical_encounter(encounter_id) ON DELETE CASCADE,
  FOREIGN KEY (patient_id)   REFERENCES patient(patient_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS allergy (
  allergy_id      INT AUTO_INCREMENT PRIMARY KEY,
  patient_id      INT NOT NULL,
  allergen        VARCHAR(200) NOT NULL,
  reaction        VARCHAR(255),
  severity        ENUM('Mild','Moderate','Severe','Life-threatening') DEFAULT 'Moderate',
  onset_date      DATE,
  status          ENUM('Active','Inactive','Resolved') DEFAULT 'Active',
  FOREIGN KEY (patient_id) REFERENCES patient(patient_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS test_results (
  test_id         INT AUTO_INCREMENT PRIMARY KEY,
  encounter_id    INT NOT NULL,
  patient_id      INT NOT NULL,
  test_name       VARCHAR(200) NOT NULL,
  test_date       DATE,
  result_value    VARCHAR(255),
  unit            VARCHAR(50),
  reference_range VARCHAR(100),
  status          ENUM('Normal','Abnormal','Critical','Pending') DEFAULT 'Pending',
  ordered_by      VARCHAR(150),
  notes           TEXT,
  FOREIGN KEY (encounter_id) REFERENCES clinical_encounter(encounter_id) ON DELETE CASCADE,
  FOREIGN KEY (patient_id)   REFERENCES patient(patient_id) ON DELETE CASCADE
);

-- ── SEED DATA ────────────────────────────────────────────────

INSERT INTO patient (first_name, last_name, dob, gender, blood_type, phone, email, address) VALUES
('Arjun',   'Sharma',    '1985-03-12', 'Male',   'O+',  '9841001001', 'arjun.sharma@email.com',   '14 Anna Nagar, Chennai'),
('Priya',   'Nair',      '1992-07-25', 'Female', 'A+',  '9841002002', 'priya.nair@email.com',     '7 T Nagar, Chennai'),
('Ramesh',  'Iyer',      '1970-11-08', 'Male',   'B-',  '9841003003', 'ramesh.iyer@email.com',    '3 Adyar, Chennai'),
('Sunita',  'Patel',     '1988-02-14', 'Female', 'AB+', '9841004004', 'sunita.patel@email.com',   '22 Velachery, Chennai'),
('Karthik', 'Krishnan',  '2001-09-30', 'Male',   'O-',  '9841005005', 'karthik.k@email.com',      '5 Guindy, Chennai');

INSERT INTO clinical_encounter (patient_id, provider_name, facility_name, encounter_type, admission_date, discharge_date, chief_complaint, notes) VALUES
(1, 'Dr. Meena Subramaniam', 'Apollo Hospitals Chennai',      'Inpatient',  '2024-01-10', '2024-01-15', 'Chest pain and shortness of breath',  'Monitored for cardiac events'),
(2, 'Dr. Ravi Chandran',    'Fortis Malar Hospital',         'Outpatient', '2024-02-20', '2024-02-20', 'Recurring migraines',                 'Neurological evaluation performed'),
(3, 'Dr. Anjali Mehta',     'MIOT International',            'Emergency',  '2024-03-05', '2024-03-06', 'Severe abdominal pain',               'CT scan ordered; pain resolved'),
(4, 'Dr. Suresh Babu',      'Sri Ramachandra Medical Centre','Telehealth', '2024-04-12', NULL,          'Diabetes follow-up and HbA1c review', 'Medication adjusted'),
(5, 'Dr. Lakshmi Rao',      'Kauvery Hospital',              'Outpatient', '2024-05-18', '2024-05-18', 'Sports knee injury',                  'MRI recommended');

INSERT INTO diagnosis (encounter_id, patient_id, icd_code, diagnosis_name, severity, status, diagnosed_date, notes) VALUES
(1, 1, 'I20.9',  'Unstable Angina',              'Severe',   'Active',   '2024-01-11', 'ECG showed ST depression'),
(2, 2, 'G43.909','Migraine without aura',         'Moderate', 'Chronic',  '2024-02-20', 'Prophylactic therapy initiated'),
(3, 3, 'K35.80', 'Acute Appendicitis',            'Severe',   'Resolved', '2024-03-05', 'Appendectomy performed'),
(4, 4, 'E11.9',  'Type 2 Diabetes Mellitus',      'Moderate', 'Chronic',  '2024-04-12', 'HbA1c 8.2%; target < 7%'),
(5, 5, 'M23.200','Medial Meniscus Tear (Left)',   'Moderate', 'Active',   '2024-05-18', 'Conservative management first');

INSERT INTO medication_record (encounter_id, patient_id, drug_name, dosage, frequency, route, start_date, end_date, prescribed_by, status) VALUES
(1, 1, 'Aspirin',      '75 mg',  'Once daily',    'Oral', '2024-01-11', NULL,         'Dr. Meena Subramaniam', 'Active'),
(2, 2, 'Topiramate',   '50 mg',  'Twice daily',   'Oral', '2024-02-20', NULL,         'Dr. Ravi Chandran',    'Active'),
(3, 3, 'Metronidazole','500 mg', 'Thrice daily',  'IV',   '2024-03-05', '2024-03-10', 'Dr. Anjali Mehta',     'Completed'),
(4, 4, 'Metformin',    '1000 mg','Twice daily',   'Oral', '2024-04-12', NULL,         'Dr. Suresh Babu',      'Active'),
(5, 5, 'Ibuprofen',    '400 mg', 'As needed',     'Oral', '2024-05-18', '2024-06-18', 'Dr. Lakshmi Rao',      'Active');

INSERT INTO allergy (patient_id, allergen, reaction, severity, onset_date, status) VALUES
(1, 'Penicillin',       'Hives and rash',              'Moderate',        '2010-06-01', 'Active'),
(2, 'Shellfish',        'Anaphylaxis',                 'Life-threatening', '2015-09-14', 'Active'),
(3, 'Sulfonamides',     'Stevens-Johnson Syndrome',    'Severe',          '2018-03-22', 'Active'),
(4, 'Latex',            'Contact dermatitis',          'Mild',            '2020-11-05', 'Active'),
(5, 'Codeine',          'Nausea and vomiting',         'Mild',            '2022-07-30', 'Active');

INSERT INTO test_results (encounter_id, patient_id, test_name, test_date, result_value, unit, reference_range, status, ordered_by, notes) VALUES
(1, 1, 'Troponin I',      '2024-01-11', '0.08',  'ng/mL', '< 0.04',    'Abnormal', 'Dr. Meena Subramaniam', 'Elevated; repeat in 6h'),
(2, 2, 'MRI Brain',       '2024-02-21', 'Normal','',      'Normal',     'Normal',   'Dr. Ravi Chandran',    'No structural abnormality'),
(3, 3, 'WBC Count',       '2024-03-05', '14.5',  'K/uL',  '4.5 – 11.0','Abnormal', 'Dr. Anjali Mehta',     'Leukocytosis consistent with infection'),
(4, 4, 'HbA1c',           '2024-04-12', '8.2',   '%',     '< 7.0',     'Abnormal', 'Dr. Suresh Babu',      'Suboptimal glycemic control'),
(5, 5, 'MRI Left Knee',   '2024-05-20', 'Medial meniscus tear grade II','','',     'Abnormal', 'Dr. Lakshmi Rao', 'Conservative vs surgical review needed');
