param($Veriable)
Write-Host "========================="
#$stName = [Environment]::GetEnvironmentVariable('MYPARTIDS')
$value = [Environment]::GetEnvironmentVariable("$Veriable")


#Write-Host "$env:some"
#Write-Host "variable value is = $(some)"
#Write-Host "variable value is $stName"
Write-Host "variable value is $value"
#Write-Host "$env:some"
Write-Host "============================="