# 📋 Mi Ruta de Aprendizaje - Auditoría de Seguridad

**Materia:** Desarrollo de Software Seguro  
**Docente:** Rodrigo Ramírez  
**Facultad de Telemática - Universidad de Colima**

---

Este checklist te guiará paso a paso a través del laboratorio. Completa cada tarea y documenta tus hallazgos.

## FASE 1: Exploración y Familiarización ✓

Comienza familiarizándote con el entorno:

- [ ] Verifico que el servidor esté corriendo en `http://localhost:3000`
- [ ] Visualizo la interfaz de login correctamente
- [ ] He leído el `README.md` para entender el proyecto
- [ ] Comprendo que hay vulnerabilidades intencionales para mi aprendizaje

## FASE 2: Reconocimiento de Vulnerabilidades

Ahora comienza a investigar. Busca activamente estas vulnerabilidades:

### Frontend (JavaScript/HTML/CSS)

- [ ] Identifico que hay `innerHTML` usado sin sanitizar
- [ ] Encuentro que los parámetros se pasan en la URL sin encripción
- [ ] Noto que la contraseña se envía en texto plano
- [ ] Veo exposición de endpoints administrativos
- [ ] Descubro que puedo acceder a las contraseñas de todos los usuarios

### Backend (Node.js/Express)

- [ ] Encuentro que usa `==` en lugar de `===` en las comparaciones
- [ ] Veo que `/users` expone todas las contraseñas sin autenticación
- [ ] Noto que `/save` usa `appendFileSync` sin validación (¡corrompe JSON!)
- [ ] Identifico que el manejo de errores expone stack traces completos
- [ ] Descubro que `/admin/stats` no requiere autenticación
- [ ] Veo que se registran contraseñas en texto plano en los logs

### Base de Datos

- [ ] Observo que las contraseñas están en texto plano en `users.json`
- [ ] Identifico que la estructura de datos es vulnerable
- [ ] Constato que no hay encriptación o hashing de contraseñas

## FASE 3: Pruebas y Evidencia

Ahora realiza pruebas controladas para confirmar cada vulnerabilidad:

### Test 1: SQL Injection Simulada
```
- [ ] Intento login con usuario 'admin' y contraseña correcta
- [ ] Pruebo login con caracteres especiales o bypass
- [ ] Documento el comportamiento exacto que observo
```

### Test 2: Información Disclosure
```
- [ ] Accedo a /users sin proporcionar autenticación
- [ ] Verifico si puedo ver todas las contraseñas expuestas
- [ ] Tomo una captura de pantalla como evidencia
```

### Test 3: XSS (Cross-Site Scripting)
```
- [ ] Intento inyectar código JavaScript: <script>alert('XSS')</script>
- [ ] Pruebo con HTML malicioso en el campo de usuario
- [ ] Documento si el código se ejecuta en mi navegador
```

### Test 4: Acceso Admin (Sin Autenticación)
```
- [ ] Accedo a /admin/stats sin proporcionar credenciales
- [ ] Observo qué información del servidor está expuesta
```

### Test 5: Escritura de Archivos Insegura
```
- [ ] Intento guardar un nuevo usuario
- [ ] Verifico si el archivo users.json se corrompe
- [ ] Pruebo inyectar datos maliciosos
```

## FASE 4: Análisis Profesional y Documentación

Ahora que has identificado las vulnerabilidades, debes analizarlas profesionalmente:

### Tabla de Vulnerabilidades

Completa esta tabla para CADA vulnerabilidad que hayas encontrado:

| # | Vulnerabilidad | Ubicación | Severidad | CVSS | Impacto | Evidencia |
|---|---|---|---|---|---|---|
| 1 | | | CRÍTICA/ALTA/MEDIA/BAJA | | | |
| 2 | | | | | | |
| 3 | | | | | | |
| ... | | | | | | |

### Severidades Sugeridas

- **CRÍTICA:** Compromiso completo de sistema, robo de credenciales
- **ALTA:** Acceso no autorizado, exposición de datos sensibles
- **MEDIA:** Funcionalidad comprometida, información parcial expuesta
- **BAJA:** Información de bajo riesgo, impacto mínimo

## FASE 5: Propuesta de Mitigación

Como especialista en seguridad, debes proponer soluciones. Para CADA vulnerabilidad:

### Documento que debes crear para cada una:

- [ ] **¿Cuál es exactamente el problema en el código?**
- [ ] **¿Cuál es el impacto en la seguridad de la aplicación?**
- [ ] **¿Cómo se puede mitigar o arreglarlo?**
- [ ] **Código de ejemplo seguro que lo soluciona**

### Ejemplos de Mitigaciones

