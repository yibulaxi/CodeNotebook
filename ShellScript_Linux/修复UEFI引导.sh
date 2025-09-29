# 修复UEFI引导

# 确认 ESP 分区大小与类型
# 推荐大小：300–500 MB
# 分区类型：
# 在 gdisk 中应设置为 EF00 (EFI System Partition)
# 在 parted 中应设置为 EFI System Partition

# 格式化为 FAT32
mkfs.fat -F32 /dev/sda1

# 挂载 ESP 到正确位置
mount /dev/sda1 /boot/efi

# 重新安装引导程序
# 如果用 GRUB：
pacman -S grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
# 如果用 systemd-boot：
bootctl --path=/boot install

# 检查 EFI 启动项
efibootmgr -v
# 应该能看到类似：
# Boot0001* GRUB HD(1,GPT,xxxx)/File(\EFI\GRUB\grubx64.efi)
# 如果没有，可以手动添加：
efibootmgr --create --disk /dev/sda --part 1 --label "Arch Linux" --loader '\EFI\GRUB\grubx64.efi'


# 从安装光盘修复

# 确认分区
lsblk -f
# 假设：
# 根分区 /dev/sda2 （ext4/btrfs）
# EFI 分区 /dev/sda1 （vfat）

# 挂载根分区和 EFI
mount /dev/sda2 /mnt
mount /dev/sda1 /mnt/boot/efi
# 如果你有 /boot 单独分区，先挂载它，再挂载 ESP 到 /mnt/boot/efi。

# 挂载必要的系统目录
mount --bind /dev /mnt/dev
mount --bind /proc /mnt/proc
mount --bind /sys /mnt/sys

# 进入系统
arch-chroot /mnt

# 重新安装引导程序
# 检查 EFI 启动项

# 退出并重启
umount -R /mnt
reboot
