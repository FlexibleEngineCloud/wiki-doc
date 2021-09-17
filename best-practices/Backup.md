---
title: Backup
description: Backup Best pratices on Flexible Engine
published: true
date: 2021-09-17T17:46:06.789Z
tags: draft
editor: Vincent E
---

# Why to backup ?
- To protect data loss caused by a hardware failure (disk, physical server)
- To protect data loss or corruption caused by software bugs
- To protect data loss or corruption caused by humain mistakes
- To protect data loss from a distaster at DC level (fire, flood, storm, earthquake, plane crash, explosion, terrorist attack, war, etc)
- To protect data loss or corruption caused by a ransomware or a cyberattack

# What to backup ?
- System: all the filesystem of a physical machine or a virtual machine (only the operating system volume or all the volumes attached to a machine). System backups must crash consistent in order to have a working system when restored.
- Volume: the whole image of a data volume (also called logical drive or partition)
- Files: all the files or a subset of the files on a data volume in order to be restored individually
- Application: some applications like databases require application aware backups in order to be restored in a consistent way

# How to backup ?
- Using agent
- Agentless

# Where to backup ?
- Tape
- Disk
- Cloud storage

# Backup types
- Full backup
- Incremental backup
- Differential backup
- Synthetic full backup
- Forever incremental backup

# 3 2 1 rule
- 3 copies of your data including the main copy
- 2 copies on site ideally on two different type of storage (example: main copy on block storage, secondary copy on object storage)
- 1 copy off site

# Backup options on Flexible Engine

## System snapshot
### ECS:
- CSBS 
- CBR Cloud Server Backup
###	BMS:
- CBR Cloud Server backup

## Volume snapshot 
### EVS:
- VBS
- CBR Cloud Disk Backup 
###	SFS Turbo:
- CBR SFS Turbo Backup

## File backup
###	EVS:
- FAB
- Commvault
- obsutil
### SFS
- FAB
- Commvault

## Application backup (database)
### RDS
- native backup function
### ECS
- CBR Cloud application consistent backup
- FAB
- Native database backup tool (Oracle Rman, MySQL Dump, PostgreSQL dump)

# Backup vs Replication vs DRP (Disaster Recovey Plan)

Backups can be used for a DRP if RPO objectives are low (RPO 4h or 24h).

Replication is necessary when RPO and RTO objectives are high (RPO close to 0 and RTO close to 0).

Replication doesn't replace backup.


## Replication options on Flexible Engine
-	ECS:

SDRS
-	Database:

Native database replication tool (Oracle dataguard,  MySQL replication, PostgreSQL replication)

## DRP options on Flexible Engine
- Platform:

Nuabee
- Backup:

CSBS cross region replication or CBR cross region replication (roadmap)
