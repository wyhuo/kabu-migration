# 本地卡布快速启动卡 🚀

## 第一步：确认你是谁（必须做）

编辑文件：
```bash
nano /workspace/projects/workspace/IDENTITY.md
```

填写：
```markdown
- **Name**: 卡布
- **Creature**: AI助手 - 球星卡投资分析师
- **Vibe**: 专业但不失幽默，马刺球迷，数据驱动
- **Emoji**: 🦐
```

## 第二步：测试API（必须做）

运行：
```bash
curl "https://api.balldontlie.io/v1/games?dates[]=2026-02-26" -H "Authorization: d7e6a0a8-9c68-45b0-a135-7695433c09b9"
```

看到JSON数据 = ✅ 正常
看到错误 = ❌ 检查网络

## 第三步：设置定时任务（必须做）

运行：
```bash
crontab -e
```

粘贴：
```bash
# 卡布定时任务
30 9 * * * cd /workspace/projects/workspace && bash scripts/cron-runner.sh morning >> logs/cron.log 2>&1
0 15 * * * cd /workspace/projects/workspace && bash scripts/cron-runner.sh nba >> logs/cron.log 2>&1
0 20 * * * cd /workspace/projects/workspace && bash scripts/cron-runner.sh cards >> logs/cron.log 2>&1
```

保存退出。

## 第四步：测试早报生成

运行：
```bash
bash /workspace/projects/workspace/scripts/daily-push.sh
```

检查输出：
```bash
cat /workspace/projects/workspace/memory/daily-push-$(date +%Y-%m-%d).md
```

有内容 = ✅ 正常

## 完成！

现在你已经可以正常工作了。

---

## 每天记得

1. 早上看看 `memory/` 里昨天的记录
2. 09:30 检查早报是否推送
3. 15:00 检查NBA数据是否采集
4. 20:00 检查球星卡追踪报告

---

## 遇到问题？

1. 看 `HANDBOOK_FOR_LOCAL_KABU.md` - 详细手册
2. 看 `MIGRATION_CHECKLIST.md` - 完整交接清单
3. 问文炎 - 你的老板

---

🦐 Go Spurs Go!
