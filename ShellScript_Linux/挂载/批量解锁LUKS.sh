#!/bin/bash
# unlock-all.sh
# 批量解锁LUKS 批量挂载加密分区

# 读取一次密码
echo -n "Enter LUKS passphrase: "
read -rs PASSWORD
echo

# 要解锁的设备列表
for dev in /dev/sd{c,d,e,f,g,h,i}1; do
    name=$(basename $dev)
    echo ">>> unlocking $dev as $name"
    echo -n "$PASSWORD" | cryptsetup open "$dev" "$name" --key-file=-
done
