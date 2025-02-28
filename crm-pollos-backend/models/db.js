// db.js
const mysql = require('mysql2');

// Configuración de la conexión
const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: 'root',
  database: 'santamaria',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

// Conectar a la base de datos
connection.connect((err) => {
  if (err) {
    console.error('Error al conectar a MySQL:', err.message);
  } else {
    console.log('Conectado a la base de datos MySQL');
  }
});

module.exports = connection;
