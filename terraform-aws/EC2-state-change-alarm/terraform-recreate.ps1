echo "terraform init"
terraform init
echo "terraform destroy -auto-approve"
terraform destroy -auto-approve
echo "terraform apply -auto-approve"
terraform apply -auto-approve
echo "terraform output > output.txt"
terraform output > output.txt
echo "####-----TERRAFORM FINISHED ALL PROCESSSES-----####"