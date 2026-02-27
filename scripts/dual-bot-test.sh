#!/bin/bash
#
# 双卡布通信测试脚本
# 测试云端和本地卡布是否能正常收发消息
#

echo "=========================================="
echo "   🦐 双卡布通信测试"
echo "=========================================="
echo ""
echo "测试时间: $(date '+%Y-%m-%d %H:%M:%S')"
echo ""

# 颜色定义
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 测试1: 检查OpenClaw状态
echo "【测试1】检查OpenClaw状态..."
if command -v openclaw &> /dev/null; then
    echo -e "${GREEN}✓${NC} OpenClaw已安装"
else
    echo -e "${RED}✗${NC} OpenClaw未安装"
    exit 1
fi

# 测试2: 检查Gateway状态
echo ""
echo "【测试2】检查Gateway状态..."
GATEWAY_STATUS=$(openclaw gateway status 2>&1)
if echo "$GATEWAY_STATUS" | grep -q "running"; then
    echo -e "${GREEN}✓${NC} Gateway运行中"
else
    echo -e "${YELLOW}!${NC} Gateway未运行，尝试启动..."
    openclaw gateway start
    sleep 2
    GATEWAY_STATUS=$(openclaw gateway status 2>&1)
    if echo "$GATEWAY_STATUS" | grep -q "running"; then
        echo -e "${GREEN}✓${NC} Gateway已启动"
    else
        echo -e "${RED}✗${NC} Gateway启动失败"
    fi
fi

# 测试3: 检查Feishu配置
echo ""
echo "【测试3】检查Feishu配置..."
FEISHU_CONFIG=$(openclaw config get feishu 2>&1)
if echo "$FEISHU_CONFIG" | grep -q "webhook"; then
    echo -e "${GREEN}✓${NC} Feishu Webhook已配置"
else
    echo -e "${YELLOW}!${NC} Feishu Webhook未配置"
    echo "   需要配置: openclaw config set feishu.webhook \"你的Webhook地址\""
fi

# 测试4: 发送测试消息
echo ""
echo "【测试4】发送测试消息到群..."
TEST_MSG="本地卡布通信测试 - $(date '+%H:%M:%S')"
SEND_RESULT=$(openclaw message send --channel feishu --message "$TEST_MSG" 2>&1)
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓${NC} 测试消息已发送"
    echo "   消息内容: $TEST_MSG"
else
    echo -e "${RED}✗${NC} 消息发送失败"
    echo "   错误: $SEND_RESULT"
fi

# 测试5: 检查网络连通性
echo ""
echo "【测试5】检查网络连通性..."
if curl -s --connect-timeout 5 "https://open.feishu.cn" > /dev/null; then
    echo -e "${GREEN}✓${NC} 可以访问Feishu服务器"
else
    echo -e "${RED}✗${NC} 无法访问Feishu服务器"
    echo "   请检查网络连接"
fi

# 测试6: 检查文件完整性
echo ""
echo "【测试6】检查交接文件完整性..."
REQUIRED_FILES=(
    "HANDBOOK_FOR_LOCAL_KABU.md"
    "QUICKSTART.md"
    "FINAL_CHECKLIST.md"
    "Feishu_SETUP_GUIDE.md"
)

ALL_PRESENT=true
for file in "${REQUIRED_FILES[@]}"; do
    if [ -f "/workspace/projects/workspace/$file" ]; then
        echo -e "${GREEN}✓${NC} $file"
    else
        echo -e "${RED}✗${NC} $file 缺失"
        ALL_PRESENT=false
    fi
done

echo ""
echo "=========================================="
echo "   测试结果总结"
echo "=========================================="

if [ "$ALL_PRESENT" = true ]; then
    echo -e "${GREEN}✓ 所有交接文件已就位${NC}"
else
    echo -e "${YELLOW}! 部分文件缺失${NC}"
fi

echo ""
echo "【下一步操作】"
echo "1. 检查群里是否收到测试消息"
echo "2. 在群里发消息@本地卡布"
echo "3. 观察本地卡布是否能响应"
echo ""
echo "如果本地卡布能收到并回复消息，说明通信正常！"
echo ""
echo "🦐 Go Spurs Go!"
echo "=========================================="
