# ControlFlux

Esse projeto consiste no controle e gerenciamento do fluxo de pessoas de um ambiente físico real. Ele foi criado para gerir e obter informações a respeito do fluxo de pessoas dentro do Diretório Acadêmico de Engenharia de Telecomunicações e Engenharia Eletrônica no campus da Universidade Federal de Pernambuco, ambiente o qual possui uma única entra/saída.

## Projeto

Os dispositivos base que compõe o projeto são eles:

- Mini trava solenoide controlada por um ESP8266, que tem acoplado um sensor biométrico responsável pela identificação dos usuários.
- Arranjo de sensores infravermelho que são capazes de contabilizar a entrada e saída do número de pessoas dentro da sala.

Estes dispositivos são conectados em um servidor local com interface em node-red que permite a visualização da contabilização de pessoas dentro da sala tal qual a identificação dos últimos usuários com acesso liberado na sala.

## Requisitos

Esse projeto possui por base o uso tanto do Docker quanto do Docker Compose (https://docs.docker.com/) para a construção do servidor. Quanto o uso e instalação do PlataformIO IDE (https://platformio.org/platformio-ide) para a programação dos firmwares.

## Instalação

### Servidor

Com o terminal aberto dentro da raiz do projeto, dê permissão para leitura e escrita na pasta de dados do node-red:

`sudo chmod -R 777 ./node-red`

Adicione certificado SSL para o mosquitto:

`mkdir certs`

`cd certs`

`openssl genrsa -des3 -out ca.key 2048`

`openssl req -new -key ca.key -out ca.csr -sha256`

`openssl x509 -req -in ca.csr -signkey ca.key -out ca-root.crt -sha256`

`openssl genrsa -out mosquitto.key 2048`

Na proxima linha de comando, quando solicitado "Common Name", use "locahost":

`openssl req -new -key mosquitto.key -out mosquitto.csr -sha256`

`openssl x509 -req -in mosquitto.csr -CA ca-root.crt -CAkey ca.key -CAcreateserial -out mosquitto.crt`

`openssl x509 -in ca.crt -out ca_cert.pem -outform PEM`

`openssl x509 -in client_mqtt.crt -out client_mqtt_cert.pem -outform PEM`

`cp client_mqtt.key client_mqtt_key.pem`

Adicione as chaves no volume do node-red:

`mkdir ../node-red/data/certs_SSL`

`cp ca_cert.pem ../node-red/data/certs_SSL/`

`cp mosquitto_key.pem ../node-red/data/certs_SSL/`

`cp mosquitto_cert.pem ../node-red/data/certs_SSL/`

Crie um arquivo de senhas para o mosquitto:

`touch ./mosquitto/password_file`

Crie um arquivo de variáveis de ambiente:

`touch .env`

Adicione o seu usuário e senha do mongo-express:

`echo "ME_WEB_USERNAME=<your_user>" >> .env`

`echo "ME_WEB_PASSWORD=<your_password>" >> .env`

Em seguida suba e construa o container do servidor com:

`docker compose up -d`

Inicie um bash dentro do container do mosquitto:

`docker exec -it <containder-mosquitto-id> sh`

Altere as permissões do arquivo de senha e adicione ao grupo do mosquitto:

`chmod 0700 /mosquitto/config/password_file`

`chown mosquitto: /mosquitto/config/password_file`

Se necessário adicione uma senha de sua preferência para o mqtt:

`docker exec mosquitto mosquitto_passwd -b /mosquitto/config/password_file <user> <password>`

Reinicie o docker:

`docker compose restart`

## Acesso

Para acessar a plataforma de construção em node-red, abra no navegador:

`localhost:1880`

Enquanto para a acessar ao mongo-express, abra:

`localhost:8081`