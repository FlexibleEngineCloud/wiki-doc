---
title: Block Storage
description: 
published: true
date: 2021-01-22T15:25:20.216Z
tags: 
editor: markdown
---

# Q&A
## How to find the mapping between EVS disk  and disk in Microsoft Windows
This section describe how to find a common identifier between an EVS disk and the disk mounted Microsoft Windows.


### On the Flexible Engine console 
Find the identifier in the console :
- Go in the **Elastic Cloud Server** feature
- Click on the targeted instance
- In the **disks** tab, select the targeted disk, then remind the **BDF** identifier as shown below
![bdf.png](/uploads/bdf.png)


### On the Microsoft Windows OS
Find the disk number in the OS : 
- Right on the **"Windows"** start button then click on **Disk management**
- Select the targeted disk and remain the number assigned as shown below 
![disknumber.png](/uploads/disknumber.png)

Find the the **BDF** identifier :
- Right on the **"Windows"** start button then click on **"run"** and type **"powershell"**
- Then copy this command : `get-disk -Number 1 | fl * | findstr UniqueId`
> Where the -Number 1 indicate that you select the disk 1. Don't forget to match with the targeted disk
{.is-warning}
- The command will return you a `UniqueID` in the format **`0000000X0000000X`** where X represent the numbers different from 0 in the **BDF** identifier in the console
- Check if the disk UniqueID match with the **BDF** number in the console
> For example with the **BDF** number showed in the console screenshot above :
We have the following **BDF** :` 0000:02:02.0 `
In the Microsoft Windows OS, the powershell command returned this `UniqueID` : **`0000000200000002`**
So it match perfectly as we found the 2 sames values

{.is-info}


