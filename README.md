# Patient Centric Clinical Data Continuity System

## Folder Structure
```
patient-cdcs/
├── server.js
├── package.json
├── db.js
├── routes/
│   ├── patients.js
│   ├── encounters.js
│   ├── clinical.js
│   └── history.js
├── public/
│   ├── index.html
│   ├── add-encounter.html
│   ├── patient-history.html
│   └── style.css
└── sql/
    └── schema.sql
```

## Setup
```bash
npm install
# Import SQL schema into MySQL
mysql -u root -p < sql/schema.sql
# Start server
node server.js
```
