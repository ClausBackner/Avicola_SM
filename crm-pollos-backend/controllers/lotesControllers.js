const pool = require('../models/db'); // Asegúrate de que estás importando bien la conexión a MySQL

const getLotes = async (req, res) => {
    try {
        const [rows] = await pool.query('SELECT * FROM lotes');
        res.json(rows);
    } catch (error) {
        console.error("Error al obtener los lotes:", error);
        res.status(500).json({ error: "Error al obtener los datos" });
    }
};

module.exports = { getLotes };
