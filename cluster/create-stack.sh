aws cloudformation create-stack \
  --stack-name $1 \
  --template-body file://$2 \
  --capabilities CAPABILITY_IAM 
  #--parameters file://$3 \

# CAPABILITY_NAMED_IAM   
# more info about resources affecting IAM https://docs.aws.amazon.com/cli/latest/reference/cloudformation/create-stack.html 