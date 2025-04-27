<<<<<<< HEAD
## EJECUTAR LOS COMANDOS A CONTINUACIÓN ##

para evitar errores se recomienda actualizar el sistema y después de actualizar reiniciar para evitar errores
=======
## Instalador para uso en Modo Local

Probado en Ubuntu 20 y 22

Editar el archivo config y colocar contraseñas de tu preferencia y la IP de la máquina Ubuntu local

La opción actualizar obtendrá la última versión del repositorio usado para instalar

---

## EJECUTAR LOS COMANDOS ABAJO ##

Para evitar errores se recomienda actualizar el sistema y luego reiniciar para evitar errores
>>>>>>> fb590da3d409fa9c73719dec7b5a7bfd2489b721

```bash
apt -y update && apt -y upgrade
```
```bash
reboot
```

<<<<<<< HEAD
 
Después de reiniciar, seguir con la instalación
=======
Después de reiniciar, continuar con la instalación
>>>>>>> fb590da3d409fa9c73719dec7b5a7bfd2489b721

```bash
cd /root
```
```bash
<<<<<<< HEAD
git clone https://github.com/cleitonme/izing.local.git izinginstalador
```
Editar datos con sus datos, con nano para guardar presiona Ctrl + x
```bash
nano ./izinginstalador/config
=======
git clone https://github.com/basorastudio/local.git local
>>>>>>> fb590da3d409fa9c73719dec7b5a7bfd2489b721
```
```bash
sudo chmod +x ./local/izing
```
```bash
cd ./local
```
```bash
sudo ./izing
```

## ¿Problemas de conexión con WhatsApp? ##

Intenta actualizar el Conector WWebJS whatsapp.js

---

<<<<<<< HEAD
## Modificar Frontend
=======
## Cambiar el Frontend
>>>>>>> fb590da3d409fa9c73719dec7b5a7bfd2489b721

Para cambiar el nombre de la aplicación:

/home/deploy/izing.io/frontend/quasar.conf

/home/deploy/izing.io/frontend/src/index.template.html

<<<<<<< HEAD
Para modificar logos e iconos:

carpeta /home/deploy/izing.io/frontend/public

Para modificar colores:
=======
Para cambiar logos e iconos:

carpeta /home/deploy/izing.io/frontend/public

Para cambiar colores:
>>>>>>> fb590da3d409fa9c73719dec7b5a7bfd2489b721

/home/deploy/izing.io/frontend/src/css/app.sass

/home/deploy/izing.io/frontend/src/css/quasar.variables.sass

<<<<<<< HEAD
Siempre modificar usando el usuario deploy. Puedes conectar al servidor con la aplicación Bitvise SSH Client. Después de las modificaciones, compilar nuevamente el Frontend
=======
Siempre realizar cambios usando el usuario deploy. Puedes conectarte al servidor con la aplicación Bitvise SSH Client. Después de los cambios, compilar nuevamente el Frontend
>>>>>>> fb590da3d409fa9c73719dec7b5a7bfd2489b721

```bash
su deploy
```
```bash
cd /home/deploy/izing.io/frontend/
```
```bash
npm run build
```

<<<<<<< HEAD
Probar las modificaciones en una pestaña de incógnito

## Errores
=======
Probar los cambios en una pestaña de incógnito

---
>>>>>>> fb590da3d409fa9c73719dec7b5a7bfd2489b721

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

<<<<<<< HEAD
## Problemas al enviar audios y notificaciones

Esto sucede porque no tienes un certificado cuando se ejecuta localmente, consideran la conexión como insegura y bloquean el micrófono.

Puedes resolver esto accediendo al enlace dentro del navegador Chrome; chrome://flags/#unsafely-treat-insecure-origin-as-secure e insertando la IP con el puerto de tu frontend y backend.

## Acceso a Portainer generar contraseña
"Your Portainer instance timed out for security purposes. To re-enable your Portainer instance, you will need to restart Portainer."
=======
---

## Problemas al enviar audios y notificaciones

Esto ocurre porque no tienes certificado. Cuando se ejecuta localmente, se considera la conexión como no segura y bloquean el micrófono.

Puedes resolver esto accediendo al siguiente enlace desde el navegador Chrome: chrome://flags/#unsafely-treat-insecure-origin-as-secure e insertando la IP con puerto de tu frontend y backend.

---

## Acceder a Portainer y generar contraseña

"Tu instancia de Portainer se cerró por motivos de seguridad. Para volver a habilitar tu instancia de Portainer, deberás reiniciarla."
>>>>>>> fb590da3d409fa9c73719dec7b5a7bfd2489b721

```bash
docker container restart portainer
```

<<<<<<< HEAD
Después accede nuevamente a la URL http://tuip:9000/
=======
Luego accede nuevamente a la URL http://tuip:9000/

---
>>>>>>> fb590da3d409fa9c73719dec7b5a7bfd2489b721
