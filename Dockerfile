# Use uma imagem base com Node.js e npm
FROM node:18

# Instale o Node-RED
RUN npm install -g --unsafe-perm node-red

# Instale o MySQL
RUN apt-get update && apt-get install -y \
    mysql-server \
    mysql-client \
    && apt-get clean

# Copie os arquivos de configuração, se houver
# COPY ./my-config-file /path/to/destination/

# Exponha as portas para Node-RED e MySQL
EXPOSE 1880 3306

# Crie um diretório para Node-RED
RUN mkdir -p /data/node-red

# Defina o diretório de trabalho
WORKDIR /data/node-red

# Defina o comando padrão para iniciar o Node-RED e MySQL
CMD ["sh", "-c", "service mysql start && node-red"]
