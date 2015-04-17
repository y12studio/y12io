Thu Apr 16 22:08:58 EDT 2015
============================



[How To Run WordPress on a DigitalOcean 512MB VPS - RyanFrankel.com](http://ryanfrankel.com/run-wordpress-digital-ocean-512mb-vps/)

```
# adduser your-new-user-name
# adduser your-new-user-name sudo
# adduser your-new-user-name www-data
# su - your-new-user-name
```



[How To Add Swap on Ubuntu 12.04 | DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-add-swap-on-ubuntu-12-04)
```
$ df -h
Filesystem      Size  Used Avail Use% Mounted on
/dev/vda1        20G  2.2G   17G  12% /
none            4.0K     0  4.0K   0% /sys/fs/cgroup
udev            235M  4.0K  235M   1% /dev
tmpfs            50M  316K   49M   1% /run
none            5.0M     0  5.0M   0% /run/lock
none            246M     0  246M   0% /run/shm
none            100M     0  100M   0% /run/user

$ sudo dd if=/dev/zero of=/swapfile bs=1024 count=256k
262144+0 records in
262144+0 records out
268435456 bytes (268 MB) copied, 0.782114 s, 343 MB/s

$ sudo mkswap /swapfile
Setting up swapspace version 1, size = 262140 KiB
no label, UUID=69ffde4e-249a-453a-8401-ae53ed627e92

$ sudo swapon /swapfile

$ sudo swapon -s
Filename                                Type            Size    Used    Priority
/swapfile                               file            262140  8       -1

$ cat /etc/fstab
# /etc/fstab: static file system information.
#
# Use 'blkid' to print the universally unique identifier for a
# device; this may be used with UUID= as a more robust way to name devices
# that works even if disks are added and removed. See fstab(5).
#
# <file system> <mount point>   <type>  <options>       <dump>  <pass>
# / was on /dev/vda1 during installation
UUID=050e1e34-39e6-4072-a03e-ae0bf90ba13a /               ext4    errors=remount-ro 0       1
/swapfile       none    swap    sw      0       0

$ echo 10 | sudo tee /proc/sys/vm/swappiness
$ echo vm.swappiness = 10 | sudo tee -a /etc/sysctl.conf
$ sudo chown root:root /swapfile
$ sudo chmod 0600 /swapfile
```

reboot test

```
# apt-get update && apt-get upgrade
# reboot

# swapon -s
Filename                                Type            Size    Used    Priority
/swapfile                               file            262140  0       -1

```
