# 🔐 Secure Audit Lab - Laboratorio Educativo
## Desarrollo de Software Seguro
**Facultad de Telemática - Universidad de Colima**
**Docente: Rodrigo Ramírez**

---

## 🎉 ¡Bienvenido al laboratorio de auditoría!

En esta materia de **Desarrollo de Software Seguro**, te presento **Secure Audit Lab**, un proyecto educativo completo con vulnerabilidades intencionales para que practiques auditoría de seguridad web.

Este laboratorio es diseñado para que desarrolles las competencias necesarias en la identificación, análisis y mitigación de vulnerabilidades de seguridad en aplicaciones web modernas.

## 🚀 Empezar en 30 segundos

### Windows (Recomendado)
```bash
# En la carpeta del proyecto, simplemente:
start.bat
```
O abre una terminal PowerShell:
```powershell
npm install
npm start
```

### Linux/Mac
```bash
npm install
npm start
```

Luego abre: `http://localhost:3000`

## 📦 Lo que incluye

✅ **Servidor vulnerable** - Con 7 vulnerabilidades intencionales  
✅ **Frontend vulnerable** - Con ejemplos de XSS y malas prácticas  
✅ **Sistema de logging** - Registra TODAS las conexiones de estudiantes  
✅ **Documentación completa** - Guías para instructores y estudiantes  
✅ **Herramientas de monitoreo** - Scripts para Windows/Linux  
✅ **Datos de prueba** - Base de datos pre-cargada  
✅ **Ejemplos de código seguro** - Soluciones a cada vulnerabilidad  

## 📚 Archivos Importantes

| Archivo | Propósito |
|---------|----------|
| `server.js` | Backend con 7 vulnerabilidades |
| `public/app.js` | Frontend con XSS y malas prácticas |
| `README.md` | Documentación técnica completa |
| `QUICKSTART.md` | Inicio rápido en 3 pasos |
| `INSTRUCTOR_GUIDE.md` | Guía de monitoreo de estudiantes |
| `STUDENT_CHECKLIST.md` | Tareas para estudiantes |
| `start.bat` | Menú interactivo para Windows |
| `monitor.ps1` | Dashboard de monitoreo |

## 🔴 Vulnerabilidades Incluidas

1. **SQL Injection (Simulada)** - `/login` endpoint
2. **XSS (Cross-Site Scripting)** - `innerHTML` sin sanitizar
3. **Información Disclosure** - `/users` expone contraseñas
4. **Insecure File Write** - `/save` sin validación
5. **Missing Authentication** - `/admin/stats` desprotegido
6. **Poor Error Handling** - Stack traces expuestos
7. **Path Traversal** - Acceso a archivos inseguro

## 📊 Sistema de Logging Automático

El servidor registra automáticamente:

✅ **connections.log** - Todas las conexiones HTTP  
✅ **activity.log** - Acciones específicas de seguridad  

Cada evento incluye:
- Timestamp exacto
- IP del estudiante
- Método HTTP
- URL accedida
- User-Agent

### Ver quién entró:
```bash
# Ver todas las conexiones
cat logs/connections.log

# Ver logins exitosos
grep "LOGIN_SUCCESS" logs/activity.log

# Ver acceso a datos sensibles
grep "GET_ALL_USERS" logs/activity.log
```

## 🎓 Para los Estudiantes

1. Lee el `QUICKSTART.md` - Inicio en 3 pasos
2. Sigue el `STUDENT_CHECKLIST.md` - Tareas organizadas
3. Documenta vulnerabilidades encontradas
4. Propón soluciones de remediación
5. Entrega un reporte final

## 👨‍🏫 Para los Instructores

1. Usa `INSTRUCTOR_GUIDE.md` para monitorear
2. Ejecuta `start.bat` en Windows para menú interactivo
3. O usa `monitor.ps1` para Dashboard en tiempo real
4. Revisa los logs para ver qué hicieron los estudiantes
5. Identifica quién encontró cada vulnerabilidad

## 💻 Comandos Útiles

### Iniciar servidor
```bash
npm start
```

### Ver logs en tiempo real (PowerShell)
```powershell
Get-Content logs/connections.log -Wait
```

### Dashboard de monitoreo (Windows)
```powershell
.\monitor.ps1
```

### Ver estudiantes más activos
```bash
grep "IP:" logs/connections.log | cut -d' ' -f9 | sort | uniq -c | sort -rn
```

## 🔍 Ejemplo de Sesión

```
Estudiante accede a http://localhost:3000
↓
Intenta login con admin/123456
↓
Se registra en logs/activity.log: LOGIN_SUCCESS
↓
Hace clic en "Ver Usuarios"
↓
Se registra: GET_ALL_USERS
↓
Ve todas las contraseñas (VULNERABILIDAD ENCONTRADA)
↓
Intenta inyectar JavaScript
↓
Se registra el intento en activity.log
```

El instructor puede luego revisar logs y ver exactamente qué hizo cada estudiante.

## ⚠️ Notas Importantes

- Este código tiene vulnerabilidades **INTENCIONALES**
- **NUNCA** usar en producción
- **Solo** para educación en entorno controlado
- **Informar a estudiantes** que todo es registrado
- **Cumplir** con políticas de privacidad

## 🎯 Próximos Pasos

1. **Instala dependencias:** `npm install`
2. **Inicia servidor:** `npm start`
3. **Abre en navegador:** `http://localhost:3000`
4. **Monitorea:** `.\monitor.ps1` (PowerShell)
5. **Lee documentación:** Abre `README.md`

## 📞 Ayuda

- Revisa `INSTRUCTOR_GUIDE.md` para monitoreo
- Lee `README.md` para detalles técnicos
- Mira `STUDENT_CHECKLIST.md` para tareas
- Ejecuta `start.bat` para menú automático (Windows)

---

**¡Tu laboratorio de auditoría está listo! 🚀**

Tiempo estimado: 5-10 minutos para iniciar
Dificultad: Educativo (estudiantes aprenderán mucho)

