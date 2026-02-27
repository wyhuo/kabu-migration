# OpenClaw 每日摘要自动化工作流

## 概述

这个自动化工作流实现了与 Coze 相同的智能管理动态加载机制：
- 每天凌晨自动读取过去 24 小时的 memory 文件
- 使用 Kimi 生成每日摘要
- 将摘要保存到 `daily_summary` 目录
- 日常对话时只加载最近 3 天的摘要，大幅降低 Token 消耗

## 目录结构

```
/workspace/projects/workspace/
├── memory/              # 当前加载的 memory 文件（仅最近3天摘要）
├── summary/             # 历史 memory 文件备份（按日期归档）
└── daily_summary/       # 每日摘要文件
```

## 自动化脚本

### 1. generate-daily-summary.js
**位置**: `/workspace/projects/scripts/generate-daily-summary.js`

**功能**:
- 读取过去 24 小时内的所有 memory 文件
- 调用 Kimi API 生成结构化摘要
- 保存到 `daily_summary/YYYY-MM-DD.md`

**手动运行**:
```bash
node /workspace/projects/scripts/generate-daily-summary.js
```

### 2. sync-memory-summaries.sh
**位置**: `/workspace/projects/scripts/sync-memory-summaries.sh`

**功能**:
- 清空 `memory/` 目录（保留模板文件）
- 复制最近 3 天的摘要到 `memory/` 目录
- 确保 OpenClaw 只加载必要的上下文

**手动运行**:
```bash
bash /workspace/projects/scripts/sync-memory-summaries.sh
```

### 3. daily-summary-daemon.sh
**位置**: `/workspace/projects/scripts/daily-summary-daemon.sh`

**功能**:
- 守护进程，每天凌晨 0 点自动触发摘要生成
- 日志记录到 `/tmp/openclaw/daily-summary-daemon.log`

**启动守护进程**:
```bash
# 后台运行
bash /workspace/projects/scripts/daily-summary-daemon.sh &

# 查看日志
tail -f /tmp/openclaw/daily-summary-daemon.log
```

## 工作流程

### 每日自动化流程（建议在 crontab 中配置）

```
0 0 * * * node /workspace/projects/scripts/generate-daily-summary.js
0 5 * * * bash /workspace/projects/scripts/sync-memory-summaries.sh
```

说明：
- **0:00** - 生成昨日摘要
- **0:05** - 同步最近 3 天摘要到 memory 目录

### 手动管理流程

当需要立即更新摘要时：
```bash
# 1. 生成摘要
node /workspace/projects/scripts/generate-daily-summary.js

# 2. 同步到 memory 目录
bash /workspace/projects/scripts/sync-memory-summaries.sh

# 3. 重启 OpenClaw Gateway
sh /workspace/projects/scripts/restart.sh
```

## 配置说明

### Kimi API 配置
编辑 `/workspace/projects/scripts/generate-daily-summary.js`:
```javascript
const CONFIG = {
  kimiApi: {
    baseUrl: 'api.moonshot.cn',
    apiKey: 'your-api-key',
    model: 'kimi-k2.5'
  }
};
```

### 动态加载策略
- **memory/** 目录：只保留最近 3 天的摘要
- **daily_summary/** 目录：保存所有历史摘要
- **summary/** 目录：保存原始 memory 文件备份

## Token 节省效果

### 优化前
- 所有 memory 文件加载：约 359,294 tokens
- 超过 Kimi 限制（262,144），导致 400 错误

### 优化后
- 最近 3 天摘要：约 10,000-20,000 tokens
- 远低于限制，大幅降低 API 成本

## 摘要模板

每日摘要包含以下部分：
1. 📋 概览 - 关键指标
2. ⏰ 时间线 - 按时间顺序的活动
3. 🎯 主要成果 - 任务完成情况
4. 🔑 学习要点 - 重要知识沉淀
5. ⚠️ 问题与解决 - 技术问题和解决方案

## 维护建议

1. **定期清理**：每月清理 `summary/` 目录中的旧文件
2. **备份策略**：重要摘要可以手动归档到其他位置
3. **监控日志**：定期检查 `/tmp/openclaw/daily-summary-daemon.log`
4. **API 配额**：注意 Kimi API 的调用限制

## 故障排查

### 摘要生成失败
```bash
# 检查日志
cat /tmp/openclaw/daily-summary.log

# 验证 API Key
curl -X POST https://api.moonshot.cn/v1/chat/completions \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"model":"kimi-k2.5","messages":[{"role":"user","content":"test"}]}'
```

### memory 目录未更新
```bash
# 手动运行同步脚本
bash /workspace/projects/scripts/sync-memory-summaries.sh

# 检查文件权限
ls -la /workspace/projects/workspace/memory/
```

### Token 仍然超限
- 检查 `workspace/` 目录下的其他文件
- 减少 `knowledge/` 目录的内容
- 清理不必要的 skills 文件

## 总结

这个自动化工作流实现了：
✅ 每日自动生成摘要
✅ 动态加载最近 3 天摘要
✅ 大幅降低 Token 消耗
✅ 保持历史记录完整性
✅ 与 Coze 相同的智能管理机制

现在 OpenClaw 可以高效地管理上下文，避免 Token 超限问题！
