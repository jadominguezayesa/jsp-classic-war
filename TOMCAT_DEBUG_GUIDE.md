# 🔥 Guía Completa: Tomcat + JPDA Debug + VS Code

## 📋 Requisitos Previos

### Extensiones VS Code Esenciales
- **Extension Pack for Java** (`vscjava.vscode-java-pack`) - OBLIGATORIO
-## ✅ **Ventajas de Esta Configuración**

### 🚀 **Desarrollo Eficiente**
- **Hot Redeploy**: Cambios automáticos sin restart completo
- **Debug Integrado**: JPDA funciona perfecto con VS Code
- **Tasks Automatizados**: Un comando hace build + deploy
- **Scripts Confiables**: .bat files eliminan problemas de sintaxis
- **Sincronización Automática**: `update-tomcat-paths` mantiene todo actualizado

### 🔧 **Mantenimiento Simple** 
- **Configuración Centralizada**: Todo en `settings.json`
- **No Extensiones Problemáticas**: Sin Community Server Connectors
- **Portable**: Script de sincronización para nuevas máquinas
- **Auto-regeneración**: .bat files se actualizan automáticamente
- **Documentado**: README completo y esta guía actualizada

### 🎯 **Estabilidad y Portabilidad**
- **Sin PowerShell Issues**: CMD + .bat approach probado
- **Rutas con Espacios**: Manejadas correctamente con comillas
- **Error Handling**: Scripts con verificación de errores y status
- **Debugging Robusto**: Conecta siempre al puerto 8000
- **Cross-Machine**: Fácil setup en diferentes entornos con `update-tomcat-paths`scode-xml`) - Para web.xml y pom.xml
- **Auto Rename Tag** (`formulahendry.auto-rename-tag`) - Para JSP editing

### Software Requerido
- **JDK 17+** (recomendado JDK 21)
- **Apache Tomcat 10.1.5+** 
- **Maven 3.9+**

## ⚙️ Configuración Inicial

### 1. Configurar Rutas en settings.json

Edita `.vscode/settings.json` con tus rutas:

```json
{
    "java.configuration.runtimes": [
        {
            "name": "JavaSE-17",
            "path": "C:\\Desarrollo\\zulu17.50.19-ca-jdk17.0.11-win_x64"
        },
        {
            "name": "JavaSE-21", 
            "path": "C:\\Desarrollo\\zulu21.38.21-ca-jdk21.0.5-win_x64"
        }
    ],
    "java.compile.nullAnalysis.mode": "automatic",
    "tomcat.home": "C:\\Desarrollo\\apache-tomcat-10.1.5\\apache-tomcat-10.1.5",
    "tomcat.webapps": "C:\\Desarrollo\\apache-tomcat-10.1.5\\apache-tomcat-10.1.5\\webapps"
}
```

### 2. Configurar Puerto Tomcat (Puerto 9080)

Edita `conf/server.xml` en tu instalación de Tomcat:

```xml
<Connector port="9080" protocol="HTTP/1.1" 
           connectionTimeout="20000" redirectPort="8443" />
