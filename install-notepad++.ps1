param(
    [Parameter(Mandatory=$true)]
    [string]$InstallPackage
)

# Test: Download from the website
$DownloadUrl = "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.5.4/npp.8.5.4.Installer.x64.exe" 

# Define the Cohesity share folder path and the local temporary folder path
#$cohesitySharePath = "\\10.229.208.24\appsshare"
#$Username = "<username>"
#$Password = ConvertTo-SecureString "<password>" -AsPlainText -Force
#$Credential = New-Object System.Management.Automation.PSCredential ($Username, $Password)

# Define the local temporary folder 
$LocalTempPath = [Environment]::GetFolderPath('Desktop') + "\tmp\"
# Create the temporary folder if it doesn't exist
if (!(Test-Path -Path $LocalTempPath)) {
    New-Item -ItemType Directory -Force -Path $LocalTempPath
}
$LocalInstallPath = $LocalTempPath + $InstallPackage

# Test: Download the installer
Invoke-WebRequest -Uri $DownloadUrl -OutFile $LocalInstallPath

# Copy the install package from the Cohesity share folder to the temporary folder
#Copy-Item -Path "$cohesitySharePath\$InstallPackage" -Destination $LocalInstallPath -Credential $Credential

# Check if the installer executable exists in the temporary folder
if (Test-Path $LocalInstallPath -PathType Leaf) {
    # Run the installer
    Start-Process -FilePath $LocalInstallPath -ArgumentList "/S" -Wait  # silent install
    Write-Host "Application installed successfully."
} else {
    Write-Host "Failed to find the installer package at $installPackagePath."
}
