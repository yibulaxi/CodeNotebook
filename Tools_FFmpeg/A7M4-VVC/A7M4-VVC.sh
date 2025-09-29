#!/usr/bin/env bash
set -euo pipefail

# ========== 可调参数 ==========
TARGET_BR="120M"   # 平均码率
MAX_BR="200M"      # 峰值码率
BUFSIZE="200M"     # 缓冲区大小（常用 = MAX_BR）
PRESET="slow"      # 预设：faster/fast/medium/slow/slower

# 让通配符对大小写不敏感，并避免无匹配时报错
shopt -s nullglob nocaseglob

# 遍历当前目录的 MP4（不区分大小写）
mp4_found=false
for f in *.mp4; do
  mp4_found=true
  in="$f"
  base_noext="${in%.*}"
  out="${base_noext}.vvc.mkv"
  passlog="${base_noext}.vvc"

  echo "=============================================="
  echo "[1/2] 分析 Pass 1 : $in"
  echo "日志基名：$passlog"
  echo "输出将为：$out"
  echo "=============================================="

  ffmpeg -y -i "$in" \
    -c:v libvvenc -preset "$PRESET" -profile:v main_10 \
    -pix_fmt yuv420p10le \
    -b:v "$TARGET_BR" -maxrate "$MAX_BR" -bufsize "$BUFSIZE" \
    -g 100 -keyint_min 50 -rc-lookahead 60 \
    -pass 1 -an -f null /dev/null \
    -passlogfile "$passlog"

  echo "=============================================="
  echo "[2/2] 正式输出 Pass 2 : $in"
  echo "=============================================="

  ffmpeg -i "$in" \
    -c:v libvvenc -preset "$PRESET" -profile:v main_10 \
    -pix_fmt yuv420p10le \
    -b:v "$TARGET_BR" -maxrate "$MAX_BR" -bufsize "$BUFSIZE" \
    -g 100 -keyint_min 50 -rc-lookahead 60 \
    -pass 2 \
    -c:a flac -sample_fmt s16 -ar 48000 -ac 2 \
    -map 0 -dn \
    -passlogfile "$passlog" \
    "$out"

  echo
  echo "完成：$out"
  echo
done

if [ "$mp4_found" = false ]; then
  echo "未找到 MP4 文件（当前目录）。"
fi

echo "=============================================="
echo "全部处理完成。输出：*.vvc.mkv，日志：*.vvc*（与源文件同目录）"
echo "=============================================="
