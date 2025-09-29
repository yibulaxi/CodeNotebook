# mount 挂载 文件系统
# mount [选项] <设备> <挂载点>
# 设备：要挂载的分区或设备，比如 /dev/sda1、/dev/cdrom。
# 挂载点：本地目录，必须已经存在，比如 /mnt 或 /media/usb。

# 挂载本地磁盘分区
sudo mount /dev/sda1 /mnt
# 把 /dev/sda1 分区挂载到 /mnt 目录。
# 挂载后 /mnt 就显示该分区的内容。

# 挂载 U 盘（假设是 /dev/sdb1）
sudo mount -t vfat /dev/sdb1 /media/usb
# -t vfat 指定文件系统类型（FAT32）。
# 如果不清楚类型，可以用 blkid 或 lsblk -f 查看。

# 挂载 ISO 镜像
sudo mount -o loop image.iso /mnt/iso
# -o loop 表示用 loop 设备，把 ISO 文件当成块设备来挂载。

# 挂载网络文件系统（NFS）
sudo mount -t nfs 192.168.1.100:/share /mnt/nfs
# 把远程服务器的 /share 挂载到本地 /mnt/nfs。

# 挂载 CIFS（Windows 共享）
sudo mount -t cifs //192.168.1.200/share /mnt/cifs -o username=user,password=pass

# 常用选项
# -t <类型>：指定文件系统类型（如 ext4、vfat、ntfs、nfs、cifs 等）。
# -o <选项>：挂载参数，如：
#     ro（只读）
#     rw（读写）
#     loop（挂载文件镜像）
#     uid/gid（指定用户/组 ID）
#     defaults（默认选项：rw, suid, dev, exec, auto, nouser, async）

# 查看已挂载的文件系统
mount
# 或者
findmnt
# 或者
cat /proc/mounts

# 卸载挂载
sudo umount /mnt
# 注意是 umount 而不是 unmount。
