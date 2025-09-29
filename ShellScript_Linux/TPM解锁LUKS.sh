# TPM解锁LUKS  Arch GRUB

# 检查 TPM 模块是否可用
ls /dev/tpm*
# 如果有 /dev/tpm0 或 /dev/tpmrm0，说明 TPM 模块可用。
pacman -Syu tpm2-tools systemd
tpm2_getrandom 8
# 能返回随机乱码就没问题。

# 列出挂载
lsblk
# 确认 systemd 版本和 LUKS 卷
cryptsetup luksDump /dev/sdd1 | grep "Version"
# 返回2正确，返回1去升级

# 开始将 TPM 添加到加密分区
systemd-cryptenroll --tpm2-device=auto /dev/sdd1
systemd-cryptenroll --tpm2-device=auto /dev/sde1
systemd-cryptenroll --tpm2-device=auto /dev/sdf1
systemd-cryptenroll --tpm2-device=auto /dev/sdg1
systemd-cryptenroll --tpm2-device=auto /dev/sdh1
# ...


# 配置 /etc/crypttab 让 systemd 自动用 TPM 解锁

# /etc/crypttab 原来大致是：
# home  UUID=xxxx-xxxx  none  luks
# var   UUID=xxxx-xxxx  none  luks

# 改成指定 tpm2-device：
# home  UUID=xxxx-xxxx  -  luks,tpm2-device=auto
# var   UUID=xxxx-xxxx  -  luks,tpm2-device=auto

# 别把 /root 写进来。root 分区不写在 /etc/crypttab，因为它在 initramfs 阶段解锁，由 mkinitcpio 或 dracut 管理。


# 更新 initramfs （如果用 mkinitcpio）

# 编辑 /etc/mkinitcpio.conf，确保 HOOKS 里有 systemd 和 sd-encrypt（不要用旧的 encrypt hook）。
# udev -> systemd
# encrypt -> sd-encrypt
HOOKS=(base systemd autodetect modconf block sd-encrypt filesystems keyboard fsck)

# 查 /root 的 UUID
lsblk -f
lsblk -f /dev/sdd1
# NAME       FSTYPE     FSVER LABEL UUID        FSAVAIL FSUSE% MOUNTPOINTS
# sdd1       crypto_LUK 2           xxxx-xxxx                
# └─cryptroot
#            ext4       1.0         yyyy-yyyy   10.7G    40% /
# 内核启动参数（rd.luks.name=…）必须用 上面那个 xxxx-xxxx
# /etc/fstab 中的参数（UUID=yyyy / ext4）写的是解密之后的文件系统 UUID，也就是 下面那个 yyyy-yyyy

# 更新 GRUB 启动参数, 在 /etc/default/grub 里找到 GRUB_CMDLINE_LINUX
# 把原来的 cryptdevice=UUID=<UUID>:root
GRUB_CMDLINE_LINUX="rd.luks.name=<LUKS-UUID>=cryptroot root=/dev/mapper/cryptroot rd.luks.options=tpm2-device=auto"

# 更新 grub
grub-mkconfig -o /boot/grub/grub.cfg
# 完成重建
mkinitcpio -P
