# gcloud-example

In this project we create a GKE cluster using Terraform. On the cluster we than deploy an Angular web application that is exposed on the internet.


##Create GKE using Terraform

```
gcloud init
gcloud auth application-default login
gcloud services enable compute.googleapis.com
gcloud services enable container.googleapis.com
cd ./terraform
terraform init
terraform apply
#Import access credentials for kubectl
gcloud container clusters get-credentias $(terraform output -raw kubernetes_cluster_name) --region $(terraform output -raw region)

```
##Building and Deploying Webapp

```
#Enable arifactregistry API on the project
gcloud services enable artifactregisty.googleapis.com
#Create docker repository
gcloud artifacts repositories create <repo-name> --repository-format=docker --location=<region> --description="Docker repo"
#Configure docker login using gcloud credential helper
gcloud auth configure-docker <region>-docker.pkg.dev
cd ~/apps/webapp
docker-compose build
#Push image to the docker registry
docker push <region>-docker.pkg.dev/<project_name>/<repo_name/<image_name>:<tag>
#Enable read access to out registry
gcloud artifacts repositories add-iam-policy-binding <repo_name> --location=<region> --member=allUsers --role=roles/artifactregistry.reader
#Create namespaces
kubectl apply -f kubernetes/namespaces/namepaces.yml
#Deploy webapp
kubectl -n webapp-prod apply -f kubernetes/deployments/webapp.yml
```
##Exposing app using Traefik ingress controller
```
#Create a service
kubectl -n webapp-prod apply -f kubernetes/services/services.yml
#Deploy our ingress controller
kubectl -n webapp-prod apply -f kubernetes/ingress/controller/traefik
kubectl -n webapp-prod apply -f kubernetes/ingress/ingress.yml
kubectl -n webapp-prod get services
```
When we recieve the external IP address we can add the DNS record to the respective domain and restart the Traefik pod.

```
kubectl -n webapp-prod delete pod <traefik_pod_name>
```

Now we can access the web application over the internet.

