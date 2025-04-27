#!/bin/bash
# 
# funciones para configurar el frontend de la aplicación

#######################################
# paquetes de nodo instalados
# Arguments:
#   None
#######################################
frontend_node_dependencies() {
  print_banner
  printf "${WHITE} 💻 Instalando dependencias del frontend...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - deploy <<EOF
  cd /home/deploy/izing.io/frontend
  npm install --force
  npm i @quasar/cli
EOF

  sleep 2
}

#######################################
# compila el código del frontend
# Arguments:
#   None
#######################################
frontend_node_build() {
  print_banner
  printf "${WHITE} 💻 Compilando el código del frontend...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - deploy <<EOF
  cd /home/deploy/izing.io/frontend
  export NODE_OPTIONS=--openssl-legacy-provider
  npx update-browserslist-db@latest
  npx quasar build -P -m pwa
EOF

  sleep 2
}


#######################################
# establece las variables de entorno del frontend
# Arguments:
#   None
#######################################
frontend_set_env() {
  print_banner
  printf "${WHITE} 💻 Configurando variables de entorno (frontend)...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  # ensure idempotency


sudo su - deploy << EOF
  cat <<[-]EOF > /home/deploy/izing.io/frontend/.env
VUE_URL_API=http://${ipservidorubuntu}:3000
VUE_FACEBOOK_APP_ID='23156312477653241'
[-]EOF
EOF

  sleep 2
}

#######################################
# genera archivo server.js
# 
#   
#######################################
frontend_serverjs() {
  print_banner
  printf "${WHITE} 💻 Generando server.js (frontend)...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

sudo su - deploy << EOF
  cat <<[-]EOF > /home/deploy/izing.io/frontend/server.js
// simple express server to run frontend production build;
const express = require('express')
const path = require('path')
const app = express()
app.use(express.static(path.join(__dirname, 'dist/pwa')))
app.get('/*', function (req, res) {
  res.sendFile(path.join(__dirname, 'dist/pwa', 'index.html'))
})
app.listen(4000)
[-]EOF
EOF

  sleep 2
}

#######################################
# inicia el frontend usando pm2 en 
# modo de producción.
# Arguments:
#   None
#######################################
frontend_start_pm2() {
  print_banner
  printf "${WHITE} 💻 Iniciando pm2 (frontend)...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - deploy <<EOF
  cd /home/deploy/izing.io/frontend
  pm2 start server.js --name izing-frontend
  pm2 save
EOF

  sleep 2
}
