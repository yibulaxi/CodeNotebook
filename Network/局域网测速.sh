# 局域网测速
sudo apt install iperf3 -y
sudo firewall-cmd --permanent --add-port=5201/tcp
sudo firewall-cmd --permanent --add-port=5201/udp
sudo firewall-cmd --reload

## 服务器
iperf3 -s
# -s:服务器  默认 TCP:5201

## 客户端
iperf3 -c 192.168.1.2 -b 100M -R -t 30
# -c:客户端  -b:以100Mbps为数据发送速率  -t:测试30s
# 不加 -d / -R 测试上传，加 -R 测试下载，加 -d 双向测试

# | 功能    | 完整参数         | 简写参数 | 示例                     |
# | ----- | ------------ | ---- | ---------------------- |
# | 客户端模式 | `--client`   | `-c` | `iperf3 -c 1.2.3.4`    |
# | 服务端模式 | `--server`   | `-s` | `iperf3 -s`            |
# | 测试时长  | `--time`     | `-t` | `-t 30` → 测试 30 秒      |
# | 端口号   | `--port`     | `-p` | `-p 5202`              |
# | 格式化单位 | `--format`   | `-f` | `-f m` → Mbps          |
# | 下载模式  | `--reverse`  | 无简写  | `--reverse`            |
# | 双向测试  | `--bidir`    | 无简写  | `--bidir`              |
# | 并发流数  | `--parallel` | `-P` | `-P 4` → 4 条流并发测试      |
# | 输出到文件 | `--logfile`  | 无简写  | `--logfile result.log` |

### 只测试连接不要测速
iperf3 -c 192.168.1.2 --set-mss 100 --len 1K -t 60
# 客户端每次发送 1KB 数据
# 每个 TCP segment 最大为 100 Bytes
# 所以每 1K 会被拆成 约 10 个小包
# 实际网络带宽使用率会非常低（因为每包都要三次握手、ACK 等协议负载）

## Docker 启动， -s 及其开始是 iperf3 程序的参数
sudo docker run -d --name=iperf3-server -p 5201:5201 networkstatic/iperf3 -s
## Docker 停止
sudo docker stop iperf3-server && sudo docker rm iperf3-server

# 带宽性能测试

## 服务器
iperf -s -u
# -u:UDP  -s:服务器  默认 UDP:5001

## 客户端
iperf -c 192.168.1.2 -u -b 100M -t 10
# -c:客户端  -u:UDP -b:以100Mbps为数据发送速率 -t:10秒
# 看丢包率和实际带宽
