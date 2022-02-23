curl -LO https://get.helm.sh/helm-v3.8.0-linux-amd64.tar.gz
tar -C /tmp/ -xzvf helm-v3.8.0-linux-amd64.tar.gz
rm helm-v3.8.0-linux-amd64.tar.gz
sudo mv /tmp/linux-amd64/helm /usr/local/bin/helm
sudo chmod +x /usr/local/bin/helm