# 🚀 Quick Start - Secure Audit Lab

## Desarrollo de Software Seguro
**Facultad de Telemática - Universidad de Colima**

---

## ⚡ Inicio Rápido en 3 Pasos

 Sigue estos pasos para comenzar con tu práctica de auditoría:

### Paso 1: Instalar dependencias
```bash
npm install
```

### Paso 2: Iniciar el servidor
```bash
npm start
```

Deberías ver:
```
==================================================
🔐 Secure Audit Lab iniciado
📍 URL: http://localhost:3000
📊 Logs: ./logs/
==================================================
```

### Paso 3: Abrir en navegador
```
http://localhost:3000
```

## 📝 Qué Hacer Ahora

1. **Prueba la aplicación:**
   - Intenta hacer login con `admin / 123456`
   - Haz clic en "Ver Usuarios"
   - Intenta guardar un nuevo usuario

2. **Revisa los logs:**
   ```bash
   # Terminal 1: Ver conexiones en tiempo real
   tail -f logs/connections.log
   
   # Terminal 2: Ver actividades
   tail -f logs/activity.log
   ```

3. **Identifica vulnerabilidades:**
   - ¿Qué información sensible ves expuesta?
   - ¿Cómo podrías inyectar código?
   - ¿Qué endpoints no tienen protección?

## 🔴 Vulnerabilidades Principales

- **SQL Injection (simulada):** Endpoint `/login`
- **XSS:** Inserción de HTML en resultados
- **Información Disclosure:** Endpoint `/users` expone contraseñas
- **Missing Authentication:** `/admin/stats` sin protección
- **Insecure Data Storage:** Contraseñas en texto plano
- **Error Handling:** Stack traces expuestos

## 📊 Monitoreo de Estudiantes

Para ver quién entró y qué hizo:

```bash
# Ver todas las conexiones
cat logs/connections.log

# Ver logins exitosos
grep "LOGIN_SUCCESS" logs/activity.log

# Ver acceso a datos sensibles
grep "GET_ALL_USERS" logs/activity.log

# Ver IPs de estudiantes
grep "IP:" logs/connections.log | cut -d' ' -f9 | sort -u
```

## 🛑 Detener el Servidor

```bash
# En la terminal donde corre el servidor:
Ctrl + C
```

## 📚 Recursos

- [README.md](./README.md) - Documentación completa
- [INSTRUCTOR_GUIDE.md](./INSTRUCTOR_GUIDE.md) - Guía de monitoreo

## 💡 Tip

Si quieres ver los logs en tiempo real mientras trabajas, abre dos terminales:

**Terminal 1:**
```bash
npm start
```

**Terminal 2:**
```bash
tail -f logs/connections.log
```

Así verás exactamente qué está pasando mientras los estudiantes interactúan con la aplicación.

---

¡A trabajar en la auditoría de seguridad! 🔐
