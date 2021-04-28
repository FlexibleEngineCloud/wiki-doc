---
title: Multi AZ NFS HA on ECS
description: 
published: true
date: 2021-04-28T15:15:00.996Z
tags: 
editor: markdown
---

# Introduction
The goal of this tutorial is to propose an NFS server with resiliency accross mutliple availability zone. It should support the loss of one node or one availability zone

# Architecture
![ecs_nfs_ha_architecture.png](/uploads/ecs_nfs_ha_architecture.png)

# How-to

## ECS Deployment
Deploy 2 ECS with at least following specs :
- C3 Family flavors
- Choose the latest Ubuntu LTS distribution
- Attach a data disk and select the performance class that fit your requirements
- Dispatch the ECS on 2 different AZ to lever multi AZ resiliency


## Master ECS configuration
### Format the data disk
List the disks to select the data disk previously created

`sudo fdisk -l`
Then search for your data disk, for me, it is mounted under **/dev/vdb**

Then format it 
`sudo fdisk /dev/vdb`
Then type `n` to create new partition
Then type `p` to create a primary partition
Keep the default parameters for the others questions

When the partition is created, type `w`to write the modifications.

### DRBD installation & configuration
Install the package 
`sudo apt-get install drbd-utils`

Enable the package 
`sudo modprobe drbd`

Then go in directory **etc/drbd.d**
`cd /etc/drbd.d`

And create a new file name  **drbd0.res**
`sudo nano drbd0.res`

Then paste this inside : 
> resource r0 {
>  
>     startup {
>                   wfc-timeout 30;
>                   degr-wfc-timeout 15;
>         }
>  
>     disk {
>         on-io-error   detach;
>     }
>  
>    syncer {
>       rate 320M;
>    }
>  
>         on ecs-nfs-master {
>                 device /dev/drbd0;
>                 disk /dev/vdb;
>                 address IP@ecs-nfs-master:7788;
>                 meta-disk internal;
>         }
>         on ecs-nfs-slave {
>                 device /dev/drbd0;
>                 disk /dev/vdb;
>                 address IP@ecs-nfs-slave:7788;
>                 meta-disk internal;
>         }
> }

Explainations : 
- The rate refer to the max throuput supported by your disk. I choosed Ultra High-IO class so it's 320M
- don't forget to adapt it to the name of your ECS (here its ecs-nfs-master and slave) + to mount path of your disk (here it /dev/vdb)
- I choose to store the metadata directly on the disk

Then initialise and start your drbd configuration 
`drbdadm create-md r0`
`drbdadm up r0`

### Private Image creation
Now shutdown the master instance then, in the ECS console, click on more then **Manage Image / Disk** and **Create Image**
![nfs_ha_create_image.png](/uploads/nfs_ha_create_image.png)

Then create a **Full ECS Image**

