#1 deploy network infrastructure for cluster (wait until created) 
./create-stack.sh capstone-cluster cluster.yml

#2 deploy eks cluster
./create-stack.sh capstone-cluster cluster.yml

#3 as all work was performed in cloud9 IDE there was need to workaround AWS managed cloud9 credentials 
#   (due to aws cli configuration limitations)
#   because of that I run AWS provided container with AWS CLI preinstalled
#   I required to customize this linux instance a little bit:
docker run -it --rm -v ${PWD}:/work -w /work --entrypoint /bin/sh amazon/aws-cli:2.0.17

#4 attach working nodes to cluster
  #4b provide AWS CLI access key created for user 
  aws configure
  
  #4c install JSON transformation tool
  yum install jq -y
  
  #4d install kubectl
  curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.16.8/2020-04-16/bin/linux/amd64/kubectl
  chmod +x ./kubectl
  mv ./kubectl /usr/local/bin
  
  #4e create our role for nodes
  role_arn=$(aws iam create-role --role-name Capstone-eks-role-nodes --assume-role-policy-document file://assume-node-policy.json | jq .Role.Arn | sed s/\"//g)
  echo $role_ar
  aws iam attach-role-policy --role-name Capstone-eks-role-nodes --policy-arn  arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy
  aws iam attach-role-policy --role-name Capstone-eks-role-nodes --policy-arn  arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy
  aws iam attach-role-policy --role-name Capstone-eks-role-nodes --policy-arn  arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly
  
  #4d if already created set rolse_arn env varieble
  # role_arn=$(aws iam get-role --role-name Capstone-eks-role-nodes | jq .Role.Arn | sed -r 's/^"|"$//g')
  
  #4e create worker nodes for cluster
  aws eks create-nodegroup \
  --cluster-name Capstone-Cluster \
  --nodegroup-name test \
  --node-role $role_arn \
  --subnets subnet-0395ffa936d3a9e14 subnet-0462227e977b884fb subnet-005924d75b8226035 \
  --disk-size 20 \
  --scaling-config minSize=1,maxSize=2,desiredSize=1 \
  --instance-types t2.small
  
#5 set cluster credentials in .kubeconfig
aws eks --region eu-west-2 update-kubeconfig --name Capstone-Cluster

#6 change state of cluster
kubectl apply -f k8s-object/deployment.yml
kubectl apply -f k8s-object/service.yml