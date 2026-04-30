# 🎓 Secure Audit Lab - Laboratorio de Auditoría de Seguridad

**Materia:** Desarrollo de Software Seguro  
**Docente:** Rodrigo Ramírez  
**Facultad de Telemática - Universidad de Colima**  

---

## 📦 Proyecto Educativo Completo

Este laboratorio está diseñado para que los estudiantes de Desarrollo de Software Seguro practiquen identificación y análisis de vulnerabilidades reales en aplicaciones web. Contiene todo lo necesario para una práctica educativa integral:

### ✅ Archivos Principales

```
secure-audit-lab/
├── server.js                 ← Servidor vulnerable (7 vulnerabilidades)
├── package.json              ← Dependencias
├── README.md                 ← Documentación técnica completa
├── INSTRUCTOR_GUIDE.md       ← Guía para instructores (monitoreo)
├── QUICKSTART.md             ← Inicio rápido (3 pasos)
├── STUDENT_CHECKLIST.md      ← Tareas y checklist para estudiantes
├── .gitignore                ← Git configuration
├── public/
│   ├── index.html            ← Interfaz frontend
│   ├── app.js                ← JavaScript vulnerable (XSS)
│   └── styles.css            ← Estilos
├── data/
│   └── users.json            ← Base de datos simulada
└── logs/
    ├── connections.log       ← Registra TODAS las conexiones HTTP
    └── activity.log          ← Registra acciones específicas
```

### 🎯 Características del Proyecto

1. **Sistema de Logging Completo**
   - Registra IP, timestamp, método, URL
   - Captura de User-Agent
   - Tracking de actividades específicas

2. **7 Vulnerabilidades Intencionales**
   - SQL Injection (simulada)
   - XSS (Cross-Site Scripting)
   - Información Disclosure
   - Insecure File Write
   - Missing Authentication
   - Poor Error Handling
   - Path Traversal potencial

3. **Documentación Educativa**
   - Explicación de cada vulnerabilidad
   - Ejemplos de código seguro
   - Plan de remedación

4. **Monitoreo de Estudiantes**
   - Logs de todas las conexiones
   - Seguimiento de actividades
   - Identificación por IP
   - Timestamps exactos

## 🚀 Cómo Desplegar

### En tu máquina local:

```bash
cd secure-audit-lab
npm install
npm start
```

El servidor estará en: `http://localhost:3000`

### Ver logs en tiempo real:

```bash
# Terminal 2 - Conexiones
tail -f logs/connections.log

# Terminal 3 - Actividades
tail -f logs/activity.log
```

## 📊 Monitoreo de Estudiantes

Después de que los estudiantes terminen, puedes ver exactamente qué hicieron:

### Tabla de Quién Entró

```bash
# Ver todas las IPs únicas de estudiantes
grep "IP:" logs/connections.log | cut -d' ' -f9 | sort -u
```

Salida esperada:
```
192.168.1.100
192.168.1.101
192.168.1.102
...
```

### Tabla de Acciones por Estudiante

```bash
# Para cada IP:
grep "192.168.1.100" logs/activity.log | cut -d' ' -f3 | sort | uniq -c
```

Salida:
```
      3 LOGIN_ATTEMPT
      1 LOGIN_SUCCESS
      2 GET_ALL_USERS
      1 SAVE_USER
```

### Generar Reporte Automático

```bash
#!/bin/bash
echo "=== REPORTE DE ACTIVIDAD DEL LABORATORIO ==="
echo "Fecha: $(date)"
echo ""
echo "Total de conexiones:"
wc -l logs/connections.log
echo ""
echo "IPs únicas de estudiantes:"
grep "IP:" logs/connections.log | cut -d' ' -f9 | sort -u
echo ""
echo "Acciones por tipo:"
grep "ACTION:" logs/activity.log | cut -d' ' -f3 | sort | uniq -c | sort -rn
```

## 🔴 Vulnerabilidades Incluidas

1. **SQL Injection (Simulada)**
   - Endpoint: `/login?username=X&password=Y`
   - Problema: Usa `==` en lugar de `===`
   - Impacto: Posible bypass de autenticación

2. **XSS (Cross-Site Scripting)**
   - Ubicación: `public/app.js` - función `login()`
   - Problema: `innerHTML` sin sanitizar
   - Impacto: Ejecución de código malicioso

3. **Información Disclosure**
   - Endpoint: `/users`
   - Problema: Expone todas las contraseñas
   - Impacto: Compromiso de todas las cuentas

