# 禁止黑屏和待机

# 把这些命令写到 ~/.xinitrc 或桌面环境的 自动启动脚本里，例如：
# ~/.xprofile 或 ~/.xsessionrc
xset s off
xset -dpms
xset s noblank

# GNOME / KDE 等桌面环境：
# 桌面环境有独立的电源管理，需关闭：
# GNOME: 
gnome-control-center power
# KDE: 
# System Settings → Power Management

# 在命令行 (TTY) 环境下
nano /etc/default/grub
# 在 GRUB_CMDLINE_LINUX_DEFAULT 中加入： consoleblank=0
update-grub   # Debian/Ubuntu
grub2-mkconfig -o /boot/grub2/grub.cfg   # RHEL/Fedora
grub-mkconfig -o /boot/grub/grub.cfg   # Arch


# 待机/休眠:

# 使用 systemd-mask 禁止：
systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target
# 恢复
systemctl unmask sleep.target suspend.target hibernate.target hybrid-sleep.target

# 桌面电源管理设置：如果在 GNOME/KDE 下，还要单独禁用自动待机。
