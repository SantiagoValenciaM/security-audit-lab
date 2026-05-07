# Vulnerabilidades Intencionales - Guía de Detección en SonarQube

Este documento explica las **vulnerabilidades intencionales** en el proyecto y cómo SonarQube puede detectarlas.

## ¿Por qué SonarQube no detecta todas las vulnerabilidades?

SonarQube Community Edition y SonarCloud tienen limitaciones:
- **Análisis estático limitado** para JavaScript
- **Security Hotspots** no siempre detectan patrones complejos
- **Reglas específicas** de seguridad pueden no estar habilitadas
- **Context-aware analysis** es limitado

## Vulnerabilidades Documentadas

### 1. **SQL Injection (Simulada)** - CRITICAL
- **Archivo**: `server.js:74`
- **Problema**: Comparación insegura (`==` en lugar de `===`)
- **Código vulnerable**:
  ```javascript
  const user = users.find(u => u.username == username && u.password == password);
  ```
- **CWE**: CWE-89
- **SonarQube debería detectar**: Uso de `==`

### 2. **Information Disclosure** - HIGH
- **Archivo**: `server.js:88`
- **Problema**: Expone todas las contraseñas sin autenticación
- **Código vulnerable**:
  ```javascript
  app.get('/users', (req, res) => {
      res.json(users);  // Devuelve todo, incluyendo passwords
  });
  ```
- **CWE**: CWE-200
- **SonarQube debería detectar**: Endpoint sin autenticación

### 3. **Cross-Site Scripting (XSS)** - HIGH
- **Archivo**: `public/app.js:22`
- **Problema**: Inserción de HTML sin sanitizar
- **Código vulnerable**:
  ```javascript
  document.getElementById('output').innerHTML = data;
  ```
- **CWE**: CWE-79
- **SonarQube debería detectar**: Uso de `innerHTML` con datos no sanitizados

### 4. **Insecure Credential Transmission** - HIGH
- **Archivo**: `public/app.js:19`
- **Problema**: Credenciales en URL sin encriptación
- **Código vulnerable**:
  ```javascript
  fetch(`/login?username=${username}&password=${password}`)
  ```
- **CWE**: CWE-312
- **SonarQube debería detectar**: Credenciales en URL

### 5. **Sensitive Data Logging** - MEDIUM
- **Archivo**: `server.js:49`
- **Problema**: Contraseñas registradas en logs
- **Código vulnerable**:
  ```javascript
  logActivity('LOGIN_ATTEMPT', { username, password });
  ```
- **CWE**: CWE-532
- **SonarQube debería detectar**: Logging de datos sensibles

### 6. **Missing Access Control** - CRITICAL
- **Archivo**: `server.js:85`
- **Problema**: Endpoint sin validación de permisos
- **Código vulnerable**:
  ```javascript
  app.get('/users', (req, res) => {
      logActivity('GET_ALL_USERS', { count: users.length });
      res.json(users);
  });
  ```
- **CWE**: CWE-639
- **SonarQube debería detectar**: Endpoints sin autenticación

## Cómo Mejorar la Detección en SonarQube

### 1. **Verificar la Configuración de SonarCloud**
- Ir a **Administration → General Settings → Security**
- Habilitar **Security Hotspots** análisis
- Verificar que estés usando un **Quality Profile** con reglas de seguridad

### 2. **Usar ESLint con SonarQube**
El workflow ahora ejecuta `npm run lint` que usa ESLint para detectar:
- Uso de `==` en lugar de `===`
- Uso de `eval()`
- Funciones inseguras

### 3. **Usar Herramientas Complementarias**
Para proyecto Node.js + Express, considera:
- **ESLint Security Plugin**: `eslint-plugin-security`
- **OWASP Dependency Check**: Detecta vulnerabilidades en dependencias
- **Snyk**: Análisis de vulnerabilidades de seguridad

### 4. **Configurar Quality Gate Personalizado**
En SonarCloud:
- Crear una "Quality Gate" específica
- Establecer reglas de seguridad como "obligatorias"
- Fallar el build si hay vulnerabilidades críticas

## Ejecutar el Análisis Completo

```bash
# 1. Instalar dependencias
npm install

# 2. Ejecutar ESLint
npm run lint

# 3. Hacer push para que GitHub Actions ejecute SonarQube
git add .
git commit -m "Agregar análisis de seguridad"
git push
```

## Ver Resultados en SonarCloud

1. Ve a `https://sonarcloud.io/projects`
2. Abre el proyecto `secure-audit-lab`
3. Revisa la sección **Security** para ver:
   - **Vulnerabilities**
   - **Security Hotspots**
   - **Issues**

## Archivos Relacionados

- `sonar-project.properties` - Configuración de SonarQube
- `.eslintrc.json` - Configuración de ESLint
- `.github/workflows/sonarqube_analysis.yml` - Workflow de análisis
- `sonarqube-vulnerabilities.json` - Documentación de vulnerabilidades

---

**Nota**: Este es un proyecto educativo con vulnerabilidades **intencionales**. No uses este código en producción.
