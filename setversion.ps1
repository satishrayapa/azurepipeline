$branchName = $env:BUILD_SOURCEBRANCHNAME
$branch = $env:BUILD_SOURCEBRANCH
$major = $env:LATEST_MAJOR
$minor = $env:LATEST_MINOR

Write-Host "Current branch name is $branchName"

if ($branch -like "refs/heads/release/*") {
    $major,$minor = $branchName | foreach split .
}

$revCounterName = "rev-$major-$minor"

Write-Host "Setting version to $major.$minor"
Write-Host "Setting revision counter to $revCounterName"

Write-Host "##vso[task.setvariable variable=major;isOutput=true]$major"
Write-Host "##vso[task.setvariable variable=minor;isOutput=true]$minor"
Write-Host "##vso[task.setvariable variable=revCounterName;isOutput=true]$revCounterName"