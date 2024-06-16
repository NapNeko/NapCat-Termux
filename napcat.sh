# 设置环境变量
export DEBIAN_FRONTEND=noninteractive

# 安装必要的软件包
apt-get update && apt-get install -y \
    libnss3 \   
    libnotify4 \
    libsecret-1-0 \
    libgbm1 \
    libasound2 \
    fonts-wqy-zenhei \
    gnutls-bin \ 
    libglib2.0-dev \
    libdbus-1-3 \
    libgtk-3-0 \
    libxss1 \
    libxtst6 \
    libatspi2.0-0 \
    libx11-xcb1 \
    ffmpeg \
    unzip \
    jq \
    curl && \   
    apt autoremove -y && \
    apt clean && \
    rm -rf \
    /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/*

# 安装Linux QQ
curl -o linuxqq.deb https://dldir1.qq.com/qqfile/qq/QQNT/Linux/QQ_3.2.9_240606_arm64_01.deb
dpkg -i --force-depends linuxqq.deb && rm linuxqq.deb

# 安装NapCat
version=$(curl "https://api.github.com/repos/NapNeko/NapCatQQ/releases/latest" | jq -r '.tag_name')
curl -s -X GET \
    -L "https://github.com/NapNeko/NapCatQQ/releases/download/$version/NapCat.linux.arm64.zip" \
    -o "NapCat.linux.arm64.zip"
unzip NapCat.linux.arm64.zip
chmod +x NapCat.linux.arm64/napcat.sh