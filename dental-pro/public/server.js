const express = require("express");
const mysql = require("mysql");
const cors = require("cors");

const app = express();
const port = 3000;

// Middleware para permitir solicitudes desde el cliente
app.use(cors());

// Configuración de la conexión a la base de datos MySQL
const db = mysql.createConnection({
  host: "localhost",       // Cambia si tu base de datos está en un servidor diferente
  user: "root",            // Tu usuario de MySQL
  password: "",            // La contraseña de tu usuario de MySQL
  database: "plataformamedica" // Nombre de la base de datos
});

// Conexión a la base de datos
db.connect((err) => {
  if (err) {
    console.error("Error al conectar a la base de datos:", err);
    return;
  }
  console.log("Conexión exitosa a la base de datos MySQL");
});

// Ruta para obtener los datos de la tabla "medicamentos"
app.get("/api/medicamentos", (req, res) => {
  const query = "SELECT * FROM medicamentos";
  db.query(query, (err, results) => {
    if (err) {
      console.error("Error al obtener datos:", err);
      res.status(500).send("Error al obtener datos de la base de datos");
    } else {
      res.json(results); // Devuelve los resultados en formato JSON
    }
  });
});

// Inicia el servidor
app.listen(port, () => {
  console.log(`Servidor corriendo en http://localhost:${port}`);
});
