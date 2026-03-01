# 🚀 Projet Fil Rouge DevOps — CloudFacile

## 📋 Description
Infrastructure Cloud automatisée, sécurisée et surveillée sur AWS.
Un simple `git push` déclenche le déploiement complet de l'infrastructure.

---

## 🏗️ Architecture
```
Developer (PC)
     │
     │ git push
     ▼
GitHub Actions (CI/CD)
     │
     │ terraform apply
     ▼
AWS EC2 (eu-west-1)
     ├── Nginx (port 80)
     └── Node Exporter (port 9100)
          │
          │ scrape métriques
          ▼
     Prometheus (local)
          │
          ▼
     Grafana (local)
     ├── Dashboard Node Exporter
     └── Alerte CPU > 80%
```

---

## 📁 Structure du projet
```
├── .github/workflows/
│     ├── deploy.yml      # Pipeline déploiement automatique
│     └── destroy.yml     # Pipeline destruction manuelle
├── terraform/
│     ├── backend.tf      # Backend S3 pour tfstate
│     ├── provider.tf     # Configuration AWS provider
│     ├── main.tf         # Instance EC2
│     ├── sg.tf           # Security Group
│     ├── outputs.tf      # Output IP publique
│     └── user_data.sh    # Script bootstrap Docker
├── monitoring/
│     ├── docker-compose.yml        # Stack Prometheus + Grafana
│     ├── prometheus/
│     │     └── prometheus.yml      # Config scraping EC2
│     └── grafana/
│           ├── datasource.yml      # Connexion Prometheus
│           └── dashboard.yml      # Config dashboards
└── README.md
```

---

## 🚀 Comment lancer le projet

### Prérequis
- Terraform installé
- AWS CLI configuré
- Docker Desktop installé
- Compte GitHub avec secrets AWS configurés

### 1. Cloner le repo
```bash
git clone https://github.com/guiyatou/PROJET_FIL_ROUGE_CLOUDFACILE
cd PROJET_FIL_ROUGE_CLOUDFACILE
```

### 2. Créer le bucket S3 (une seule fois)
```bash
aws s3api create-bucket \
  --bucket TON-BUCKET-TFSTATE \
  --region eu-west-1 \
  --create-bucket-configuration LocationConstraint=eu-west-1
```

### 3. Déployer l'infrastructure
```bash
# Simple push sur main → GitHub Actions s'occupe du reste !
git push origin main
```

### 4. Lancer le monitoring local
```bash
cd monitoring
docker-compose up -d
```

### 5. Accéder aux interfaces
| Interface | URL | Credentials |
|-----------|-----|-------------|
| Grafana | http://localhost:3000 | admin/admin |
| Prometheus | http://localhost:9090 | - |
| Nginx EC2 | http://TON-IP-EC2 | - |
| Node Exporter | http://TON-IP-EC2:9100 | - |

---

## 🔥 Détruire l'infrastructure
Sur GitHub → **Actions → Destroy Infrastructure → Run workflow**

> ⚠️ Cette action supprime toute l'infrastructure AWS !

---

## 🚨 Test de l'alerte CPU

Pour déclencher l'alerte CPU > 80% :
```bash
# Se connecter en SSH à l'EC2
ssh -i ta-cle.pem ubuntu@TON-IP-EC2

# Simuler une charge CPU
stress --cpu 4 --timeout 180
```

L'alerte passe en **Firing** après 2 minutes dans Grafana.

---

## 📸 Preuves visuelles
- Dashboard Grafana — métriques EC2
- Prometheus Targets — EC2 UP
- Alerte CPU Firing
- Pipeline GitHub Actions — Deploy Success

---

## 🛠️ Stack technique
| Outil | Usage |
|-------|-------|
| Terraform | Infrastructure as Code |
| AWS EC2 | Serveur cloud |
| AWS S3 | Backend tfstate |
| Docker | Conteneurisation |
| Nginx | Serveur web |
| Node Exporter | Collecte métriques |
| Prometheus | Agrégation métriques |
| Grafana | Visualisation + Alertes |
| GitHub Actions | CI/CD Pipeline |