# installawscli quickly installs aws cli, ansible, credstash, packer and terraform on centos/redhat or ubuntu
Instructions
1. sudo yum -y install git or sudo apt-get -y install git
2. mkdir repos; cd repos
3. git clone https://github.com/joelckwong/setupvm.git
4. cd setupvm
5. ./runfirst.sh
6. ./rocky8.sh or ./ubuntu.sh
7. sudo shutdown -r now
8. aws configure
9. credstash setup
