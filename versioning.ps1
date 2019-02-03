param ($buildId)

if (!$buildId) {
    $buildId = 0
}

$pubspec = Get-Content ./pubspec.yaml -Raw
$match = $pubspec -match "version: (\d+\.)?(\d+\.)?(\*|\d+)"
$versionRow = $Matches[0].Trim()

if ($versionRow.EndsWith(".0") -eq $false) {
    Write-Error "versions must end with .0 to allow automatic versioning"
    exit -1
}

$versionPrefix = $versionRow.Substring(0, $versionRow.LastIndexOf("."))
$newVersion = $versionPrefix + "." + $buildId

(Get-Content .\pubspec.yaml -Raw).Replace($versionRow, $newVersion) | Set-Content .\pubspec.yaml