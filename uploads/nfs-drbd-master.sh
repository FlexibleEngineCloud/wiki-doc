#cloud-config
#!/bin/bash 

### Data Disk configuration (/dev/vdb can change)
sudo fdisk /dev/vdb <<EOF
n
p



w
EOF

### Install packages  
sudo apt-get update &&-o Dpkg::Options::="--force-confdef" --assume-yes install  drbd-utils && nfs-kernel-server && heartbeat


### Enable DRBD
sudo modprobe drbd
sudo cat /etc/drbd.d/drbd0.res
sudo tee -a drbd0.res > /etc/drbd.d/drbd0.res <<EOT
resource r0 {

startup {
              wfc-timeout 30;
              degr-wfc-timeout 15;
    }

disk {
    on-io-error   detach;
}
syncer {
rate 320M;
}

    on ecs-nfs-maitre {
            device /dev/drbd0;
            disk /dev/vdb;
            address 192.168.0.50:7788;
            meta-disk internal;
    }
    on ecs-nfs-esclave {
            device /dev/drbd0;
            disk /dev/vdb;
            address 192.168.0.51:7788;
            meta-disk internal;
    }
}
EOT

### enable DRBD configuration
sudo drbdadm create-md r0
sudo drbdadm up r0

### Heartbeat configuration 
sudo cat /etc/ha.d/ha.cf
sudo tee -a ha.cf > /etc/ha.d/ha.cf <<EOT
mcast eth0 239.0.0.10 694 1 0
 
warntime 4
deadtime 5
initdead 15
keepalive 2
 
#Auto failback when master node goes online again
auto_failback on
 
#Name of clusters node
node ecs-nfs-maitre
node ecs-nfs-slave
EOT

### Authkey creation (generate a password)
sudo cat /etc/ha.d/authkey
sudo tee -a authkey > /etc/ha.d/authkey <<EOT
auth 3
3 md5 Pa$$word_of_your_choice
EOT

sudo chmod 600 /etc/ha.d/authkey/

### Sleep for 10m only for ECS Master, mark as comment for the slave
read -r -p "Wait 5 Minutes or press any key to continue immediately" -t 300 -n 1 -s

### DRBD start for master instance
drbdadm -- --overwrite-data-of-peer primary r0

### DRBD start for slave instance
#drbdadm secondary r0

### waiting for ending of initial sync
read -r -p "Wait 10 Minutes or press any key to continue immediately" -t 500 -n 1 -s

### Only on the master node
sudo mkfs.ext4 /dev/drbd0 <<EOF
y

EOF

### Create the data folder and configure nfs folder
sudo mkdir /data-nfs

sudo tee -a exports > /etc/exports <<EOT
/data-nfs 0.0.0.0/0(rw,sync,fsid=0,no_root_squash,no_subtree_check)
EOT


### heartbeat VIP and mounting point (don't forget to create VIP in FE also
sudo cat /etc/ha.d/haresources
sudo tee -a haresources > /etc/ha.d/haresources <<EOT
ecs-nfs-maitre IPaddr::10.1.0.30/24/eth0 drbddisk::r0 Filesystem::/dev/drbd0::/data-nfs::ext4 nfs-kernel-server
EOT

### disable auto launch of NFS 
sudo systemctl disable nfs-kernel-server

###Start Heartbeat
sudo /etc/init.d/heartbeat start