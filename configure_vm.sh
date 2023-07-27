export RESOURCE_GROUP_NAME=testTaskGroup
export VM_NAME=testTastVM
export ADMIN_USERNAME=testtask
export IP_ADDRESS=$(az vm show --show-details --resource-group $RESOURCE_GROUP_NAME --name $VM_NAME --query publicIps --output tsv)

scp ./hello_world.sh $ADMIN_USERNAME@$IP_ADDRESS:/home/$ADMIN_USERNAME/

#Install NGINX web server
az vm run-command invoke \
   --resource-group $RESOURCE_GROUP_NAME \
   --name $VM_NAME \
   --command-id RunShellScript \
   --scripts "chmod +x /home/$ADMIN_USERNAME/hello_world.sh && /home/$ADMIN_USERNAME/hello_world.sh"
