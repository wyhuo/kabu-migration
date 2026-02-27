#!/bin/bash
#
# NBA球员数据快速查询工具
# 手动查询关注球员数据
#

API_KEY="${BALLDONTLIE_API_KEY:-d7e6a0a8-9c68-45b0-a135-7695433c09b9}"
API_BASE="https://api.balldontlie.io/v1"

echo "🏀 NBA球员数据查询工具"
echo ""

# 显示菜单
echo "请选择查询类型:"
echo "1. 搜索球员"
echo "2. 获取昨日比赛"
echo "3. 获取球员赛季数据（需ID）"
echo "4. 获取球队列表"
echo "5. 退出"
echo ""

# 默认执行：获取昨日比赛
choice="${1:-2}"

case $choice in
    1)
        echo "🔍 搜索球员"
        echo "请输入球员名（如：Victor Wembanyama）:"
        read -r player_name
        if [ -n "$player_name" ]; then
            encoded_name=$(echo "$player_name" | sed 's/ /%20/g')
            echo "查询中..."
            curl -s "$API_BASE/players?search=$encoded_name&per_page=5" \
                -H "Authorization: $API_KEY" | head -200
        fi
        ;;
    2)
        echo "📊 获取昨日比赛"
        YESTERDAY=$(date -d "yesterday" +%Y-%m-%d 2>/dev/null || echo "2025-02-26")
        echo "日期: $YESTERDAY"
        echo "查询中..."
        RESULT=$(curl -s "$API_BASE/games?dates[]=$YESTERDAY&per_page=100" \
            -H "Authorization: $API_KEY")
        
        # 统计比赛数量
        GAME_COUNT=$(echo "$RESULT" | grep -o '"id":[0-9]*' | wc -l)
        echo ""
        echo "找到 $GAME_COUNT 场比赛"
        echo ""
        
        # 显示马刺比赛（如果有）
        echo "$RESULT" | grep -i "spurs" && echo "✅ 包含马刺比赛" || echo "⚠️ 未找到马刺比赛"
        
        # 保存到文件
        echo "$RESULT" > "/workspace/projects/workspace/knowledge/nba-data/last-games.json"
        echo "数据已保存到: last-games.json"
        ;;
    3)
        echo "📈 获取球员赛季数据"
        echo "请输入球员ID（如：237 for LeBron）:"
        read -r player_id
        if [ -n "$player_id" ]; then
            echo "查询中..."
            curl -s "$API_BASE/season_averages?player_ids[]=$player_id" \
                -H "Authorization: $API_KEY" | head -200
        fi
        ;;
    4)
        echo "🏢 获取球队列表"
        curl -s "$API_BASE/teams" -H "Authorization: $API_KEY" | head -500
        ;;
    5)
        echo "退出"
        exit 0
        ;;
    *)
        echo "无效选项"
        ;;
esac
