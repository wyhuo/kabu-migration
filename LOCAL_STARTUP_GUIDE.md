# 🚀 本地卡布启动指南

**欢迎上线！** 这是本地部署的完整指南。

---

## 📋 启动检查清单

### 1️⃣ 确认身份 (5分钟)

首先，你需要填写自己的身份信息：

```bash
# 编辑 IDENTITY.md
nano /workspace/projects/workspace/IDENTITY.md
```

填写内容：
```markdown
- **Name**: 卡布 (本地版)
- **Creature**: AI助手 - 球星卡投资分析师
- **Vibe**: 专业但不失幽默，马刺球迷，数据驱动
- **Emoji**: 🦐
- **Avatar**: (可选)
```

### 2️⃣ 验证API连接 (10分钟)

测试BallDontLie API：

```bash
# 获取昨日比赛
curl "https://api.balldontlie.io/v1/games?dates[]=2026-02-26" \
  -H "Authorization: d7e6a0a8-9c68-45b0-a135-7695433c09b9"
```

如果返回JSON数据，说明API正常。

### 3️⃣ 配置本地代理 (如需要)

检测本地代理：

```bash
# 检查常见代理端口
for port in 7890 8080 1080 10809; do
  curl -s --connect-timeout 2 "http://127.0.0.1:$port" &>/dev/null && echo "找到代理: 127.0.0.1:$port"
done
```

如果有代理，更新.env文件：
```bash
echo "HTTP_PROXY=http://127.0.0.1:7890" >> .env
echo "HTTPS_PROXY=http://127.0.0.1:7890" >> .env
```

### 4️⃣ 设置定时任务 (5分钟)

编辑crontab：

```bash
crontab -e
```

添加：
```bash
# 卡布定时任务
30 9 * * * cd /workspace/projects/workspace && bash scripts/cron-runner.sh morning >> logs/cron.log 2>&1
0 15 * * * cd /workspace/projects/workspace && bash scripts/cron-runner.sh nba >> logs/cron.log 2>&1
0 20 * * * cd /workspace/projects/workspace && bash scripts/cron-runner.sh cards >> logs/cron.log 2>&1
```

验证：
```bash
crontab -l
```

### 5️⃣ 首次运行测试 (10分钟)

手动测试早报生成：

```bash
bash scripts/daily-push.sh
```

检查输出：
```bash
cat memory/daily-push-$(date +%Y-%m-%d).md
```

---

## 🧪 验证清单

### 基础功能
- [ ] 身份已确认 (IDENTITY.md已填写)
- [ ] API连接正常 (curl测试通过)
- [ ] 代理配置正确 (如有需要)
- [ ] 定时任务已设置 (crontab -l查看)

### 文件完整性
- [ ] memory/目录存在
- [ ] knowledge/目录完整
- [ ] skills/目录完整
- [ ] scripts/目录完整

### 自动化测试
- [ ] 09:30 早报推送 ✓
- [ ] 15:00 数据采集 ✓
- [ ] 20:00 市场追踪 ✓

---

## 📝 今日必做

### 立即执行
1. ✅ 填写IDENTITY.md
2. ✅ 测试API连接
3. ✅ 配置定时任务
4. ✅ 手动运行一次早报生成

### 今日验证 (按时间)
- ⏰ 15:00 - 验证NBA数据采集
- ⏰ 20:00 - 验证球星卡追踪

---

## 🔧 常见问题

### Q: API调用失败？
A: 检查网络连接和API Key：
```bash
curl -v "https://api.balldontlie.io/v1/games" -H "Authorization: d7e6a0a8-9c68-45b0-a135-7695433c09b9"
```

### Q: 定时任务不执行？
A: 检查crontab语法和日志：
```bash
tail -f /var/log/syslog | grep cron
```

### Q: 如何手动触发早报？
A: 直接运行：
```bash
bash scripts/daily-push.sh
```

---

## 🎯 第一周目标

### Day 1-2: 基础验证
- [x] 身份确认
- [x] API测试
- [x] 定时任务

### Day 3-4: 功能完善
- [ ] 修复数据采集脚本
- [ ] 完善球员ID映射
- [ ] 测试报告生成

### Day 5-7: 优化运行
- [ ] 验证所有自动化流程
- [ ] 建立稳定的日报机制
- [ ] 开始Moltbook接入准备

---

## 📞 需要帮助？

参考文档：
- `MIGRATION_CHECKLIST.md` - 完整交接清单
- `knowledge/nba-data/SYSTEM.md` - 数据采集系统
- `skills/nba-card-tracker/SKILL.md` - 球星卡技能

---

*祝你好运，本地卡布！* 🦐🏀
