---
title: Multi AZ NFS HA on ECS
description: 
published: true
date: 2021-04-28T17:12:16.595Z
tags: 
editor: markdown
---

# Introduction
The goal of this tutorial is to propose an NFS server with resiliency accross mutliple availability zone. It should support the loss of one node or one availability zone

# Architecture
![ecs_nfs_ha_architecture.png](/uploads/ecs_nfs_ha_architecture.png)

# Auto-deployment Script (WIP)
Terraform Script to deploy the infrastructure : To be started
Bash Script to install & configure the software stack : Work In Progress


# Step By Step How-to

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

### Packages installation
Install the packages 
`sudo apt-get install drbd-utils`
`sudo apt-get install nfs-kernel-server`
`sudo apt-get install heartbeat`
Select **no configuration** for the postfix configuration

### DRBD Configuration
Enable the package DRBD
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
- Adapt the IP adresses of your ECS (you can make a plan to define later the IP of the slave)
- I choose to store the metadata directly on the disk

Then initialise and start your drbd configuration 
`sudo drbdadm create-md r0`
`sudo drbdadm up r0`

### Private Image creation & Slave ECS deployment
Now shutdown the master instance then, in the ECS console, click on more then **Manage Image / Disk** and **Create Image**
![nfs_ha_create_image.png](/uploads/nfs_ha_create_image.png)

Then create a **Full ECS Image**
![NFS_HA_param_image.PNG](/uploads/NFS_HA_param_image.PNG)

After image is created, in the ECS console create a new ECS based on this private image then name it **ecs-nfs-slave**
> Don't forget to select the deployment on a different AZ than the master + select a C3 family flavor
{.is-warning}

### VIP Creation 
Now you have the 2 ECS created, you have to create a VIP for Heartbeat in the Flexible Engine Console
- Go in the **VPC Console**, then in the **Subnet** select the subnet where the 2 ECS are, then click on **Assign Virtual IP** click on manual assignation and note the VIP you set
![nfs_ha_create_VIP.png](/uploads/nfs_ha_create_VIP.png)

- Once the VIP is created, click on **more** next to it then **Assign to Server** attach the VIP to the 2 ECS (You can attach 1 server at once)

### DRBD Synchronisation and Filesystem creation

Now launch the initialisation synchronisation of the disk with DRBD
On the master node :
`drbdadm -- --overwrite-data-of-peer primary r0`
On the slave node
`drbdadm secondary r0`
> This can take a  very long time (up to 1day depending on the disk size)...
You can monitor the status with 
> `cat /proc/drbd`
{.is-info}

When the first synchronisation is finished, create the filesystem **only on the master node**
`mkfs.ext4 /dev/drbd0`

### NFS Server configuration
Create a directory that will host the NFS share then mount it under the DRBD partition:
`sudo mkdir /data-nfs`
`sudo mount /dev/drbd0 /data-nfs`
`df -h`