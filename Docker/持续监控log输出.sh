# 持续监控log输出 ： -f 持续监控
# docker logs -f 容器名 --tail 初始输出多少行历史
docker logs -f clamav-fullscan --tail 20
