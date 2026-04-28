const mysql = require('mysql2/promise');

const pool = mysql.createPool({
  host:     process.env.DB_HOST     || 'localhost',
  user:     process.env.DB_USER     || 'root',
  password: process.env.DB_PASSWORD || 'Prithu@1905',
  database: process.env.DB_NAME     || 'patient_cdcs',
  waitForConnections: true,
  connectionLimit: 10
});

pool
  .getConnection()
  .then((conn) => {
    console.log('[db] MySQL pool connected:', process.env.DB_NAME || 'patient_cdcs');
    conn.release();
  })
  .catch((err) => {
    console.error('[db] MySQL connection failed:', err.message);
    console.error('[db] Check DB_HOST, DB_USER, DB_PASSWORD, DB_NAME and that MySQL is running.');
  });

module.exports = pool;
