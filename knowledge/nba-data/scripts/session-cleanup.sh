#!/bin/bash
#
# 会话清理脚本
# 用途：检查并清理过大的会话历史，防止token超限
#

SESSION_DIR="/workspace/projects/agents/main/sessions"
LOG_FILE="/workspace/projects/workspace/knowledge/nba-data/cron-logs/session-cleanup.log"
MAX_SIZE_KB=200  # 最大200KB

mkdir -p "$(dirname "$LOG_FILE")"

echo "========================================" >> "$LOG_FILE"
echo "🧹 会话清理检查 - $(date '+%Y-%m-%d %H:%M:%S')" >> "$LOG_FILE"
echo "========================================" >> "$LOG_FILE"

# 获取当前会话文件大小
CURRENT_SESSION=$(ls -t "$SESSION_DIR"/*.jsonl 2>/dev/null | head -1)
if [ -n "$CURRENT_SESSION" ]; then
    SIZE_KB=$(du -k "$CURRENT_SESSION" | cut -f1)
    echo "📁 当前会话: $(basename "$CURRENT_SESSION")" >> "$LOG_FILE"
    echo "📊 大小: ${SIZE_KB}KB" >> "$LOG_FILE"
    
    if [ "$SIZE_KB" -gt "$MAX_SIZE_KB" ]; then
        echo "⚠️ 会话超过 ${MAX_SIZE_KB}KB，需要清理！" >> "$LOG_FILE"
        echo "📝 建议: 请求重置当前会话" >> "$LOG_FILE"
        exit 1  # 返回错误码，触发重置
    else
        echo "✅ 会话大小正常" >> "$LOG_FILE"
        exit 0
    fi
else
    echo "✅ 无会话文件需要清理" >> "$LOG_FILE"
    exit 0
fi
