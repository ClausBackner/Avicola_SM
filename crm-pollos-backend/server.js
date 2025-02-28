const express = require('express');
const cors = require('cors');

const lotesRoutes = require('./routes/lotesRoutes'); // Asegúrate de que la ruta es correcta

const app = express();

app.use(cors());
app.use(express.json());

app.use('/lotes', lotesRoutes); // Asegúrate de usar correctamente el prefijo '/lotes'

const PORT = 3000;
app.listen(PORT, () => {
    console.log(`Servidor corriendo en http://localhost:${PORT}`);
});
