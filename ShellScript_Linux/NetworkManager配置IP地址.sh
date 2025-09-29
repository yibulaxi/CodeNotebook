# NetworkManager配置IP地址
nmcli con show   # 列出现有连接名，比如 "Wired connection 1"
nmcli con mod "Wired connection 1" ipv4.addresses 192.168.1.100/24
nmcli con mod "Wired connection 1" ipv4.gateway 192.168.1.1
nmcli con mod "Wired connection 1" ipv4.dns 8.8.8.8
nmcli con mod "Wired connection 1" ipv4.method manual
nmcli con up "Wired connection 1"
