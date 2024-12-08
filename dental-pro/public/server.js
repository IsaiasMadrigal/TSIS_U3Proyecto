const express = require("express");
const mysql = require("mysql");
const cors = require("cors");
const bodyParser = require("body-parser");

const app = express();
const port = 3000;

// Middleware para permitir solicitudes desde el cliente
app.use(cors());
app.use(bodyParser.json());
// Configuración de la conexión a la base de datos MySQL
const db = mysql.createConnection({
  host: "localhost",       // Cambia si tu base de datos está en un servidor diferente
  user: "root",            // Tu usuario de MySQL
  password: "",            // La contraseña de tu usuario de MySQL
  database: 'plataformamedica' // Nombre de la base de datos
});

// Conexión a la base de datos
db.connect((err) => {
  if (err) {
    console.error("Error al conectar a la base de datos:", err);
    return;
  }
  console.log("Conexión exitosa a la base de datos MySQL");
});




// Ruta para autenticar administradores------------------------------------------------------------
app.post("/api/login", express.json(), (req, res) => {
  const { nombre_usuario, contrasena } = req.body;

  // Consulta a la base de datos
  const query = "SELECT * FROM administradores WHERE nombre_usuario = ?";
  db.query(query, [nombre_usuario], (err, results) => {
    if (err) {
      console.error("Error al consultar la base de datos:", err);
      return res.status(500).json({ error: "Error del servidor" });
    }

    if (results.length === 0) {
      // Usuario no encontrado
      return res.status(404).json({ error: "Usuario no encontrado" });
    }

    const admin = results[0];
    if (admin.contrasena !== contrasena) {
      // Contraseña incorrecta
      return res.status(401).json({ error: "Contraseña incorrecta" });
    }

    // Autenticación exitosa
    res.status(200).json({ message: "Autenticación exitosa" });
  });
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

// Ruta para obtener los datos de la tabla "tiposcancer"
app.get("/api/tiposcancer", (req, res) => {
  const query = "SELECT * FROM tiposcancer";
  db.query(query, (err, results) => {
    if (err) {
      console.error("Error al obtener datos:", err);
      res.status(500).send("Error al obtener datos de la base de datos");
    } else {
      res.json(results); // Devuelve los resultados en formato JSON
    }
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

//CRUD'S---------------------------------------------------------------------------
// Ruta para crear un nuevo medicamento (administración)
app.post("/api/medicamentos/admin", (req, res) => {
  const {
    nombre,
    tipo_medicamento,
    ingrediente_activo,
    tipo_cancer_nombre,
    laboratorio,
    imagen,
    precio,
  } = req.body;

  const query =
    "INSERT INTO medicamentos (nombre, tipo_medicamento, ingrediente_activo, tipo_cancer_nombre, laboratorio, imagen, precio) VALUES (?, ?, ?, ?, ?, ?, ?)";

  db.query(
    query,
    [nombre, tipo_medicamento, ingrediente_activo, tipo_cancer_nombre, laboratorio, imagen, precio],
    (err) => {
      if (err) {
        console.error("Error al insertar datos:", err);
        res.status(500).send("Error al insertar datos en la base de datos");
      } else {
        res.status(201).send("Medicamento creado exitosamente");
      }
    }
  );
});

// Ruta para actualizar un medicamento por ID (administración)
app.put("/api/medicamentos/admin/:id", (req, res) => {
  const { id } = req.params;
  const { nombre, descripcion } = req.body;
  db.query("UPDATE medicamentos SET nombre = ?, descripcion = ? WHERE id = ?", [nombre, descripcion, id], (err) => {
    if (err) {
      console.error("Error al actualizar datos:", err);
      res.status(500).send("Error al actualizar datos en la base de datos");
    } else {
      res.send("Medicamento actualizado exitosamente");
    }
  });
});

// Ruta para eliminar un medicamento por ID (administración)
app.delete("/api/medicamentos/admin/:id", (req, res) => {
  const { id } = req.params;
  db.query("DELETE FROM medicamentos WHERE id = ?", [id], (err) => {
    if (err) {
      console.error("Error al eliminar datos:", err);
      res.status(500).send("Error al eliminar datos de la base de datos");
    } else {
      res.send("Medicamento eliminado exitosamente");
    }
  });
});

//insertar un nuevo tipo de cáncer
app.post("/api/tiposcancer/admin", (req, res) => {
  const {
    nombre,
    descripcion,
    sintomas,
  } = req.body;

  const query =
    "INSERT INTO tiposcancer (nombre, descripcion, sintomas) VALUES (?, ?, ?)";

  db.query(
    query,
    [nombre, descripcion, sintomas],
    (err) => {
      if (err) {
        console.error("Error al insertar datos:", err);
        res.status(500).send("Error al insertar datos en la base de datos");
      } else {
        res.status(201).send("Cáncer creado exitosamente");
      }
    }
  );
});

/*app.put("/api/tiposcancer/:id", (req, res) => {
  const { id } = req.params;
  const { tipo, descripcion } = req.body;
  db.query("UPDATE tiposcancer SET tipo = ?, descripcion = ? WHERE id = ?", [tipo, descripcion, id], (err) => {
    if (err) return res.status(500).send(err);
    res.send("Tipo de cáncer actualizado");
  });
});*/

// Ruta para eliminar un cancer por ID (administración)
app.delete("/api/tiposcancer/admin/:id", (req, res) => {
  const { id } = req.params;
  db.query("DELETE FROM tiposcancer WHERE id = ?", [id], (err) => {
    if (err) {
      console.error("Error al eliminar datos:", err);
      res.status(500).send("Error al eliminar datos de la base de datos");
    } else {
      res.send("Cáncer eliminado exitosamente");
    }
  });
});

// Obtener todas las noticias
app.get("/api/noticias", (req, res) => {
  db.query("SELECT * FROM noticias", (err, resultados) => {
    if (err) {
      console.error("Error al obtener noticias:", err);
      res.status(500).send("Error al obtener noticias");
    } else {
      res.json(resultados);
    }
  });
});

// Obtener una noticia por ID
app.get("/api/noticias/:id", (req, res) => {
  const { id } = req.params;
  db.query("SELECT * FROM noticias WHERE id = ?", [id], (err, resultados) => {
    if (err) {
      console.error("Error al obtener la noticia:", err);
      res.status(500).send("Error al obtener la noticia");
    } else {
      res.json(resultados[0]);
    }
  });
});

// Actualizar una noticia por ID
app.put("/api/noticias/:id", (req, res) => {
  const { id } = req.params;
  const { titulo, texto, imagen, enlace } = req.body;

  db.query(
    "UPDATE noticias SET titulo = ?, texto = ?, imagen = ?, enlace = ? WHERE id = ?",
    [titulo, texto, imagen, enlace, id],
    (err) => {
      if (err) {
        console.error("Error al actualizar la noticia:", err);
        res.status(500).send("Error al actualizar la noticia");
      } else {
        res.send("Noticia actualizada exitosamente");
      }
    }
  );
});

// Inicia el servidor
app.listen(port, () => {
  console.log(`Servidor corriendo en http://localhost:${port}`);
});