const medicamentosTable = document.getElementById("medicamentos-table").querySelector("tbody");
const tiposCancerTable = document.getElementById("tiposcancer-table").querySelector("tbody");

// Cargar datos al cargar la página
document.addEventListener("DOMContentLoaded", () => {
  cargarMedicamentos();
  cargarTiposCancer();
});

// Función para cargar los medicamentos
async function cargarMedicamentos() {
  const response = await fetch("http://localhost:3000/api/medicamentos");
  const medicamentos = await response.json();

  medicamentosTable.innerHTML = "";
  medicamentos.forEach((medicamento) => {
    const row = `<tr>
      <td>${medicamento.id}</td>
      <td>${medicamento.nombre}</td>
      <td>${medicamento.tipo_medicamento}</td>
      <td>${medicamento.ingrediente_activo}</td>
      <td>${medicamento.tipo_cancer_nombre}</td>
      <td>${medicamento.laboratorio}</td>
      <td>${medicamento.precio}</td>
      <td>
        <button onclick="editarMedicamento(${medicamento.id})" class="text-blue-400 hover:text-blue-700">Editar</button>
        <button onclick="eliminarMedicamento(${medicamento.id})" class="text-red-400 hover:text-red-700">Eliminar</button>
      </td>
    </tr>`;
    medicamentosTable.innerHTML += row;
  });
}

// Función para cargar los tipos de cáncer
async function cargarTiposCancer() {
  const response = await fetch("http://localhost:3000/api/tiposcancer");
  const tiposCancer = await response.json();

  tiposCancerTable.innerHTML = "";
  tiposCancer.forEach((tipo) => {
    const row = `<tr>
      <td>${tipo.id}</td>
      <td>${tipo.nombre}</td>
      <td>${tipo.descripcion}</td>
      <td>${tipo.sintomas}</td>
      <td>
        <button onclick="editarTipoCancer(${tipo.id})" class="text-blue-400 hover:text-blue-700">Editar</button>
        <button onclick="eliminarTipoCancer(${tipo.id})" class="text-red-400 hover:text-red-700">Eliminar</button>
      </td>
    </tr>`;
    tiposCancerTable.innerHTML += row;
  });
}

// CRUD para Medicamentos---------------------------------------------------------------------------ooooooooooooooooooo
async function eliminarMedicamento(id) {
  if (confirm("¿Estás seguro de que deseas eliminar este medicamento?")) {
    await fetch(`http://localhost:3000/api/medicamentos/admin/${id}`, { method: "DELETE" });
    cargarMedicamentos();
  }
}

