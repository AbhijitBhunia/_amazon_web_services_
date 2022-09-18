Write-Host "terraform init" -ForegroundColor Green
terraform get
terraform init

Write-Host "terraform fmt" -ForegroundColor Blue
terraform fmt

Write-Host "terraform validate" -ForegroundColor Blue
terraform validate

Write-Host "terraform destroy -auto-approve" -ForegroundColor Yellow
$destroy = Read-Host -Prompt "destroy old config? Y/N"
if($destroy -eq 'Y'){
  Write-Host "terraform destroying all old resources" -ForegroundColor Red
  terraform destroy -auto-approve -lock=false
}

Write-Host "terraform plan" -ForegroundColor Green
terraform plan -lock=false

$planapply = Read-Host -Prompt "Do you want to apply? Y/N"
if($planapply -eq 'Y'){
  Write-Host "terraform Apply running" -ForegroundColor Green
  Write-Host "terraform apply -auto-approve" -ForegroundColor Green
  terraform apply -auto-approve -lock=false
  Write-Host "terraform output > output.txt" -ForegroundColor Green
  terraform output > output.txt
}
else{
  Write-Host "terraform Apply skipped" -ForegroundColor Green
}
Write-Host "####-----TERRAFORM FINISHED ALL PROCESSSES-----####" -ForegroundColor Green