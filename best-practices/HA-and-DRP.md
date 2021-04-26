---
title: High Availability and Disaster Recovery Plan
description: 
published: true
date: 2020-06-23T16:08:29.752Z
tags: 
editor: undefined
---

# High Availability best practise
As described in the additionnal documentation about the HA & DRP on Flexible Engine, here is the best practise to let your applications run in HA on Flexible Engine

## Intra Availabilty Zone HA 
HA in the same AZ of nominal.
In this case, nothing is needed from user side, all the features of Flexible Engine propose at least this type of high availability

## Inter Availability Zones HA
HA distributed to one or more different AZ from the nominal one, in the same region

### Inter AZ HA through Flexible Engine features
Some features of Flexible Engine support HA on multiple AZ. It can be enabled at your choice or it is natively enabled, here is the list of the service covered : 
- All the network features (From VPC to NAT Gateway) include it natively
- All the database feature, user need to enable a slave on the second AZ
- Cloud Steam Service and Data Ingestion service include it natively
- All the management & deployment features
- All the "Application" features (some need to enable it)

### Inter AZ HA through user application
In the others case, the way to enable HA for your service will be to use a 3rd party software, or better, directly the HA feature of your application. In terms of best practises (after using the included HA in Flexible Engine features), using the application HA is the better way to have a reliable HA that will permit also a BCP (Business Continuity Plan)
Here is some example to enable inter AZ HA through your application on Flexible Engine :

### Application that support a loadbalancer
For the application that support to be loadbalanced, the easiest way is to put an Elastic Loab Balancer on top of the service en deploy two instances (or more) of your application on multiple AZ. As the ELB as a native HA, it will cover the lose of one (or more) of your instance.

Generally, this type of application will not host any user data and are stateless like web servers and some application servers

(Diagram to come)

### Application that host data
For application that host data, many possibilies depending of the application

#### Database
For database, the easiest way would be to use our RDS feature. But if not possible, most of database engine support clustering feature that permit data replication and failover.

#### File Servers
Multiple examples here, file servers will depend on the protocol used, some of them support distributed / replicated datas.

Here some example based on the protocol needed :
- **SMB** : You can use Microsoft DFS (Distributed File System) with the replication enabled to distribute the data accros multiple AZ or Region
- **Volume** (to be mounted directly to an OS, multiple protocols compatible) : 
	-  GlusterFS, can permit replicated / distributed filesytem accross multiple AZ or Region.
	- DRBD (Distributed Replicated Block Device) can permit replicated volume accross mutliple AZ or Region
- **NFS** : Using volume replication and NFS Servers on top or NFSv4 replication feature

#### Others applications

For the applications that is not a database or a file service, the possibility depend on the application itself, some applications will have an HA feature, with or without data resiliency. Some others will have nothing. 

In these case, 3 possibilities: 

- The application have a HA feature + data replication feature. You're good
- The application have only a HA feature. You're almost good, but if data replication is needed, you can use one of the solution above to replicate the data
- The application doesn't support HA and/or Data replication. You can maybe use some HA 3rd party tool to achieve the HA on the software part and volume replication. HA 3rd party tool can be WSCF (Windows Server Failover Clustering) on Windows or Heartbeat on Linux



