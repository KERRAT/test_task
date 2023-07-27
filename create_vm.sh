#ENV variables of resources's names that will be created 
export RESOURCE_GROUP_NAME=testTaskGroup
export LOCATION=westeurope
export VM_NAME=testTastVM
export VM_IMAGE=debian
export ADMIN_USERNAME=testtask

#Create a resource group
az group create --name $RESOURCE_GROUP_NAME --location $LOCATION

#Create virtual machine
az vm create \
  --resource-group $RESOURCE_GROUP_NAME \
  --name $VM_NAME \
  --image $VM_IMAGE \
  --admin-username $ADMIN_USERNAME \
  --generate-ssh-keys \
  --public-ip-sku Standard

#Install NGINX web server
az vm run-command invoke \
   --resource-group $RESOURCE_GROUP_NAME \
   --name $VM_NAME \
   --command-id RunShellScript \
   --scripts "sudo apt-get update && sudo apt-get install -y nginx"

#Open port 80 to use with NGINX
az vm open-port --port 80 --resource-group $RESOURCE_GROUP_NAME\
   --name $VM_NAME
