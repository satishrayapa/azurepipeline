$buildNumber = $Env:BUILD_BUILDNUMBER;
$branch = $env:BUILD_SOURCEBRANCH
$SourceBranchName = $Env:Build_SourceBranchName;
$packageVersion = $Env:packageVersion;

if ($branch -like "refs/heads/release/*") {
    $portion = $SourceBranchName + "_";
    $buildNumber = $buildNumber.Replace($portion, $packageVersion + "_");

    Write-Host "##vso[build.updatebuildnumber]$buildNumber"
}