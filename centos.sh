#!/bin/bash
sudo yum -y update
sudo yum -y install epel-release
sudo yum -y install wget nc bind-utils unzip python36 python36-devel openssl-devel gcc git sshpass
curl https://bootstrap.pypa.io/get-pip.py --output get-pip.py
sudo python3.6 get-pip.py
pip install --upgrade pip
pip install --user virtualenv
mkdir ~/venv
virtualenv ~/venv
source ~/venv/bin/activate
echo "source venv/bin/activate" >> ~/.bash_profile
pip install boto
pip install boto3
pip install awscli
pip install -I ansible
pip install credstash
curl https://releases.hashicorp.com/terraform/0.13.2/terraform_0.13.2_linux_amd64.zip --output terraform_0.13.2_linux_amd64.zip
sudo unzip terraform_0.13.2_linux_amd64.zip -d /usr/bin
curl https://releases.hashicorp.com/packer/1.6.2/packer_1.6.2_linux_amd64.zip --output packer_1.6.2_linux_amd64.zip
sudo unzip packer_1.6.2_linux_amd64.zip -d /usr/bin
curl https://github.com/sspinc/terraform-provider-credstash/releases/download/0.5.0/terraform-provider-credstash_linux_amd64 --output terraform-provider-credstash
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
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum -y install docker-ce
sudo systemctl start docker && sudo systemctl enable docker
sudo usermod -aG docker $LOGNAME
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
curl https://get.helm.sh/helm-v3.3.1-linux-amd64.tar.gz --output helm-v3.3.1-linux-amd64.tar.gz
tar -zxvf helm-v3.3.1-linux-amd64.tar.gz
chmod +x linux-amd64/helm
sudo mv linux-amd64/helm /usr/bin/helm
sudo chown root: /usr/bin/helm
