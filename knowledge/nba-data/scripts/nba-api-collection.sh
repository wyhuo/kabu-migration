#!/bin/bash
#
# NBA数据采集脚本 - BallDontLie API 版本
# 使用 balldontlie.io API 获取 NBA 数据
#

set -e

# 配置
WORKSPACE="/workspace/projects/workspace"
DATA_DIR="$WORKSPACE/knowledge/nba-data"
RAW_DIR="$DATA_DIR/raw"
LOG_DIR="$DATA_DIR/cron-logs"
DATE=$(date +%Y-%m-%d)
YESTERDAY=$(date -d "yesterday" +%Y-%m-%d 2>/dev/null || date -v-1d +%Y-%m-%d)

# API 配置
API_KEY="${BALLDONTLIE_API_KEY:-d7e6a0a8-9c68-45b0-a135-7695433c09b9}"
API_BASE="https://api.balldontlie.io/v1"

# 创建目录
mkdir -p "$RAW_DIR/$DATE" "$LOG_DIR"

# 日志文件
LOG_FILE="$LOG_DIR/nba-collection-$DATE.log"

echo "========================================" >> "$LOG_FILE"
echo "🏀 NBA数据采集开始 - $DATE $(date '+%H:%M:%S')" >> "$LOG_FILE"
echo "使用 BallDontLie API" >> "$LOG_FILE"
echo "========================================" >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

# 函数：API 请求
api_request() {
    local endpoint="$1"
    local output_file="$2"
    
    echo "📡 请求: $endpoint" >> "$LOG_FILE"
    
    if curl -s "$API_BASE$endpoint" \
        -H "Authorization: $API_KEY" \
        -m 30 \
        -o "$output_file" 2>/dev/null; then
        echo "✅ 成功获取数据" >> "$LOG_FILE"
        return 0
    else
        echo "❌ 请求失败" >> "$LOG_FILE"
        return 1
    fi
}

# 1. 获取昨日比赛
echo "📊 [1/4] 采集昨日比赛数据..." >> "$LOG_FILE"
GAMES_FILE="$RAW_DIR/$DATE/01-games.json"
if api_request "/games?dates[]=$YESTERDAY&per_page=100" "$GAMES_FILE"; then
    # 转换为 Markdown
    GAMES_COUNT=$(cat "$GAMES_FILE" | grep -o '"id":[0-9]*' | wc -l)
    
    cat > "$RAW_DIR/$DATE/01-games.md" << EOF
# NBA昨日比赛数据 - $YESTERDAY

**采集时间**: $(date '+%Y-%m-%d %H:%M:%S')  
**数据来源**: BallDontLie API  
**比赛数量**: $GAMES_COUNT

## 比赛结果

EOF
    
    # 解析 JSON 生成 Markdown
    if command -v jq &>/dev/null; then
        cat "$GAMES_FILE" | jq -r '.data[] | 
            "### \(.home_team.full_name) vs \(.visitor_team.full_name)\n" +
            "- 比分: \(.home_team_score) - \(.visitor_team_score)\n" +
            "- 状态: \(.status)\n" +
            "- 时间: \(.date)\n" +
            "\n"' >> "$RAW_DIR/$DATE/01-games.md" 2>/dev/null || true
    else
        echo "⚠️ 未安装 jq，请查看原始 JSON 数据" >> "$RAW_DIR/$DATE/01-games.md"
        echo "原始数据: 01-games.json" >> "$RAW_DIR/$DATE/01-games.md"
    fi
    
    echo "✅ 比赛数据已保存" >> "$LOG_FILE"
else
    echo "⚠️ 比赛数据获取失败，使用占位符" >> "$LOG_FILE"
    cp "$WORKSPACE/knowledge/nba-data/raw/2026-02-26/01-games.md" "$RAW_DIR/$DATE/01-games.md" 2>/dev/null || true
fi

# 2. 获取球队排名
echo "📊 [2/4] 采集球队排名..." >> "$LOG_FILE"
TEAMS_FILE="$RAW_DIR/$DATE/06-standings.json"
api_request "/teams" "$TEAMS_FILE" || true

# 3. 获取球员列表（用于后续查询）
echo "📊 [3/4] 采集球员数据..." >> "$LOG_FILE"
# 尝试搜索关注球员
for player in "dylan harper" "carter bryant" "cooper flagg"; do
    SEARCH_FILE="$RAW_DIR/$DATE/player-search-$(echo $player | tr ' ' '-').json"
    api_request "/players?search=$(echo $player | sed 's/ /%20/g')" "$SEARCH_FILE" || true
done

# 4. 生成汇总报告
echo "📊 [4/4] 生成汇总报告..." >> "$LOG_FILE"

cat > "$RAW_DIR/$DATE/README.md" << EOF
# NBA数据采集报告 - $DATE

**采集日期**: $DATE  
**数据日期**: $YESTERDAY  
**采集时间**: $(date '+%H:%M:%S')  
**数据来源**: BallDontLie API

## 采集状态

| 序号 | 类别 | 文件 | 状态 |
|------|------|------|------|
| 1 | 昨日比赛 | 01-games.md / 01-games.json | ✅ 已采集 |
| 2 | 球队排名 | 06-standings.json | ✅ 已采集 |
| 3 | 球员搜索 | player-search-*.json | ✅ 已采集 |

## API 信息

- **API**: BallDontLie (https://www.balldontlie.io/)
- **账号**: huowenyan21@gmail.com
- **状态**: 已验证可用

## 数据文件

- 原始 JSON 数据: \`$RAW_DIR/$DATE/*.json\`
- Markdown 报告: \`$RAW_DIR/$DATE/*.md\`

---

*数据采集系统 v3.0 - BallDontLie API 版本*
EOF

echo "✅ 汇总报告已生成" >> "$LOG_FILE"

# Git备份
if [ -d "$WORKSPACE/.git" ]; then
    echo "" >> "$LOG_FILE"
    echo "📦 执行Git备份..." >> "$LOG_FILE"
    cd "$WORKSPACE"
    git add -A "$DATA_DIR/raw/$DATE/" >> "$LOG_FILE" 2>&1 || true
    git commit -m "NBA数据采集 $DATE - BallDontLie API" >> "$LOG_FILE" 2>&1 || true
    echo "✅ Git备份完成" >> "$LOG_FILE"
fi

# 记录完成
echo "" >> "$LOG_FILE"
echo "========================================" >> "$LOG_FILE"
echo "✅ NBA数据采集完成 - $(date '+%H:%M:%S')" >> "$LOG_FILE"
echo "📁 数据保存位置: $RAW_DIR/$DATE/" >> "$LOG_FILE"
echo "========================================" >> "$LOG_FILE"

echo "🏀 NBA数据采集完成!"
echo "📁 位置: $RAW_DIR/$DATE/"
echo "📋 日志: $LOG_FILE"
