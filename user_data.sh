# #!/bin/bash
# set -e
 
# # user_data = script exécuté au 1er boot par cloud-init
# # Avantage : pas besoin de SSH / remote-exec
# # On configure la machine dès son démarrage.
 
# apt-get update -y
# apt-get install -y nginx
 
# systemctl enable nginx
# systemctl start nginx

#!/bin/bash
set -e

# Mettre à jour le système
apt-get update -y
apt-get upgrade -y

# Installer Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

# Installer Docker Compose
curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Ajouter ubuntu au groupe docker
usermod -aG docker ubuntu

# Créer le répertoire pour Jenkins
mkdir -p /home/ubuntu/jenkins
cd /home/ubuntu/jenkins

# Créer le fichier docker-compose.yml
cat <<EOF > docker-compose.yml
version: '3.8'

services:
  jenkins:
    image: jenkins/jenkins:lts
    container_name: jenkins
    restart: unless-stopped
    privileged: true
    user: root
    ports:
      - "8080:8080"
      - "50000:50000"
    volumes:
      - jenkins_home:/var/jenkins_home
      - /var/run/docker.sock:/var/run/docker.sock
      - /usr/bin/docker:/usr/bin/docker
    environment:
      - JAVA_OPTS=-Djenkins.install.runSetupWizard=true

volumes:
  jenkins_home:
EOF

# Démarrer Jenkins
docker-compose up -d

# Attendre que Jenkins démarre
sleep 30

# Afficher le mot de passe initial
echo "Jenkins Initial Password:" > /home/ubuntu/jenkins_password.txt
docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword >> /home/ubuntu/jenkins_password.txt

# Fixer les permissions
chown -R ubuntu:ubuntu /home/ubuntu/jenkins
chown ubuntu:ubuntu /home/ubuntu/jenkins_password.txt