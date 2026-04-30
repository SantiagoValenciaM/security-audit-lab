# 🔐 Secure Audit Lab - Laboratorio de Auditoría de Seguridad

**Desarrollo de Software Seguro**  
**Facultad de Telemática - Universidad de Colima**  
**Docente: Rodrigo Ramírez**  

---

## 📖 Descripción

En esta materia de Desarrollo de Software Seguro, te presento este laboratorio educativo que contiene **vulnerabilidades intencionales**. Tu misión es practicar la identificación, análisis y mitigación de riesgos de seguridad en aplicaciones web reales.

A través de este proyecto, desarrollarás competencias críticas en:
- Identificación de vulnerabilidades OWASP Top 10
- Análisis de riesgos de seguridad
- Propuesta de soluciones de remediación
- Documentación profesional de auditorías
- Implementación de prácticas seguras de desarrollo

## 📋 Estructura del Proyecto

```
secure-audit-lab/
├── server.js              # Backend vulnerable (Express)
├── package.json           # Dependencias
├── public/
│   ├── index.html        # Interfaz de usuario
│   ├── app.js            # Lógica del cliente (vulnerable)
│   └── styles.css        # Estilos
├── data/
│   └── users.json        # Base de datos simulada
└── logs/
    ├── connections.log   # Registro de conexiones
    └── activity.log      # Registro de actividades
```

## 🚀 Instalación y Uso

### 1. Instalar dependencias
```bash
npm install
```

### 2. Iniciar el servidor
```bash
npm start
```

### 3. Acceder a la aplicación
- URL: `http://localhost:3000`
- El servidor registrará todas las conexiones en `logs/connections.log`

## 📊 Sistema de Logging

El servidor registra automáticamente:

### **connections.log**
- Todas las conexiones HTTP
- IP del cliente
- Método (GET, POST, etc.)
- URL accedida
- User-Agent del navegador
- Timestamp

**Ubicación:** `./logs/connections.log`

### **activity.log**
- Intentos de login
- Lecturas de usuarios
- Acceso a admin
- Errores
- Cualquier acción crítica

**Ubicación:** `./logs/activity.log`

## 🔴 Vulnerabilidades Intencionales

### VULNERABILIDAD 1: SQL Injection (Simulada)
**Ubicación:** `/login` (GET)
```javascript
// VULNERABLE: Compara directamente sin sanitizar
const user = users.find(u => u.username == username && u.password == password);
```
**Problema:** Usa `==` en lugar de `===`, no valida entrada
**Impacto:** Posible bypass de autenticación

### VULNERABILIDAD 2: Exposición de Datos Sensibles
**Ubicación:** `/users` (GET)
```javascript
res.json(users); // Expone TODAS las contraseñas en texto plano
```
**Problema:** Sin autenticación, devuelve todas las credenciales
**Impacto:** Información Disclosure, compromiso de cuentas

### VULNERABILIDAD 3: Escritura Insegura en Archivo
**Ubicación:** `/save` (POST)
```javascript
fs.appendFileSync('./data/users.json', JSON.stringify(data));
```
**Problemas:**
- Corrompe el JSON al hacer append
- No valida entrada
- Sin protección de acceso
- Permite inyección de datos arbitrarios

### VULNERABILIDAD 4: Manejo Deficiente de Errores
**Ubicación:** `/error` (GET)
```javascript
throw new Error("Error interno del servidor");
```
**Problema:** Expone stack trace completo a clientes
**Impacto:** Information Disclosure

### VULNERABILIDAD 5: XSS (Cross-Site Scripting)
**Ubicación:** `public/app.js` - función `login()`
```javascript
document.getElementById('output').innerHTML = data; // Sin sanitizar
```
**Problema:** Inserta HTML directamente sin validar
**Impacto:** Ejecución de código malicioso en navegador

### VULNERABILIDAD 6: Missing Authentication
**Ubicación:** `/admin/stats` (GET)
- Endpoint administrativo sin autenticación
- Expone información sensible del sistema

### VULNERABILIDAD 7: Path Traversal
**Ubicación:** `/logs/:file` (GET)
```javascript
fs.readFileSync(path.join(logsDir, file), 'utf-8');
```
**Problema:** Podría permitir acceso a archivos fuera de `/logs`
**Impacto:** Lectura no autorizada de archivos

## 📝 Fases del Laboratorio

### FASE 1: Identificación
- [ ] Ejecutar la aplicación
- [ ] Revisar los logs generados
- [ ] Detectar vulnerabilidades en backend y frontend
- [ ] Clasificarlas (XSS, SQL Injection, etc.)

### FASE 2: Análisis
- [ ] Documentar cada vulnerabilidad
- [ ] Explicar el impacto de seguridad
- [ ] Proporcionar evidencia (request/response)
- [ ] Clasificar por severidad (CVSS)

### FASE 3: Mitigación
- [ ] Proponer soluciones específicas
- [ ] Hash de contraseñas (bcrypt)
- [ ] Sanitización de inputs
- [ ] Validación en cliente y servidor
- [ ] Manejo seguro de errores
- [ ] Autenticación y autorización

### FASE 4: Entregable
- [ ] Reporte técnico con:
  - Lista de vulnerabilidades encontradas
  - Evidencia con capturas/logs
  - Recomendaciones de remediación
  - Mini plan de acción prioritario
  - Código corregido (opcionales)

## 🔗 Endpoints Disponibles

| Endpoint | Método | Descripción | Vulnerabilidades |
|----------|--------|-------------|------------------|
| `/` | GET | Página principal | XSS |
| `/login` | GET | Autenticación | SQL Injection simulada |
| `/users` | GET | Listar usuarios | Información Disclosure |
| `/save` | POST | Guardar usuario | Validación insegura, corrupción de datos |
| `/error` | GET | Trigger error | Error Handling deficiente |
| `/admin/stats` | GET | Estadísticas admin | Missing Authentication |
| `/logs/:file` | GET | Leer logs | Path Traversal potencial |

## 📊 Monitoreo de Estudiantes

Los logs permiten ver exactamente qué estudiantes accedieron y qué hicieron:

```bash
# Ver todas las conexiones
cat logs/connections.log

# Ver actividades específicas
grep "LOGIN_ATTEMPT" logs/activity.log

# Monitorear acceso en tiempo real
tail -f logs/connections.log
```

## 💡 Ejemplo de Uso Seguro

Para referencia, aquí hay ejemplos de código seguro:

### Login Seguro
```javascript
// Usar bcrypt para hash
const bcrypt = require('bcrypt');
const user = users.find(u => u.username === username); // === en lugar de ==
if (user && await bcrypt.compare(password, user.passwordHash)) {
    // Generar token JWT
}
```

### Sanitización de XSS
```javascript
// Usar textContent en lugar de innerHTML
document.getElementById('output').textContent = data;
// O sanitizar con DOMPurify
document.getElementById('output').innerHTML = DOMPurify.sanitize(data);
```

### Validación de Input
```javascript
// Validar en servidor
if (!username || typeof username !== 'string' || username.length > 50) {
    return res.status(400).json({ error: 'Invalid input' });
}
```

## 📚 Recursos Adicionales

- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [CWE Top 25](https://cwe.mitre.org/top25/)
- [OWASP Testing Guide](https://owasp.org/www-project-web-security-testing-guide/)

## ⚠️ Disclaimer

Este proyecto contiene vulnerabilidades intencionales **SOLO** para propósitos educativos. 
**NUNCA** desplegar código similar en producción. 
Este código es exclusivamente para aprendizaje en entorno controlado.

---

**Última actualización:** 29 de Abril de 2026
**Versión:** 1.0.0
