document.getElementById("login-form").addEventListener("submit", async (e) => {
    e.preventDefault();
  
    const username = document.getElementById("username").value;
    const password = document.getElementById("password").value;
  
    try {
      const response = await fetch("http://localhost:3000/api/login", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ nombre_usuario: username, contrasena: password }),
      });
  
      if (!response.ok) {
        const errorData = await response.json();
        document.getElementById("error-message").textContent = errorData.error;
        return;
      }
  
      // Redirige al index.html si el inicio de sesión es exitoso
      window.location.href = "index.html";
    } catch (error) {
      document.getElementById("error-message").textContent =
        "Error al conectar con el servidor.";
    }
  });
  