#!/bin/bash
# Mise à jour du système
apt-get update -y
apt-get upgrade -y

# Installation de Docker
apt-get install -y docker.io

# Démarrage et activation de Docker
systemctl start docker
systemctl enable docker

# Lancement du conteneur Nginx
docker run -d \
  --name nginx \
  --restart always \
  -p 80:80 \
  nginx:latest

# Lancement du conteneur Node Exporter
docker run -d \
  --name node-exporter \
  --restart always \
  -p 9100:9100 \
  prom/node-exporter:latest
