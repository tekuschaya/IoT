echo -e "\033[1;33mSet mirrow\033[0m"
sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
yum update -y
yum install net-tools -y

curl -sfL https://get.k3s.io | sh -s - server \
--write-kubeconfig-mode 0644 \
--node-ip "192.168.42.110" \
--flannel-iface eth1

echo -e "\033[1;33mDeploy APP-1\033[0m"
/usr/local/bin/kubectl create configmap app1-html --from-file /vagrant/confs/app1/index.html
/usr/local/bin/kubectl apply -f /vagrant/confs/app1/deployment.yaml -f /vagrant/confs/app1/service.yaml -f /vagrant/confs/app1/ingress.yaml

echo -e "\033[1;33mDeploy APP-2\033[0m"
/usr/local/bin/kubectl create configmap app2-html --from-file /vagrant/confs/app2/index.html
/usr/local/bin/kubectl apply -f /vagrant/confs/app2/deployment.yaml -f /vagrant/confs/app2/service.yaml -f /vagrant/confs/app2/ingress.yaml

echo -e "\033[1;33mDeploy APP-3\033[0m"
/usr/local/bin/kubectl create configmap app3-html --from-file /vagrant/confs/app3/index.html
/usr/local/bin/kubectl apply -f /vagrant/confs/app3/deployment.yaml -f /vagrant/confs/app3/service.yaml -f /vagrant/confs/app3/ingress.yaml