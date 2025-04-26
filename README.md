## Instalador para uso em Modo Local

Testado ubuntu 20 e 22


Editar arquivo config e colocar senhas de sua preferencia e ip do maquina ubuntu local


A opção atualizar vai pegar ultima versao do repositorio usado para instalar



## RODAR OS COMANDOS ABAIXO ##

para evitar erros recomendados atualizar sistema e apos atualizar reniciar para evitar erros

```bash
apt -y update && apt -y upgrade
```
```bash
reboot
```

 
Depois reniciar seguir com a instalacao

```bash
cd /root
```
```bash
git clone https://github.com/basorastudio/multiagente.git izinginstalador
```
Editar dados com seus dados, com nano para salvar aperta Ctrl + x
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

## Problemas conexão whatsapp? ##

Tente atualizar o Conector WWebJS whatsapp.js


## Alterar Frontend

Para mudar nome do aplicativo:

/home/deploy/izing.io/frontend/quasar.conf

/home/deploy/izing.io/frontend/src/index.template.html

Para alterar logos e icones:

pasta /home/deploy/izing.io/frontend/public

Para alterar cores:

/home/deploy/izing.io/frontend/src/css/app.sass

/home/deploy/izing.io/frontend/src/css/quasar.variables.sass

Sempre alterar usando usuario deploy você pode conectar servidor com aplicativo Bitvise SSH Client. Depois das alterações compilar novamente o Frontend

```bash
su deploy
```
```bash
cd /home/deploy/izing.io/frontend/
```
```bash
npm run build
```

Testar as alterações em aba anonima

## Erros

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

## Problemas enviar audios e noticações

Isso porque você não possui certificado quando roda localmente consideram a conexão como insegura e bloqueiam o microfone.

Você consegue resolver isto, acessando o link dentro do navegador Chrome; chrome://flags/#unsafely-treat-insecure-origin-as-secure e inserindo o ip com porta do seu frontend e backend.

## Acesso Portainer gerar senha
"Your Portainer instance timed out for security purposes. To re-enable your Portainer instance, you will need to restart Portainer."

```bash
docker container restart portainer
```

Depois acesse novamente url http://seuip:9000/
