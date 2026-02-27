#!/bin/bash
#
# NBA数据采集 - 使用 browser 工具手动采集
# 配合 openclaw browser 命令使用
#

YESTERDAY=$(date -d "yesterday" +%Y-%m-%d 2>/dev/null || date -v-1d +%Y-%m-%d)

echo "🏀 NBA数据采集 - Browser 方案"
echo ""
echo "由于自动化 browser 工具需要 Chrome 扩展支持，"
echo "当前采用半自动化方式："
echo ""

# 生成访问链接
echo "📊 请手动访问以下链接获取数据："
echo ""
echo "1. 昨日比赛:"
echo "   https://www.nba.com/games?date=$YESTERDAY"
echo ""
echo "2. 球员数据:"
echo "   https://www.nba.com/stats/players/traditional"
echo ""
echo "3. 新秀数据:"
echo "   https://www.nba.com/stats/players/traditional?SeasonType=Regular%20Season&PlayerPosition=ROOKIE"
echo ""
echo "4. 球队排名:"
echo "   https://www.nba.com/standings"
echo ""

# 如果有 openclaw browser 命令，尝试使用
if command -v openclaw &> /dev/null; then
    echo "🔄 尝试使用 browser 工具..."
    echo "   openclaw browser open https://www.nba.com/games?date=$YESTERDAY"
    echo ""
    echo "注意: 需要 Chrome 扩展已连接才能使用"
fi

echo "✅ 完成。请将观察到的数据更新到:"
echo "   knowledge/nba-data/raw/$(date +%Y-%m-%d)/"
