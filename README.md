# JSP Classic Web Application - VS Code Debugging Setup

Una aplicación web simple usando JSP y Servlets clásicos con configuración completa para debugging con VS Code y Tomcat.

## Requisitos
- JDK 17+
- Maven 3.9+
- Apache Tomcat 10.1.5+
- VS Code con Java Extension Pack

## Estructura del proyecto

```
src/
  main/
    java/
      com/ejemplo/web/
        HelloServlet.java    # Servlet de ejemplo con breakpoints
    webapp/
      index.jsp              # Página JSP principal
.vscode/
  tasks.json               # Tasks para build, deploy y Tomcat
  launch.json              # Configuración debug JPDA
  settings.json            # Rutas de Tomcat y JDK
  start-tomcat.bat         # Script inicio Tomcat con JPDA
  stop-tomcat.bat          # Script parada Tomcat
  deploy-war.bat           # Script deploy automático
pom.xml                    # Configuración Maven
```

## Configuración inicial

### 1. Configurar rutas en settings.json

Edita `.vscode/settings.json` y actualiza las rutas:

```json
{
    "tomcat.home": "C:\\tu\\ruta\\a\\apache-tomcat-10.1.5",
    "tomcat.webapps": "C:\\tu\\ruta\\a\\apache-tomcat-10.1.5\\webapps"
}
```

### 2. Configurar puerto Tomcat (opcional)

Si necesitas cambiar el puerto 9080, edita `conf/server.xml` en tu instalación de Tomcat:

```xml
<Connector port="9080" protocol="HTTP/1.1" 
           connectionTimeout="20000" redirectPort="8443" />
```

## Flujo de desarrollo con VS Code

### Tasks disponibles (Ctrl+Shift+P > Tasks: Run Task)

1. **build-war**: Compila el proyecto con Maven
2. **deploy-war**: Despliega automáticamente el WAR a Tomcat
3. **start-tomcat-jpda**: Inicia Tomcat en modo debug (puerto 8000)
4. **stop-tomcat**: Detiene Tomcat
5. **hot-redeploy**: Build + Deploy en una operación

### Workflow completo de debugging

1. **Compilar y desplegar**:
   ```
   Run Task: hot-redeploy
   ```

2. **Iniciar Tomcat con debugging**:
   ```
   Run Task: start-tomcat-jpda
   ```

3. **Conectar debugger**:
   - Ir a Run and Debug (F5)
   - Seleccionar "Attach to Tomcat JPDA"
   - El debugger se conectará al puerto 8000

4. **Probar la aplicación**:
   - Página principal: http://localhost:9080/jsp-classic-war/
   - Servlet con breakpoints: http://localhost:9080/jsp-classic-war/hello

5. **Hot Reload** (desarrollo activo):
   - Modifica el código Java
   - Ejecuta `hot-redeploy` (Build + Deploy)
   - Tomcat detectará automáticamente los cambios
   - Recarga la página web para ver cambios

## Debugging Features

- ✅ **Breakpoints**: Funciona en servlets y JSPs
- ✅ **Hot Deploy**: Los cambios se reflejan automáticamente
- ✅ **Variable Inspection**: Ve valores en tiempo real
- ✅ **Step Debugging**: Step over, step into, step out
- ✅ **Watch Expressions**: Monitor variables específicas

## Solución de problemas

### Tomcat no inicia
- Verifica que el puerto 9080 no esté ocupado
- Revisa que las rutas en `settings.json` sean correctas
- Ejecuta `stop-tomcat` antes de `start-tomcat-jpda`

### Deploy falla
- Verifica que Tomcat esté detenido antes del deploy
- Asegúrate que la ruta `tomcat.webapps` en settings.json sea correcta
- Ejecuta `build-war` manualmente para verificar la compilación

### Debugger no se conecta
- Confirma que Tomcat inició con el mensaje "Listening for transport dt_socket at address: 8000"
- Verifica que no haya firewall bloqueando el puerto 8000
- Reinicia VS Code si persisten problemas de conexión

## Ejecutar (método clásico)
```bash
mvn clean package
# despliega target/jsp-classic-war-1.0.0.war en tu servidor (Tomcat/Payara/WildFly)
```

## URLs de acceso
- Página principal: http://localhost:9080/jsp-classic-war/
- Servlet: http://localhost:9080/jsp-classic-war/hello

## Tecnologías

- **Java**: 17/21 (Jakarta EE)
- **Tomcat**: 10.1.5+ 
- **Maven**: 3.9+
- **VS Code**: Con Java Extension Pack
- **Debugging**: JPDA (Java Platform Debugger Architecture)
