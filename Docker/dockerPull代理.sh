# docker pull 代理
mkdir -p /etc/systemd/system/docker.service.d
nano /etc/systemd/system/docker.service.d/http-proxy.conf
# 内容示例（如果是 HTTP 代理）：
# [Service]
# Environment="HTTP_PROXY=http://代理服务器地址:端口/"
# Environment="HTTPS_PROXY=http://代理服务器地址:端口/"
# Environment="NO_PROXY=localhost,127.0.0.1"

# 如果代理需要用户名和密码：
# [Service]
# Environment="HTTP_PROXY=http://username:password@代理服务器地址:端口/"
# Environment="HTTPS_PROXY=http://username:password@代理服务器地址:端口/"

# 重新加载并重启 Docker
systemctl daemon-reexec
systemctl daemon-reload
systemctl restart docker

# 验证配置
systemctl show --property=Environment docker
