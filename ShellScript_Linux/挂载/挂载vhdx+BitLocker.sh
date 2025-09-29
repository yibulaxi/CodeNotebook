# 挂载 vhdx + BitLocker
apt install qemu-utils libguestfs-tools
apt install dislocker
apt install ntfs-3g  # NTFS

# 加载内核模块（如果没有 /dev/nbd0 ）
modprobe nbd max_part=8
# `max_part=8` 表示每个 NBD 设备最多支持 8 个分区。
ls /dev/nbd*

# 把 VHDX 映像挂载为块设备
qemu-nbd --connect=/dev/nbd0 data.vhdx

# 查看虚拟硬盘中的分区
lsblk /dev/nbd0

# 解锁 BitLocker 分区
mkdir -p /mnt/bitlocker
dislocker -V /dev/nbd0p2 -u -- /mnt/bitlocker
# 如果是用48位恢复密码：
sudo dislocker -V /dev/nbd0p1 -pYOUR-RECOVERY-KEY -- /mnt/bitlocker

# 挂载 exFAT 文件系统
mkdir -p /mnt/exfat
mount -o loop /mnt/bitlocker/dislocker-file /mnt/exfat
df -h | grep exfat
# 挂载 NTFS 文件系统
mkdir -p /mnt/ntfs
mount -t ntfs-3g -o loop /mnt/bitlocker/dislocker-file /mnt/ntfs
df -h | grep ntfs
# loop 改成 loop,ro 是只读挂载

# 卸载
umount /mnt/exfat
pkill dislocker
rm -rf /mnt/bitlocker/*
qemu-nbd --disconnect /dev/nbd0
