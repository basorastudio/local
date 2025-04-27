¡Claro! Aquí tienes un README ordenado y listo para GitHub basado en el contenido que enviaste:

---

# Instalador para Uso en Modo Local

Probado en **Ubuntu 20** y **Ubuntu 22**.

> ⚡ **Importante:** Antes de instalar, se recomienda actualizar el sistema y reiniciar para evitar errores.

---

## Pasos Iniciales

Actualizar el sistema:
```bash
apt -y update && apt -y upgrade
```

Reiniciar el servidor:
```bash
reboot
```

Después del reinicio, proceder con la instalación:

```bash
cd /root
git clone https://github.com/basorastudio/local.git local
sudo chmod +x ./local/izing
cd ./local
sudo ./izing
```

---

## Configuración Inicial

- Editar el archivo `config`.
- Colocar contraseñas de tu preferencia.
- Configurar la IP de la máquina Ubuntu local.

La opción **actualizar** descargará la última versión del repositorio usado para la instalación.

---

## Problemas de Conexión con WhatsApp

Si tienes problemas de conexión, intenta actualizar el conector **WWebJS** `whatsapp.js`.

---

# Modificar el Frontend

## Cambiar el nombre de la aplicación:

Editar los siguientes archivos:
- `/home/deploy/izing.io/frontend/quasar.conf`
- `/home/deploy/izing.io/frontend/src/index.template.html`

## Cambiar logos e iconos:

Modificar la carpeta:
- `/home/deploy/izing.io/frontend/public`

## Cambiar colores:

Editar los archivos:
- `/home/deploy/izing.io/frontend/src/css/app.sass`
- `/home/deploy/izing.io/frontend/src/css/quasar.variables.sass`

> 🛠️ **Notas:**
> - Siempre realizar cambios usando el usuario **deploy**.
> - Puedes conectarte al servidor usando la aplicación **Bitvise SSH Client**.
> - Después de las modificaciones, es necesario **compilar nuevamente el Frontend**.

Compilar:
```bash
su deploy
cd /home/deploy/izing.io/frontend/
npm run build
```

**Importante:** Probar las modificaciones en una **pestaña de incógnito**.

---

# Solución de Errores

## Error: SequelizeConnectionError

"Error interno del servidor: SequelizeConnectionError: no se pudo abrir el archivo `global/pg_filenode.map`: Permiso denegado."

Solución:
```bash
docker container restart postgresql
docker exec -u root postgresql bash -c "chown -R postgres:postgres /var/lib/postgresql/data"
docker container restart postgresql
```

---

## Problemas al enviar audios y notificaciones

Sucede porque la conexión se considera **insegura** al ejecutarse localmente (sin certificado SSL), lo cual bloquea el micrófono.

**Solución:**
- Accede en Chrome a `chrome://flags/#unsafely-treat-insecure-origin-as-secure`
- Inserta la IP y puerto de tu frontend y backend para permitir el uso seguro.

---

# Acceder a Portainer y Generar Contraseña

Si ves el mensaje:

> "Tu instancia de Portainer se cerró por motivos de seguridad. Para volver a habilitarla, deberás reiniciarla."

Reiniciar Portainer:
```bash
docker container restart portainer
```

Después, accede nuevamente:
```
http://tuip:9000/
```

---

¿Quieres que también te prepare una versión en inglés o un formato con secciones plegables para que luzca aún más profesional? 🚀
