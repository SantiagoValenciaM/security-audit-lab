# Guía de Herramientas de Seguridad

Este documento explica las herramientas de seguridad integradas en el proyecto.

## 🔍 Herramientas Incluidas

### 1. **ESLint with Security Plugin**
Detecta patrones de código inseguro:

```bash
npm run lint
```

**Detecta:**
- Uso de `eval()` y funciones derivadas
- Credenciales expuestas
- Expresiones regulares inseguras
- Errores comunes de seguridad

### 2. **npm audit**
Verifica vulnerabilidades en dependencias:

```bash
npm audit --production
```

**Verifica:**
- Dependencias con CVE conocidas
- Vulnerabilidades de seguridad publicadas
- Versiones recomendadas

### 3. **Security Full Check**
Ejecuta ESLint + npm audit:

```bash
npm run security
```

## 📊 SonarQube Integration

El workflow ejecuta automáticamente:

1. ✅ `npm audit` - Auditoría de dependencias
2. ✅ `eslint` - Análisis estático de seguridad
3. ✅ `npm run security` - Verificación completa
4. ✅ SonarQube Scan - Análisis en la nube

## 🚀 Ejecutar Localmente

```bash
# 1. Instalar dependencias
npm install

# 2. Ejecutar auditoría de dependencias
npm audit

# 3. Ejecutar ESLint
npm run lint

# 4. Ejecutar verificación de seguridad completa
npm run security
```

## 📝 Configuración

### ESLint Security Rules
Configurado en `.eslintrc.json`:
- **Plugin**: `eslint-plugin-security`
- **Reglas**: Detecta patrones de seguridad OWASP

### SonarQube Properties
Configurado en `sonar-project.properties`:
- Lenguaje: JavaScript
- Organización: jr4mx
- Análisis de Security Hotspots habilitado

## 🎯 Vulnerabilidades que Detecta

### ESLint Security Plugin detecta:
- ❌ `eval()`, `Function()`, `setTimeout()` con strings
- ❌ Uso de `innerHTML`
- ❌ Prototipos inseguros
- ❌ Expresiones regulares con DoS
- ❌ Credenciales en código
- ❌ Llamadas a funciones peligrosas

### npm audit detecta:
- ❌ Vulnerabilidades en dependencias directas
- ❌ CVE públicamente reportados
- ❌ Vulnerabilidades de severidad crítica

### SonarQube detecta:
- ❌ Security Hotspots
- ❌ Code Smells
- ❌ Issues de calidad
- ❌ Patrones inseguros

## 🔐 Vulnerabilidades Conocidas en Este Proyecto

Ver `VULNERABILITIES.md` para lista completa.

---

**Nota**: Este es un proyecto educativo. Las vulnerabilidades son intencionales para propósitos de aprendizaje.
