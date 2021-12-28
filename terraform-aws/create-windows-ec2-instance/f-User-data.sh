mkdir C:\Vijay-Mourya -Force
New-Item C:Vijay-Mourya\System-Start-Up.txt -Force
Write-Output "System Startup Date-Time" >> C:Vijay-Mourya\System-Start-Up.txt
Write-Output (Get-Date -f yyyy-mm-dd_HH-mm-ss) >> C:Vijay-Mourya\System-Start-Up.txt