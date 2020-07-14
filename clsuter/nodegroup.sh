# docker run -it --rm -v ${PWD}:/work -w /work --entrypoint /bin/sh amazon/aws-cli:2.0.17
# aws eks get-token --cluster-name Capstone-Clusterku
# aws eks describe-cluster --name Capstone-Cluster
# aws ec2 describe-security-groups --group-ids <sg-0b....>
# aws eks --region eu-west-2 update-kubeconfig --name Capstone-Cluster
# aws iam list-users
# aws sts get-caller-identity

# prepare env to work with k8s
docker run -it --rm -v ${PWD}:/work -w /work --entrypoint /bin/sh amazon/aws-cli:2.0.17
aws configure
yum install jq
curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.16.8/2020-04-16/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv ./kubectl /usr/local/bin

# create our role for nodes
role_arn=$(aws iam create-role --role-name Capstone-eks-role-nodes --assume-role-policy-document file://assume-node-policy.json | jq .Role.Arn | sed s/\"//g)
role_arn=$(aws iam get-role --role-name Capstone-eks-role-nodes | jq .Role.Arn)
aws iam attach-role-policy --role-name Capstone-eks-role-nodes --policy-arn  arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy
aws iam attach-role-policy --role-name Capstone-eks-role-nodes --policy-arn  arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy
aws iam attach-role-policy --role-name Capstone-eks-role-nodes --policy-arn  arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly

aws eks create-nodegroup \
--cluster-name Capstone-Cluster \
--nodegroup-name test \
--node-role $role_arn \
--subnets subnet-0395ffa936d3a9e14 subnet-0462227e977b884fb subnet-005924d75b8226035 \
--disk-size 20 \
--scaling-config minSize=1,maxSize=2,desiredSize=1 \
--instance-types t2.small

aws eks --region eu-west-2 update-kubeconfig --name Capstone-Cluster


aws eks delete-nodegroup --cluster-name Capstone-Cluster --nodegroup-name test
aws iam delete-role --role-name Capstone-eks-role-node