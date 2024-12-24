#!/bin/bash
sudo dnf -y upgrade
sudo dnf -y install epel-release
sudo dnf -y install wget nc bind-utils unzip python39 python39-devel openssl-devel gcc git sshpass make
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm -rf ~/miniconda3/miniconda.sh
~/miniconda3/bin/conda init bash
export PATH=$PATH:~/miniconda3/bin
echo "export PATH=$PATH:~/miniconda3/bin" >> ~/.bash_profile
conda create -n dev -y
conda install pip -y
echo "conda activate dev" >> ~/.bash_profile
pip install boto
pip install boto3
pip install awscli
pip install -I ansible
pip install credstash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
curl -Lo aws-iam-authenticator https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v0.6.29/aws-iam-authenticator_0.6.11_linux_amd64
sudo install -o root -g root -m 0755 aws-iam-authenticator /usr/local/bin/aws-iam-authenticator
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xvz
sudo install -o root -g root -m 0755 eksctl /usr/local/bin/eksctl
sudo dnf install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo dnf -y install terraform
terraform -install-autocomplete
sudo dnf -y install packer
packer plugins install github.com/hashicorp/amazon
packer plugins install github.com/hashicorp/ansible
packer plugins install github.com/hashicorp/vsphere
curl -Lo terraform-provider-credstash https://github.com/sspinc/terraform-provider-credstash/releases/download/v0.5.0/terraform-provider-credstash_linux_amd64
sudo install -o root -g root -m 0755 terraform-provider-credstash /usr/local/bin/terraform-provider-credstash
cat << EOF > ~/.terraformrc
providers {
     credstash = "/usr/local/bin/terraform-provider-credstash"
}
EOF
mkdir ~/repos
cd ~/repos
git clone https://github.com/uriagassi/sash.git
cd sash
make install
echo "source ~/.local/bin/sash.sh" >> ~/.bashrc
cd
source ~/.bashrc
sudo dnf install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf -y module enable container-tools
sudo dnf -y install docker-ce --allowerasing
sudo systemctl start docker && sudo systemctl enable docker
sudo usermod -aG docker $LOGNAME
sudo curl -Lo docker-compose "https://github.com/docker/compose/releases/download/v2.33.1/docker-compose-$(uname -s)-$(uname -m)"
sudo install -o root -g root -m 0755 docker-compose /usr/bin/docker-compose
curl --silent --location https://get.helm.sh/helm-v3.16.4-linux-amd64.tar.gz | tar xvz
sudo install -o root -g root -m 0755 linux-amd64/helm /usr/local/bin/helm
