$Winget = Get-ChildItem -Path (Join-Path -Path (Join-Path -Path $env:ProgramFiles -ChildPath "WindowsApps") -ChildPath "Microsoft.DesktopAppInstaller*_x64*\AppInstallerCLI.exe")

# https://docs.microsoft.com/en-us/windows/package-manager/winget/upgrade#options
$Options = "upgrade --all -h --accept-package-agreements --accept-source-agreements"

$TaskAction = New-ScheduledTaskAction -Execute $Winget -Argument $Options

$TaskName = "Winget Upgrade Packages"

$TaskTrigger = New-ScheduledTaskTrigger -AtLogOn

$TaskUserPrincipal = New-ScheduledTaskPrincipal -UserId 'SYSTEM' -RunLevel Highest

$TaskSettings = New-ScheduledTaskSettingsSet -Compatibility Win8

$Task = New-ScheduledTask -Action $TaskAction -Principal $TaskUserPrincipal -Trigger $TaskTrigger -Settings $TaskSettings

Write-Host "Adding new Scheduled Task: $TaskName"
Register-ScheduledTask -TaskName $TaskName -InputObject $Task -Force