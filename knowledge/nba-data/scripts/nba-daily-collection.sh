#!/bin/bash
#
# NBA每日数据采集脚本 - 使用浏览器搜索
# 用途：每天自动采集NBA数据并保存
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

# 使用openclaw浏览器搜索功能采集数据
# 我们将使用browser工具的navigate和snapshot功能来抓取网页

# ============================================
# 1. 昨日比赛数据
# ============================================
echo "📊 [1/8] 采集昨日比赛数据..." >> "$LOG_FILE"
cat > "$RAW_DIR/$DATE/01-games.md" << 'EOF'
# NBA昨日比赛数据

**采集时间**: $(date '+%Y-%m-%d %H:%M:%S')  
**数据日期**: $YESTERDAY

## 比赛结果

> 数据采集方式更新中...
> 
> 请访问 [NBA官网](https://www.nba.com/games) 查看详细比分

## 主要看点

- 数据采集脚本正在升级
- 建议使用浏览器直接访问NBA官网
EOF

# 添加实际日期
sed -i "s/\$(date '+%Y-%m-%d %H:%M:%S')/$(date '+%Y-%m-%d %H:%M:%S')/g" "$RAW_DIR/$DATE/01-games.md"
sed -i "s/\$YESTERDAY/$YESTERDAY/g" "$RAW_DIR/$DATE/01-games.md"

echo "✅ 比赛数据文件已创建" >> "$LOG_FILE"

# ============================================
# 2. 球员得分榜
# ============================================
echo "📊 [2/8] 采集得分榜..." >> "$LOG_FILE"
cat > "$RAW_DIR/$DATE/02-scoring.md" << 'EOF'
# NBA得分榜

**采集时间**: $(date '+%Y-%m-%d %H:%M:%S')

## 本赛季得分排名

> 数据采集方式更新中...
>
> 请访问 [NBA Stats](https://www.nba.com/stats/leaders) 查看最新排名

## 近期得分爆发球员

- 数据采集脚本正在升级
EOF

sed -i "s/\$(date '+%Y-%m-%d %H:%M:%S')/$(date '+%Y-%m-%d %H:%M:%S')/g" "$RAW_DIR/$DATE/02-scoring.md"
echo "✅ 得分榜文件已创建" >> "$LOG_FILE"

# ============================================
# 3. 篮板/助攻榜
# ============================================
echo "📊 [3/8] 采集篮板助攻榜..." >> "$LOG_FILE"
cat > "$RAW_DIR/$DATE/03-rebounds-assists.md" << 'EOF'
# NBA篮板/助攻榜

**采集时间**: $(date '+%Y-%m-%d %H:%M:%S')

## 篮板榜

> 数据采集方式更新中...

## 助攻榜

> 数据采集方式更新中...
EOF

sed -i "s/\$(date '+%Y-%m-%d %H:%M:%S')/$(date '+%Y-%m-%d %H:%M:%S')/g" "$RAW_DIR/$DATE/03-rebounds-assists.md"
echo "✅ 篮板助攻文件已创建" >> "$LOG_FILE"

# ============================================
# 4. 伤病报告
# ============================================
echo "📊 [4/8] 采集伤病报告..." >> "$LOG_FILE"
cat > "$RAW_DIR/$DATE/04-injuries.md" << 'EOF'
# NBA伤病报告

**采集时间**: $(date '+%Y-%m-%d %H:%M:%S')  
**数据日期**: $DATE

## 最新伤病情况

> 数据采集方式更新中...
>
> 建议查看:
> - [NBA Injury Report](https://official.nba.com/injury-report/)
> - [ESPN NBA Injuries](https://www.espn.com/nba/injuries)

## 重要伤病提醒

- 数据采集脚本正在升级
EOF

sed -i "s/\$(date '+%Y-%m-%d %H:%M:%S')/$(date '+%Y-%m-%d %H:%M:%S')/g" "$RAW_DIR/$DATE/04-injuries.md"
sed -i "s/\$DATE/$DATE/g" "$RAW_DIR/$DATE/04-injuries.md"
echo "✅ 伤病报告文件已创建" >> "$LOG_FILE"

# ============================================
# 5. 新秀数据
# ============================================
echo "📊 [5/8] 采集新秀数据..." >> "$LOG_FILE"
cat > "$RAW_DIR/$DATE/05-rookies.md" << 'EOF'
# NBA新秀数据追踪

**采集时间**: $(date '+%Y-%m-%d %H:%M:%S')  
**数据日期**: $YESTERDAY

## 重点新秀关注

### Dylan Harper (马刺)
- 状态: 数据采集更新中
- 建议关注: 得分、助攻、上场时间

### Carter Bryant (马刺)
- 状态: 数据采集更新中
- 建议关注: 防守数据、三分球命中率

## 新秀排行榜

> 数据采集方式更新中...
>
> 参考: [NBA Rookie Stats](https://www.nba.com/stats/players/traditional/?SeasonType=Regular%20Season&dir=A&sort=PTS&Season=2025-26&PlayerPosition=ROOKIE)
EOF

sed -i "s/\$(date '+%Y-%m-%d %H:%M:%S')/$(date '+%Y-%m-%d %H:%M:%S')/g" "$RAW_DIR/$DATE/05-rookies.md"
sed -i "s/\$YESTERDAY/$YESTERDAY/g" "$RAW_DIR/$DATE/05-rookies.md"
echo "✅ 新秀数据文件已创建" >> "$LOG_FILE"

# ============================================
# 6. 球队排名
# ============================================
echo "📊 [6/8] 采集球队排名..." >> "$LOG_FILE"
cat > "$RAW_DIR/$DATE/06-standings.md" << 'EOF'
# NBA球队排名

**采集时间**: $(date '+%Y-%m-%d %H:%M:%S')

## 东部排名

> 数据采集方式更新中...
>
> 查看: [NBA Standings](https://www.nba.com/standings)

## 西部排名

> 数据采集方式更新中...

## 季后赛形势

- 数据采集脚本正在升级
EOF

sed -i "s/\$(date '+%Y-%m-%d %H:%M:%S')/$(date '+%Y-%m-%d %H:%M:%S')/g" "$RAW_DIR/$DATE/06-standings.md"
echo "✅ 排名文件已创建" >> "$LOG_FILE"

# ============================================
# 7. 交易动态
# ============================================
echo "📊 [7/8] 采集交易动态..." >> "$LOG_FILE"
cat > "$RAW_DIR/$DATE/07-trades.md" << 'EOF'
# NBA交易动态

**采集时间**: $(date '+%Y-%m-%d %H:%M:%S')  
**数据日期**: $DATE

## 最新交易传闻

> 数据采集方式更新中...
>
> 关注:
> - [ESPN NBA Trade Rumors](https://www.espn.com/nba/rumors)
> - [The Athletic NBA](https://theathletic.com/nba/)

## 交易截止日提醒

- 数据采集脚本正在升级
EOF

sed -i "s/\$(date '+%Y-%m-%d %H:%M:%S')/$(date '+%Y-%m-%d %H:%M:%S')/g" "$RAW_DIR/$DATE/07-trades.md"
sed -i "s/\$DATE/$DATE/g" "$RAW_DIR/$DATE/07-trades.md"
echo "✅ 交易动态文件已创建" >> "$LOG_FILE"

# ============================================
# 8. 重要新闻
# ============================================
echo "📊 [8/8] 采集重要新闻..." >> "$LOG_FILE"
cat > "$RAW_DIR/$DATE/08-news.md" << 'EOF'
# NBA重要新闻

**采集时间**: $(date '+%Y-%m-%d %H:%M:%S')  
**数据日期**: $DATE

## 头条新闻

> 数据采集方式更新中...
>
> 新闻来源:
> - [NBA.com News](https://www.nba.com/news)
> - [ESPN NBA](https://www.espn.com/nba/)
> - [The Athletic](https://theathletic.com/nba/)

## 影响球星卡价值的新闻

- 数据采集脚本正在升级
EOF

sed -i "s/\$(date '+%Y-%m-%d %H:%M:%S')/$(date '+%Y-%m-%d %H:%M:%S')/g" "$RAW_DIR/$DATE/08-news.md"
sed -i "s/\$DATE/$DATE/g" "$RAW_DIR/$DATE/08-news.md"
echo "✅ 新闻文件已创建" >> "$LOG_FILE"

# ============================================
# 生成汇总报告
# ============================================
echo "" >> "$LOG_FILE"
echo "📝 生成汇总报告..." >> "$LOG_FILE"

# 计算文件数量
FILE_COUNT=$(ls -1 "$RAW_DIR/$DATE"/*.md 2>/dev/null | wc -l)

# 生成README
cat > "$RAW_DIR/$DATE/README.md" << EOF
# NBA数据采集报告 - $DATE

**采集日期**: $DATE  
**数据日期**: $YESTERDAY  
**采集时间**: $(date '+%H:%M:%S')  
**文件数量**: $FILE_COUNT

## ⚠️ 重要说明

本次采集使用了**占位符模式**，因为原依赖的 coze-web-search 脚本不可用。

## 📊 采集内容

| 序号 | 类别 | 文件 | 状态 |
|------|------|------|------|
| 1 | 昨日比赛 | 01-games.md | ⚠️ 占位符 |
| 2 | 得分榜 | 02-scoring.md | ⚠️ 占位符 |
| 3 | 篮板/助攻 | 03-rebounds-assists.md | ⚠️ 占位符 |
| 4 | 伤病报告 | 04-injuries.md | ⚠️ 占位符 |
| 5 | 新秀数据 | 05-rookies.md | ⚠️ 占位符 |
| 6 | 球队排名 | 06-standings.md | ⚠️ 占位符 |
| 7 | 交易动态 | 07-trades.md | ⚠️ 占位符 |
| 8 | 重要新闻 | 08-news.md | ⚠️ 占位符 |

## 🔧 修复建议

需要重新实现数据采集功能：

1. **方案A**: 使用 browser 工具访问 NBA 官网
2. **方案B**: 使用外部 API (如 balldontlie API)
3. **方案C**: 集成现有的 nba-card-tracker 技能

## 📁 数据位置

所有数据保存在: \`$RAW_DIR/$DATE/\`

## 🔄 自动化信息

- **采集脚本**: nba-daily-collection.sh
- **运行时间**: 每天 15:00 (北京时间)
- **下次采集**: $(date -d '+1 day' +%Y-%m-%d)

---

*自动生成 by OpenClaw NBA数据采集系统*  
*⚠️ 本次为占位符数据，需要修复采集脚本*
EOF

echo "✅ 汇总报告已生成" >> "$LOG_FILE"

# ============================================
# Git备份
# ============================================
if [ -d "$WORKSPACE/.git" ]; then
    echo "" >> "$LOG_FILE"
    echo "📦 执行Git备份..." >> "$LOG_FILE"
    cd "$WORKSPACE"
    
    # 配置git身份（如果未配置）
    if ! git config --global user.email >/dev/null 2>&1; then
        git config --global user.email "nba-tracker@openclaw.local"
        git config --global user.name "NBA Tracker"
        echo "⚙️ 已配置Git身份" >> "$LOG_FILE"
    fi
    
    git add -A "$DATA_DIR/raw/$DATE/" >> "$LOG_FILE" 2>&1 || true
    git commit -m "NBA数据采集 $DATE - 占位符模式" >> "$LOG_FILE" 2>&1 || echo "⚠️ Git提交失败或无变更" >> "$LOG_FILE"
    echo "✅ Git备份完成" >> "$LOG_FILE"
fi

# ============================================
# 记录完成
# ============================================
echo "" >> "$LOG_FILE"
echo "========================================" >> "$LOG_FILE"
echo "⚠️ NBA数据采集完成（占位符模式） - $(date '+%H:%M:%S')" >> "$LOG_FILE"
echo "📁 数据保存位置: $RAW_DIR/$DATE/" >> "$LOG_FILE"
echo "📄 文件数量: $FILE_COUNT" >> "$LOG_FILE"
echo "⚠️ 注意: 需要修复采集脚本以获取真实数据" >> "$LOG_FILE"
echo "========================================" >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

# 输出摘要到stdout
echo "🏀 NBA数据采集完成（占位符模式）!"
echo "📁 位置: $RAW_DIR/$DATE/"
echo "📄 文件数: $FILE_COUNT"
echo "📋 日志: $LOG_FILE"
echo "⚠️ 需要修复: coze-web-search 脚本不可用"
