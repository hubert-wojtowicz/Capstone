aws cloudformation create-stack \
  --stack-name $1 \
  --template-body file://$2 \
  #--parameters file://$3 \
  # --capabilities CAPABILITY_IAM 

# CAPABILITY_NAMED_IAM   
# more info about resources affecting IAM https://docs.aws.amazon.com/cli/latest/reference/cloudformation/create-stack.html 