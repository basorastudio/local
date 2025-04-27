#!/bin/bash
# 
# funciones para configurar el backend de la aplicación

#######################################
# crea la base de datos docker
# Arguments:
#   None
#######################################
backend_db_create() {
  print_banner
  printf "${WHITE} 💻 Creando base de datos...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  usermod -aG docker deploy
  mkdir -p /data
  chown -R 999:999 /data
  docker run --name postgresql \
                -e POSTGRES_USER=izing \
                -e POSTGRES_PASSWORD=${pg_pass} \
				-e TZ="America/Santo_Domingo" \
                -p 5432:5432 \
                --restart=always \
                -v /data:/var/lib/postgresql/data \
                -d postgres

  docker run --name redis-izing \
                -e TZ="America/Santo_Domingo" \
                -p 6379:6379 \
                --restart=always \
                -d redis:latest redis-server \
                --appendonly yes \
                --requirepass "${redis_pass}"

  docker run -d --name portainer \
                -p 9000:9000 -p 9443:9443 \
                --restart=always \
                -v /var/run/docker.sock:/var/run/docker.sock \
                -v portainer_data:/data portainer/portainer-ce
EOF

  sleep 2
}

#######################################
# instalar_chrome
# Arguments:
#   None
#######################################
backend_chrome_install() {
  print_banner
  printf "${WHITE} 💻 Instalar Google Chrome...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
wget --inet4-only -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmour -o /usr/share/keyrings/chrome-keyring.gpg 
sudo sh -c 'echo "deb [arch=amd64,arm64,ppc64el signed-by=/usr/share/keyrings/chrome-keyring.gpg] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list'
sudo apt update 
sudo apt install -y google-chrome-stable 
EOF

  sleep 2
}

#######################################
# establece la variable de entorno para el backend.
# Arguments:
#   None
#######################################
backend_set_env() {
  print_banner
  printf "${WHITE} 💻 Configurando variables de entorno (backend)...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

sudo su - deploy << EOF
  cat <<[-]EOF > /home/deploy/izing.io/backend/.env
NODE_ENV=dev
BACKEND_URL=http://${ipservidorubuntu}
FRONTEND_URL=http://${ipservidorubuntu}:4000

PROXY_PORT=3000
PORT=3000

# conexión con la base de datos
DB_DIALECT=postgres
DB_PORT=5432
DB_TIMEZONE=-04:00
POSTGRES_HOST=localhost
POSTGRES_USER=izing
POSTGRES_PASSWORD=${pg_pass}
POSTGRES_DB=postgres

# Claves para la encriptación del token jwt
JWT_SECRET=DPHmNRZWZ4isLF9vXkMv1QabvpcA80Rc
JWT_REFRESH_SECRET=EMPehEbrAdi7s8fGSeYzqGQbV5wrjH4i

# Datos de conexión con REDIS
IO_REDIS_SERVER=localhost
IO_REDIS_PASSWORD=${redis_pass}
IO_REDIS_PORT=6379
IO_REDIS_DB_SESSION=2

#CHROME_BIN=/usr/bin/google-chrome
CHROME_BIN=/usr/bin/google-chrome-stable

# tiempo para la aleatorización del mensaje de horario de funcionamiento
MIN_SLEEP_BUSINESS_HOURS=10000
MAX_SLEEP_BUSINESS_HOURS=20000

# tiempo para la aleatorización de los mensajes del bot
MIN_SLEEP_AUTO_REPLY=4000
MAX_SLEEP_AUTO_REPLY=6000

# tiempo para la aleatorización de los mensajes generales
MIN_SLEEP_INTERVAL=2000
MAX_SLEEP_INTERVAL=5000

# datos de RabbitMQ / Para no utilizar, simplemente comente la variable AMQP_URL
RABBITMQ_DEFAULT_USER=admin
RABBITMQ_DEFAULT_PASS=123456
# AMQP_URL='amqp://admin:123456@host.docker.internal:5672?connection_attempts=5&retry_delay=5'

# api oficial (integración en desarrollo)
API_URL_360=https://waba-sandbox.360dialog.io

# usado para mostrar opciones no disponibles normalmente.
ADMIN_DOMAIN=izing.io

# Datos para la utilización del canal de facebook
FACEBOOK_APP_ID=3237415623048660
FACEBOOK_APP_SECRET_KEY=3266214132b8c98ac59f3e957a5efeaaa13500

# Forzar el uso de la versión definida a través de caché (https://wppconnect.io/es/whatsapp-versions/)
#WEB_VERSION=2.2409.2

# Personalizar opciones del pool de conexiones DB
#POSTGRES_POOL_MAX=100
#POSTGRES_POOL_MIN=10
#POSTGRES_POOL_ACQUIRE=30000
#POSTGRES_POOL_IDLE=10000

# Limitar Uso de Izing Usuario y Conexiones
USER_LIMIT=99
CONNECTIONS_LIMIT=99
[-]EOF
EOF

  sleep 2
}


#######################################
# instala las dependencias de node.js
# Arguments:
#   None
#######################################
backend_node_dependencies() {
  print_banner
  printf "${WHITE} 💻 Instalando dependencias del backend...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - deploy <<EOF
  cd /home/deploy/izing.io/backend
  npm install --force
EOF

  sleep 2
}

#######################################
# compila el código del backend
# Arguments:
#   None
#######################################
backend_node_build() {
  print_banner
  printf "${WHITE} 💻 Compilando el código del backend...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - deploy <<EOF
  cd /home/deploy/izing.io/backend
  npm run build
EOF

  sleep 2
}

#######################################
# actualiza whatsapp.js
# Arguments:
#   None
#######################################
whatsappweb_update() {
  print_banner
  printf "${WHITE} 💻 Actualizando whatsapp.js...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - deploy <<EOF
  cd /home/deploy/izing.io/backend
  pm2 stop all
  rm .wwebjs_auth -Rf
  rm .wwebjs_cache -Rf
  npm r whatsapp-web.js
  npm install github:pedroslopez/whatsapp-web.js
  pm2 restart all
EOF

  sleep 2
}

restart_pm2() {
  print_banner
  printf "${WHITE} 💻 Reiniciando PM2...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - deploy <<EOF
  pm2 restart all
EOF

  sleep 2
}

#######################################
# actualiza izing
# Arguments:
#   None
#######################################
git_update() {
  print_banner
  printf "${WHITE} 💻 Actualizando izing desde git...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - deploy <<EOF
  cd /home/deploy/izing.io
  pm2 stop all
  git checkout master
  git pull
EOF

  sleep 2
}

#######################################
# ejecuta db migrate
# Arguments:
#   None
#######################################
backend_db_migrate() {
  print_banner
  printf "${WHITE} 💻 Ejecutando db:migrate...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - deploy <<EOF
  cd /home/deploy/izing.io/backend
  npx sequelize db:migrate
EOF

  sleep 2
}

#######################################
# ejecuta db seed
# Arguments:
#   None
#######################################
backend_db_seed() {
  print_banner
  printf "${WHITE} 💻 Ejecutando db:seed...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - deploy <<EOF
  cd /home/deploy/izing.io/backend
  npx sequelize db:seed:all
EOF

  sleep 2
}

#######################################
# inicia el backend usando pm2 en 
# modo de producción.
# Arguments:
#   None
#######################################
backend_start_pm2() {
  print_banner
  printf "${WHITE} 💻 Iniciando pm2 (backend)...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - deploy <<EOF
  cd /home/deploy/izing.io/backend
  pm2 start dist/server.js --name izing-backend
  pm2 save
EOF

  sleep 2
}