function mostrarFormularioEditar(id, medicamento) {
  // Verifica si ya existe un formulario desplegado y lo elimina
  const formularioExistente = document.getElementById("formulario-editar");
  if (formularioExistente) formularioExistente.remove();

  // Crea el formulario de edición
  const formulario = document.createElement("div");
  formulario.id = "formulario-editar";
  formulario.innerHTML = `
    <h3>Editar Medicamento</h3>
    <form id="editar-formulario">
      <label for="nombre">Nombre:</label>
      <input type="text" id="nombre" name="nombre" value="${medicamento.nombre}" required>
      <label for="tipo_medicamento">Tipo de Medicamento:</label>
      <input type="text" id="tipo_medicamento" name="tipo_medicamento" value="${medicamento.tipo_medicamento}" required>
      <label for="ingrediente_activo">Ingrediente Activo:</label>
      <input type="text" id="ingrediente_activo" name="ingrediente_activo" value="${medicamento.ingrediente_activo}" required>
      <label for="tipo_cancer_nombre">Tipo de Cáncer:</label>
      <input type="text" id="tipo_cancer_nombre" name="tipo_cancer_nombre" value="${medicamento.tipo_cancer_nombre}" required>
      <label for="laboratorio">Laboratorio:</label>
      <input type="text" id="laboratorio" name="laboratorio" value="${medicamento.laboratorio}" required>
      <label for="imagen">Imagen (URL):</label>
      <input type="text" id="imagen" name="imagen" value="${medicamento.imagen}" required>
      <label for="precio">Precio:</label>
      <input type="number" id="precio" name="precio" value="${medicamento.precio}" step="0.01" required>
      <button type="button" id="guardar-cambios">Guardar Cambios</button>
      <button type="button" id="cancelar-edicion">Cancelar</button>
    </form>
  `;
  document.body.appendChild(formulario);

  // Maneja el evento de guardar cambios
  document.getElementById("guardar-cambios").addEventListener("click", () => {
    const nombre = document.getElementById("nombre").value;
    const tipo_medicamento = document.getElementById("tipo_medicamento").value;
    const ingrediente_activo = document.getElementById("ingrediente_activo").value;
    const tipo_cancer_nombre = document.getElementById("tipo_cancer_nombre").value;
    const laboratorio = document.getElementById("laboratorio").value;
    const imagen = document.getElementById("imagen").value;
    const precio = parseFloat(document.getElementById("precio").value);

    fetch(`http://localhost:3000/api/medicamentos/admin/${id}`, {
      method: "PUT",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        nombre,
        tipo_medicamento,
        ingrediente_activo,
        tipo_cancer_nombre,
        laboratorio,
        imagen,
        precio,
      }),
    })
      .then((response) => {
        if (response.ok) {
          alert("Medicamento actualizado exitosamente.");
          formulario.remove();
          cargarMedicamentos();
        } else {
          alert("Error al actualizar el medicamento.");
        }
      })
      .catch((error) => console.error("Error al actualizar el medicamento:", error));
  });

  // Maneja el evento de cancelar
  document.getElementById("cancelar-edicion").addEventListener("click", () => {
    formulario.remove();
  });
}

function editarMedicamento(id) {
  // Obtiene los datos del medicamento para precargar el formulario
  fetch(`http://localhost:3000/api/medicamentos/${id}`)
    .then((response) => response.json())
    .then((medicamento) => mostrarFormularioEditar(id, medicamento))
    .catch((error) => console.error("Error al obtener los datos del medicamento:", error));
}


// Función para agregar un nuevo medicamento
function agregarMedicamento() {
  const nombre = document.getElementById("nombre").value;
  const tipo_medicamento = document.getElementById("tipo_medicamento").value;
  const ingrediente_activo = document.getElementById("ingrediente_activo").value;
  const tipo_cancer_nombre = document.getElementById("tipo_cancer_nombre").value;
  const laboratorio = document.getElementById("laboratorio").value;
  const imagen = document.getElementById("imagen").value;
  const precio = parseFloat(document.getElementById("precio").value);

  if (!nombre || !tipo_medicamento || !ingrediente_activo || !tipo_cancer_nombre || !laboratorio || !imagen || isNaN(precio)) {
    alert("Por favor, completa todos los campos correctamente.");
    return;
  }

  fetch("http://localhost:3000/api/medicamentos/admin", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      nombre,
      tipo_medicamento,
      ingrediente_activo,
      tipo_cancer_nombre,
      laboratorio,
      imagen,
      precio,
    }),
  })
    .then((response) => {
      if (response.ok) {
        alert("Medicamento creado exitosamente.");
        cargarMedicamentos();
        document.getElementById("form-medicamento").reset();
      } else {
        alert("Error al crear el medicamento.");
      }
    })
    .catch((error) => console.error("Error al crear el medicamento:", error));
}

// CRUD para Tipos de Cáncer
async function eliminarTipoCancer(id) {
  if (confirm("¿Estás seguro de que deseas eliminar este tipo de cáncer?")) {
    await fetch(`http://localhost:3000/api/tiposcancer/admin/${id}`, { method: "DELETE" });
    cargarTiposCancer();
  }
}

