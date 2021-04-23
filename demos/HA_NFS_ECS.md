---
title: Multi AZ NFS HA on ECS
description: 
published: true
date: 2021-04-23T15:33:43.406Z
tags: 
editor: markdown
---

# Goal
Deploy an NFS service with a multi AZ resilience onto ECS instances

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
>       rate 100M;
>    }
>  
>         on nfs1 {
>                 device /dev/drbd0;
>                 disk /dev/sdb1;
>                 address 10.1.0.31:7788;
>                 meta-disk internal;
>         }
>         on nfs2 {
>                 device /dev/drbd0;
>                 disk /dev/sdb1;
>                 address 10.1.0.32:7788;
>                 meta-disk internal;
>         }
> }