4. **Insecure File Write**
   - Endpoint: `/save` (POST)
   - Problema: `appendFileSync` sin validación
   - Impacto: Corrupción de datos

5. **Missing Authentication**
   - Endpoint: `/admin/stats`
   - Problema: Sin verificación de credenciales
   - Impacto: Exposición de datos administrativos

6. **Poor Error Handling**
   - Endpoint: `/error`
   - Problema: Expone stack trace completo
   - Impacto: Information Disclosure

7. **Path Traversal (Potencial)**
   - Endpoint: `/logs/:file`
   - Problema: No valida ruta de archivo
   - Impacto: Acceso no autorizado a archivos

## 📚 Archivos Documentación

### Para Instructores
- **README.md** - Overview técnico completo
- **INSTRUCTOR_GUIDE.md** - Guía de monitoreo de estudiantes
- **DEPLOYMENT.md** - Este archivo

### Para Estudiantes
- **QUICKSTART.md** - Cómo empezar en 3 pasos
- **STUDENT_CHECKLIST.md** - Tareas y estructura del reporte
- **README.md** (secciones relevantes) - Explicación de vulnerabilidades

## 🎓 Plan Sugerido para Clase

### Sesión 1: Setup y Exploración (1 hora)
- [ ] Cada estudiante corre el servidor
- [ ] Accede a `http://localhost:3000`
- [ ] Lee la documentación
- [ ] Prueba los endpoints básicos

### Sesión 2: Identificación de Vulnerabilidades (2 horas)
- [ ] Busca XSS en el login
- [ ] Intenta acceder a `/users`
- [ ] Prueba `/admin/stats`
- [ ] Documenta hallazgos

### Sesión 3: Análisis Profundo (2 horas)
- [ ] Estudia el código fuente
- [ ] Clasifica por tipo de vulnerabilidad
- [ ] Calcula CVSS scores
- [ ] Propone mitigaciones

### Sesión 4: Presentación del Reporte (1 hora)
- [ ] Presentación de hallazgos
- [ ] Demostración de vulnerabilidades
- [ ] Propuestas de arreglo

## 💡 Ejemplos de Comandos para Instructores

### Ver quién ejecutó XSS
```bash
grep "LOGIN_ATTEMPT" logs/activity.log | grep "<"
```

### Ver intentos de admin
```bash
grep "ADMIN_STATS" logs/activity.log
```

### Ver estudiante más activo
```bash
grep "IP:" logs/connections.log | cut -d' ' -f9 | sort | uniq -c | sort -rn | head -1
```

### Generar reporte JSON
```bash
cat logs/activity.log | \
  grep -o 'ACTION: [^ ]*' | \
  cut -d' ' -f2 | \
  sort | uniq -c | \
  awk '{print "{\"action\":\"" $2 "\", \"count\":" $1 "}"}' > stats.json
```

## 🔧 Troubleshooting

### Puerto 3000 en uso
```bash
# Windows
netstat -ano | findstr :3000
taskkill /PID <PID> /F

# Linux/Mac
lsof -i :3000
kill -9 <PID>
```

### Logs no se generan
```bash
# Verificar permisos de carpeta logs/
ls -la logs/

# Crear carpeta si no existe
mkdir -p logs
```

### Node.js no instalado
```bash
# Instalar desde https://nodejs.org/
node --version  # Debe ser v14+
```

### Dependencias faltantes
```bash
npm install --save
```

## 📞 Soporte

Si tienes preguntas:
1. Revisa el `README.md`
2. Consulta `INSTRUCTOR_GUIDE.md`
3. Revisa los logs para evidencia
4. Lee el código comentado en `server.js`

## 📄 Notas Importantes

- ⚠️ Este código tiene vulnerabilidades INTENCIONALES
- ⚠️ NUNCA usar en producción
- ⚠️ Solo para educación en entorno controlado
- ⚠️ Informar a estudiantes que todo es registrado
- ⚠️ Cumplir con políticas de privacidad

## ✅ Checklist de Implementación

- [ ] Node.js instalado (v14+)
- [ ] `npm install` ejecutado
- [ ] Carpeta `logs/` existe
- [ ] `npm start` corre sin errores
- [ ] Acceso a `http://localhost:3000` funciona
- [ ] Logs se generan en tiempo real
- [ ] Estudiantes entienden que es un laboratorio educativo
- [ ] Datos de estudiantes / IPs será registrado

---

**Proyecto creado:** 29 de Abril de 2026  
**Versión:** 1.0.0  
**Estado:** Listo para usar en clase

¡Éxito con tu laboratorio de auditoría de seguridad! 🚀
