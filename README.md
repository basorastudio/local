## EJECUTAR LOS COMANDOS A CONTINUACIÓN ##

para evitar errores se recomienda actualizar el sistema y después de actualizar reiniciar para evitar errores

```bash
apt -y update && apt -y upgrade
```
```bash
reboot
```

 
Después de reiniciar, seguir con la instalación

```bash
cd /root
```
```bash
git clone https://github.com/cleitonme/izing.local.git izinginstalador
```
Editar datos con sus datos, con nano para guardar presiona Ctrl + x
```bash
nano ./izinginstalador/config
```
```bash
sudo chmod +x ./izinginstalador/izing
```
```bash
cd ./izinginstalador
```
```bash
sudo ./izing
```

## ¿Problemas de conexión con WhatsApp? ##

Intenta actualizar el Conector WWebJS whatsapp.js


## Modificar Frontend

Para cambiar el nombre de la aplicación:

/home/deploy/izing.io/frontend/quasar.conf

/home/deploy/izing.io/frontend/src/index.template.html

Para modificar logos e iconos:

carpeta /home/deploy/izing.io/frontend/public

Para modificar colores:

/home/deploy/izing.io/frontend/src/css/app.sass

/home/deploy/izing.io/frontend/src/css/quasar.variables.sass

Siempre modificar usando el usuario deploy. Puedes conectar al servidor con la aplicación Bitvise SSH Client. Después de las modificaciones, compilar nuevamente el Frontend

```bash
su deploy
```
```bash
cd /home/deploy/izing.io/frontend/
```
```bash
npm run build
```

Probar las modificaciones en una pestaña de incógnito

## Errores

"Internal server error: SequelizeConnectionError: could not open file \"global/pg_filenode.map\": Permission denied"

```bash
docker container restart postgresql
```
```bash
docker exec -u root postgresql bash -c "chown -R postgres:postgres /var/lib/postgresql/data"
```
```bash
docker container restart postgresql
```

## Problemas al enviar audios y notificaciones

Esto sucede porque no tienes un certificado cuando se ejecuta localmente, consideran la conexión como insegura y bloquean el micrófono.

Puedes resolver esto accediendo al enlace dentro del navegador Chrome; chrome://flags/#unsafely-treat-insecure-origin-as-secure e insertando la IP con el puerto de tu frontend y backend.

## Acceso a Portainer generar contraseña
"Your Portainer instance timed out for security purposes. To re-enable your Portainer instance, you will need to restart Portainer."

```bash
docker container restart portainer
```

Después accede nuevamente a la URL http://tuip:9000/