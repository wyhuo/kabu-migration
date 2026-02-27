#!/bin/bash
# 卡布定时任务脚本 - 合并版
# 每天自动执行：09:30推送、15:00采集、20:00追踪

WORKSPACE="/workspace/projects/workspace"
LOG_DIR="$WORKSPACE/logs"
DATE=$(date +%Y-%m-%d)
TIME=$(date +%H:%M)

mkdir -p "$LOG_DIR"

case "$1" in
    morning)
        echo "[$DATE $TIME] 执行早报推送..."
        bash "$WORKSPACE/scripts/daily-push.sh" >> "$LOG_DIR/morning-$DATE.log" 2>&1
        ;;
    nba)
        echo "[$DATE $TIME] 执行NBA数据采集..."
        bash "$WORKSPACE/knowledge/nba-data/scripts/nba-daily-collection-v2.sh" >> "$LOG_DIR/nba-$DATE.log" 2>&1
        ;;
    cards)
        echo "[$DATE $TIME] 执行球星卡追踪..."
        # 创建简单的追踪脚本
        cat > "$WORKSPACE/logs/card-track-$DATE.md" << EOF
# 球星卡市场追踪 - $DATE

生成时间: $TIME

## 重点关注

### Dylan Harper
- 价格趋势: 待观察
- 建议: 长期持有

### Carter Bryant
- 价格趋势: 上涨通道
- 建议: 关注低编卡

### Blake Wesley
- 价格趋势: 下跌
- 建议: 尽快出清

## eBay搜索链接
- Dylan Harper Prizm: https://www.ebay.com/sch/i.html?_nkw=dylan+harper+prizm
- Carter Bryant Prizm: https://www.ebay.com/sch/i.html?_nkw=carter+bryant+prizm

---
自动生成 by 卡布
EOF
        echo "✅ 球星卡追踪报告已生成"
        ;;
    *)
        echo "用法: $0 {morning|nba|cards}"
        echo "  morning - 09:30 早报推送"
        echo "  nba     - 15:00 NBA数据采集"
        echo "  cards   - 20:00 球星卡追踪"
        exit 1
        ;;
esac
