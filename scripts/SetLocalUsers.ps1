# Prompt user to enter a new password for Administrator
$newAdminPassword = Read-Host "Enter new password for Administrator" -AsSecureString

# Enable Administrator account if it's not already enabled
try {
    $adminAccount = Get-LocalUser -Name "Administrator"
    if (!$adminAccount.Enabled) {
        $adminAccount | Enable-LocalUser
    }
    Write-Host "Administrator account is enabled."
} catch {
    Write-Host "Error enabling Administrator account: $_"
}

# Change password for Administrator
try {
    $adminAccount = Get-LocalUser -Name "Administrator"
    $adminAccount | Set-LocalUser -Password $newAdminPassword
    Write-Host "Password for Administrator was changed successfully."
} catch {
    Write-Host "Error changing password for Administrator: $_"
}

# Prompt user to enter a new password for UserAdmin
$newUserAdminPassword = Read-Host "Enter new password for UserAdmin" -AsSecureString

# Change password for UserAdmin
try {
    $userAdminAccount = Get-LocalUser -Name "UserAdmin"
    $userAdminAccount | Set-LocalUser -Password $newUserAdminPassword
    Write-Host "Password for UserAdmin was changed successfully."
} catch {
    Write-Host "Error changing password for UserAdmin: $_"
}
