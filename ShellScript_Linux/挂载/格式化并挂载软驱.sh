# 格式化并挂载软驱

# 检查软驱是否可用
lsblk /dev/fd0
dmesg | grep fd0
# 如果没有输出，先加载模块：
modprobe floppy

# 为软盘创建分区表和分区
fdisk /dev/fd0
# 在交互界面里：
# 输入 o → 创建新的 DOS 分区表。
# 输入 n → 创建新分区（通常 1 个主分区即可）。
# 输入 w → 写入并退出。
# 完成后会有 /dev/fd0p1（某些发行版可能是 /dev/fd0 直接用，无分区）。
ls /dev/fd0 /dev/fd0p1

# 格式化分区 FAT12 文件系统
mkfs.vfat -F 12 /dev/fd0

# 挂载软盘
mkdir -p /mnt/floppy
mount /dev/fd0 /mnt/floppy

# 检查
df -h | grep fd0
ls /mnt/floppy

# 卸载软盘
umount /mnt/floppy
