#Use “gcloud config set project [PROJECT_ID]” to change to a different project
#to set env variable for zone and cluster name
export my_zone=us-central1-a
export my_cluster=standard-cluster-1
# create a Kubernetes cluster
gcloud container clusters create $my_cluster --num-nodes 3 --zone $my_zone --enable-ip-alias
#command to modify standard-cluster-1 to have four nodes:
gcloud container clusters resize $my_cluster --zone $my_zone --num-nodes=4
#To create a kubeconfig file with the credentials of the current user (to allow authentication) and provide the endpoint details for a specific cluster (to allow communicating with that cluster through the kubectl command-line tool), execute the following command:
gcloud container clusters get-credentials $my_cluster --zone $my_zone
#After the kubeconfig file is populated and the active context is set to a particular cluster, you can use the kubectl command-line tool to execute commands against the cluster
#print out the cluster information for the active context:
kubectl cluster-info
#to get a A line of output indicates the active context cluster, This information is the same as the information in the current-context property of the kubeconfig file.
kubectl config current-context
#command to change the active context:
kubectl config use-context gke_${GOOGLE_CLOUD_PROJECT}_us-central1-a_standard-cluster-1
#view resources usage in nodes
kubectl top nodes
#command to deploy nginx as a Pod named nginx-1,This command creates a Pod named nginx with a container running the nginx image. When a repository isn't specified, the default behavior is to try and find the image either locally or in the Docker public registry. In this case, the image is pulled from the Docker public registry.
kubectl create deployment --image nginx nginx-1
#You will now enter your Pod name into a variable that we will use. Using variables like this can help you minimize human error when typing long names. You must type your Pod's unique name in place of [your_pod_name]
export my_nginx_pod=nginx-1-d5c9f69b7-rhdgm
#execute the following command to view the complete details of the Pod just created
kubectl describe pod $my_nginx_pod
#command to place the file into the appropriate location within the nginx container in the nginx Pod to be served statically:
kubectl cp ~/test.html $my_nginx_pod:/usr/share/nginx/html/test.html
#command to create a service to expose our nginx Pod externally,This command creates a LoadBalancer service, which allows the nginx Pod to accessed from internet addresses outside of the cluster.
kubectl expose pod $my_nginx_pod --port 80 --type LoadBalancer
#to deploy mainifest file (yamlfile) which is better to use:
kubectl apply -f ./new-nginx-pod.yaml
