---
title: IAM
description: 
published: true
date: 2020-07-30T12:22:24.711Z
tags: 
editor: undefined
---

# Multitenancy
## Terminology 
- Domain (Openstack) / Account (Flexible Engine) :

Domains are the highest level abstraction for resources and users in an OpenStack environment. Domain can directly contain users, user groups and projects. If there is no domain, Identity V3 API assumes a default domain named ‘default’. Domains can also be considered as namespaces. Domain names must be unique across all domains. 

- Projects (Openstack & Flexible Engine) / Tenant (deprecated):

Projects are the second highest abstraction level in OpenStack environment. Projects can directly contain user groups or users. Project can also contain resources. Note that, one project can be assigned to at most one domain. 

- User groups (Openstack & Flexible Engine) :

As the name says, user groups are group of users. The advantage of having user groups is that by assigning roles to a user group, all users in the group get permissions of the roles. For example, an user group ‘CS6393’ may contain students in the course. By assigning  roles to ‘CS6393’ all students get access to the permissions of the roles. User group names are not global in OpenStack environment. Group names are unique within the owning domain and a group can be assigned to at most domain. 

- Roles:

In OpenStack, permissions to do anything is achieved via assignment to roles. Users or user groups  without any role assigned, can do nothing in the OpenStack environment. As in Role Based access Control (RBAC [2]), role contains permission which is a pair of object-type and operation. For example, create object of type VM or network can be considered as a permission. Note that role name are global in OpenStack environment. In other words, no two role can have the same name.

- Users:

Users are the active entity in the OpenStack system who can consume resources. Users are assigned to role to be able to carry on their activity. Users without any role, cannot do anything in the system, though it is possible to have users without any roles assigned to them.

## Evolution of Openstack (Keystone)
### Keystone v2
Example Org Structure using Keystone v2 Projects implementation
![projects](https://obs-public-staticfiles.oss.eu-west-0.prod-cloud-ocb.orange-business.com/multitenancy-os_projects.png "projects")
* A user can reside in multiple departments yet have a different role in that department.
* SandraD is a Sysadmin in Aerospace, but not in Biology. In the CompSci project, she has the Support role, but not the Sysadmin role.
### Keystone v3
Example of v3 API "Domains"
![domains](https://obs-public-staticfiles.oss.eu-west-0.prod-cloud-ocb.orange-business.com/multitenancy-os_domain.png "domains")
v3  introduces true multi-tenancy with the use of domains. As we can see the domain acts as a high level container for projects.

With domains, a cloud customer can be the owner of the domain. They can then create additional users, groups, and roles to be used within their specified domain.

## Global diagram 
 
![Multitenancy Os](https://obs-public-staticfiles.oss.eu-west-0.prod-cloud-ocb.orange-business.com/multitenancyDiagram.png "Multitenancy Os")
Domains and the Domain administrator, need to be created by what is termed the ‘The Cloud Administrator’. He can have access to Domain resources but this is not mandatory.
Each domain will then have its own top level Domain Administrator, with that administrator having rights to perform the following actions:
                * Create/Update Projects within their Domain
                * Create/Update/Delete Users within their Domain
                * Grant/Revoke Roles on Projects

## Domains or Projects organization 
### Multi-Domain architecture
Pros:
* Users are totally separated 
* Billing detail by Domain
* Highest level of isolation
* Quotas can be defined for each domains

Cons:
* Users need to added manually to each domains
* User groups/RBAC need to be created on each domains
* Reserved instances are at domain level (company's domain B can't benefit of unused reserved instances of compagny's domain A)
* External IDP have to be defined for each domains (An External IDP can't be attached to several FE domains)
* Automation: custom APIs provided at Cloud Store level (creation only)

### Multi-Project architecture
Pros:
* Easy to create
* Can be orchestrated using Openstack API/Terraform
* Can use transversal services/features (like CTS of each projects with the same OBS bucket as target for traces)

Cons:
* No detailed billing per project (at the moment)
* Isolation for some services is a bit complex (ex: OBS is expose at Domain level and can’t be spited by project)
