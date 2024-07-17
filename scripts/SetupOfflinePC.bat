# Check if the password parameter is provided
param (
    [string]$password
)

# Check if the UserAdmin account exists
$userExists = Get-LocalUser -Name "UserAdmin" -ErrorAction SilentlyContinue

if ($null -ne $userExists) {
    # If the account exists, set the password
    if ($password) {
        $securePassword = ConvertTo-SecureString $password -AsPlainText -Force
        Set-LocalUser -Name "UserAdmin" -Password $securePassword
        Write-Output "Password for UserAdmin was set successfully."
    } else {
        Write-Output "UserAdmin account already exists and no password was provided."
    }
} else {
    # If the account does not exist, create it
    if ($password) {
        $securePassword = ConvertTo-SecureString $password -AsPlainText -Force
        New-LocalUser -Name "UserAdmin" -Password $securePassword -PasswordNeverExpires:$true
        Write-Output "Created UserAdmin with a password."
    } else {
        New-LocalUser -Name "UserAdmin" -NoPassword -PasswordNeverExpires:$true
        Write-Output "Created UserAdmin without a password."
    }
}

# Add UserAdmin to Administrators group
Add-LocalGroupMember -Group "Administrators" -Member "UserAdmin"

# Start msoobe.exe and restart the system using shutdown.exe -r
Start-Process "msoobe.exe"
Start-Sleep -Seconds 10  # Wait for msoobe.exe to start properly
Start-Process "shutdown.exe" -ArgumentList "/r /t 0"