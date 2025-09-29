# 在安装介质挂载chroot环境
# 如果需要先：批量解锁LUKS.sh
# 解锁后：
mount /dev/mapper/sdc1 /mnt
mkdir -p /mnt/{boot,home,var,tmp,usr,opt,srv}

mount /dev/sda2 /mnt/boot
mkdir -p /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi

mount /dev/mapper/sdd1 /mnt/home
mount /dev/mapper/sde1 /mnt/var
mount /dev/mapper/sdf1 /mnt/tmp
mount /dev/mapper/sdg1 /mnt/usr # 安装 Arch 的话，不要把 usr 单分出去！！
mount /dev/mapper/sdh1 /mnt/opt
mount /dev/mapper/sdi1 /mnt/srv

# 准备 chroot 环境
mount --types proc /proc /mnt/proc
mount --rbind /sys /mnt/sys
mount --make-rslave /mnt/sys
mount --rbind /dev /mnt/dev
mount --make-rslave /mnt/dev
mount --bind /run /mnt/run
mount --make-slave /mnt/run

# 进入系统
arch-chroot /mnt
