## How to interconnect my on premise AD ?

There is 3 recommended solutions :

- Use an IPSEC VPN to interconnect your on premise AD and Workspace (you can use our VPNaaS feature)
- Use a FE Direct Connect (with MPLS VPN or other)
- Create a AD replica in Flexible Engine and replicate the content with from your on premise AD. This solution requires also of the two others solutions, but can be great to reduce external network consumption.

## Multi domain integration

For today (03/2020), multi domain integration is not supported.

Workaround is to use one project per sub domain

## What about rights needed for the workspace admin ?

Everything is specified in the workspace documentation, but here is a reminder of the account right in case an issue for deleting computers in AD when desktop is deleted (most common) is encountered

![img](https://github.com/FlexibleEngineCloud/wiki-doc/blob/master/uploads/workspace-admin-rigths.png?raw=true)



## Why time/date in the master image is very important ?

If the time is wrong, you can encounter an issue when you'll deploy a wrong timed images. This will cause a AD join failure.

## Where are my users ?

You users are not shown in the workspace console, only users with dedicated desktop created will be shown in the users tabs on Workspace Console (a copy of the users informations which have already a desktop is done on the worskpace infrastructure to permit login in case of AD Failure)



## I want to put my computers in a specific OU ?

You can put the desktop you will create in the OU of your choice, just enter the path to the OU in the case below in the desktop creation form :

## I deployed my computer in the wrong OU, can I have move it

Sure, you can move the desktop, then think to reboot it in case you have specific GPO (Group Policy Object) on this new OU.

![img](https://github.com/FlexibleEngineCloud/wiki-doc/blob/master/uploads/ou-users.png?raw=true)

## How are named my desktop ?

In the desktop creation process from Workspace console, name of desktop will take the name of users or group (if it is Desktop Pool) with a number, (exemple : tony01, it-group01)

The name can be choose with using API to create desktop
