#!/bin/bash
#
# 本地卡布自动获取脚本（零配置版）
# 自动发现云端数据并下载
#

set -e

echo "🤖 本地卡布自动获取系统"
echo "========================"
echo ""

# 尝试多种方式获取云端数据

# 方式1: GitHub（默认）
GITHUB_REPO="${1:-}"

if [ -n "$GITHUB_REPO" ]; then
    echo "📡 方式1: 从GitHub获取..."
    git clone "https://github.com/$GITHUB_REPO.git" ~/workspace/kabu 2>/dev/null && {
        echo "✅ GitHub获取成功"
        cd ~/workspace/kabu
        bash scripts/absorb-from-cloud.sh
        exit 0
    }
fi

# 方式2: 局域网发现（如果云端启动了HTTP服务）
echo "🔍 方式2: 尝试局域网发现..."
# 扫描常见IP段（需要知道云端IP范围）
# 这里需要用户或系统提供云端IP

# 方式3: 手动复制（如果以上都失败）
echo ""
echo "⚠️  自动获取失败"
echo ""
echo "请使用以下方式之一:"
echo ""
echo "方案A - GitHub（推荐）:"
echo "  bash <(curl -s URL) 用户名/仓库名"
echo ""
echo "方案B - 直接下载:"
echo "  curl -O http://云端IP:8080/kabu-complete.tar.gz"
echo "  tar xzvf kabu-complete.tar.gz -C ~/workspace/kabu"
echo ""
echo "方案C - 手动复制:"
echo "  scp 云端:/tmp/kabu-complete-*.tar.gz ~/workspace/"
echo ""
