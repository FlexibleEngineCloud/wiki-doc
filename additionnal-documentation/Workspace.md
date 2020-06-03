---
title: Workspace
description: 
published: true
date: 2020-06-03T13:15:22.693Z
tags: 
---

# Active Directory
## AD Integration
### How to interconnect my on premise AD ?

There is 3 recommended solutions :

- Use an IPSEC VPN to interconnect your on premise AD and Workspace (you can use our VPNaaS feature)
- Use a FE Direct Connect (with MPLS VPN or other)
- Create a AD replica in Flexible Engine and replicate the content with from your on premise AD. This solution requires also of the two others solutions, but can be great to reduce external network consumption.

### Multi domain integration

For today (03/2020), multi domain integration is not supported.

Workaround is to use one project per sub domain

### What about rights needed for the workspace admin ?

Everything is specified in the workspace documentation, but here is a reminder of the account right in case an issue for deleting computers in AD when desktop is deleted (most common) is encountered

![img](https://github.com/FlexibleEngineCloud/wiki-doc/blob/master/uploads/workspace-admin-rigths.png?raw=true)



### Why time/date in the master image is very important ?

If the time is wrong, you can encounter an issue when you'll deploy a wrong timed images. This will cause a AD join failure.

### Where are my users ?

You users are not shown in the workspace console, only users with dedicated desktop created will be shown in the users tabs on Workspace Console (a copy of the users informations which have already a desktop is done on the worskpace infrastructure to permit login in case of AD Failure)



### I want to put my computers in a specific OU ?

You can put the desktop you will create in the OU of your choice, just enter the path to the OU in the case below in the desktop creation form :

### I deployed my computer in the wrong OU, can I have move it

Sure, you can move the desktop, then think to reboot it in case you have specific GPO (Group Policy Object) on this new OU.

![img](https://github.com/FlexibleEngineCloud/wiki-doc/blob/master/uploads/ou-users.png?raw=true)

### How are named my desktop ?

In the desktop creation process from Workspace console, name of desktop will take the name of users or group (if it is Desktop Pool) with a number, (exemple : tony01, it-group01)

The name can be choose with using API to create desktop



# Desktop Private Image
## Language
### How to change the public image to French (Keyboard Layout and interface) for all users ?

You can follow this [guide](https://plazza.orange.com/external-link.jspa?url=https%3A%2F%2Fobs-tony-paris.oss.eu-west-0.prod-cloud-ocb.orange-business.com%2FWorkspace_langue_francaise.pdf) (only in French now)

# Workspace GPU benchmark

### g1.xlarge 4 vCPU 8 GB RAm 1/8 M60 1GB vRAM

#### (Windows server 2016 - 80GB Ultra High-IO - Driver 370.28 )

| **3dmark (TimeSpy DX12)** | **3dmark (Frire Strike DX11)** | **Unigine Superposition  (OpenGL 1.1, 1080p medium)** | **Unigine Superposition  (Direct X, 1080p medium)** |                |               |                |       |       |
| :------------------------ | :----------------------------- | :---------------------------------------------------- | :-------------------------------------------------- | -------------- | ------------- | -------------- | ----- | ----- |
| Total Score               | Graphics Score                 | CPU Score                                             | Total Score                                         | Graphics Score | Physics Score | Combined Score | Score | Score |
| Failed (not enough VRAM)  | Failed                         | Failed                                                | 8606                                                | 10900          | 6723          | 3989           | 1328  | 5634  |



| PassMark Performance Test(OpenCL/ CUDA not supported)        | SPECviewperf 13                                              |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| ![img](https://github.com/FlexibleEngineCloud/wiki-doc/blob/master/uploads/g1_xlarge_passmark.png?raw=true) | ![img](https://github.com/FlexibleEngineCloud/wiki-doc/blob/master/uploads/g1_xlarge_specviewperf.png?raw=true) |












### g1.2xlarge 8 vCPU 16 GB ram 1/8 M60 1GB vRAM

#### (Windows server 2016 - 80GB Ultra High-IO - Driver 370.28)

| **3dmark (TimeSpy DX12)** | **3dmark (Frire Strike DX11)** | **Unigine Superposition  (OpenGL 1.1, 1080p medium)** | **Unigine Superposition  (Direct X, 1080p medium)** |                |               |                |       |       |
| :------------------------ | :----------------------------- | :---------------------------------------------------- | :-------------------------------------------------- | -------------- | ------------- | -------------- | ----- | ----- |
| Total Score               | Graphics Score                 | CPU Score                                             | Total Score                                         | Graphics Score | Physics Score | Combined Score | Score | Score |
| 673                       | 586                            | 4508                                                  | 8593                                                | 9375           | 12800         | 4057           | 1433  | 5470  |



| PassMark Performance Test(OpenCL/ CUDA not supported)        | SPECviewperf 13                                              |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| ![img](![g1_2xlarge_passmark.png](https://github.com/FlexibleEngineCloud/wiki-doc/blob/master/uploads/g1_2xlarge_passmark.png?raw=true) | ![img](https://github.com/FlexibleEngineCloud/wiki-doc/blob/master/uploads/g1_2xlarge_specviewperf.png?raw=true) |



### g1.4xlarge 16 vCPU 32 GB RAM 1/4 M60 4GB vRAM

#### (Windows 2016 - 80GB Ultra High-IO - Driver 370.28)

| **3dmark (TimeSpy DX12)** | **3dmark (Frire Strike DX11)** | **Unigine Superposition  (OpenGL 1.1, 1080p medium)** | **Unigine Superposition  (Direct X, 1080p medium)** |                |               |                |       |       |
| :------------------------ | :----------------------------- | :---------------------------------------------------- | :-------------------------------------------------- | -------------- | ------------- | -------------- | ----- | ----- |
| Total Score               | Graphics Score                 | CPU Score                                             | Total Score                                         | Graphics Score | Physics Score | Combined Score | Score | Score |
| 3582                      | 3252                           | 8429                                                  | 9975                                                | 11012          | 19379         | 4098           | 6822  | 7363  |



| PassMark Performance Test(OpenCL/ CUDA not supported)        | SPECviewperf 13                                              |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| ![img](https://github.com/FlexibleEngineCloud/wiki-doc/blob/master/uploads/g1_4xlarge_passmark.png?raw=true) | ![img](https://github.com/FlexibleEngineCloud/wiki-doc/blob/master/uploads/g1_4xlarge_specviewperf.png?raw=true) |



### g1.4xlarge 16 vCPU 32 GB RAM 1/4 M60 4GB vRAM

#### (Windows 10 - 500GB Ultra High-IO - Driver 370.28)

| **3dmark (TimeSpy DX12)** | **3dmark (Frire Strike DX11)** | **Unigine Superposition  (OpenGL 1.1, 1080p medium)** | **Unigine Superposition  (Direct X, 1080p medium)** |                |               |                |       |       |
| :------------------------ | :----------------------------- | :---------------------------------------------------- | :-------------------------------------------------- | -------------- | ------------- | -------------- | ----- | ----- |
| Total Score               | Graphics Score                 | CPU Score                                             | Total Score                                         | Graphics Score | Physics Score | Combined Score | Score | Score |
| 3622                      | 3297                           | 8216                                                  | 10113                                               | 11152          | 20745         | 4099           | 6944  | 7433  |



| PassMark Performance Test(OpenCL/ CUDA not supported)        | SPECviewperf 13                                              |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| ![img](https://github.com/FlexibleEngineCloud/wiki-doc/blob/master/uploads/g1_4xlarge_passmark_w10.png?raw=true) | ![img](https://github.com/FlexibleEngineCloud/wiki-doc/blob/master/uploads/g1_4xlarge_specviewperf_w10.png?raw=true) |


# Workspace Network
## General facts
### About "management network"

Management network is only used by management server to manage workspace desktop and also capture the audio / video / mouse & keyboard traffic in order to encapsule through the workspace manager to the end user (diagram to come)

In the creation process, take care to not overlap the management network with others subnet you'll use.

 
## Network Consumption
### What is the prerequisite of bandwidth for general desktop ?

- Average bandwidth: 300 kbps/ instance. Peak bandwidth: 5 Mbps/ instance.
- Packet loss rate ≤ 0.01%
- Round-trip delay ≤ 30 ms
- Network Jitter ≤ 10 ms(Floating in the range of ±10ms of average delay)

### What is the prerequisite of bandwidth for GPU Desktop ?

- Max bandwidth: 20 Mbps/ instance
- Packet loss rate ≤ 0.01%
- Round-trip delay ≤ 30 ms
- Network Jitter ≤ 10 ms(Floating in the range of ±10ms of average delay)
- These values are for reference only and may be more stringent depending on the application scenario.

 

### Do you have some example of bandwidth consumption for software ?

| **Scenario Type**                                 | **Scenario**               | **Bandwidth Reference Value** |
| ------------------------------------------------- | -------------------------- | ----------------------------- |
| **Silence**                                       | No application running     | 4 Kbit/s                      |
| Microsoft Office running without document editing | 20 Kbit/s                  |                               |
| **Office applications**                           | Word                       | 45 Kbit/s                     |
| PPT                                               | 589 Kbit/s                 |                               |
| **Video playback**                                | Standard definition (480p) | 6.85 Mbit/s                   |
| High definition (1080p)                           | 13.7 Mbit/s                |                               |
| **Other applications**                            | PDF                        | 265 Kbit/s                    |
| IE                                                | 150 Kbit/s                 |                               |
| Picture browsing                                  | 123 Kbit/s                 |                               |


# Workspace Security
### The traffic between Workspace and end users is secure ?

Yes, it uses TLS Encryption between servers and client. That why there is no security issue to use it through internet. (Figure 1)

### How to secure Workspace Network with the others ECS ?

In the creation form of the infrastructure, you can select the VPC and subnets you want to use. You also have a Workspace Security Group that you can manage to control the traffic between Workspace Desktop and other ECS 

 

 

 



![img](https://github.com/FlexibleEngineCloud/wiki-doc/blob/master/uploads/security%20diagram.png?raw=true)
