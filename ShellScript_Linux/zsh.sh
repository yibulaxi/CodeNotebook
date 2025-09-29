# 查看当前环境shell
echo $SHELL
# 查看系统自带哪些shell
cat /etc/shells

# 安装zsh
yum install zsh # CentOS
brew install zsh # mac安装（已自带）

# 将zsh设置为默认shell
chsh -s /bin/zsh

# Mac 如下
# 在 /etc/shells 文件中加入如下一行
/usr/local/bin/zsh
# 接着运行
chsh -s /usr/local/bin/zsh

# msys2 如下
pacman -S zsh
# MSYS2 每个子环境（比如 clang64.exe, mingw64.exe, ucrt64.exe）都会读取自己的配置文件。
# 对于 clang64，对应的是：
# C:\msys64\clang64.ini
# 打开这个文件，把 SHELL 改成：
# SHELL=zsh.exe
# 如果不想改 .ini 文件，可以直接在启动时指定：
# C:\msys64\clang64.exe -defterm -no-start -here /usr/bin/zsh.exe
#     -defterm 默认用 Windows Console Host 或 Windows Terminal（取决于系统设置）作为终端
#     -no-start 告诉 MSYS2 启动器 不要调用 start 来新开一个进程，而是直接在当前窗口里运行
#     -here 在当前目录启动 shell，而不是切换到用户主目录或者 MSYS2 的默认路径
# 第三方终端：命令行修改为：
# C:\tools\msys64\usr\bin\zsh.exe --login

# 可以通过echo $SHELL查看当前默认的shell，如果没有改为/bin/zsh，那么需要重启shell。

# 安装oh-my-zsh
# 1.自动安装
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
# 2.手动安装
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

# 通过如下命令可以查看可用的Theme：
ls ~/.oh-my-zsh/themes

# 如何修改zsh主题呢？
# 编辑~/.zshrc文件，将ZSH_THEME="candy"

# https://segmentfault.com/a/1190000013612471


# OhMyZsh 配置 Agnoster 主题
vim ~/.zshrc
# 找到 ZSH_THEME 修改为： ZSH_THEME="agnoster"
# 安装Powerline 对应的字体库
dnf install powerline-fonts
apt install fonts-powerline -y
# 手动安装
git clone https://github.com/powerline/fonts.git
cd fonts
./install.sh
# 字体修改为 ：Meslo LG S DZ Regular for Powerline


# 更新 oh-my-zsh
omz update

# (anon):12: character not in range
apt install locales -y
# .zshrc添加
export LC_ALL=C.UTF-8
export LANG=C.UTF-8


# 代码高亮和自动补全插件
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
vim ~/.zshrc
# plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
