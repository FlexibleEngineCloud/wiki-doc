---
title: Security
description: Security related additionnal documentation
published: true
date: 2020-06-04T15:56:45.826Z
tags: 
editor: undefined
---

# Anti-DDoS on Flexible Engine
## Default Anti-DDoS Solution
By default on Flexible Engine, all customers ressources and platform are protected. 
Regarding customers ressources, in case of an attack, traffic to their EIP can be blackholed in order to protect the whole platform.
This solution is included for every customers

### Case of an attack targeting the platform

![](https://github.com/FlexibleEngineCloud/wiki-doc/blob/master/uploads/antiddos-solution-on-fe-Default%20Antiddos%20Platform.png?raw=true)


### Case of an attack targeting customer EIP
![](https://github.com/FlexibleEngineCloud/wiki-doc/blob/master/uploads/antiddos-solution-on-fe-Default%20Antiddos%20EIP.png?raw=true)

## Self Service Anti-DDoS Solution 
Available directly from console, you can enable and configure the feature. After that, automatic remedation will be operated but it can handle only low or mid size attack (few Gbps). If the attack is upper this limit, the default Anti-DDoS Solution will be applied.
More documentation [here](https://docs.prod-cloud-ocb.orange-business.com/en-us/antiddos/index.html)
This solution is provided for free for every customers

### Case of an attack targeting customer EIP and protected by Self Service Anti-DDoS solution

![antiddos-solution-on-fe-Self Service Antiddos.png](https://github.com/FlexibleEngineCloud/wiki-doc/blob/master/uploads/antiddos-solution-on-fe-Self%20Service%20Antiddos.png?raw=true)

## Orange DDoS Protection Cleanpipe Anti-DDoS Solution 
Based on a additionnal Orange offer, named DDoS Protection Cleanpipe. It offer a fully managed advanced anti-DDoS solution to let you protect your ressources. 
The solution is fully managed by Orange Cyberdefense expertise in this domain. You just indicate the threshold for protection and (optionnal) the remedation policy.
Automatic remediation will be applied in case of attack and it can cover every size of attack which avoid to being blackholed by the default anti-DDoS solution.
More documentation [here](https://www.orange-business.com/en/products/ddos-protection)
This solution has to be subscribed as a 3rd party solution

### Case of an attack targeting customer EIP and protected by Orange DDoS Protection Cleanpipe
![antiddos-solution-on-fe-OCD Cleanpipe Antiddos.png](https://github.com/FlexibleEngineCloud/wiki-doc/blob/master/uploads/antiddos-solution-on-fe-OCD%20Cleanpipe%20Antiddos.png?raw=true)