```

**Nota**: Este proyecto usa puerto **9080** en lugar del estándar 8080.

## 🚀 Workflow de Desarrollo (Automático)

### Método Rápido - Hot Redeploy

1. **🔄 Build + Deploy automático:**
   ```
   Ctrl+Shift+P → Tasks: Run Task → hot-redeploy
   ```

2. **🚀 Start Tomcat con Debug:**
   ```
   Ctrl+Shift+P → Tasks: Run Task → start-tomcat-jpda
   ```
   - Espera el mensaje: "Listening for transport dt_socket at address: 8000"
   - Y luego: "Server startup in XXX milliseconds"

3. **🔗 Conectar Debugger:**
   ```
   F5 → Seleccionar: "Attach to Tomcat JPDA"
   ```

4. **🌐 Probar aplicación:**
   - Principal: http://localhost:9080/jsp-classic-war/
   - Servlet: http://localhost:9080/jsp-classic-war/hello

### Desarrollo Iterativo

Para cambios durante desarrollo:
1. **Modifica código Java**
2. **`Ctrl+Shift+P → hot-redeploy`** (build + deploy automático)
3. **Recarga la página web** - Los cambios se reflejan automáticamente
4. **Los breakpoints siguen funcionando** sin reconectar debugger

### Método Manual (Paso a Paso)

Si prefieres control granular:
1. **`Tasks: build-war`** - Solo compilar
2. **`Tasks: deploy-war`** - Solo desplegar  
3. **`Tasks: start-tomcat-jpda`** - Iniciar con debug
4. **F5 → "Attach to Tomcat JPDA"** - Conectar debugger

## URLs de Acceso

- **Aplicación**: http://localhost:9080/jsp-classic-war/
- **Servlet**: http://localhost:9080/jsp-classic-war/hello
- **Debug Port**: 8000

## 📋 Tareas VS Code Disponibles

| Task | Descripción | Uso | |
|------|-------------|-----|-----|
| **build-war** | Compila proyecto con Maven | Compilación independiente | `mvn package` |
| **deploy-war** | Build + Copia WAR a webapps | Deploy después de cambios | Usa .bat script |
| **hot-redeploy** | build-war + deploy-war | **🔥 Recomendado para desarrollo** | Un solo comando |
| **start-tomcat-jpda** | Inicia Tomcat modo debug | Puerto 8000 para debugger | Usa .bat script |
| **stop-tomcat** | Detiene Tomcat limpiamente | Cierre seguro | Usa .bat script |
| **update-tomcat-paths** | 🔄 Sincroniza rutas settings→.bat | Después cambiar rutas Tomcat | **NUEVO** |

### 🎯 Scripts .bat Internos (Auto-generados)
- `.vscode/start-tomcat.bat` - Inicio con JPDA en puerto 8000
- `.vscode/stop-tomcat.bat` - Parada limpia de Tomcat 
- `.vscode/deploy-war.bat` - Deploy con verificación y error handling
- `.vscode/update-tomcat-paths.bat` - Script sincronización de rutas

## 🔧 Solución de Problemas

### Errores Comunes

#### 1. 🚫 "Cannot connect to debug port 8000"
- **Causa**: Tomcat no está en modo JPDA
- **Solución**: Usar `start-tomcat-jpda` (NO `catalina.bat start`)
- **Verificar**: Busca "Listening for transport dt_socket at address: 8000"

#### 2. 🌐 "Port 9080 already in use"
- **Causa**: Otro proceso usa el puerto
- **Solución**: `netstat -ano | findstr :9080` y terminar proceso
- **Alternativa**: Cambiar puerto en `server.xml`

#### 3. 📁 "WAR deploy falla"
- **Causa**: Tomcat corriendo o permisos
- **Solución**: Ejecutar `stop-tomcat` antes de `deploy-war`
- **Verificar**: Ruta `tomcat.webapps` en settings.json

#### 4. ⚙️ "Java extension not working"
- **Causa**: Extensiones Java no instaladas
- **Solución**: Ejecutar `install-extensions.bat`
- **Verificar**: Extension Pack for Java activo

#### 5. 🔄 "Hot redeploy no funciona"
- **Causa**: Cambios no se reflejan
- **Solución**: Esperar 2-3 segundos después de deploy
- **Alternativa**: Refrescar browser (F5)

#### 6. 📁 "Rutas incorrectas en .bat files"
- **Causa**: .bat files con rutas obsoletas
- **Solución**: Ejecutar `update-tomcat-paths` task
- **Verificar**: Revisar que `settings.json` tenga rutas correctas

#### 7. 🔧 "Settings.json no se sincroniza"
- **Causa**: Script update no ejecutado después de cambios
- **Solución**: Siempre ejecutar `update-tomcat-paths` tras editar settings
- **Automatizar**: Considerar ejecutarlo antes de otros tasks

### Comandos de Diagnóstico

```powershell
# Verificar procesos Java
Get-Process | Where-Object { $_.Name -like "*java*" }

# Ver puertos ocupados
netstat -ano | findstr ":9080\|:8000"

