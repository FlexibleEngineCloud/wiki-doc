---
title: Workspace
description: 
published: true
date: 2020-06-05T09:46:26.773Z
tags: 
---

# Active Directory Multi-Domain Infrastructure

As described in the Active Directory Integration part,

 

Worskpace does not support multi active directory domain integration.

 

The only way to support it is to deploy 1 project per domain.

 

## Sample Architecture


---


# Workspace Base Ecosystem


## Recommended services to deploy a base Workspace ecosystem (Including AD & File Server)

- Active Directory → Centralised directory to permit users login and right management
- Windows File Server → Secure the storage of data in one place instead of desktop, provide also right management on folders.
  **NB : Use of SFS or object storage is not recommended, they do not provide a efficient right management system in this scenario**
- Nat gateway → permit internet outbound for AD, File Server and Workspace Desktop without exposing them to internet

## Architecture Sample for a base workspace ecosystem
![img](https://github.com/FlexibleEngineCloud/wiki-doc/blob/master/uploads/workspace_base_ecosystem.png?raw=true)


