# WARNING do this in safe place to not reveal private key
aws ec2 create-key-pair --key-name cluster4capstone --query 'KeyMaterial' --output text > cluster4capstone.pem
chmod 400 cluster4capstone 
ssh-keygen -y -f cluster4capstone.pem > ./cluster4capstone.pub # -y - input keyfile, -f  - output keyfile

eksctl create cluster \
--name cluster4capstone \
--region eu-west-2 \
--nodegroup-name standard-workers \
--node-type t3.micro \
--nodes 1 \
--nodes-min 1 \
--nodes-max 1 \
--ssh-access=true \
--ssh-public-key cluster4capstone.pub

eksctl delete cluster --name cluster4capstone

# configure kubectl for AWS EKS
aws eks --region eu-west02 update-kubeconfig --name capstone

# apply desired state over c
kubectl apply -f ~/.kube/aws-auth-cm.yaml