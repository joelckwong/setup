#!/bin/bash
echo $(hostname -I | cut -d\  -f1) $(hostname) | sudo tee -a /etc/hosts
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install python3 python3-distutils wget netcat-openbsd unzip curl virtualenv make git
curl https://bootstrap.pypa.io/get-pip.py --output get-pip.py
sudo python3 get-pip.py
pip install --upgrade pip
pip install --user virtualenv
mkdir ~/venv
virtualenv -p python3 ~/venv
source ~/venv/bin/activate
echo "source venv/bin/activate" >> ~/.bash_profile
pip install boto
pip install boto3
pip install awscli
pip install -I ansible
pip install credstash
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
