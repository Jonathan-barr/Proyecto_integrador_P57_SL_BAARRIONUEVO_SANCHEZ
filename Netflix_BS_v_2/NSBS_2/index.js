//importar express
const express = require('express');
const cors = require('cors');
const { dbConnection } = require('./db/config');
require('dotenv').config();

// Crear el servidor/app de express
const app = express();

// Conexión a la Base de Datos
dbConnection();
// Directorio Público
app.use(express.static('public'));

// CORS
app.use(cors());

// Lectura y transformación de body
app.use(express.json());

/// variable env

// console.log(process.env);

// levantar el puerto
app.listen(process.env.PORT, () => {
    console.log(`Servidor corriendo en el puerto ${ process.env.PORT }`);
});

// Rutas

app.use('/api/auth', require('./routes/auth'));