# Verificar extensiones VS Code
code --list-extensions | findstr -i "java\|xml"
```

## 🎯 **Debugging Features Incluidas**

### ✅ **Completamente Funcional**
- **Breakpoints**: En servlets, JSPs y clases Java
- **Step Debugging**: Step over, into, out
- **Variable Inspection**: Watch, locals, call stack
- **Hot Code Replace**: Cambios en tiempo real (limitado)
- **Exception Handling**: Catch automático de excepciones

### ✅ **Integración VS Code**
- **Debug Console**: Evaluación de expresiones
- **Integrated Terminal**: Output de Tomcat visible
- **Problem Matchers**: Errores de compilación resaltados  
- **IntelliSense**: Autocomplete para Jakarta EE APIs

## 🚫 **Extensiones Evitadas (Problemáticas)**

Esta configuración **NO** usa:
- ❌ **Community Server Connectors** - RSP provider inestable
- ❌ **Tomcat for Java** (adashen) - Conflictos con paths

### ✅ **Solo Extensiones Oficiales/Estables**
- ✅ **Extension Pack for Java** (Microsoft)
- ✅ **XML Support** (Red Hat) 
- ✅ **Auto Rename Tag** (Comunidad estable)
- ✅ **Configuración manual** - Totalmente controlable

## ✅ Ventajas de Esta Configuración

### 🚀 **Desarrollo Eficiente**
- **Hot Redeploy**: Cambios automáticos sin restart completo
- **Debug Integrado**: JPDA funciona perfecto con VS Code
- **Tasks Automatizados**: Un comando hace build + deploy
- **Scripts Confiables**: .bat files eliminan problemas de sintaxis

### 🔧 **Mantenimiento Simple** 
- **Configuración Centralizada**: Todo en `settings.json`
- **No Extensiones Problemáticas**: Sin Community Server Connectors
- **Portable**: Fácil cambio de rutas Tomcat
- **Documentado**: README completo y esta guía

### 🎯 **Estabilidad**
- **Sin PowerShell Issues**: CMD + .bat approach
- **Rutas con Espacios**: Manejadas correctamente
- **Error Handling**: Scripts con verificación de errores
- **Debugging Robusto**: Conecta siempre al puerto 8000

## 🔄 Gestión de Rutas de Tomcat

### 📝 **Cómo Funciona la Sincronización**

Los archivos `.bat` contienen **rutas hardcodeadas** que se sincronizan desde `settings.json`:

```bat
@echo off
REM Este archivo es generado automáticamente - NO EDITAR MANUALMENTE
set "CATALINA_HOME=C:\Desarrollo\apache-tomcat-10.1.5\apache-tomcat-10.1.5"
set "CATALINA_BASE=C:\Desarrollo\apache-tomcat-10.1.5\apache-tomcat-10.1.5"
```

⚠️ **IMPORTANTE**: Los .bat files se marcan como "NO EDITAR MANUALMENTE" porque se regeneran automáticamente.

### 🔧 **Script de Sincronización: `update-tomcat-paths`**

#### ¿Qué hace?
- Lee configuración de `.vscode/settings.json`
- Actualiza **automáticamente** todos los .bat files:
  - `start-tomcat.bat` → Rutas CATALINA_HOME/BASE
  - `stop-tomcat.bat` → Rutas CATALINA_HOME/BASE
  - `deploy-war.bat` → Rutas SOURCE (workspace) y DEST (webapps)

#### ¿Cuándo usarlo?
- ✅ Cambias instalación de Tomcat
- ✅ Mueves proyecto a otra máquina
- ✅ Rutas incorrectas en .bat files
- ✅ Después de clonar el repositorio

### 🚀 **Procedimiento Completo de Cambio**

#### **Paso 1**: Editar `settings.json`
```json
{
    "tomcat.home": "C:\\Nueva\\Ruta\\Tomcat",
    "tomcat.webapps": "C:\\Nueva\\Ruta\\Tomcat\\webapps"
}
```

#### **Paso 2**: Ejecutar sincronización
```
Ctrl+Shift+P → Tasks: Run Task → update-tomcat-paths
```

#### **Paso 3**: Verificación
- Los .bat files muestran las nuevas rutas
- Ejecutar `start-tomcat-jpda` para confirmar
- Si hay errores, verificar que las rutas existen

### 📁 **Alternativas de Ejecución**

```powershell
# Via VS Code Task (Recomendado)
Ctrl+Shift+P → Tasks: Run Task → update-tomcat-paths

# Directamente en terminal
.\.vscode\update-tomcat-paths.bat

# Verificar configuración actual
Get-Content .vscode\settings.json
```

## 📦 Instalación Rápida de Extensiones

Ejecuta el script incluido:
```powershell
# Instalación automática de extensiones recomendadas
.\install-extensions.bat
```

O instala manualmente las esenciales:
- Extension Pack for Java
- XML (Red Hat) 
- Auto Rename Tag