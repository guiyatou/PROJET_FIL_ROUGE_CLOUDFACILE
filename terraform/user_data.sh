#!/bin/bash
apt-get update -y
apt-get upgrade -y

# Installation de Docker
apt-get install -y docker.io
systemctl start docker
systemctl enable docker

# Cree le dossier pour la page web
mkdir -p /home/ubuntu/app

# Cree la page index.html
cat > /home/ubuntu/app/index.html << 'EOF'
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Mon Projet DevOps</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: Arial, sans-serif;
            background: #0f0f1a;
            color: white;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .container { text-align: center; padding: 40px; }
        .badge {
            background: #00c853;
            color: white;
            padding: 6px 16px;
            border-radius: 20px;
            font-size: 14px;
            margin-bottom: 20px;
            display: inline-block;
        }
        h1 {
            font-size: 48px;
            margin-bottom: 16px;
            color: #00c853;
        }
        p { color: #aaa; font-size: 18px; margin-bottom: 40px; }
        .stack {
            display: flex;
            gap: 16px;
            justify-content: center;
            flex-wrap: wrap;
            margin-bottom: 40px;
        }
        .card {
            background: #1a1a2e;
            border: 1px solid #333;
            border-radius: 12px;
            padding: 20px 24px;
            min-width: 140px;
        }
        .card .name { font-size: 14px; color: #aaa; }
        .footer { color: #555; font-size: 13px; }
        .dot {
            width: 10px;
            height: 10px;
            background: #00c853;
            border-radius: 50%;
            display: inline-block;
            margin-right: 6px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="badge">Deploye via GitHub Actions</div>
        <h1>Mon Projet DevOps</h1>
        <p>Infrastructure Cloud automatisee, securisee et surveillee sur AWS</p>
        <div class="stack">
            <div class="card"><div class="name">Terraform</div></div>
            <div class="card"><div class="name">AWS EC2</div></div>
            <div class="card"><div class="name">Docker</div></div>
            <div class="card"><div class="name">GitHub Actions</div></div>
            <div class="card"><div class="name">Grafana</div></div>
        </div>
        <div class="footer">
            <span class="dot"></span> Serveur actif - AWS eu-west-1 Irlande
        </div>
    </div>
</body>
</html>
EOF

# Lance Nginx avec notre page personnalisee
docker run -d \
  --name nginx \
  --restart always \
  -p 80:80 \
  -v /home/ubuntu/app:/usr/share/nginx/html \
  nginx:latest

# Lance Node Exporter
docker run -d \
  --name node-exporter \
  --restart always \
  -p 9100:9100 \
  prom/node-exporter:latest