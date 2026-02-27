#!/bin/bash
#
# NBA数据采集脚本 v2.0 - 使用 browser 工具
# 用途：每天自动采集NBA数据
#

set -e

# 配置
WORKSPACE="/workspace/projects/workspace"
DATA_DIR="$WORKSPACE/knowledge/nba-data"
RAW_DIR="$DATA_DIR/raw"
LOG_DIR="$DATA_DIR/cron-logs"
DATE=$(date +%Y-%m-%d)
YESTERDAY=$(date -d "yesterday" +%Y-%m-%d 2>/dev/null || date -v-1d +%Y-%m-%d)

# 创建目录
mkdir -p "$RAW_DIR/$DATE" "$LOG_DIR"

# 日志文件
LOG_FILE="$LOG_DIR/nba-collection-$DATE.log"

# 记录开始时间
echo "========================================" >> "$LOG_FILE"
echo "🏀 NBA数据采集开始 - $DATE $(date '+%H:%M:%S')" >> "$LOG_FILE"
echo "========================================" >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

echo "📊 开始采集昨日($YESTERDAY)NBA数据..." >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

# ============================================
# 使用 browser 工具采集数据
# ============================================

# 1. 昨日比赛数据
echo "📊 [1/8] 采集昨日比赛数据..." >> "$LOG_FILE"
# 通过 openclaw browser 工具采集（需要手动执行或定时触发）
cat > "$RAW_DIR/$DATE/01-games.md" << EOF
# NBA昨日比赛数据 - $YESTERDAY

**采集时间**: $(date '+%Y-%m-%d %H:%M:%S')  
**数据日期**: $YESTERDAY

## 数据来源

由于自动化采集需要 browser 工具支持，当前采用半自动化方式：

### 建议查看
- [NBA官网 - 昨日比赛](https://www.nba.com/games?date=$YESTERDAY)
- [ESPN NBA Scoreboard](https://www.espn.com/nba/scoreboard/_/date/${YESTERDAY//-/})

## 重点关注的比赛

### 马刺比赛
- 需要手动查看昨日马刺是否有比赛
- 关注：Dylan Harper, Carter Bryant 表现

### 新秀比赛
- Cooper Flagg (独行侠)
- Dylan Harper (马刺)
- Carter Bryant (马刺)
- Matas Buzelis (公牛)

## 数据采集说明

使用以下命令手动采集：
\`\`\`bash
# 采集NBA官网数据
openclaw browser open https://www.nba.com/games
\`\`\`

EOF

echo "✅ 比赛数据文件已创建" >> "$LOG_FILE"

# 2-8. 其他数据文件使用类似的占位符模式...
# （简化为关键文件）

for file in "02-scoring.md" "03-rebounds-assists.md" "04-injuries.md" "05-rookies.md" "06-standings.md" "07-trades.md" "08-news.md"; do
    echo "📊 创建 $file..." >> "$LOG_FILE"
    cat > "$RAW_DIR/$DATE/$file" << EOF
# $(echo $file | cut -d'-' -f2- | cut -d'.' -f1 | tr '-' ' ' | sed 's/.*/\u&/')  

**采集时间**: $(date '+%Y-%m-%d %H:%M:%S')  
**数据日期**: $DATE

## 数据来源

- [NBA官网](https://www.nba.com)
- [ESPN NBA](https://www.espn.com/nba/)
- [The Athletic](https://theathletic.com/nba/)

## 说明

当前使用半自动化数据采集。
完整数据建议通过 browser 工具访问官网获取。

EOF
done

echo "✅ 所有数据文件已创建" >> "$LOG_FILE"

# 生成汇总报告
FILE_COUNT=$(ls -1 "$RAW_DIR/$DATE"/*.md 2>/dev/null | wc -l)

cat > "$RAW_DIR/$DATE/README.md" << EOF
# NBA数据采集报告 - $DATE

**采集日期**: $DATE  
**数据日期**: $YESTERDAY  
**采集时间**: $(date '+%H:%M:%S')  
**文件数量**: $FILE_COUNT

## 数据说明

由于原 coze-web-search 脚本不可用，当前采用**半自动化数据采集方案**：

### 方案A：Browser 工具（推荐）
使用 OpenClaw browser 工具访问NBA官网获取实时数据：
\`\`\`bash
openclaw browser open https://www.nba.com/games?date=$YESTERDAY
\`\`\`

### 方案B：balldontlie API
使用免费API获取数据（需要API Key）：
\`\`\`bash
curl https://api.balldontlie.io/v1/games?dates[]=$YESTERDAY
\`\`\`

### 方案C：手动更新
直接编辑 md 文件，添加观察到的数据。

## 📁 文件列表

| 序号 | 类别 | 文件 | 状态 |
|------|------|------|------|
| 1 | 昨日比赛 | 01-games.md | 📝 模板 |
| 2 | 得分榜 | 02-scoring.md | 📝 模板 |
| 3 | 篮板/助攻 | 03-rebounds-assists.md | 📝 模板 |
| 4 | 伤病报告 | 04-injuries.md | 📝 模板 |
| 5 | 新秀数据 | 05-rookies.md | 📝 模板 |
| 6 | 球队排名 | 06-standings.md | 📝 模板 |
| 7 | 交易动态 | 07-trades.md | 📝 模板 |
| 8 | 重要新闻 | 08-news.md | 📝 模板 |

## 重点关注球员

### Dylan Harper (马刺)
- 位置: SG
- 数据: 需要更新
- 关注: 得分、助攻、上场时间

### Carter Bryant (马刺)
- 位置: SF/PF
- 数据: 需要更新
- 关注: 三分命中率、防守数据

### Cooper Flagg (独行侠)
- 位置: SF/PF
- 数据: 需要更新
- 关注: 全面数据、球队战绩

---

*数据采集系统 v2.0 - 半自动化模式*
EOF

echo "✅ 汇总报告已生成" >> "$LOG_FILE"

# Git备份
if [ -d "$WORKSPACE/.git" ]; then
    echo "" >> "$LOG_FILE"
    echo "📦 执行Git备份..." >> "$LOG_FILE"
    cd "$WORKSPACE"
    
    if ! git config --global user.email >/dev/null 2>&1; then
        git config --global user.email "nba-tracker@openclaw.local"
        git config --global user.name "NBA Tracker"
    fi
    
    git add -A "$DATA_DIR/raw/$DATE/" >> "$LOG_FILE" 2>&1 || true
    git commit -m "NBA数据采集 $DATE - 半自动化模式" >> "$LOG_FILE" 2>&1 || true
    echo "✅ Git备份完成" >> "$LOG_FILE"
fi

# 记录完成
echo "" >> "$LOG_FILE"
echo "========================================" >> "$LOG_FILE"
echo "✅ NBA数据采集完成 - $(date '+%H:%M:%S')" >> "$LOG_FILE"
echo "📁 数据保存位置: $RAW_DIR/$DATE/" >> "$LOG_FILE"
echo "📄 文件数量: $FILE_COUNT" >> "$LOG_FILE"
echo "⚠️ 注意: 当前为半自动化模式，需要配合 browser 工具获取真实数据" >> "$LOG_FILE"
echo "========================================" >> "$LOG_FILE"

echo "🏀 NBA数据采集完成!"
echo "📁 位置: $RAW_DIR/$DATE/"
echo "📄 文件数: $FILE_COUNT"
