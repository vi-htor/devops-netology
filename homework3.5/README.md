# Answers to questions

1. Done. Интересное решение.
2. Нет, так как hardlink это ссылка на тот же самый файл и имеет тот же inode, соответственно и права будут одни и те же.
3. Done:
   ```
   root@vagrant:~# lsblk
   NAME                      MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
   loop0                       7:0    0 67.2M  1 loop /snap/lxd/21835
   loop1                       7:1    0 43.6M  1 loop /snap/snapd/14978
   loop2                       7:2    0 61.9M  1 loop /snap/core20/1328
   sda                         8:0    0   64G  0 disk
   ├─sda1                      8:1    0    1M  0 part
   ├─sda2                      8:2    0  1.5G  0 part /boot
   └─sda3                      8:3    0 62.5G  0 part
     └─ubuntu--vg-ubuntu--lv 253:0    0 31.3G  0 lvm  /
   sdb                         8:16   0  2.5G  0 disk
   sdc                         8:32   0  2.5G  0 disk
   ```
4. Done:
   ```
   sdb                         8:16   0  2.5G  0 disk
   ├─sdb1                      8:17   0    2G  0 part
   └─sdb2                      8:18   0  559M  0 part
   ```
5. Done:
   ```
   root@vagrant:~# sfdisk -d /dev/sdb|sfdisk /dev/sdc
   Checking that no-one is using this disk right now ... OK
   <...>
   New situation:
   Disklabel type: dos
   Disk identifier: 0x18c32730

   Device     Boot   Start     End Sectors  Size Id Type
   /dev/sdc1          2048 4098047 4096000    2G 83 Linux
   /dev/sdc2       4098048 5242879 1144832  559M 83 Linux
   root@vagrant:~# lsblk
   <...>
   sdb                         8:16   0  2.5G  0 disk
   ├─sdb1                      8:17   0    2G  0 part
   └─sdb2                      8:18   0  559M  0 part
   sdc                         8:32   0  2.5G  0 disk
   ├─sdc1                      8:33   0    2G  0 part
   └─sdc2                      8:34   0  559M  0 part
   ```
6. `root@vagrant:~# mdadm --create --verbose /dev/md0 -l 1 -n 2 /dev/sd{b1,c1}`
7. `root@vagrant:~# mdadm --create --verbose /dev/md1 -l 0 -n 2 /dev/sd{b2,c2}`
   done:
   ```
   sdb                         8:16   0  2.5G  0 disk
   ├─sdb1                      8:17   0    2G  0 part
   │ └─md0                     9:0    0    2G  0 raid1
   └─sdb2                      8:18   0  559M  0 part
     └─md1                     9:1    0  1.1G  0 raid0
   sdc                         8:32   0  2.5G  0 disk
   ├─sdc1                      8:33   0    2G  0 part
   │ └─md0                     9:0    0    2G  0 raid1
   └─sdc2                      8:34   0  559M  0 part
     └─md1                     9:1    0  1.1G  0 raid0
   ```
8. `root@vagrant:~# pvcreate /dev/md0 /dev/md1`
9. `root@vagrant:~# vgcreate vg1 /dev/md0 /dev/md1`
10. `root@vagrant:~# lvcreate -L 100M vg1 /dev/md1`
11. `root@vagrant:~# mkfs.ext4 /dev/vg1/lvol0`
12. `root@vagrant:~# mkdir /tmp/new && mount /dev/vg1/lvol0 /tmp/new`
13. Done: `root@vagrant:~# wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz`
14. lsblk:
    ```
    root@vagrant:~# lsblk
   NAME                      MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
   loop0                       7:0    0 67.2M  1 loop  /snap/lxd/21835
   loop1                       7:1    0 43.6M  1 loop  /snap/snapd/14978
   loop2                       7:2    0 61.9M  1 loop  /snap/core20/1328
   loop3                       7:3    0 61.9M  1 loop  /snap/core20/1518
   loop4                       7:4    0   47M  1 loop  /snap/snapd/16010
   loop5                       7:5    0 67.8M  1 loop  /snap/lxd/22753
   sda                         8:0    0   64G  0 disk
   ├─sda1                      8:1    0    1M  0 part
   ├─sda2                      8:2    0  1.5G  0 part  /boot
   └─sda3                      8:3    0 62.5G  0 part
     └─ubuntu--vg-ubuntu--lv 253:0    0 31.3G  0 lvm   /
   sdb                         8:16   0  2.5G  0 disk
   ├─sdb1                      8:17   0    2G  0 part
   │ └─md0                     9:0    0    2G  0 raid1
   └─sdb2                      8:18   0  559M  0 part
     └─md1                     9:1    0  1.1G  0 raid0
       └─vg1-lvol0           253:1    0  100M  0 lvm   /tmp/new
   sdc                         8:32   0  2.5G  0 disk
   ├─sdc1                      8:33   0    2G  0 part
   │ └─md0                     9:0    0    2G  0 raid1
   └─sdc2                      8:34   0  559M  0 part
     └─md1                     9:1    0  1.1G  0 raid0
       └─vg1-lvol0           253:1    0  100M  0 lvm   /tmp/new
   ```
15. Done:
   ```
   root@vagrant:~# gzip -t /tmp/new/test.gz && echo $?
   0
   ```
16. Done:
   ```
   root@vagrant:~# pvmove /dev/md1
   /dev/md1: Moved: 20.00%
   /dev/md1: Moved: 100.00%
   root@vagrant:~# lsblk
   NAME                      MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
   <...>
   sdb                         8:16   0  2.5G  0 disk
   ├─sdb1                      8:17   0    2G  0 part
   │ └─md0                     9:0    0    2G  0 raid1
   │   └─vg1-lvol0           253:1    0  100M  0 lvm   /tmp/new
   └─sdb2                      8:18   0  559M  0 part
     └─md1                     9:1    0  1.1G  0 raid0
   sdc                         8:32   0  2.5G  0 disk
   ├─sdc1                      8:33   0    2G  0 part
   │ └─md0                     9:0    0    2G  0 raid1
   │   └─vg1-lvol0           253:1    0  100M  0 lvm   /tmp/new
   └─sdc2                      8:34   0  559M  0 part
     └─md1                     9:1    0  1.1G  0 raid0
   ```
17. `root@vagrant:~# mdadm /dev/md0 --fail /dev/sdc1`
18. Done:
   ```
   root@vagrant:~# dmesg | grep md0
   [ 1988.396148] md/raid1:md0: not clean -- starting background reconstruction
   [ 1988.396149] md/raid1:md0: active with 2 out of 2 mirrors
   [ 1988.396164] md0: detected capacity change from 0 to 2095054848
   [ 1988.397178] md: resync of RAID array md0
   [ 1998.488857] md: md0: resync done.
   [ 6976.753722] md/raid1:md0: Disk failure on sdc1, disabling device.
                  md/raid1:md0: Operation continuing on 1 devices.
   ```
19.  Done:
   ```
   root@vagrant:~# gzip -t /tmp/new/test.gz && echo $?
   0
   ```
20. Done.