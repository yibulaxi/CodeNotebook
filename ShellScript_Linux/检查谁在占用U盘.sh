# 检查谁在占用U盘

# 离开当前文件夹
cd ~

# 快速
fuser -vm /mnt/disk

# 慢速
lsof +D /mnt/smb

# 结束相关进程
kill -9 <PID>

# 正常卸载
umount /mnt/smb

# 如果仍然失败，可以强制卸载（谨慎使用）
umount -l /mnt/smb   # lazy 卸载，等不再被使用时真正卸载
umount -f /mnt/smb   # 强制卸载（NFS/SMB 常用）
