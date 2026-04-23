# hybrid-identity-ad-entra-lab

# Hybrid Identity Lab: Active Directory + Microsoft Entra ID

## Overview
Built a hybrid identity environment integrating on-premises Active Directory with Microsoft Entra ID to enable synchronized identities and unified authentication across cloud and on-prem systems.

---

## Domain Ownership Note
When this lab was originally created, the Microsoft Entra tenant was deployed first using the default *.onmicrosoft.com domain. At that time, I did not yet own a custom domain.

Later, after purchasing my own domain (judeidentity.com), I updated the environment to use this domain as the primary UPN suffix for users. This required:

- Adding the custom domain to Microsoft Entra ID  
- Verifying DNS ownership  
- Adding the same UPN suffix inside Active Directory Domains and Trusts  
- Updating Azure AD Connect to use the new UPN suffix for synchronization  

This change aligns the on‑premises AD identities with the cloud tenant and reflects a more realistic enterprise identity setup.


## Environment Setup
- Provisioned a Windows Server virtual machine using Oracle VirtualBox  
- Installed Windows Server using official ISO media  
- Configured Active Directory Domain Services (AD DS)  
- Established domain environment for hybrid identity integration with Microsoft Entra ID  

---

## Architecture
This environment consists of:
- On-premises Active Directory (Windows Server)  
- Microsoft Entra ID (Azure AD)  
- Azure AD Connect for directory synchronization  

---

## Key IAM Concepts
- Identity Synchronization (AD > Entra ID)  
- Authentication across hybrid environments  
- Role-Based Access Control (RBAC)  
- Identity lifecycle management (Joiner/Mover/Leaver)  

---

## Implementation
- Deployed Active Directory domain environment  
- Designed Organizational Unit (OU) structure  
- Created users and security groups in AD via powershell
- Password and logon requirements
- Configured Azure AD Connect for directory synchronization  
- Synced users from AD to Entra ID  
- Joined devices to domain and tested authentication
- Created a domain admin account and added it to a OU

## PowerShell Script
The full automation script is available here:
[AD-Automation.ps1](scripts/AD-Automation.ps1)

## Active Directory Structure (Screenshots)

Below are screenshots of the on‑premises Active Directory structure created for this lab:

![AD Structure 1](images/ad-structure1.png)
![AD Structure 2](images/ad-structure2.png)
![AD Structure 3](images/ad-structure3.png)
![AD Structure 4](images/ad-structure4.png)
![AD Structure 5](images/ad-structure5.png)
![AD Structure 6](images/ad-structure6.png)
![AD Structure 7](images/ad-structure7.png)

## Azure AD Connect Configuration (Screenshots)

Below are the Azure AD Connect configuration screenshots used in this hybrid identity setup.

![Connect to Entra ID](images/Connect-to-EntralID.png)
![Connect Directory](images/Connect-Directory.png)
![User Sign-In](images/User-sign-in.png)
![Domain OU Filtering](images/Domain-OU-Filtering.png)
![Optional Features](images/Optional-Features.png)
![Device Options](images/Device-Options.png)
![Device OS](images/Device-OS.png)
![SCP Configuration](images/SCP-Configuration.png)
![Primary Custom Domain](images/Primary-Custom-Domain.png)
![AD Domain Trusts](images/AD-Domain-Trusts.png)
![Server Management Tasks](images/Server-management-tasks.png)
![Certificate Management Task](images/Cert-management-task.png)

## Azure AD Connect Sync Results

Below are the results showing successful synchronization of on‑premises identities to Microsoft Entra ID.

![Synced Users](images/Synced-Users.png)
![Synced AD Security Groups](images/Synced-AD-Security-Groups.png)


## Authentication Flow
User attempts to log into a cloud application → redirected to Entra ID → Entra authenticates using synced identity → access granted based on group membership.

---

## Validation
- Verified users synced successfully from AD to Entra ID  
- Tested authentication to Microsoft 365 services  
- Confirmed group-based access assignments  

---

## Challenges
- Resolved synchronization issues caused by incorrect UPN configuration  
- Troubleshot login failures due to domain configuration issues  
- Fixed group membership inconsistencies affecting access  




