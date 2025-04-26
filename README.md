## Instalador para uso en Modo Local

Probado en Ubuntu 20 y 22

Editar el archivo config y colocar contraseñas de tu preferencia y la IP de la máquina Ubuntu local

La opción actualizar obtendrá la última versión del repositorio usado para instalar

---

## EJECUTAR LOS COMANDOS ABAJO ##

Para evitar errores se recomienda actualizar el sistema y luego reiniciar para evitar errores

```bash
apt -y update && apt -y upgrade
```
```bash
reboot
```

Después de reiniciar, continuar con la instalación

```bash
cd /root
```
```bash
git clone https://github.com/basorastudio/multiagente.git izinginstalador
```
```bash
sudo chmod +x ./multiagente/izing
```
```bash
cd ./izinginstalador
```
```bash
sudo ./izing
```

## ¿Problemas de conexión con WhatsApp? ##

Intenta actualizar el Conector WWebJS whatsapp.js

---

## Cambiar el Frontend

Para cambiar el nombre de la aplicación:

/home/deploy/izing.io/frontend/quasar.conf

/home/deploy/izing.io/frontend/src/index.template.html

Para cambiar logos e iconos:

carpeta /home/deploy/izing.io/frontend/public

Para cambiar colores:

/home/deploy/izing.io/frontend/src/css/app.sass

/home/deploy/izing.io/frontend/src/css/quasar.variables.sass

Siempre realizar cambios usando el usuario deploy. Puedes conectarte al servidor con la aplicación Bitvise SSH Client. Después de los cambios, compilar nuevamente el Frontend

```bash
su deploy
```
```bash
cd /home/deploy/izing.io/frontend/
```
```bash
npm run build
```

Probar los cambios en una pestaña de incógnito

---

## Errores

"Error interno del servidor: SequelizeConnectionError: no se pudo abrir el archivo \"global/pg_filenode.map\": Permiso denegado"

```bash
docker container restart postgresql
```
```bash
docker exec -u root postgresql bash -c "chown -R postgres:postgres /var/lib/postgresql/data"
```
```bash
docker container restart postgresql
```

---

## Problemas al enviar audios y notificaciones

Esto ocurre porque no tienes certificado. Cuando se ejecuta localmente, se considera la conexión como no segura y bloquean el micrófono.

Puedes resolver esto accediendo al siguiente enlace desde el navegador Chrome: chrome://flags/#unsafely-treat-insecure-origin-as-secure e insertando la IP con puerto de tu frontend y backend.

---

## Acceder a Portainer y generar contraseña

"Tu instancia de Portainer se cerró por motivos de seguridad. Para volver a habilitar tu instancia de Portainer, deberás reiniciarla."

```bash
docker container restart portainer
```

Luego accede nuevamente a la URL http://tuip:9000/

---
