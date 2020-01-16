#!/bin/bash
echo $(hostname -I | cut -d\  -f1) $(hostname) | sudo tee -a /etc/hosts
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install python3 python3-distutils wget netcat-openbsd unzip curl virtualenv make git sshpass
sudo apt install python3-pip
pip3 install --upgrade pip
pip3 install --user virtualenv
mkdir ~/venv
virtualenv -p python3 ~/venv
source ~/venv/bin/activate
echo "source venv/bin/activate" >> ~/.bash_profile
pip3 install boto
pip3 install boto3
pip3 install awscli
pip3 install -I ansible
pip3 install credstash
curl https://releases.hashicorp.com/terraform/0.12.18/terraform_0.12.18_linux_amd64.zip --output terraform_0.12.18_linux_amd64.zip
sudo unzip terraform_0.12.18_linux_amd64.zip -d /usr/bin
curl https://releases.hashicorp.com/packer/1.5.1/packer_1.5.1_linux_amd64.zip --output packer_1.5.1_linux_amd64.zip
sudo unzip packer_1.5.1_linux_amd64.zip -d /usr/bin
sudo cp -p terraform-provider-credstash /usr/bin
cat << EOF > ~/.terraformrc
providers {
     credstash = "/usr/bin/terraform-provider-credstash"
}
EOF
mkdir ~/repos
cd ~/repos
git clone https://github.com/uriagassi/sash.git
cd sash
make install
echo "source ~/.local/bin/sash.sh" >> ~/.bashrc
source ~/.bashrc
sudo apt-get -y update
sudo apt-get -y install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get -y update
sudo apt-get -y install docker-ce
sudo systemctl start docker && sudo systemctl enable docker
sudo usermod -aG docker $LOGNAME
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