/*function editarTipoCancer(id) {
  const nuevoTipo = prompt("Ingrese el nuevo tipo:");
  const nuevaDescripcion = prompt("Ingrese la nueva descripción:");
  if (nuevoTipo && nuevaDescripcion) {
    fetch(`http://localhost:3000/api/tiposcancer/admin/${id}`, {
      method: "PUT",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ tipo: nuevoTipo, descripcion: nuevaDescripcion }),
    }).then(() => cargarTiposCancer());
  }
}*/

// Función para agregar un nuevo cancer
function agregarTipocancer() {
  const nombre = document.getElementById("nombrecancer").value;
  const descripcion = document.getElementById("descripcioncancer").value;
  const sintomas = document.getElementById("sintomascancer").value;


  if (!nombre || !descripcion || !sintomas) {
    alert("Por favor, completa todos los campos correctamente.");
    return;
  }

  fetch("http://localhost:3000/api/tiposcancer/admin", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      nombre,
      descripcion,
      sintomas,
    }),
  })
    .then((response) => {
      if (response.ok) {
        alert("Cáncer creado exitosamente.");
        cargarTiposCancer();
        document.getElementById("form-tiposcancer").reset();
      } else {
        alert("Error al crear el medicamento.");
      }
    })
    .catch((error) => console.error("Error al crear el Cáncer:", error));
}

// Cargar noticias dinámicamente
function cargarNoticias() {
  fetch("http://localhost:3000/api/noticias")
    .then((response) => response.json())
    .then((noticias) => {
      const contenedor = document.getElementById("noticias-admin");
      contenedor.innerHTML = ""; // Limpiar contenido

      noticias.forEach((noticia) => {
        const noticiaHTML = `
          <div class="flex mb-10 border-b pb-4">
            <div class="w-3/5 pr-10">
              <h3 class="font-bold text-2xl">${noticia.titulo}</h3>
              <p class="text-blue-900 text-lg mt-2">${noticia.texto}</p>
              <a href="${noticia.enlace}" class="text-blue-500 underline">Leer más</a>
            </div>
            <div class="w-2/5">
              <img src="${noticia.imagen}" alt="Noticia" class="max-w-full rounded-lg" />
            </div>
            <button class="mt-4 bg-yellow-500 text-white px-4 py-2 rounded" onclick="editarNoticia(${noticia.id})">Editar</button>
          </div>
        `;
        contenedor.insertAdjacentHTML("beforeend", noticiaHTML);
      });
    });
}

// Mostrar formulario de edición
function editarNoticia(id) {
  fetch(`http://localhost:3000/api/noticias/${id}`)
    .then((response) => response.json())
    .then((noticia) => {
      document.getElementById("noticia-id").value = noticia.id;
      document.getElementById("titulo").value = noticia.titulo;
      document.getElementById("texto").value = noticia.texto;
      document.getElementById("imagen").value = noticia.imagen;
      document.getElementById("enlace").value = noticia.enlace;

      document.getElementById("editar-noticia").classList.remove("hidden");
    });
}

// Guardar cambios
function guardarCambiosNoticia() {
  const id = document.getElementById("noticia-id").value;
  const titulo = document.getElementById("titulo").value;
  const texto = document.getElementById("texto").value;
  const imagen = document.getElementById("imagen").value;
  const enlace = document.getElementById("enlace").value;

  fetch(`http://localhost:3000/api/noticias/${id}`, {
    method: "PUT",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ titulo, texto, imagen, enlace }),
  })
    .then((response) => {
      if (response.ok) {
        alert("Noticia actualizada exitosamente.");
        cargarNoticias();
        cancelarEdicion();
      } else {
        alert("Error al actualizar la noticia.");
      }
    });
}

// Cancelar edición
function cancelarEdicion() {
  document.getElementById("editar-noticia").classList.add("hidden");
  document.getElementById("form-editar-noticia").reset();
}

// Cargar noticias al inicio
cargarNoticias();
