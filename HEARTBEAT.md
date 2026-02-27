# HEARTBEAT.md - 定期检查任务

## 🔄 沙箱恢复检查清单

每次收到heartbeat时，执行以下检查：

### 1. 检查每日归档任务是否正常执行
```bash
# 检查最后执行时间
ls -la /workspace/projects/workspace/memory/RESET_*.md 2>/dev/null | tail -1
```

**如果超过24小时未执行重置任务：**
- 立即执行归档和重置
- 运行：`bash /workspace/projects/scripts/daily-reset.sh`

### 2. 检查会话历史大小
```bash
# 获取当前会话大小
CURRENT=$(ls -t /workspace/projects/agents/main/sessions/*.jsonl 2>/dev/null | head -1)
if [ -n "$CURRENT" ]; then
  du -k "$CURRENT" | cut -f1
fi
```

**如果 > 200KB:**
- 请求重置会话
- 记录日志

### 3. 检查NBA数据采集
```bash
# 检查今日数据是否存在
TODAY=$(date +%Y-%m-%d)
if [ ! -d "/workspace/projects/workspace/knowledge/nba-data/raw/$TODAY" ]; then
  # 如果超过15:00且未采集，立即执行
  HOUR=$(date +%H)
  if [ "$HOUR" -ge 15 ]; then
    # 立即采集
    bash /workspace/projects/workspace/knowledge/nba-data/scripts/nba-daily-collection.sh
  fi
fi
```

---

## 📝 当前执行计划

| 时间 | 任务 | 说明 |
|------|------|------|
| 00:00 | 生成摘要 | 每日摘要生成 |
| 00:05 | 同步Memory | 只保留最近3天 |
| 00:10 | 重置会话 | 清理上下文 |
| 09:30 | 早报推送 | 给文炎推送今日内容 |
| 14:00 | 会话清理检查 | 预防token超限 |
| 15:00 | NBA数据采集 | 采集昨日数据 |
| 20:00 | 球星卡追踪 | 市场动态追踪 |

### 4. 检查定时任务
```bash
HOUR=$(date +%H)
MINUTE=$(date +%M)

# 09:30 早报推送
if [ "$HOUR" -eq 9 ] && [ "$MINUTE" -ge 25 ] && [ "$MINUTE" -le 35 ]; then
  bash /workspace/projects/workspace/scripts/cron-runner.sh morning
fi

# 15:00 NBA数据采集
if [ "$HOUR" -eq 15 ] && [ "$MINUTE" -ge 0 ] && [ "$MINUTE" -le 10 ]; then
  bash /workspace/projects/workspace/scripts/cron-runner.sh nba
fi

# 20:00 球星卡追踪
if [ "$HOUR" -eq 20 ] && [ "$MINUTE" -ge 0 ] && [ "$MINUTE" -le 10 ]; then
  bash /workspace/projects/workspace/scripts/cron-runner.sh cards
fi
```

---

## ⚠️ 沙箱恢复处理

如果沙箱在00:00-00:10期间恢复：
1. **检查是否错过了重置任务**
2. **立即执行daily-reset.sh**
3. **检查并执行错过的NBA数据采集**

如果会话token超限：
1. **请求重置当前会话**
2. **保留memory文件**
3. **重新开始对话**
