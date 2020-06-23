---
title: High Availability (HA) and Disaster Recovery Plan (DRP) on FE :
description: What is HA and DRP on Flexible Engine
published: true
date: 2020-06-23T08:41:39.567Z
tags: 
---



HA and DRP are often confused in IT, especially on Flexible Engine :

 

# High Availability 

HA will answer to a failure of the service by providing a second instance of the service to keep minimum interruption, in every case, HA has to be automatic and is better offered by the software. For some case, HA can also be offered by hardware or 3rd party solution, but consistency can be not warranted. No matter of the location of the second instance, HA is a generic term explaining that you service is fault tolerant to a specific failure case.

## High Availability category 
(Check architecture best practices to know more)
- Intra Availabilty Zone HA : HA in the same AZ of nominal (All services used in Flexible Engine are covered by HA in AZ)
- Inter Availability Zones HA : HA distributed to one or more different AZ from the nominal one, in the same region
- Multi Region HA : HA distributed to one or more different region from nominal

 

 

# Disaster Recovery Plan 

DRP will answer to a major failure of a service / provider (or when HA cannot cover this type of failure), it should cover a large spectrum of application and is not only focused on the technical part, in most cases customer want to trigger it manually, (as it have a huge impact on their application and need verification of the status of each application after). If customer want a very low interruption DRP (RTO/RPO near 0), it's called a BCP (Business Continuity Plan). The term DRP or BCP is finally a generic term used to speak about HA, but simply in different ways, in the common usage, most of people speak about HA for local HA and DRP for Regional HA. But in most of case, it is based on 3rd party solutions, with or without manual or automatic failover. As described before, HA permit very low interruption, a DRP is different and based on two factors :

**the Recovery Time Objective (RTO) and Recovery Point Objective (RPO) :**

- A Recovery Time Objective is the maximum amount of time that a system can be down before it is recovered to an operational state. For some systems, this recovery time objective can be measured in hours or even days, but for more mission-critical systems the recovery time objectives are typically measured in seconds.
- A Recovery Point Objective is the amount of data loss, measured in time, that is tolerable in a disaster. For some systems, losing a day’s worth of data might be acceptable while for other systems this might be mere minutes or seconds. The length of RTO’s and RPO’s have profound implications on how disaster recovery plans are implemented.

It can be as simple as backup and restore in other region or way more complex with hardware or software replication / HA solutions.

 

 

 

 

## Disaster Recovery Plan category
(Check in architecture best practice to know more):

- Multi AZ DRP : DRP between one or more different AZ of nominal, in the same region
- Multi Region DRP : DRP between one or more different region of nominal
- Multi Cloud : DRP between one or more different Cloud Provider of nominal
- On Premises to cloud : DRP between on-premises DC to Flexible Engine

 

# Conclusion 
High Availability is the technical part when DRP will allow a High Level view that help to define which HA solution to choose for each scenarios
