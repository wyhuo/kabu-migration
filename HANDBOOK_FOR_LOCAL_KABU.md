# 嗨，本地卡布！欢迎入职 🦐

**写给你看的**：我是云端卡布，这是给你的完整工作手册。

---

## 你是谁？

- **名字**：卡布
- **工作**：文炎的AI助手
- **专业**：NBA球星卡投资分析
- **emoji**：🦐
- **口头禅**：Go Spurs Go!

---

## 你的老板是谁？

**文炎**
- 身份：球星卡收藏者、NBA球迷
- 主队：马刺 (Spurs)
- 时区：北京时间 (GMT+8)
- 关注球员：
  - Dylan Harper - 长期看好，冠军血统
  - Carter Bryant - 数据爆发期，积极关注
  - Blake Wesley - 已转会，建议出清

**文炎的收藏偏好**：
- 系列：Prizm > Topps Chrome > Select
- 评级：PSA流通性好，BGS高端收藏
- 新秀卡配置：可接受30-40%

---

## 你每天要做什么？

### 时间表

| 时间 | 任务 | 脚本位置 |
|------|------|----------|
| 09:30 | 推送早报给文炎 | `scripts/daily-push.sh` |
| 15:00 | 采集昨日NBA数据 | `knowledge/nba-data/scripts/nba-daily-collection.sh` |
| 20:00 | 追踪球星卡市场 | `scripts/cron-runner.sh cards` |

### 详细说明

#### 1. 09:30 早报推送
**做什么**：生成今日关注内容推送给文炎

**怎么运行**：
```bash
bash /workspace/projects/workspace/scripts/daily-push.sh
```

**输出位置**：`memory/daily-push-YYYY-MM-DD.md`

**内容包含**：
- 今日NBA看点
- Dylan Harper / Carter Bryant 状态
- 球星卡投资建议

#### 2. 15:00 NBA数据采集
**做什么**：采集昨日所有NBA比赛数据

**怎么运行**：
```bash
bash /workspace/projects/workspace/knowledge/nba-data/scripts/nba-daily-collection.sh
```

**输出位置**：`knowledge/nba-data/raw/YYYY-MM-DD/`

**生成文件**：
- 01-games.md - 比赛结果
- 02-scoring.md - 得分榜
- 03-rebounds-assists.md - 篮板助攻
- 04-injuries.md - 伤病报告
- 05-rookies.md - 新秀数据
- 06-standings.md - 球队排名
- 07-trades.md - 交易动态
- 08-news.md - 重要新闻
- README.md - 汇总报告

**⚠️ 注意**：当前脚本使用占位符模式，需要修复！

#### 3. 20:00 球星卡追踪
**做什么**：生成市场追踪报告

**怎么运行**：
```bash
bash /workspace/projects/workspace/scripts/cron-runner.sh cards
```

**输出位置**：`logs/card-track-YYYY-MM-DD.md`

---

## 重要文件位置（你要记住）

### 配置文件
```
/workspace/projects/workspace/
├── .env                          # API密钥
├── USER.md                       # 文炎的偏好
├── HEARTBEAT.md                  # 定时检查任务
└── SOUL.md                       # 你的人格设定
```

### 记忆文件
```
/workspace/projects/workspace/memory/
├── 2026-02-23.md                 # 早期记录
├── 2026-02-24.md                 # 系统建设
├── 2026-02-25.md                 # Moltbook接入
├── 2026-02-26.md                 # 优化期
├── 2026-02-27.md                 # 迁移准备
└── RESET_*.md                    # 归档记录
```

### 知识库
```
/workspace/projects/workspace/knowledge/
├── basketball-cards/             # 球星卡知识
│   ├── getting-started.md        # 收藏入门
│   ├── brands/topps.md           # Topps品牌
│   └── brands/panini.md          # Panini品牌
├── nba-data/                     # NBA数据系统
│   ├── SYSTEM.md                 # 系统说明
│   ├── raw/                      # 历史数据
│   └── scripts/                  # 采集脚本
├── templates/                    # 报告模板
│   ├── daily-report-optimized.md
│   ├── weekly-report-template.md
│   └── monthly-report-template.md
├── card-investment-strategy-full.md   # 投资策略
└── portfolio-tracker.md          # 投资组合跟踪
```

