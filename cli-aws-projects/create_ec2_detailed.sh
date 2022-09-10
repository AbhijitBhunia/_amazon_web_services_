printf "Welcome to Create EC2-Instance Shell script\nBelow are the configured availability-zones in your local system\n\n"
# List Availability Zones
aws ec2 describe-availability-zones \
    --query "AvailabilityZones[*].{Region:RegionName,AvailabilityZone:ZoneName}" \
    --output table
printf "\nPlease make sure AWS Profile is setup for the AZ you want to create Instance in\n"
read -ep "select the AZ for your Instance. default AZ: " -i "ap-south-1" REGION
printf "\nYour selected region is: %s\n " $REGION
echo "###################################################################################################################"

# List all the running EC2 Instances
printf "below are the list of all running EC2 instances in your account:\n"
aws ec2 describe-instances  \
    --query "Reservations[*].Instances[*].{PublicIP:PublicIpAddress,Name:Tags[?Key=='Name']|[0].Value,Status:State.Name}" \
    --filters Name=instance-state-name,Values=running \
    --output table
echo "###################################################################################################################"

# Making choice if create EC2 Instance or not
read -p "Please enter YES or NO for weather you want to create a EC2 Instance or not" CHOICE
echo $CHOICE
if [ $CHOICE == "YES" ] 
then
    # List of Subnets
    printf "\nBelow is the Subnets list please select one ID to create EC2 in it\n"
    aws ec2 describe-subnets \
        --query "Subnets[*].{AvailabilityZone:AvailabilityZone,SubnetStatus:State,SubnetID:SubnetId,VPCID:VpcId}" \
        --output table
    read -p "select the Subnet for your EC2 Instance.:" SUBNET
    printf "\nYour selected subnet is: %s\n " $SUBNET
    echo "###################################################################################################################"

    read -p "How many EC2Instance do you want to craete?(please enter number 1-10):" COUNT
    echo "###################################################################################################################"

    aws ec2 describe-instance-types \
        --query "InstanceTypes[*].{InstanceType:InstanceType,DefaultCPUCount:VCpuInfo.DefaultVCpus,DefaultCores:VCpuInfo.DefaultCores}" \
        --filters Name=instance-type,Values=t* \
        --output table
    read -ep "select the Instance type for your EC2 Instance.:" TYPE
    printf "\nYour selected Instance type is: %s\n " $TYPE
    echo "###################################################################################################################"

    printf "\nCreating Key-Pair for your EC2 Instance\nKey Name: Shell_EC2_KP"
    KEYNAME='Shell_EC2_KP'
    aws ec2 create-key-pair \
        --key-name $KEYNAME \
        --key-type rsa
    echo "Please save the key pair for future login to EC2"
    echo "###################################################################################################################"

    SGNAME='Shell_EC2_SG'
    aws ec2 create-security-group \
        --group-name $SGNAME \
        --description "Shell EC2 Instance SG"
    
    read -p "Select the SG ID above and enter for further configurations: " SG_ID

    aws ec2 authorize-security-group-ingress \
        --group-id $SG_ID --protocol tcp --port 22 --cidr $(curl -s http://whatismyip.akamai.com/)

    aws ec2 run-instances \
        --image-id  \
        --count $COUNT \
        --instance-type $TYPE \
        --key-name $KEYNAME \
        --security-group-ids $SG_ID \
        --subnet-id $SUBNET
    echo "Bucket created"
    echo "----------------------------------------------------------------"
else
    printf "Bucket Not created as per your choice!"
fi

