# 常用GUI软件

# RIME输入法
sudo pacman -S fcitx5 fcitx5-rime fcitx5-configtool fcitx5-gtk fcitx5-qt

# GNOME 磁盘管理工具
sudo pacman -S gnome-disk-utility

# AUR 助手 yay
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# 谷歌浏览器
yay -S google-chrome

# 防火墙配置软件
sudo pacman -S firewalld
sudo systemctl enable --now firewalld
firewall-config

# Telegram
sudo pacman -S telegram-desktop pipewire-jack

# VSCode
yay -S visual-studio-code-bin
yay -S vscodium-bin

# Docker
sudo pacman -S docker
sudo systemctl enable --now docker
sudo usermod -aG docker $USER
sudo pacman -S docker-compose

# 播放
sudo pacman -S ffmpeg mpv vlc

# 图形编辑
sudo pacman -S imagemagick gimp inkscape
