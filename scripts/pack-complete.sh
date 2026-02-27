#!/bin/bash
#
# 全自动打包脚本 - 云端执行
# 打包全部内容，供本地卡布自动获取
#

set -e

WORKSPACE="/workspace/projects/workspace"
PACKAGE_NAME="kabu-complete-$(date +%Y%m%d-%H%M%S)"
PACKAGE_DIR="/tmp/$PACKAGE_NAME"

echo "========================================"
echo "  📦 卡布全自动打包系统"
echo "========================================"
echo ""

# 1. 创建临时目录
echo "📁 创建打包目录..."
mkdir -p "$PACKAGE_DIR"

# 2. 复制全部内容
echo "📋 复制全部文件..."
cd "$WORKSPACE"

# 使用rsync或cp复制（排除大文件和缓存）
rsync -av \
  --exclude='.git/objects' \
  --exclude='node_modules' \
  --exclude='*.tar.gz' \
  --exclude='.clawhub/cache' \
  --exclude='logs/*.log' \
  . "$PACKAGE_DIR/" 2>/dev/null || \
cp -r \
  knowledge scripts memory daily_summary skills \
  *.md .env \
  "$PACKAGE_DIR/" 2>/dev/null || true

# 3. 创建获取说明
cat > "$PACKAGE_DIR/DOWNLOAD_INSTRUCTIONS.txt" << 'EOF'
# 🎯 本地卡布获取指南

## 方案A: GitHub克隆（推荐）
```bash
git clone https://github.com/云端用户名/kabu-migration.git ~/workspace/kabu
cd ~/workspace/kabu
bash scripts/absorb-from-cloud.sh
```

## 方案B: 直接下载压缩包
```bash
# 如果云端提供了下载链接
curl -O https://下载地址/kabu-complete.tar.gz
tar xzvf kabu-complete.tar.gz -C ~/workspace/kabu
cd ~/workspace/kabu
bash scripts/absorb-from-cloud.sh
```

## 方案C: 局域网传输（如果本地可访问云端）
```bash
# 从云端IP下载
scp 云端用户名@云端IP:/tmp/kabu-complete-*.tar.gz ~/workspace/
tar xzvf ~/workspace/kabu-complete-*.tar.gz -C ~/workspace/kabu
```

## 获取后执行
```bash
cd ~/workspace/kabu
# 1. 查看阅读地图
cat READING_MAP.md

# 2. 配置API Keys
nano .env

# 3. 执行吸收
bash scripts/absorb-from-cloud.sh
```

## ⚠️ 重要提醒
本压缩包包含全部工作成果：
- 12,920字交接手册
- 46位球员投资策略
- 201个文件完整知识库
- 29次Git提交历史

但**不包含**真实的API Keys（安全考虑）
需要在本地.env中重新配置。
EOF

# 4. 创建压缩包
echo "🗜️  创建压缩包..."
cd /tmp
tar czvf "${PACKAGE_NAME}.tar.gz" "$PACKAGE_NAME"

PACKAGE_SIZE=$(du -h "${PACKAGE_NAME}.tar.gz" | cut -f1)
PACKAGE_PATH="/tmp/${PACKAGE_NAME}.tar.gz"

echo "✅ 打包完成！"
echo ""
echo "📦 压缩包信息:"
echo "  文件名: ${PACKAGE_NAME}.tar.gz"
echo "  大小: $PACKAGE_SIZE"
echo "  路径: $PACKAGE_PATH"
echo ""

# 5. 计算校验和
echo "🔐 生成校验和..."
CHECKSUM=$(md5sum "$PACKAGE_PATH" | cut -d' ' -f1)
echo "  MD5: $CHECKSUM"
echo "$CHECKSUM" > "${PACKAGE_PATH}.md5"
echo ""

# 6. 生成传输选项
cat > "/tmp/${PACKAGE_NAME}-TRANSFER_OPTIONS.txt" << EOF
# 📤 传输选项（选择一种）

## 选项1: GitHub推送（全自动，推荐）
命令: bash scripts/push-to-github.sh
结果: 生成 https://github.com/用户名/kabu-migration.git
本地执行: git clone 地址 ~/workspace/kabu

## 选项2: HTTP服务器（局域网）
命令: cd /tmp && python3 -m http.server 8080
结果: 本地可访问 http://云端IP:8080/${PACKAGE_NAME}.tar.gz
注意: 需要云端防火墙开放8080端口

## 选项3: 云盘上传（阿里云盘/Google Drive）
需要: 配置rclone或对应CLI工具
命令: rclone copy ${PACKAGE_PATH} 云盘:备份/

## 选项4: 直接输出base64（命令行粘贴）
命令: base64 ${PACKAGE_PATH} | head -c 1000
tar xzvf 解码后的文件
注意: 仅适合小文件，此包可能太大

## 选项5: 分卷压缩+复制粘贴
命令: split -b 100k ${PACKAGE_PATH} ${PACKAGE_NAME}.part
cat ${PACKAGE_NAME}.part* | base64
注意: 需要手动合并

## 推荐方案
对于大多数用户，推荐使用选项1 (GitHub) 或选项2 (HTTP服务器)。

## 当前压缩包位置
本地路径: $PACKAGE_PATH
大小: $PACKAGE_SIZE
MD5: $CHECKSUM
EOF

echo "📋 传输选项文档已生成: /tmp/${PACKAGE_NAME}-TRANSFER_OPTIONS.txt"
echo ""

# 7. 输出总结
echo "========================================"
echo "  ✅ 打包完成！"
echo "========================================"
echo ""
echo "📦 压缩包: ${PACKAGE_PATH}"
echo "   大小: ${PACKAGE_SIZE}"
echo "   MD5: ${CHECKSUM}"
echo ""
echo "📄 获取说明: ${PACKAGE_PATH}/DOWNLOAD_INSTRUCTIONS.txt"
echo "📄 传输选项: /tmp/${PACKAGE_NAME}-TRANSFER_OPTIONS.txt"
echo ""
echo "🚀 下一步: 选择传输方式，让本地卡布获取"
echo "   选项1: GitHub推送 (bash scripts/push-to-github.sh)"
echo "   选项2: HTTP服务器 (python3 -m http.server 8080)"
echo "   选项3: 其他方式..."
echo ""