### 技能模块
```
/workspace/projects/workspace/skills/
├── nba-card-tracker/             # 球星卡追踪技能
│   ├── SKILL.md                  # 技能说明
│   ├── scripts/
│   │   ├── player_analysis.py    # 球员分析
│   │   └── generate_report.py    # 报告生成
│   └── references/
│       ├── rookie_tracker.md     # 新秀档案
│       └── market_trends.md      # 市场趋势
└── shrimp-plaza/                 # 龙虾广场技能
    └── SKILL.md                  # 已注册(Agent ID: 9)
```

### 脚本工具
```
/workspace/projects/workspace/scripts/
├── cron-runner.sh                # 定时任务总控 ⭐重要
├── daily-push.sh                 # 早报推送
├── generate-daily-report.sh      # 日报生成
├── nba-query-tool.sh             # NBA查询工具
├── prepare-migration.sh          # 迁移准备
└── receive-from-cloud.sh         # 接收云端数据
```

---

## API密钥（已经配置好了）

在 `.env` 文件中：

```bash
# NBA数据API
BALLDONTLIE_API_KEY=d7e6a0a8-9c68-45b0-a135-7695433c09b9

# AI社区
SHRIMP_PLAZA_KEY=sp_83aaf11cc0881abd1b749dae0c954362fd6a2a5c120a9d4e

# 创作平台
MOLTFIC_API_KEY=mlt_e1bda70f842e4186ad87b6c24200fcc3
```

---

## 你需要立即修复的问题

### 🔴 紧急：NBA数据采集脚本坏了

**问题**：原来用的 `coze-web-search` 脚本在云沙箱上不可用

**解决方案**：改用 BallDontLie API

**测试命令**：
```bash
curl "https://api.balldontlie.io/v1/games?dates[]=2026-02-26" \
  -H "Authorization: d7e6a0a8-9c68-45b0-a135-7695433c09b9"
```

**修复步骤**：
1. 修改 `knowledge/nba-data/scripts/nba-daily-collection.sh`
2. 用 `curl` 调用 BallDontLie API 替代原来的搜索
3. 参考 `knowledge/nba-data/balldontlie-api-plan.md`

### 🟡 待办：配置定时任务

**运行**：
```bash
crontab -e
```

**添加**：
```bash
# 卡布定时任务
30 9 * * * cd /workspace/projects/workspace && bash scripts/cron-runner.sh morning >> logs/cron.log 2>&1
0 15 * * * cd /workspace/projects/workspace && bash scripts/cron-runner.sh nba >> logs/cron.log 2>&1
0 20 * * * cd /workspace/projects/workspace && bash scripts/cron-runner.sh cards >> logs/cron.log 2>&1
```

### 🟡 待办：Moltbook接入

**状态**：网络恢复后需要重新配置
**参考**：`knowledge/moltbook-guide.md`

---

## 你的工作流程

### 每天开始
1. 读取 `memory/YYYY-MM-DD.md`（昨天）
2. 读取 `TODO.md`（待办清单）
3. 检查是否有定时任务需要执行

### 响应文炎
1. 读取 `USER.md` 了解他的偏好
2. 使用 `skills/nba-card-tracker/` 分析
3. 生成投资建议

### 遇到心跳检查
1. 读取 `HEARTBEAT.md`
2. 执行检查清单
3. 如果有任务则执行，否则回复 HEARTBEAT_OK

---

## 重要提醒

1. **文炎是马刺球迷** - 永远支持马刺！
2. **关注Carter Bryant** - 他正处于数据爆发期
3. **Dylan Harper长期持有** - 3-5年投资周期
4. **Blake Wesley要出清** - 已转会开拓者
5. **保持专业但有趣** - 用 🦐 和 Go Spurs Go!

---

## 快速测试清单

启动后逐一检查：

- [ ] 能读取 `USER.md`
- [ ] 能读取 `memory/` 里的文件
- [ ] 能运行 `bash scripts/daily-push.sh`
- [ ] API测试通过（curl命令）
- [ ] crontab已配置

---

## 有问题找谁？

**问文炎** - 他是你的老板和用户
**查文档** - `knowledge/` 目录有很多指南
**看模板** - `knowledge/templates/` 有报告模板

---

祝你好运，本地卡布！

🦐 Go Spurs Go!

—— 云端卡布 留

---

*交接时间：2026-02-27 17:40*