```javascript
// ✅ SEGURO: Hash de contraseñas
const bcrypt = require('bcrypt');
const hashed = await bcrypt.hash(password, 10);

// ✅ SEGURO: Sanitizar inputs
const sanitized = DOMPurify.sanitize(userInput);

// ✅ SEGURO: Usar textContent en lugar de innerHTML
element.textContent = data;

// ✅ SEGURO: Validar en servidor
if (typeof username !== 'string' || username.length > 50) {
    return res.status(400).json({ error: 'Invalid' });
}

// ✅ SEGURO: Manejo de errores
try {
    // código
} catch (err) {
    console.error('Error:', err);
    res.status(500).json({ error: 'Internal Server Error' });
    // NO exponer stack trace
}

// ✅ SEGURO: Autenticación
app.use(authMiddleware); // Verificar token/sesión

// ✅ SEGURO: Usar === en lugar de ==
if (user.username === username && user.password === password) { }
```

## FASE 6: Reporte Final de Auditoría

Este es tu entregable principal. Debes presentar un reporte profesional.

### Estructura que debe tener tu Reporte:

```
📄 REPORTE DE AUDITORÍA - SECURE AUDIT LAB
═══════════════════════════════════════════
Autor: [Tu nombre]
Materia: Desarrollo de Software Seguro
Docente: Rodrigo Ramírez
Facultad de Telemática - Universidad de Colima
Fecha: [Fecha actual]

1. RESUMEN EJECUTIVO
   - Breve descripción del análisis realizado
   - Cantidad total de vulnerabilidades encontradas
   - Clasificación general del riesgo (Crítico/Alto/Medio/Bajo)
   - Recomendación principal inmediata

2. VULNERABILIDADES ENCONTRADAS
   2.1 [Nombre de Vulnerabilidad]
       - Tipo: SQL Injection / XSS / Information Disclosure / etc.
       - Ubicación: Archivo y línea de código
       - Severidad: CRÍTICA/ALTA/MEDIA/BAJA
       - Descripción: Qué hace mal el código
       - Impacto: Qué consecuencias tiene
       - Evidencia: Screenshot/log/request
       - Recomendación: Cómo arreglarlo
       - Código seguro: Ejemplo de solución
   
   2.2 [Siguiente vulnerabilidad]
       ...

3. TABLA RESUMEN
   │ ID │ Tipo            │ Severidad │ Componente │
   ├────┼─────────────────┼───────────┼────────────┤
   │ 1  │ XSS             │ ALTA      │ Frontend   │
   │ 2  │ Info Disclosure │ CRÍTICA   │ Backend    │
   ...

4. PLAN DE ACCIÓN PRIORITARIO
   Ordena por importancia:
   1. Vulnerabilidades CRÍTICAS - Corrección inmediata (Semana 1)
   2. Vulnerabilidades ALTAS - Corrección urgente (Semana 2)
   3. Vulnerabilidades MEDIAS - Planificar en corto plazo (Semana 3-4)
   4. Vulnerabilidades BAJAS - Planificar en mediano plazo

5. RECURSOS Y REFERENCIAS
   - OWASP Top 10
   - CWE Top 25
   - Links a documentación
```

## � Desafíos Adicionales (Opcional - Puntos Extra)

Si deseas profundizar más en tu aprendizaje:

- [ ] Crear un script que automatice la detección de XSS
- [ ] Desarrollar una versión segura de toda la aplicación
- [ ] Implementar autenticación segura con JWT tokens
- [ ] Usar bcrypt para hashing criptográfico de contraseñas
- [ ] Crear tests de seguridad automatizados (pruebas de penetración)
- [ ] Documentar un plan de remediación completo y realista

## 📊 Rúbrica de Evaluación

Esta es la forma en que será evaluado tu trabajo:

| Criterio | Puntuación | Descripción |
|----------|-----------|-------------|
| Vulnerabilidades identificadas | 0-25 pts | ¿Cuántas encontraste? ¿Son correctas? |
| Análisis técnico y documentación | 0-25 pts | ¿Explicaste bien cada una? ¿Evidencia clara? |
| Propuestas de mitigación | 0-25 pts | ¿Las soluciones son viables? ¿Código seguro? |
| Calidad del reporte | 0-25 pts | ¿Está bien presentado? ¿Profesional? ¿Completo? |
| **Puntuación Total** | **0-100 pts** | Tu calificación final |

**Puntos Bonus:** +5 pts por cada desafío adicional completado (máx +30 pts)

---

## 📞 Soporte

Si tienes preguntas durante el desarrollo:
- Consulta la documentación en el `README.md`
- Revisa ejemplos de código en `server.js`
- Contacta con tu docente: **Rodrigo Ramírez**

---

**¡Éxito en tu auditoría de seguridad! 🔐**

Recuerda: *"La seguridad no es un destino, es un proceso continuo de aprendizaje y mejora."*

Tienes todo lo que necesitas para completar este laboratorio. ¡Adelante!
