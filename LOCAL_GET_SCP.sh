#!/bin/bash
#
# 本地卡布完整获取指令（SCP方案）
#

# 云端信息
CLOUD_IP="115.190.192.22"
CLOUD_USER="root"
PACKAGE="kabu-complete-20260227.tar.gz"

echo "========================================"
echo "  📦 本地卡布SCP获取方案"
echo "========================================"
echo ""
echo "云端IP: $CLOUD_IP"
echo "文件: /tmp/$PACKAGE"
echo "大小: 220K"
echo ""

# 第1步：SCP下载
echo "步骤1: 从云端下载..."
scp $CLOUD_USER@$CLOUD_IP:/tmp/$PACKAGE ~/workspace/

if [ $? -ne 0 ]; then
    echo "❌ SCP失败，可能原因:"
    echo "  1. SSH端口未开放"
    echo "  2. 需要配置密钥/密码"
    echo "  3. 防火墙限制"
    echo ""
    echo "尝试方案B（云盘）或方案C（base64）"
    exit 1
fi

echo "✅ 下载成功"

# 第2步：解压
mkdir -p ~/workspace/kabu
tar xzvf ~/workspace/$PACKAGE -C ~/workspace/kabu
cd ~/workspace/kabu

# 第3步：Git配置
git init
git remote add origin https://github.com/wyhuo/kabu-migration.git

# 第4步：执行吸收
echo ""
echo "步骤2: 执行吸收..."
bash scripts/absorb-from-cloud.sh

echo ""
echo "========================================"
echo "  ✅ 完成！"
echo "========================================"
