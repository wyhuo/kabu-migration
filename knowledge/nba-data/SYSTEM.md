# 🏀 NBA每日数据采集系统

**系统状态**: ✅ 已启用  
**运行时间**: 每天上午 9:30 (北京时间)  
**数据保存**: 本地 + Git自动备份  
**数据保留**: 永久保存

---

## 📋 系统说明

### 自动化流程

每天上午9:30，系统会自动执行以下操作：

1. **采集昨日NBA数据**（8个类别）
2. **保存到本地目录**（按日期归档）
3. **自动生成汇总报告**
4. **Git自动备份**（确保数据永不丢失）

---

## 📊 采集内容

| 序号 | 类别 | 文件 | 说明 |
|------|------|------|------|
| 1 | 昨日比赛 | 01-games.md | 所有比赛结果和球员数据 |
| 2 | 得分榜 | 02-scoring.md | 球员得分排名 |
| 3 | 篮板/助攻 | 03-rebounds-assists.md | 篮板和助攻榜 |
| 4 | 伤病报告 | 04-injuries.md | 球员伤病情况 |
| 5 | 新秀数据 | 05-rookies.md | 新秀表现（含Carter Bryant、Dylan Harper） |
| 6 | 球队排名 | 06-standings.md | 东西部排名 |
| 7 | 交易动态 | 07-trades.md | 交易传闻和实际交易 |
| 8 | 重要新闻 | 08-news.md | NBA重要新闻 |
| - | 汇总报告 | README.md | 每日数据汇总 |

---

## 📁 数据存储位置

```
/workspace/projects/workspace/knowledge/nba-data/
├── raw/                          # 原始数据
│   ├── 2026-02-25/              # 日期目录
│   │   ├── 01-games.md
│   │   ├── 02-scoring.md
│   │   ├── 03-rebounds-assists.md
│   │   ├── 04-injuries.md
│   │   ├── 05-rookies.md
│   │   ├── 06-standings.md
│   │   ├── 07-trades.md
│   │   ├── 08-news.md
│   │   └── README.md            # 汇总报告
│   ├── 2026-02-26/              # 下一天数据
│   └── ...
├── scripts/                      # 脚本
│   └── nba-daily-collection.sh  # 采集脚本
├── cron-logs/                    # 日志
│   └── nba-collection-YYYY-MM-DD.log
└── SYSTEM.md                     # 本文件
```

---

## 🔄 数据备份策略

### 本地存储
- 所有数据保存在 `/workspace/projects/workspace/knowledge/nba-data/raw/`
- 按日期分类，永久保存

### Git备份
- 每天采集完成后自动执行 `git commit`
- 提交信息：`NBA数据采集 YYYY-MM-DD - 自动提交`
- 确保数据即使系统故障也不会丢失

---

## 📈 历史数据

已采集数据：
- ✅ 2026-02-24 数据（10场比赛）

即将采集：
- ⏳ 2026-02-25 数据（明天9:30自动采集）

---

## 🛠️ 手动操作

### 立即采集今天数据
```bash
bash /workspace/projects/workspace/knowledge/nba-data/scripts/nba-daily-collection.sh
```

### 查看采集日志
```bash
cat /workspace/projects/workspace/knowledge/nba-data/cron-logs/nba-collection-$(date +%Y-%m-%d).log
```

### 查看最新数据
```bash
ls -la /workspace/projects/workspace/knowledge/nba-data/raw/
```

---

## 📝 系统配置

### Cron任务
- **任务ID**: `74134690-578b-4476-bb4f-39e86d6a70b7`
- **执行时间**: 每天 09:30 (Asia/Shanghai)
- **执行方式**: 隔离会话 (isolated)
- **超时时间**: 300秒

### 数据来源
- ESPN
- NBA官网
- 其他权威体育媒体

---

## ⚠️ 注意事项

1. **数据延迟**: 采集的是昨日数据（NBA比赛在美国时间晚上进行）
2. **网络依赖**: 需要网络连接才能采集数据
3. **数据完整性**: 偶尔某些类别可能采集失败，会在日志中记录
4. **存储空间**: 每天约生成 300-500KB 数据，长期积累会占用空间

---

## 📞 问题排查

### 数据采集失败
1. 检查日志：`cron-logs/nba-collection-YYYY-MM-DD.log`
2. 检查网络连接
3. 手动运行脚本测试

### Git备份失败
- 不影响本地数据保存
- 检查git配置：`git status`

---

*系统创建时间: 2026-02-25*  
*最后更新: 2026-02-25*  
*创建者: OpenClaw Agent*
