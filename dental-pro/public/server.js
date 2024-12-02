const express = require("express");
const mysql = require("mysql");
const cors = require("cors");
const path = require("path"); // Para manejar rutas de archivos

const app = express();
const port = 3000;

// Middleware para permitir solicitudes desde el cliente
app.use(cors());
app.use(express.json()); // Para parsear JSON en solicitudes POST/PUT si lo necesitas

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
    process.exit(1); // Detiene el servidor si hay un error
  }
  console.log("Conexión exitosa a la base de datos MySQL");
});

// Servir archivos estáticos desde la carpeta 'public'
app.use(express.static(path.join(__dirname, "public")));  

// Rutas del API

// Ruta para obtener todos los tipos de cáncer
app.get("/api/tiposcancer", (req, res) => {
  const query = "SELECT * FROM tiposcancer";
  db.query(query, (err, results) => {
    if (err) {
      console.error("Error al obtener tipos de cáncer:", err);
      return res.status(500).send("Error al obtener datos de la base de datos");
    }
    // Asegurarse de incluir las rutas de las imágenes
    const tipos = results.map((tipo) => ({
      ...tipo,
      imagen: tipo.imagen ? `/images/t-cancer/${tipo.imagen}` : `/images/t-cancer/default.jpg`,
    }));
    res.json(tipos);
  });
});

// Ruta para obtener detalles de un tipo de cáncer
app.get("/api/tiposcancer/:id", (req, res) => {
  const { id } = req.params;
  const query = "SELECT * FROM tiposcancer WHERE id = ?";
  db.query(query, [id], (err, results) => {
    if (err) {
      console.error("Error al obtener detalles del tipo de cáncer:", err);
      return res.status(500).send("Error al obtener datos de la base de datos");
    }
    if (results.length > 0) {
      const tipo = {
        ...results[0],
        imagen: results[0].imagen
          ? `/images/t-cancer/${results[0].imagen}`
          : `/images/t-cancer/default.jpg`,
      };
      res.json(tipo);
    } else {
      res.status(404).send("Tipo de cáncer no encontrado");
    }
  });
});

// Ruta para obtener medicamentos relacionados con un tipo de cáncer
app.get("/api/tiposcancer/:id/medicamentos", (req, res) => {
  const { id } = req.params;
  const query = "SELECT * FROM medicamentos WHERE tipo_cancer_id = ?";
  db.query(query, [id], (err, results) => {
    if (err) {
      console.error("Error al obtener medicamentos:", err);
      return res.status(500).send("Error al obtener datos de la base de datos");
    }
    res.json(results);
  });
});

// Ruta para servir imágenes directamente (opcional si ya usas 'express.static')
app.get("/images/t-cancer/:imagen", (req, res) => {
  const { imagen } = req.params;
  const rutaImagen = path.join(__dirname, "public", "images", "t-cancer", imagen);
  res.sendFile(rutaImagen, (err) => {
    if (err) {
      console.error("Error al enviar la imagen:", err);
      res.status(404).send("Imagen no encontrada");
    }
  });
});

// Inicia el servidor
app.listen(port, () => {
  console.log(`Servidor corriendo en http://localhost:${port}`);
});
