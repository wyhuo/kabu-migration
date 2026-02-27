# 卡布定时任务配置

## 任务列表

| 时间 | 任务 | 说明 | 状态 |
|------|------|------|------|
| 00:00 | 生成每日摘要 | 归档昨日会话 | ✅ 已实现 |
| 00:05 | 同步 Memory | 只保留最近3天 | ✅ 已实现 |
| 00:10 | 重置会话 | 清理上下文 | ✅ 已实现 |
| 09:30 | 推送早报 | 给文炎推送今日内容 | 🔄 待配置 |
| 14:00 | 会话清理检查 | 预防token超限 | ✅ 已实现 |
| 15:00 | NBA数据采集 | 采集昨日数据 | 🔄 待修复 |
| 20:00 | 球星卡追踪 | 市场动态 | 🔄 待配置 |

## 配置方法

### 方法1：Cron 定时任务（推荐）

编辑 crontab：
```bash
crontab -e
```

添加任务：
```bash
# 卡布定时任务

# 每日 09:30 推送早报
30 9 * * * cd /workspace/projects/workspace && bash scripts/daily-push.sh >> logs/daily-push.log 2>&1

# 每日 15:00 采集NBA数据
0 15 * * * cd /workspace/projects/workspace && bash knowledge/nba-data/scripts/nba-daily-collection-v2.sh >> logs/nba-collection.log 2>&1

# 每日 20:00 球星卡追踪
0 20 * * * cd /workspace/projects/workspace && bash scripts/card-market-track.sh >> logs/card-track.log 2>&1
```

### 方法2：Heartbeat 触发

在 HEARTBEAT.md 中添加检查：
```markdown
### 定时任务检查
- 检查是否到 09:30，推送早报
- 检查是否到 15:00，采集NBA数据
- 检查是否到 20:00，追踪球星卡
```

### 方法3：OpenClaw Gateway Cron

如果 Gateway 支持 cron：
```json
{
  "cron": [
    {
      "schedule": "30 9 * * *",
      "command": "daily-push"
    },
    {
      "schedule": "0 15 * * *",
      "command": "nba-collection"
    }
  ]
}
```

## 当前状态

- ✅ 00:00-00:10 归档任务已实现
- 🔄 09:30 推送待配置
- 🔄 15:00 数据采集待修复
- 🔄 20:00 球星卡追踪待实现
