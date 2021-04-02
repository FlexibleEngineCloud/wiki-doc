---
title: Resiliency
description: What is HA and DRP on Flexible Engine
published: true
date: 2021-04-02T13:44:59.583Z
tags: 
editor: markdown
---



The resiliency remain in two most used terms : HA and DRP. They are often confused in IT, especially on Flexible Engine :

 
# Definitions on FE 
## High Availability 

HA will answer to a failure of the service by providing a second instance of the service to keep minimum interruption, in every case, HA has to be automatic and is better offered by the software. For some case, HA can also be offered by hardware or 3rd party solution, but consistency can be not warranted. No matter of the location of the second instance, HA is a generic term explaining that you service is fault tolerant to a specific failure case.

### High Availability category 
(Check architecture best practices to know more)
- Intra Availabilty Zone HA : HA in the same AZ of nominal (All services used in Flexible Engine are covered by HA in AZ)
- Inter Availability Zones HA : HA distributed to one or more different AZ from the nominal one, in the same region
- Multi Region HA : HA distributed to one or more different region from nominal


 

## Disaster Recovery Plan 

DRP will answer to a major failure of a service / provider (or when HA cannot cover this type of failure), it should cover a large spectrum of application and is not only focused on the technical part, in most cases customer want to trigger it manually, (as it have a huge impact on their application and need verification of the status of each application after). If customer want a very low interruption DRP (RTO/RPO near 0), it's called a BCP (Business Continuity Plan). The term DRP or BCP is finally a generic term used to speak about HA, but simply in different ways, in the common usage, most of people speak about HA for local HA and DRP for Regional HA. But in most of case, it is based on 3rd party solutions, with or without manual or automatic failover. As described before, HA permit very low interruption, a DRP is different and based on two factors :

**the Recovery Time Objective (RTO) and Recovery Point Objective (RPO) :**

- A Recovery Time Objective is the maximum amount of time that a system can be down before it is recovered to an operational state. For some systems, this recovery time objective can be measured in hours or even days, but for more mission-critical systems the recovery time objectives are typically measured in seconds.
- A Recovery Point Objective is the amount of data loss, measured in time, that is tolerable in a disaster. For some systems, losing a day’s worth of data might be acceptable while for other systems this might be mere minutes or seconds. The length of RTO’s and RPO’s have profound implications on how disaster recovery plans are implemented.

It can be as simple as backup and restore in other region or way more complex with hardware or software replication / HA solutions.

 

 

 

 

### Disaster Recovery Plan category
(Check in architecture best practice to know more):

- Multi AZ DRP : DRP between one or more different AZ of nominal, in the same region
- Multi Region DRP : DRP between one or more different region of nominal
- Multi Cloud : DRP between one or more different Cloud Provider of nominal
- On Premises to cloud : DRP between on-premises DC to Flexible Engine

 

## Conclusion 
High Availability is the technical part when DRP will allow a High Level view that help to define which HA solution to choose for each scenarios


# Resiliency on Flexible Engine Feature
This section cover the resiliency proposed or integrated in the feature. 
## Computing
### ECS
Intra AZ : Resiliency with multiple servers and automatic HA mechanism that recover the ECS on others hypervisor in the AZ if needed. A service interruption for OS rebooting (as it is a cold migration) can be observed. 
> You can create an anti affinity group then	add ECS in if you want to run these ECS on different hypervisor
{.is-info}

### BMS
There is no HA mechanism on BMS as it is a dedicated bare metal server. In case of failure, spare BMS will be provided (as BMS can contains local storage. Please make sure that you have a backup plan for this)

### CSBS
### CCE

### IMS
Inter AZ resiliency : HA in backend. Data are stored on OBS Storage
### Auto Scaling
Inter AZ Resilience : HA in backend
### Dedicated Cloud
Depend of the subscribed design
### Dedicated Host
Intra AZ : HA in backend. Handled like the ECS intra AZ resiliency

## Storage
### CBR
### DES
### EVS
Intra AZ : Data are distributed on 3 storage nodes
### Dedicated Storage Service
Depend of the subscribed design
### SDRS
Inter AZ resiliency
Goal of this feature is to replicated EVS data from 1 AZ to other one

### VBS
Inter AZ resiliency
### OBS
2 class of object storage : 
- Mono AZ : Inter AZ HA - Data are distributed over 3 nodes in the same AZ
- Multi AZ : Intra AZ HA - Data are distributed over 3 AZ

Capable of inter region resiliency with cross region OBS replication feature
### SFS 
#### SFS Classic
Intra AZ resiliency : Data a distributed over 3 nodes in the same AZ
#### SFS Turbo
Intra AZ resiliency : Data a distributed over 3 nodes in the same AZ
Inter AZ resiliency in roadmap
### FAB
Inter AZ resiliency for frontend
Data are stored on Mono AZ object storage (Multi AZ Storage is in roadmap). Capable on Inter Region resiliency with cross region OBS replication feature
## Network
### VPC
Inter AZ resiliency and subnet extended on all AZ of the region
### ELB
Inter AZ resiliency 
### Direct Connect
Direct connect port are sold with 2 ports on differents AZ
### DNS
### NAT Gateway
Inter AZ resiliency
### VPC Endpoint
Inter AZ resiliency

## Security
### Anti-DDoS
### KMS
Inter AZ resiliency
### WAF
Inter AZ resiliency

## Management & Deployment
### CTS
Inter AZ resiliency
### Cloud Eye
### IAM
### RTS
### LTS
### TMS

## Application
### SWR for Container
### Service Stage
### DCS
### DMS for Kafka
### SMN
### API Gateway
Inter AZ resiliency

## Database 
### RDS
Service include inter AZ resiliency
For databases instances, two modes are available for customers : 
- Standalone. One instance on 1 AZ
- Master/ Standby. 2 instance with master / standby architecture. Can be distributed or not on 2 AZ
### DDS
### DRS

## Migration
### SMS

## Data Analysis
### ModelArts
### CS
### MRS
### DWS
### DLI
### CSS
### DIS
### MLS
### DPS
## Enterprise Application
