function prev_command_exit_status($status) {
    if( $status -eq 0 ) {
        Write-Output "Command executed successfully"
    } else {
        Write-Output "Last command failed"
        exit 0
    }
}

function destroy_all_provisioned_resources(){
    Write-Host "Do you want to destory all resources: >terraform destroy -auto-approve" -ForegroundColor Yellow
    $destroy = Read-Host -Prompt "Select Y/y for yes else press any key?(Y/N)"
    if($destroy -eq 'Y'){
        Write-Host "terraform destroying all old resources please wait" -ForegroundColor Red
        terraform destroy -auto-approve -lock=false # need to remove -lock=false
        prev_command_exit_status $LASTEXITCODE
    }
    else{
        Write-Host "Skipped >terraform destroy" -ForegroundColor Red
    }
}

function display_infra(){
    Write-Host "Showing all provisioned resources: >terraform show" -ForegroundColor Yellow
    terraform show
    prev_command_exit_status $LASTEXITCODE
}

function exec_main(){
    Write-Host "####-----TERRAFORM STARTING ALL PROCESSSES-----####" -ForegroundColor Green
    display_infra
    destroy_all_provisioned_resources
    Write-Host "####-----TERRAFORM FINISHED ALL PROCESSSES-----####" -ForegroundColor Green
}

exec_main