/**
 * ===============================
 * APLICACIÓN CLIENTE CON VULNERABILIDADES
 * ===============================
 * VULNERABILIDADES INTENCIONALES:
 * - XSS en output
 * - Parámetros en URL sin sanitizar
 * - Exposición de endpoints de admin
 */

function login() {
    const username = document.getElementById('username').value;
    const password = document.getElementById('password').value;

    if (!username || !password) {
        document.getElementById('output').textContent = "Por favor completa todos los campos";
        return;
    }

    // VULNERABILIDAD: Parámetros en URL sin encriptación
    fetch(`/login?username=${username}&password=${password}`)
        .then(res => res.text())
        .then(data => {
            // VULNERABILIDAD: XSS - Se inserta HTML sin sanitizar
            document.getElementById('output').innerHTML = data;
        })
        .catch(err => {
            document.getElementById('output').textContent = "Error: " + err.message;
        });
}

function getUsers() {
    // VULNERABILIDAD: Endpoint de admin expuesto sin autenticación
    fetch('/users')
        .then(res => res.json())
        .then(data => {
            // VULNERABILIDAD: Se exponen todas las contraseñas
            document.getElementById('output').textContent = JSON.stringify(data, null, 2);
        })
        .catch(err => {
            document.getElementById('output').textContent = "Error: " + err.message;
        });
}

function saveUser() {
    const username = prompt("Ingresa nombre de usuario:");
    const password = prompt("Ingresa contraseña:");

    if (!username || !password) {
        document.getElementById('output').textContent = "Operación cancelada";
        return;
    }

    // VULNERABILIDAD: Método POST inseguro
    fetch('/save', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ username, password })
    })
    .then(res => res.text())
    .then(data => {
        document.getElementById('output').textContent = data;
    })
    .catch(err => {
        document.getElementById('output').textContent = "Error: " + err.message;
    });
}
