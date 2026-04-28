const express = require('express');
const cors    = require('cors');
const path    = require('path');

const app = express();
app.use(cors());
app.use(express.json());

// API routes before static files so /api/* is never treated as a static path
app.use('/api/patients',   require('./patients'));
app.use('/api/encounters', require('./encounters'));
app.use('/api/clinical',   require('./clinical'));
app.use('/api/history',    require('./history'));

app.use(express.static(path.join(__dirname, '../frontend')));

app.get('/', (_, res) => res.sendFile(path.join(__dirname, '../frontend/index.html')));

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`CDCS running → http://localhost:${PORT}`));
