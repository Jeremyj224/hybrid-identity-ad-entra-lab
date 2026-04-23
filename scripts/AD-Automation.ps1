
## Users
- 6 users per department  
- Randomized first/last names  
- Unique SAMAccountName logic  
- UPN + email using judeidentity.com  
- Forced password change at next logon  

---

## PowerShell Automation Script

```powershell
Import-Module ActiveDirectory

$ParentOUName = "Jude Identity Users"
$UpnSuffix    = "judeidentity.com"
$DefaultPasswordPlain = (<REPLACE_WITH_SECURE_PASSWORD>)
$DefaultPassword = ConvertTo-SecureString $DefaultPasswordPlain -AsPlainText -Force

$DomainDN = (Get-ADDomain).DistinguishedName

# Create parent OU if missing
$ParentOU = Get-ADOrganizationalUnit -LDAPFilter "(ou=$ParentOUName)" -SearchBase $DomainDN -ErrorAction SilentlyContinue
if (-not $ParentOU) {
    New-ADOrganizationalUnit -Name $ParentOUName -Path $DomainDN -ProtectedFromAccidentalDeletion $true | Out-Null
    $ParentOU = Get-ADOrganizationalUnit -LDAPFilter "(ou=$ParentOUName)" -SearchBase $DomainDN
}

$ParentOUdn = $ParentOU.DistinguishedName

$Departments = @("IT","HR","Finance","Sales")

# Create department OUs
foreach ($dept in $Departments) {
    $deptOU = Get-ADOrganizationalUnit -LDAPFilter "(ou=$dept)" -SearchBase $ParentOUdn -ErrorAction SilentlyContinue
    if (-not $deptOU) {
        New-ADOrganizationalUnit -Name $dept -Path $ParentOUdn -ProtectedFromAccidentalDeletion $true | Out-Null
    }
}

# Create security groups in parent OU
foreach ($dept in $Departments) {
    $groupName = "SG-$dept"
    if (-not (Get-ADGroup -LDAPFilter "(cn=$groupName)" -ErrorAction SilentlyContinue)) {
        New-ADGroup -Name $groupName -GroupScope Global -GroupCategory Security -Path $ParentOUdn `
            -Description "Jude Identity $dept Department Security Group" | Out-Null
    }
}

# Name pools
$FirstNames = "Ava","Noah","Mia","Liam","Sophia","Ethan","Olivia","Lucas","Amelia","Mason","Isabella","Logan","Charlotte","James","Harper","Benjamin"
$LastNames  = "Johnson","Smith","Brown","Davis","Miller","Wilson","Moore","Taylor","Anderson","Thomas","Jackson","White","Harris","Martin","Thompson","Garcia"

function Get-UniqueSam([string]$First,[string]$Last){
    $base = (($First.Substring(0,1) + $Last) -replace "[^a-zA-Z0-9]", "").ToLower()
    $sam = $base
    $i = 1
    while (Get-ADUser -Filter "SamAccountName -eq '$sam'" -ErrorAction SilentlyContinue) {
        $i++
        $sam = "$base$i"
    }
    return $sam
}

$UsersPerDept = 6

foreach ($dept in $Departments) {
    $deptOUdn = "OU=$dept,$ParentOUdn"
    $groupName = "SG-$dept"

    1..$UsersPerDept | ForEach-Object {
        $first = Get-Random $FirstNames
        $last  = Get-Random $LastNames
        $sam   = Get-UniqueSam $first $last
        $display = "$first $last"
        $upn   = "$sam@$UpnSuffix"
        $mail  = "$sam@$UpnSuffix"

        New-ADUser -Name $display -GivenName $first -Surname $last -DisplayName $display `
            -SamAccountName $sam -UserPrincipalName $upn -EmailAddress $mail `
            -Path $deptOUdn -AccountPassword $DefaultPassword -Enabled $true `
            -ChangePasswordAtLogon $true -Description "Jude Identity User"- $dept" | Out-Null

        Add-ADGroupMember -Identity $groupName -Members $sam
    }
}

Write-Host "Done. Created OUs, groups, and users. Password: $DefaultPasswordPlain" -ForegroundColor Green
