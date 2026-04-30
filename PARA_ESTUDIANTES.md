# 👋 Bienvenida al Laboratorio de Auditoría de Seguridad

**Materia:** Desarrollo de Software Seguro  
**Docente:** Rodrigo Ramírez  
**Facultad de Telemática - Universidad de Colima**  

---

## 🎯 Tu Objetivo en Este Laboratorio

Te invito a participar activamente en este laboratorio educativo diseñado específicamente para que desarrolles competencias profesionales en seguridad de software. En esta materia aprenderás a:

✅ **Identificar vulnerabilidades** reales en código web  
✅ **Analizar riesgos** de seguridad profesionalmente  
✅ **Proponer soluciones** viables y seguras  
✅ **Documentar hallazgos** como lo hace un auditor profesional  
✅ **Implementar prácticas seguras** desde el diseño  

## 📖 ¿Cómo Utilizar Este Laboratorio?

### Paso 1: Familiarízate con la Aplicación
Lee el archivo `COMIENZA_AQUI.md` y `QUICKSTART.md` para entender cómo funciona el proyecto.

### Paso 2: Ejecuta el Servidor
Sigue las instrucciones en `QUICKSTART.md` para iniciar la aplicación:
```bash
npm install
npm start
```

### Paso 3: Explora y Prueba
Accede a `http://localhost:3000` e interactúa con la aplicación. Intenta:
- Hacer login con diferentes credenciales
- Ver la lista de usuarios
- Intentar guardar nuevos usuarios
- Acceder a otros endpoints

### Paso 4: Identifica Vulnerabilidades
Usa el checklist en `STUDENT_CHECKLIST.md` como tu guía. Busca activamente las 7 vulnerabilidades intencionales que he incluido.

### Paso 5: Documenta Tus Hallazgos
Para cada vulnerabilidad que encuentres, documenta:
- **Qué es:** Nombre y tipo de vulnerabilidad
- **Dónde está:** Ubicación exacta en el código
- **Por qué es peligroso:** Impacto en la seguridad
- **Cómo se arregla:** Propuesta de solución

### Paso 6: Entrega Tu Reporte
Prepara un reporte profesional de auditoría siguiendo la estructura especificada en `STUDENT_CHECKLIST.md`.

## 🔍 Las 7 Vulnerabilidades Que Debes Encontrar

1. **SQL Injection (Simulada)** - Endpoint `/login`
2. **XSS (Cross-Site Scripting)** - En la función de login
3. **Información Disclosure** - Endpoint `/users` expone contraseñas
4. **Insecure File Write** - Endpoint `/save` sin validación
5. **Missing Authentication** - `/admin/stats` desprotegido
6. **Poor Error Handling** - Stack traces expuestos
7. **Path Traversal** - Acceso inseguro a archivos

Cada una presenta un riesgo real que encontrarías en aplicaciones web profesionales.

## 📊 Sistema de Logging

Durante tu trabajo, el servidor registra automáticamente:
- Todas tus conexiones HTTP
- Tus intentos de login
- Acceso a datos sensibles
- Cualquier acción que realices

**Esto es importante:** Los logs te ayudarán a recopilar evidencia para tu reporte. Por ejemplo, podrás demostrar que accediste a `/users` sin autenticación y viste las contraseñas.

## 📝 Estructura de Archivos Importantes

| Archivo | Para Qué Sirve |
|---------|---|
| `COMIENZA_AQUI.md` | **Punto de partida** - Lee primero |
| `QUICKSTART.md` | Cómo iniciar en 3 pasos |
| `README.md` | Documentación técnica detallada |
| `STUDENT_CHECKLIST.md` | **Tu guía de tareas** - Síguelo paso a paso |
| `INSTRUCTOR_GUIDE.md` | Información para el docente |
| `server.js` | Código del backend (con comentarios de vulnerabilidades) |
| `public/app.js` | Código del frontend (con vulnerabilidades) |

## 🎓 Cómo Será Evaluado Tu Trabajo

Tu reporte será evaluado en estos criterios:

| Criterio | Puntos |
|----------|--------|
| Vulnerabilidades identificadas correctamente | 25 pts |
| Análisis técnico y documentación clara | 25 pts |
| Propuestas de mitigación viables | 25 pts |
| Calidad y profesionalismo del reporte | 25 pts |
| **Total** | **100 pts** |

**Puntos Extra:** +5 pts por cada desafío adicional que completes.

## 💡 Consejos para Tener Éxito

### 1. **Lee el código fuente**
```bash
# Abre estos archivos:
- server.js        (Backend)
- public/app.js    (Frontend)
- data/users.json  (Base de datos)
```

Observa los comentarios que he dejado marcando las vulnerabilidades.

### 2. **Prueba sistemáticamente**
No intentes encontrar todo de una vez. Sigue el checklist paso a paso.

### 3. **Toma evidencia**
- Capturas de pantalla
- URLs exactas que probaste
- Respuestas del servidor
- Errores que observaste

### 4. **Documentación es clave**
No es suficiente encontrar vulnerabilidades. Debes explicar:
- QUÉ encontraste
- DÓNDE está
- POR QUÉ es peligroso
- CÓMO se arregla

### 5. **Sé profesional**
Este reporte será como los que escribirías en tu carrera profesional. Mantén un tono técnico y formal.

## 🆘 Si Tienes Preguntas

- **Problemas técnicos:** Revisa el `README.md`
- **No entiendo una vulnerabilidad:** Lee la descripción en el código fuente
- **Necesito ayuda:** Consulta con tu docente, Rodrigo Ramírez

## ⏰ Cronograma Sugerido

### Sesión 1: Exploración
- [ ] Configurar e iniciar el servidor
- [ ] Familiarizarse con la interfaz
- [ ] Leer la documentación

### Sesión 2-3: Identificación
- [ ] Seguir el `STUDENT_CHECKLIST.md`
- [ ] Buscar activamente cada vulnerabilidad
- [ ] Recopilar evidencia

### Sesión 4-5: Análisis Profundo
- [ ] Estudiar el código fuente
- [ ] Proponer soluciones
- [ ] Documentar findings detalladamente

### Sesión 6: Reportes
- [ ] Compilar hallazgos
- [ ] Crear el reporte final
- [ ] Preparar presentación

## 🚀 ¡Estás Listo Para Comenzar!

1. Lee `COMIENZA_AQUI.md`
2. Sigue `QUICKSTART.md`
3. Usa `STUDENT_CHECKLIST.md` como tu guía
4. ¡Descubre las vulnerabilidades!
5. Entrega tu reporte profesional

---

## 📞 Contacto del Docente

**Nombre:** Rodrigo Ramírez  
**Materia:** Desarrollo de Software Seguridad  
**Institución:** Facultad de Telemática - Universidad de Colima  

---

## 💭 Reflexión Final

*"La seguridad en software no es una característica, es una mentalidad. Cada decisión de diseño, cada línea de código, cada validación de entrada contribuye o resta a la seguridad de la aplicación. Este laboratorio te enseña a pensar como un auditor de seguridad profesional."*

**¡Bienvenido! ¡Que comience tu aventura en auditoría de seguridad! 🔐**

---

**Última actualización:** 29 de Abril de 2026  
**Materia:** Desarrollo de Software Seguro  
**Docente:** Rodrigo Ramírez
