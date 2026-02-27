#!/bin/bash
#
# 沙箱恢复检查脚本
# 用途：沙箱恢复后立即检查并执行错过的任务
#

WORKSPACE="/workspace/projects/workspace"
LOG_FILE="$WORKSPACE/knowledge/nba-data/cron-logs/sandbox-recovery.log"
TODAY=$(date +%Y-%m-%d)
CURRENT_HOUR=$(date +%H)

mkdir -p "$(dirname "$LOG_FILE")"

echo "========================================" >> "$LOG_FILE"
echo "🔄 沙箱恢复检查 - $(date '+%Y-%m-%d %H:%M:%S')" >> "$LOG_FILE"
echo "========================================" >> "$LOG_FILE"

# 1. 检查今日是否已重置
RESET_FILE="$WORKSPACE/memory/RESET_${TODAY//-}.md"
if [ ! -f "$RESET_FILE" ]; then
    echo "⚠️ 今日重置未完成，立即执行..." >> "$LOG_FILE"
    
    # 执行摘要生成
    if [ -f "$WORKSPACE/scripts/generate-daily-summary.js" ]; then
        echo "📄 生成昨日摘要..." >> "$LOG_FILE"
        node "$WORKSPACE/scripts/generate-daily-summary.js" >> "$LOG_FILE" 2>&1 || echo "⚠️ 摘要生成失败" >> "$LOG_FILE"
    fi
    
    # 执行memory同步
    if [ -f "$WORKSPACE/scripts/sync-memory-summaries.sh" ]; then
        echo "📂 同步Memory摘要..." >> "$LOG_FILE"
        bash "$WORKSPACE/scripts/sync-memory-summaries.sh" >> "$LOG_FILE" 2>&1 || echo "⚠️ 同步失败" >> "$LOG_FILE"
    fi
    
    # 执行重置
    if [ -f "$WORKSPACE/scripts/daily-reset.sh" ]; then
        echo "🔄 执行每日重置..." >> "$LOG_FILE"
        bash "$WORKSPACE/scripts/daily-reset.sh" >> "$LOG_FILE" 2>&1 || echo "⚠️ 重置失败" >> "$LOG_FILE"
    fi
    
    echo "✅ 归档重置任务完成" >> "$LOG_FILE"
else
    echo "✅ 今日重置已完成: $RESET_FILE" >> "$LOG_FILE"
fi

# 2. 检查NBA数据采集（如果过了15:00）
NBA_DIR="$WORKSPACE/knowledge/nba-data/raw/$TODAY"
if [ ! -d "$NBA_DIR" ] && [ "$CURRENT_HOUR" -ge 15 ]; then
    echo "⚠️ 今日NBA数据未采集，立即执行..." >> "$LOG_FILE"
    if [ -f "$WORKSPACE/knowledge/nba-data/scripts/nba-daily-collection.sh" ]; then
        bash "$WORKSPACE/knowledge/nba-data/scripts/nba-daily-collection.sh" >> "$LOG_FILE" 2>&1
        echo "✅ NBA数据采集完成" >> "$LOG_FILE"
    fi
else
    echo "✅ NBA数据已采集或未到采集时间" >> "$LOG_FILE"
fi

# 3. 检查会话大小
SESSION_DIR="/workspace/projects/agents/main/sessions"
CURRENT_SESSION=$(ls -t "$SESSION_DIR"/*.jsonl 2>/dev/null | head -1)
if [ -n "$CURRENT_SESSION" ]; then
    SIZE_KB=$(du -k "$CURRENT_SESSION" | cut -f1)
    echo "📊 当前会话大小: ${SIZE_KB}KB" >> "$LOG_FILE"
    if [ "$SIZE_KB" -gt 200 ]; then
        echo "⚠️ 警告：会话超过200KB，建议重置" >> "$LOG_FILE"
    fi
fi

echo "========================================" >> "$LOG_FILE"
echo "" >> "$LOG_FILE"
