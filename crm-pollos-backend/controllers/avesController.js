const db = require('../models/db');

exports.getAves = async (req, res) => {
  try {
    const [rows] = await db.query('SELECT * FROM aves');
    res.json(rows);
  } catch (error) {
    res.status(500).json({ message: 'Error al obtener aves', error });
  }
};
