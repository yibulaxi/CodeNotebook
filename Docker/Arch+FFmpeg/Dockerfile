FROM docker.1panel.live/library/archlinux:latest

# 时区 + 代理（构建期和运行期都会生效）
ENV TZ=Asia/Shanghai \
    HTTP_PROXY=http://192.168.1.45:23334 \
    HTTPS_PROXY=http://192.168.1.45:23334 \
    http_proxy=http://192.168.1.45:23334 \
    https_proxy=http://192.168.1.45:23334

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN set -eux; \
    # ---------------------------
    # 使用官方源（保持 pacman 默认 mirrorlist，不替换为阿里源）
    # ---------------------------
    pacman -Syy --noconfirm; \
    pacman-key --init; \
    pacman-key --populate archlinux; \
    pacman -Syu --noconfirm; \
    \
    # ---------------------------
    # 添加 archlinuxcn + Chaotic-AUR 仓库（保持之前逻辑）
    # ---------------------------
    { echo ''; echo '[archlinuxcn]'; echo 'Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch'; } >> /etc/pacman.conf; \
    pacman -Syy --noconfirm; \
    pacman -S --noconfirm archlinuxcn-keyring || true; \
    \
    pacman -S --noconfirm --needed curl ca-certificates; \
    curl -L -o /tmp/chaotic-keyring.pkg.tar.zst     https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst; \
    curl -L -o /tmp/chaotic-mirrorlist.pkg.tar.zst  https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst; \
    pacman -U --noconfirm /tmp/chaotic-keyring.pkg.tar.zst /tmp/chaotic-mirrorlist.pkg.tar.zst; \
    { echo ''; echo '[chaotic-aur]'; echo 'Include = /etc/pacman.d/chaotic-mirrorlist'; } >> /etc/pacman.conf; \
    pacman -Syy --noconfirm; \
    \
    # ---------------------------
    # 基础软件 + 编解码支持（不触碰 /root /home）
    # ---------------------------
    pacman -S --noconfirm --needed \
      tzdata glibc \
      xz imagemagick vim nano openssl zsh 7zip gnupg htop \
      aom svt-av1 rav1e libvpx x264 x265 xvidcore vmaf \
      opus libvorbis lame \
      noto-fonts-cjk; \
    \
    # 可选运行库探测：vvdec/fdk-aac
    for PKG in libvvdec vvdec; do pacman -Si "$PKG" >/dev/null 2>&1 && pacman -S --noconfirm --needed "$PKG" && break; done; \
    for PKG in libfdk-aac fdk-aac; do pacman -Si "$PKG" >/dev/null 2>&1 && pacman -S --noconfirm --needed "$PKG" && break; done; \
    \
    # ffmpeg-full 优先，不存在则回退 ffmpeg-git
    (pacman -S --noconfirm --needed ffmpeg-full) || \
    (pacman -S --noconfirm --needed ffmpeg-git); \
    \
    # ---------------------------
    # locale
    # ---------------------------
    sed -ri 's|^#\s*(zh_CN\.UTF-8)\s+UTF-8$|\1 UTF-8|' /etc/locale.gen; \
    sed -ri 's|^#\s*(en_US\.UTF-8)\s+UTF-8$|\1 UTF-8|' /etc/locale.gen; \
    locale-gen; \
    localedef -f UTF-8 -i zh_CN zh_CN.UTF-8 || true; \
    localedef -f UTF-8 -i en_US en_US.UTF-8 || true; \
    \
    # 清理
    pacman -Scc --noconfirm || true; \
    rm -rf /var/cache/pacman/pkg/* /tmp/*

# locale 环境
ENV LANG=zh_CN.UTF-8 \
    LC_ALL=zh_CN.UTF-8 \
    LANGUAGE=zh_CN:zh

SHELL ["/usr/bin/zsh", "-lc"]
ENTRYPOINT ["/usr/bin/zsh","-l","-i"]
CMD []
