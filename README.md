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

Crie um arquivo de senhas para o mosquitto:

`touch ./mosquitto/passwd`

Em seguida suba e construa o container do servidor com:

`docker compose up -d`

Inicie um bash dentro do container do mosquitto:

`docker exec -it <containder-id> sh`

Altere as permissões do arquivo de senha e adicione ao grupo do mosquitto:

`chmod 0700 /etc/mosquitto/passwd`

`chown mosquitto: /etc/mosquitto/passwd`

Se necessário adicione uma senha de sua preferência para o mqtt:

`docker exec mosquitto mosquitto_passwd -b /etc/mosquitto/passwd <user> <password>`

Reinicie o docker:

`docker compose restart`

## Acesso

Para acessar a plataforma de construção em node-red, abra no navegador:

`localhost:1880`

Enquanto para a acessar ao mongo-express, abra:

`localhost:8081`