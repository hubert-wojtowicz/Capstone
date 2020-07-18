#1 Delete load balancer/console
aws elb delete-load-balancer --load-balancer-name value

#2 Delete node groups
aws eks delete-nodegroup --cluster-name Capstone-Cluster --nodegroup-name test
aws iam delete-role --role-name Capstone-eks-role-node

#3 Delete cluster
./delete-stack.sh capstone-cluster

#4 Delete network
./delete-stack.sh capstone-infrastructure