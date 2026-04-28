# 🏥 Patient Centric Clinical Data Continuity System

## 📌 Overview

The **Patient Centric Clinical Data Continuity System** is a full-stack web application designed to maintain a continuous and unified record of a patient’s healthcare journey across multiple encounters, providers, and time periods.

This system ensures that all clinical data related to a patient is centrally stored and easily accessible, enabling better decision-making and improved healthcare outcomes.

---

## 🎯 Objectives

* Maintain **longitudinal patient records**
* Ensure **continuity of care across multiple encounters**
* Reduce **data fragmentation and redundancy**
* Provide **quick access to complete patient history**
* Implement a **rule-based recommendation system** for medications

---

## ⚙️ Tech Stack

* **Frontend:** HTML, CSS, JavaScript
* **Backend:** Node.js (Express)
* **Database:** MySQL

---

## 🗂️ Project Structure

```
/project-root
  /backend
    server.js
    db.js
    patients.js
    encounters.js
    history.js
    clinical.js
    package.json

  /frontend
    index.html
    patient-history.html
    add-encounter.html
    style.css
```

---

## 🧩 Features

### 👤 Patient Management

* Add and store patient details
* Maintain unique patient records

### 🏥 Clinical Encounters

* Record multiple visits for a patient
* Store provider and facility details
* Track admission and discharge

### 📋 Medical Data Tracking

* Diagnoses
* Medications
* Allergies
* Test results

### 🔗 Data Continuity

* Link all records using relational database design
* View complete patient history across time

### 🤖 AI-Based Recommendation (Demo Feature)

* Generates medication recommendations based on:

  * Patient diagnosis
  * Medical history
  * Known allergies
* Highlights:

  * ✅ Recommended medications
  * ❌ Medications to avoid

> Note: This is a rule-based simulation of an AI-driven clinical decision support system.

---

## 🚀 How to Run

### 1. Setup Database

```sql
CREATE DATABASE patient_system;
USE patient_system;
```

* Run `schema.sql` to create tables and insert sample data

---

### 2. Run Backend

```bash
cd backend
npm install
node server.js
```

---

### 3. Run Frontend

* Open `index.html` in browser
  **OR**
* Use Live Server

---

## 🔍 Key Functionalities

* Add Patient
* Add Clinical Encounter
* View Patient History
* Generate AI Recommendations

---

## 🧠 How It Works

* Frontend sends requests to backend APIs
* Backend processes data and interacts with MySQL
* Patient history is retrieved using JOIN queries
* Recommendation system analyzes existing data and applies rule-based logic

---

## 🎓 Academic Value

This project demonstrates:

* Database design and normalization
* Full-stack development
* REST API integration
* Real-world healthcare data modeling
* Clinical decision support concepts

---

## 💬 Sample Use Case

A patient visits multiple times:

* Visit 1 → Fever
* Visit 2 → Follow-up
* Visit 3 → Lab test

The system links all encounters and provides a **complete medical timeline**, along with **safe medication recommendations**.

---

## ⚠️ Disclaimer

This system is for **educational purposes only** and does not replace professional medical advice.

---

## 👩‍💻 Author

**Prithuloma S.B.**
