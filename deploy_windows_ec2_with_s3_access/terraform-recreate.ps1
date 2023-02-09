function prev_command_exit_status($status)
{
    if ($status -eq 0)
    {
        Write-Output "Command executed successfully"
    }
    else
    {
        Write-Output "Last command failed"
        exit 0
    }
}

function initialize_terraform()
{
    Write-Host "Initializing Terraform: >terraform init" -ForegroundColor Green
    terraform get
    prev_command_exit_status $LASTEXITCODE
    terraform init
    prev_command_exit_status $LASTEXITCODE
}

function format_tf_config_files()
{
    Write-Host "Formatting the files: >terraform fmt" -ForegroundColor Blue
    terraform fmt
    prev_command_exit_status $LASTEXITCODE
}

function validate_the_tf_configs()
{
    Write-Host "Validating the TF config: >terraform validate" -ForegroundColor Blue
    terraform validate
    prev_command_exit_status $LASTEXITCODE
}

function destroy_old_provisioned_resources()
{
    Write-Host "Do you want to destory old resources: >terraform destroy -auto-approve" -ForegroundColor Yellow
    $destroy = Read-Host -Prompt "Select Y/y for yes else press any key?(Y/N)"
    if ($destroy -eq 'Y')
    {
        Write-Host "terraform destroying all old resources please wait" -ForegroundColor Red
        terraform destroy -auto-approve #-lock=false # need to remove -lock=false
        prev_command_exit_status $LASTEXITCODE
    }
    else
    {
        Write-Host "Skipped >terraform destroy" -ForegroundColor Red
    }
}

function plan_infra()
{
    Write-Host "Showing the plan for configurations: >terraform plan" -ForegroundColor Green
    terraform plan -lock=false # need to remove -lock=false
    prev_command_exit_status $LASTEXITCODE
}

function create_infra()
{
    $planapply = Read-Host -Prompt "Do you want to apply the changes? Y/N"
    if ($planapply -eq 'Y')
    {
        Write-Host "terraform Apply running: >terraform apply -auto-approve" -ForegroundColor Green
        terraform apply -auto-approve #-lock=false
        prev_command_exit_status $LASTEXITCODE
        Write-Host "Saving output: >terraform output > output.txt" -ForegroundColor Green
        terraform output > output.txt
        prev_command_exit_status $LASTEXITCODE
    }
    else
    {
        Write-Host "terraform Apply skipped" -ForegroundColor Red
    }
}

function exec_main()
{
    Write-Host "####-----TERRAFORM STARTING ALL PROCESSSES-----####" -ForegroundColor Green
    initialize_terraform
    format_tf_config_files
    validate_the_tf_configs
    destroy_old_provisioned_resources
    plan_infra
    create_infra
    Write-Host "####-----TERRAFORM FINISHED ALL PROCESSSES-----####" -ForegroundColor Green
}

exec_main