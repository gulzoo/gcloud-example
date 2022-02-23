helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
(cd ./kube-prometheus-stack ; helm dependency build)
helm install prometheus-stack ./kube-prometheus-stack