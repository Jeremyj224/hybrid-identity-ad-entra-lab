# hybrid-identity-ad-entra-lab

# Hybrid Identity Lab: Active Directory + Microsoft Entra ID

## Overview
Built a hybrid identity environment integrating on-premises Active Directory with Microsoft Entra ID to enable synchronized identities and unified authentication across cloud and on-prem systems.

---

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




