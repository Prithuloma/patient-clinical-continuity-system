
# Patient Centric Clinical Data Continuity System

A full-stack system to manage and visualize continuous patient clinical records across encounters.

---

## Overview

A web application that ensures continuity of patient clinical data across multiple healthcare encounters.

---

## Tech Stack

* Node.js + Express
* MySQL
* HTML, CSS, JavaScript

---

## Features

* Add patients
* Record clinical encounters
* View complete patient history
* Integrated diagnosis, medications, and test results

---

## Folder Structure

```
patient-cdcs/
├── server.js
├── package.json
├── db.js
├── patients.js
├── encounters.js
├── clinical.js
├── history.js
├── index.html
├── add-encounter.html
├── patient-history.html
├── style.css
└── schema.sql
```

---

## Setup

```bash
npm install
# Import SQL schema into MySQL
mysql -u root -p < schema.sql
# Start server
node server.js
```

---

## How to Run

1. Clone repo
2. Run `npm install`
3. Setup MySQL database using schema.sql
4. Run `node server.js`
5. Open http://localhost:3000

---

## Author

Prithuloma S.B.
