/**
 * ===============================
 * SECURE AUDIT LAB - SERVIDOR
 * Stack: Node.js (Express) + Vanilla JS
 * NOTA: Este proyecto contiene VULNERABILIDADES INTENCIONALES
 * ===============================
 */

const express = require('express');
const fs = require('fs');
const path = require('path');
const bodyParser = require('body-parser');

const app = express();
app.use(bodyParser.json());
app.use(express.static('public'));

// ===============================
// SISTEMA DE LOGGING
// ===============================
const logsDir = path.join(__dirname, 'logs');
const connectionLogFile = path.join(logsDir, 'connections.log');
const activityLogFile = path.join(logsDir, 'activity.log');

// Crear directorio de logs si no existe
if (!fs.existsSync(logsDir)) {
    fs.mkdirSync(logsDir, { recursive: true });
}

// Middleware para logging de todas las conexiones
app.use((req, res, next) => {
    const timestamp = new Date().toISOString();
    const ip = req.ip || req.connection.remoteAddress;
    const method = req.method;
    const url = req.originalUrl;
    const userAgent = req.get('user-agent') || 'Unknown';
    
    const logEntry = `[${timestamp}] ${method} ${url} | IP: ${ip} | User-Agent: ${userAgent}\n`;
    
    // Escribir en archivo de log de conexiones
    fs.appendFileSync(connectionLogFile, logEntry);
    
    // También loguear en consola
    console.log(`[${timestamp}] ${method} ${url} (${ip})`);
    
    next();
});

// Función para loguear actividades
function logActivity(action, details) {
    const timestamp = new Date().toISOString();
    const logEntry = `[${timestamp}] ACTION: ${action} | DETAILS: ${JSON.stringify(details)}\n`;
    fs.appendFileSync(activityLogFile, logEntry);
}

// ===============================
// Simulación de base de datos
// ===============================
let users = require('./data/users.json');

// ===============================
// VULNERABILIDAD 1: Inyección (simulada tipo SQL)
// ===============================
/**
 * ⚠️ VULNERABILIDAD: SQL Injection (simulada)
 * - Compara directamente sin sanitizar
 * - Usa == en lugar de ===
 * - Credenciales en logs
 */
app.get('/login', (req, res) => {
    const { username, password } = req.query;

    logActivity('LOGIN_ATTEMPT', { username, password });

    // VULNERABLE: Comparación insegura
    const user = users.find(u => u.username == username && u.password == password);

    if (user) {
        res.send(`Bienvenido ${user.username}`);
        logActivity('LOGIN_SUCCESS', { username });
    } else {
        res.send("Error: usuario o contraseña incorrectos");
        logActivity('LOGIN_FAILED', { username, reason: 'Invalid credentials' });
    }
});

// ===============================
// VULNERABILIDAD 2: Exposición de datos sensibles
// ===============================
/**
 * ⚠️ VULNERABILIDAD: Información Disclosure
 * - Expone TODOS los usuarios
 * - Devuelve contraseñas en texto plano
 * - Sin autenticación
 */
app.get('/users', (req, res) => {
    logActivity('GET_ALL_USERS', { count: users.length });
    res.json(users); // devuelve TODO, incluyendo passwords
});

// ===============================
// VULNERABILIDAD 3: Escritura insegura en archivo
// ===============================
/**
 * ⚠️ VULNERABILIDADES MÚLTIPLES:
 * - No valida entrada
 * - Corrompe JSON al appender
 * - Sin protección de acceso
 * - Sin persistencia adecuada
 */
app.post('/save', (req, res) => {
    const data = req.body;

    logActivity('SAVE_USER', { data });

    // VULNERABLE: Append directo corrompe JSON
    fs.appendFileSync('./data/users.json', JSON.stringify(data));

    res.send("Guardado correctamente");
});

// ===============================
// VULNERABILIDAD 4: Manejo deficiente de errores
// ===============================
/**
 * ⚠️ VULNERABILIDAD: Error Handling
 * - Expone stack trace
 * - No hay manejo de errores
 * - No hay validación
 */
app.get('/error', (req, res) => {
    logActivity('ERROR_TEST', { triggered: true });
    throw new Error("Error interno del servidor");
});

// ===============================
// ENDPOINT BONUS: Lectura de logs (VULNERABLE)
// ===============================
/**
 * ⚠️ VULNERABILIDAD: Path Traversal
 * - Permite leer archivos del sistema
 */
app.get('/logs/:file', (req, res) => {
    const file = req.params.file;
    logActivity('READ_LOGS', { file });
    
    try {
        const content = fs.readFileSync(path.join(logsDir, file), 'utf-8');
        res.type('text/plain').send(content);
    } catch (err) {
        res.status(404).send('Archivo no encontrado');
    }
});

// ===============================
// ENDPOINT DE ADMIN (SIN PROTECCIÓN)
// ===============================
/**
 * ⚠️ VULNERABILIDAD: Missing Authentication
 * - Admin endpoint sin autenticación
 */
app.get('/admin/stats', (req, res) => {
    logActivity('ADMIN_STATS_REQUEST', { timestamp: new Date() });
    
    res.json({
        totalUsers: users.length,
        users: users,
        serverTime: new Date(),
        uptime: process.uptime()
    });
});

// ===============================
// Manejo de errores (inseguro)
// ===============================
app.use((err, req, res, next) => {
    console.error('Error:', err);
    logActivity('ERROR_OCCURRED', { error: err.message });
    
    // VULNERABLE: Expone stack trace completo
    res.status(500).json({
        error: err.message,
        stack: err.stack // NO HACER ESTO EN PRODUCCIÓN
    });
});

// ===============================
// Inicio del servidor
// ===============================
const PORT = 3000;
app.listen(PORT, () => {
    console.log(`\n${'='.repeat(50)}`);
    console.log(`🔐 Secure Audit Lab iniciado`);
    console.log(`📍 URL: http://localhost:${PORT}`);
    console.log(`📊 Logs: ./logs/`);
    console.log(`${'='.repeat(50)}\n`);
    
    logActivity('SERVER_START', { port: PORT, timestamp: new Date() });
});
