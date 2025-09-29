# 安装中文输入法RIME
sudo pacman -S --needed fcitx5 fcitx5-rime fcitx5-gtk fcitx5-qt fcitx5-configtool
# 如果你更习惯 ibus 而不是 fcitx5 :
sudo pacman -S --needed ibus-rime

# 编辑 ~/.pam_environment 或 ~/.xprofile，加入：
GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx

# 如果你用 Wayland（如 KDE Plasma 6、GNOME Wayland），还可以在 ~/.config/environment.d/input.conf 中写：
GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx
INPUT_METHOD=fcitx

# 启动输入法守护进程, 把 fcitx5 添加到启动项：
systemctl --user enable --now fcitx5
# 或者直接在 DE 的自动启动里加上 fcitx5.

# 启用 RIME 中州韵输入法
fcitx5-configtool

# RIME 的配置文件在
cd ~/.local/share/fcitx5/rime
# 如果你用的是 ibus-rime，配置目录在：
cd ~/.config/ibus/rime
# 如果要修改方案，比如切换到 朙月拼音 (luna pinyin)、双拼、五笔，可以在 default.custom.yaml 里改。改完后，重新部署：
fcitx5-rime
# 然后按 Ctrl+` (默认热键) 选择方案

# 想要更多 RIME 词库，可以用 AUR 包：
yay -S rime-ice

# 如果使用 startx 启动，编辑 ~/.xinitrc ，内容：
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export INPUT_METHOD=fcitx
fcitx5 &  # 也可以 GUI 启动项中设置，就不用写这个
exec startxfce4