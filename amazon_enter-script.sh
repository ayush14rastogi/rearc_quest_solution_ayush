#!/bin/bash
USERNAME="ec2-user"

sudo yum update
sudo yum install docker git -y 
#wget https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) 
#sudo mv docker-compose-$(uname -s)-$(uname -m) /usr/local/bin/docker-compose
#sudo chmod -v +x /usr/local/bin/docker-compose
sudo systemctl enable docker.service
sudo systemctl start docker.service
sudo git clone https://github.com/rearc/quest.git

sudo usermod -aG docker ec2-user
sudo su - ec2-user
git clone https://github.com/rearc/quest.git /home/${USERNAME}/quest
cp /tmp/Dockerfile /home/${USERNAME}/quest/ 

cd /home/${USERNAME}/quest/ ; docker build -t docker-reacr-app . 
echo 'export SECRET_WORD="Bruce Wayne is BATMANN"' >> /home/ec2-user/.bashrc
source .bashrc
docker run --env SECRET_WORD --name docker-reacr-app -d -p 80:3000 docker-reacr-app




#sudo -u ${USERNAME} -H bash -c "git clone https://github.com/rearc/quest.git /home/${USERNAME}/quest"
#sudo -u ${USERNAME} -H bash -c  "cp /tmp/Dockerfile /home/${USERNAME}/quest/ "

#sudo -u ${USERNAME} -H bash -c "cd /home/${USERNAME}/quest/ ; docker build -t docker-reacr-app . "
#sudo -u ${USERNAME} -H bash -c  'echo "export SECRET_WORD=\"Bruce Wayne is BATMANN\"" >> /home/ec2-user/.bashrc'

#sudo -u ${USERNAME} -H bash -c   "source .bashrc; docker run --env SECRET_WORD --name docker-reacr-app -d -p 80:3000 docker-reacr-app"
