const express = require('express');
const router = express.Router();
const lotesControllers = require('../controllers/lotesControllers'); // Asegúrate de que la ruta sea correcta

// Prueba con una ruta simple para verificar si funciona
router.get('/lotes', (req, res) => {
    console.log("Ruta /lotes fue accedida"); // 🔥 Verificación
    res.send("Ruta /lotes funciona");
});

// Si tienes un controlador, agrégalo aquí
router.get('/lotes/datos', lotesControllers.getLotes); 

module.exports = router;
