# 检查硬盘SMART

# 安装 smartmontools
apt install smartmontools -y

# 查看硬盘设备
lsblk

# 查看基本 SMART 信息
smartctl -i /dev/sda
# 查看完整的 SMART 状态
smartctl -a /dev/sda
# 或更详细
smartctl -x /dev/sda
# 运行时间（Power_On_Hours）
# 通电次数（Power_Cycle_Count）
# 坏扇区数（Reallocated_Sector_Ct）
# 温度（Temperature_Celsius 或类似项）
# 设备健康状态（SMART overall-health self-assessment test result）
# -i -a -x 是只读操作，不会对硬盘写入数据。它们只是读取控制器和固件中保存的 SMART 信息。

# 运行自检
# 短测（大约 1~2 分钟）：
smartctl -t short /dev/sda
# 长测（可能数小时）：
smartctl -t long /dev/sda
# 这类 自检测试 是由硬盘固件自己执行的，测试过程本身不会对磁盘扇区写入数据（尤其 short/long test 是只读扫描）。
# NVMe SSD 用：
smartctl -a /dev/nvme0
# 查看进度（找 Self-test execution status: ），会显示**剩余百分比**和状态：
smartctl -c /dev/sda
# 日志查看命令：查看结果：
smartctl -l selftest /dev/sda
# 日志查看命令只读取设备维护的日志区，不会写入磁盘用户数据区。
