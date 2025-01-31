$registryPaths = @(
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModel\StateChange\PackageList\Microsoft.WindowsAppRuntime.1.4_4000.1309.2056.0_x64__8wekyb3d8bbwe",
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModel\StateChange\PackageList\Microsoft.WindowsAppRuntime.1.4_4000.1309.2056.0_x86__8wekyb3d8bbwe",
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModel\StateChange\PackageList\GoogleChrome_b4z5fs62cjeq2",
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModel\StateChange\PackageList\MozillaFirefox134.0.1x64en_b4z5fs62cjeq2"
)

$keyName = "PackageStatus"
$desiredValue = 0

foreach ($registryPath in $registryPaths) {
    # Check if the registry key exists
    if (Test-Path $registryPath) {
        $currentValue = Get-ItemProperty -Path $registryPath -Name $keyName -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $keyName
        
        if ($currentValue -ne $desiredValue) {
            # Update the registry value
            Set-ItemProperty -Path $registryPath -Name $keyName -Value $desiredValue
            Write-Output "Updated '$keyName' to $desiredValue at $registryPath."
        } else {
            Write-Output "'$keyName' is already set to $desiredValue at $registryPath. No changes made."
        }
    } else {
        Write-Output "Registry path not found: $registryPath"
    }
}
