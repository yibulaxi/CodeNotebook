# 挂载
veracrypt --text --keyfiles="/root/keyfile" --hash=sha-512 --pim=1024 backup.hc /mnt/vc

# 密码 → --password=你的密码
# 密钥文件 → --keyfiles=/路径/到/密钥文件 ，可以是一个文件夹路径
# 哈希算法 (HMAC-SHA-512) → --hash=sha-512
# PIM (Personal Iterations Multiplier) → --pim=数字
# 非交互模式（避免交互输入）→ --non-interactive

# 卸载
veracrypt -d /mnt/vc

# 挂载加密分区
lsblk
veracrypt --text --keyfiles="/root/keyfile" --hash=sha-512 --pim=1024 /dev/sdd3 /mnt/vcsrc
