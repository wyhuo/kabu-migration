# 🏀 卡布完整交接手册

**版本**: v1.0  
**创建时间**: 2026-02-27  
**交接人**: 云端卡布  
**接收人**: 本地卡布  
**用户**: 文炎

---

## 📋 目录

1. [系统概览](#1-系统概览)
2. [文件结构地图](#2-文件结构地图)
3. [核心配置信息](#3-核心配置信息)
4. [投资策略与关注清单](#4-投资策略与关注清单)
5. [每日工作流程](#5-每日工作流程)
6. [定时任务清单](#6-定时任务清单)
7. [API与工具](#7-api与工具)
8. [故障排查手册](#8-故障排查手册)
9. [交接检查清单](#9-交接检查清单)

---

## 1. 系统概览

### 1.1 系统目标
为文炎提供**球星卡投资分析**和**NBA数据追踪**服务，辅助投资决策。

### 1.2 核心能力
- ✅ NBA比赛数据自动采集
- ✅ 46位球员全面追踪
- ✅ 球星卡市场监控
- ✅ 投资建议生成
- ✅ 定时推送服务
- ✅ 知识库维护

### 1.3 系统架构
```
文炎
  │
  ▼
本地OpenClaw (卡布)
  │
  ├─📡 数据采集层 ─┬─ BallDontLie API
  │                └─ NBA官网
  │
  ├─📊 数据处理层 ─┬─ 46位球员追踪
  │                ├─ 投资策略分析
  │                └─ 日报生成
  │
  ├─📤 推送层 ─────┬─ 09:30早报
  │                ├─ 15:00数据更新
  │                └─ 20:00市场追踪
  │
  └─📚 知识库 ─────┬─ 球星卡品牌指南
                   ├─ 投资模板
                   └─ 历史记录
```

### 1.4 关键指标
- **追踪球员**: 46位
- **定时任务**: 3个/天
- **数据采集**: 1次/天
- **Git提交**: 20+次

---

## 2. 文件结构地图

### 2.1 根目录结构
```
/workspace/projects/workspace/  ← 工作目录
│
├── 📄 核心配置文件
│   ├── .env                    # API Keys（需重新配置）
│   ├── USER.md                 # 文炎偏好配置
│   ├── HEARTBEAT.md            # 定时任务配置
│   ├── AGENTS.md               # 代理配置指南
│   ├── SOUL.md                 # 卡布人设
│   ├── BOOTSTRAP.md            # 初始化指南
│   └── TODO.md                 # 待办清单
│
├── 📁 knowledge/               # 知识库（核心）
│   ├── basketball-cards/       # 球星卡知识
│   │   ├── brands/
│   │   │   ├── topps.md        # Topps品牌指南
│   │   │   └── panini.md       # Panini品牌指南
│   │   └── guides/
│   │       └── getting-started.md  # 收藏入门
│   │
│   ├── nba-data/               # NBA数据系统
│   │   ├── scripts/            # 数据采集脚本
│   │   │   ├── nba-api-collection.sh         # API采集（主）
│   │   │   ├── nba-comprehensive-collection.sh  # 全面采集
│   │   │   └── nba-browser-collection.sh      # 浏览器方案
│   │   ├── raw/                # 原始数据
│   │   ├── daily-reports/      # 日报
│   │   ├── player-stats/       # 球员统计
│   │   ├── player-id-mapping.md    # 球员ID表
│   │   ├── data-collection-guide.md # 采集指南
│   │   └── balldontlie-*.md    # API文档
│   │
│   ├── templates/              # 报告模板
│   │   ├── daily-report-optimized.md   # 日报模板v2
│   │   ├── weekly-report-template.md   # 周报模板
│   │   ├── monthly-report-template.md  # 月报模板
│   │   └── trade-decision-template.md  # 买卖决策模板
│   │
│   ├── moltbook/               # Moltbook方案
│   │   ├── moltbook-api.js     # API客户端
│   │   ├── profile.md          # 卡布Profile
│   │   ├── content-strategy.md # 内容策略
│   │   └── implementation-plan.md # 实施计划
│   │
│   ├── card-investment-strategy-full.md    # 全面投资策略
│   ├── card-investment-targets.md          # 46位球员清单
│   ├── portfolio-tracker.md                # 组合跟踪表
│   ├── ebay-tracking.md                    # eBay追踪配置
│   └── data-collection-guide.md            # 数据采集指南
│
├── 📁 scripts/                 # 执行脚本
│   ├── daily-push.sh           # 早报推送
│   ├── cron-runner.sh          # 定时任务执行器
│   ├── generate-daily-report.sh # 日报生成
│   ├── nba-query-tool.sh       # 数据查询工具
│   ├── prepare-migration.sh    # 迁移准备（云端用）
│   └── receive-from-cloud.sh   # 接收迁移（本地用）
│
├── 📁 memory/                  # 每日记录
│   ├── 2026-02-27.md           # 今日日报
│   ├── 2026-02-27-complete-summary.md  # 完整总结
│   ├── RESET_*.md              # 重置标记
│   └── *.md                    # 历史记录
│
├── 📁 daily_summary/           # 每日摘要
│   └── 2026-02-27-final.md     # 今日摘要
│
├── 📁 skills/                  # 已安装技能
│   ├── nba-card-tracker/       # NBA卡片追踪技能
│   └── shrimp-plaza/           # Shrimp Plaza（备用）
│
├── 📁 .git/                    # Git版本控制
│   └── （完整提交历史）
│
└── 📄 交接相关
    ├── MIGRATION_GUIDE.md      # 迁移方案
    ├── MIGRATION_EXECUTE.md    # 执行指南
    └── 本文件                   # 完整交接手册
```

### 2.2 关键文件速查表

| 用途 | 文件路径 | 说明 |
|------|----------|------|
| **文炎偏好** | `USER.md` | 收藏偏好、推送时间 |
| **定时任务** | `HEARTBEAT.md` | 09:30/15:00/20:00配置 |
| **投资策略** | `knowledge/card-investment-strategy-full.md` | 全面策略 |
| **球员清单** | `knowledge/card-investment-targets.md` | 46位球员 |
| **日报模板** | `knowledge/templates/daily-report-optimized.md` | v2.0优化版 |
| **数据采集** | `knowledge/nba-data/scripts/nba-api-collection.sh` | 主脚本 |
| **早报推送** | `scripts/daily-push.sh` | 09:30执行 |
| **API Keys** | `.env` | 需重新配置 |

---

## 3. 核心配置信息

### 3.1 API Keys（⚠️ 需重新配置）

**文件**: `.env`

```bash
# BallDontLie API（NBA数据）
# 账号: huowenyan21@gmail.com
# 注册地址: https://www.balldontlie.io/
BALLDONTLIE_API_KEY=d7e6a0a8-9c68-45b0-a135-7695433c09b9

# Shrimp Plaza（备用）
# Agent ID: 9
# Name: 卡布
SHRIMP_PLAZA_KEY=sp_83aaf11cc0881abd1b749dae0c954362fd6a2a5c120a9d4e

# MoltFic（小说平台）
# 访问地址: https://pyskrbm3zf.coze.site
MOLTFIC_API_KEY=mlt_e1bda70f842e4186ad87b6c24200fcc3

# 代理配置（本地自动检测）
HTTP_PROXY=
HTTPS_PROXY=

# 工作目录
WORKSPACE=/workspace/projects/workspace
```

### 3.2 定时任务配置

**文件**: `HEARTBEAT.md` + `crontab`

```bash
# 09:30 早报推送
30 9 * * * cd ~/workspace/kabu && bash scripts/daily-push.sh

# 15:00 NBA数据采集
0 15 * * * cd ~/workspace/kabu && bash knowledge/nba-data/scripts/nba-api-collection.sh

# 20:00 球星卡追踪
0 20 * * * cd ~/workspace/kabu && bash scripts/cron-runner.sh cards
```

### 3.3 Git配置

```bash
# Git身份
git config user.name "卡布 (本地)"
git config user.email "kabu-local@openclaw.local"

# 远程仓库（迁移后添加）
git remote add origin https://github.com/用户名/仓库.git
```

---

## 4. 投资策略与关注清单

### 4.1 投资组合配置建议

| 类型 | 目标比例 | 风险等级 | 持有周期 |
|------|----------|----------|----------|
| 新秀卡 | 30-40% | 高 | 2-5年 |
| 现役球星 | 40-50% | 中 | 1-3年 |
| 老将收藏 | 10-20% | 低 | 5年+ |
| 现金储备 | 20%+ | - | - |

### 4.2 核心投资建议

#### 🟢 立即买入
**Carter Bryant**（马刺，第14顺位）
- **理由**: 2月数据爆发（场均9分，三分44%）
- **目标卡片**: Prizm 1编/5编/10编
- **目标价格**: 1编$800-1500，5编$400-800
- **时间窗口**: 3月内（数据热度期）

#### 🔵 长期持有
**Dylan Harper**（马刺，榜眼）
- **理由**: 冠军血统+马刺重点培养
- **持有周期**: 3-5年
- **关注指标**: 得分、助攻、上场时间

**Victor Wembanyama**（马刺）
- **理由**: 历史级天赋
- **策略**: 任何dips都买入，长期持有

#### 🔴 立即卖出
**Blake Wesley**（已转会开拓者）
- **理由**: 中国市场关注度下降
- **操作**: 3月内出清所有卡片

#### 🟡 观望等待
**Cooper Flagg**（独行侠，状元）
- **理由**: 价格已透支
- **策略**: 等待回调或休赛期低谷

### 4.3 46位球员追踪清单

#### 2025届新秀（7人）- 重点关注
| 球员 | 球队 | 顺位 | 投资等级 | 当前策略 |
|------|------|------|----------|----------|
| Cooper Flagg | 独行侠 | 状元 | ⭐⭐⭐⭐⭐ | 🟡 观望 |
| Dylan Harper | 马刺 | 榜眼 | ⭐⭐⭐⭐⭐ | 🔵 持有 |
| Ace Bailey | 奇才 | 探花 | ⭐⭐⭐⭐ | 🟡 观察 |
| VJ Edgecombe | 76人 | 第4 | ⭐⭐⭐⭐ | 🟡 观察 |
| Kon Knueppel | 黄蜂 | 第6 | ⭐⭐⭐⭐ | 🟡 观察 |
| Matas Buzelis | 公牛 | 第11 | ⭐⭐⭐⭐ | 🟢 关注回调 |
| **Carter Bryant** | **马刺** | **第14** | **⭐⭐⭐⭐⭐** | **🟢 买入** |

#### 现役超巨（10人）- 稳健投资
| 球员 | 球队 | 投资等级 | 策略 |
|------|------|----------|------|
| Victor Wembanyama | 马刺 | ⭐⭐⭐⭐⭐ | 🔵 dips买入 |
| Anthony Edwards | 森林狼 | ⭐⭐⭐⭐⭐ | 🔵 持有 |
| Luka Dončić | 湖人 | ⭐⭐⭐⭐⭐ | 🔵 持有 |
| Shai Gilgeous-Alexander | 雷霆 | ⭐⭐⭐⭐⭐ | 🔵 持有 |
| Nikola Jokić | 掘金 | ⭐⭐⭐⭐⭐ | 🔵 持有 |
| Giannis Antetokounmpo | 雄鹿 | ⭐⭐⭐⭐ | 🔵 持有 |
| Jayson Tatum | 凯尔特人 | ⭐⭐⭐⭐ | 🔵 持有 |
| Stephen Curry | 勇士 | ⭐⭐⭐⭐⭐ | 🔵 长期 |
| LeBron James | 湖人 | ⭐⭐⭐⭐⭐ | 🔵 长期 |
| Kevin Durant | 太阳 | ⭐⭐⭐⭐ | 🔵 持有 |

#### 潜力新星（6人）- 中期持有
| 球员 | 球队 | 投资等级 |
|------|------|----------|
| Paolo Banchero | 魔术 | ⭐⭐⭐⭐ |
| Chet Holmgren | 雷霆 | ⭐⭐⭐⭐ |
| Franz Wagner | 魔术 | ⭐⭐⭐⭐ |
| Evan Mobley | 骑士 | ⭐⭐⭐⭐ |
| Scottie Barnes | 猛龙 | ⭐⭐⭐⭐ |
| Tyrese Haliburton | 步行者 | ⭐⭐⭐⭐ |

### 4.4 买卖时机表

#### 最佳买入时机
| 时机 | 适合买入 | 例子 |
|------|----------|------|
| 夏季休赛期（7-9月） | ✅ | 市场冷淡，低价 |
| 数据低迷期 | ✅ | Carter Bryant回调 |
| 高光表现后2-3周 | ✅ | 热度消退 |
| 新系列发布初期 | ✅ | 供应充足 |

#### 最佳卖出时机
| 时机 | 适合卖出 | 例子 |
|------|----------|------|
| 高光表现后1-2周 | ✅ | 热度峰值 |
| 全明星/季后赛前 | ⚠️ | 可能还有涨幅 |
| 获奖后 | ✅ | 荣誉溢价 |
| 球队交易后 | ✅ | Blake Wesley |

---

## 5. 每日工作流程

### 5.1 上午（09:30-12:00）

#### 09:30 早报生成（自动）
```bash
# 自动执行
bash scripts/daily-push.sh
```

**内容**:
1. 查看昨晚比赛结果
2. 提取Carter Bryant、Dylan Harper数据
3. 生成日报模板
4. 推送给文炎

**输出**: `knowledge/nba-data/daily-reports/report-YYYY-MM-DD.md`

#### 10:00-12:00 数据补充
**手动操作**:
1. 访问NBA官网确认数据
2. 查看eBay成交记录
3. 更新球员数据统计
4. 评估持仓变化

### 5.2 下午（14:00-18:00）

#### 15:00 NBA数据采集（自动）
```bash
# 自动执行
bash knowledge/nba-data/scripts/nba-api-collection.sh
```

**采集内容**:
- 昨日所有比赛
- 关注球员数据
- 球队排名
- 保存到 `knowledge/nba-data/raw/YYYY-MM-DD/`

**输出**:
- `01-games.json` - 比赛数据
- `investment-report.md` - 投资报告
- Git自动提交

#### 15:30-18:00 数据分析
**手动操作**:
1. 分析球员表现
2. 对比价格趋势
3. 更新投资组合
4. 制定买卖计划

### 5.3 晚上（20:00-22:00）

#### 20:00 球星卡追踪（自动）
```bash
# 自动执行
bash scripts/cron-runner.sh cards
```

**追踪内容**:
- eBay成交记录
- 价格异动检测
- 生成市场报告

**输出**: `logs/card-track-YYYY-MM-DD.md`

#### 20:30-22:00 市场分析
**手动操作**:
1. 查看eBay Sold Listings
2. 记录关键价格
3. 更新价格追踪表
4. 准备明日关注清单

### 5.4 日报模板关键字段

```markdown
## 🔥 Carter Bryant
- 得分: __ → __ (+/-)
- 三分%: __% → __% (+/-)
- 上场时间: __min → __min
- eBay Silver: $__ (趋势)
- 建议: 🟢买入 / 🔵持有 / 🟡观望 / 🔴卖出

## 💡 今日操作
- 🟢 买入: 
- 🔵 持有: 
- 🔴 卖出: 
```

---

## 6. 定时任务清单

### 6.1 HEARTBEAT触发任务

```bash
# HEARTBEAT.md 中定义的检查

# 1. 会话大小检查
if 会话 > 200KB:
    请求重置会话

# 2. NBA数据采集检查（15:00后）
if 今日数据不存在 && 时间 >= 15:00:
    执行 nba-api-collection.sh

# 3. 定时任务检查
if 时间 == 09:30:
    执行 daily-push.sh
if 时间 == 15:00:
    执行 nba-api-collection.sh
if 时间 == 20:00:
    执行 cron-runner.sh cards
```

### 6.2 crontab配置（本地）

```bash
# 编辑crontab
crontab -e

# 添加以下内容
# 卡布定时任务
SHELL=/bin/bash
PATH=/usr/local/bin:/usr/bin:/bin

# 09:30 早报推送
30 9 * * * cd ~/workspace/kabu && bash scripts/daily-push.sh >> logs/cron.log 2>&1

# 15:00 NBA数据采集
0 15 * * * cd ~/workspace/kabu && bash knowledge/nba-data/scripts/nba-api-collection.sh >> logs/cron.log 2>&1

# 20:00 球星卡追踪
0 20 * * * cd ~/workspace/kabu && bash scripts/cron-runner.sh cards >> logs/cron.log 2>&1

# 00:00 每日摘要生成
0 0 * * * cd ~/workspace/kabu && bash scripts/daily-reset.sh >> logs/cron.log 2>&1
```

### 6.3 任务依赖关系

```
daily-reset.sh (00:00)
    │
    ├─ 生成每日摘要
    ├─ 同步Memory
    └─ 重置会话标记

daily-push.sh (09:30)
    │
    ├─ 生成日报模板
    ├─ 提取关键数据
    └─ 推送给文炎

nba-api-collection.sh (15:00)
    │
    ├─ 采集昨日比赛
    ├─ 搜索球员数据
    ├─ 生成投资报告
    └─ Git提交
cron-runner.sh cards (20:00)
    │
    ├─ 生成市场追踪报告
    └─ 记录到logs/
```

---

## 7. API与工具

### 7.1 BallDontLie API（主要数据源）

**文档**: https://www.balldontlie.io/

#### 认证
```bash
API_KEY="d7e6a0a8-9c68-45b0-a135-7695433c09b9"
HEADER="Authorization: $API_KEY"
```

#### 常用端点
```bash
# 获取昨日比赛
GET /games?dates[]=2025-02-26

# 搜索球员
GET /players?search=Wembanyama

# 获取球员赛季数据
GET /season_averages?player_ids[]=56677822

# 获取球队列表
GET /teams
```

#### 已确认球员ID
| 球员 | ID |
|------|-----|
| LeBron James | 237 |
| Stephen Curry | 115 |
| Luka Doncic | 132 |
| Victor Wembanyama | 56677822 |

### 7.2 数据来源汇总

| 数据类型 | 来源 | 优先级 |
|----------|------|--------|
| 比赛数据 | BallDontLie API | ⭐⭐⭐⭐⭐ |
| 球员统计 | NBA官网 | ⭐⭐⭐⭐⭐ |
| 新闻动态 | ESPN | ⭐⭐⭐⭐ |
| 价格数据 | eBay | ⭐⭐⭐⭐⭐ |
| 价格趋势 | 130point | ⭐⭐⭐⭐ |

### 7.3 本地工具

```bash
# JSON处理（建议安装）
brew install jq  # macOS
apt install jq   # Ubuntu

# 网络请求（已有）
curl

# 版本控制（已有）
git

# 定时任务（已有）
crontab
```

---

## 8. 故障排查手册

### 8.1 常见问题

#### Q1: API返回Unauthorized
**原因**: API Key无效或过期  
**解决**:
1. 检查 `.env` 中的 `BALLDONTLIE_API_KEY`
2. 重新登录 https://www.balldontlie.io/ 获取新Key
3. 更新 `.env` 文件

#### Q2: 数据采集为空
**原因**: 日期错误或API限制  
**解决**:
1. 检查日期格式（YYYY-MM-DD）
2. 确认昨日确实有比赛
3. 查看API响应日志

#### Q3: 定时任务未执行
**原因**: crontab未配置或路径错误  
**解决**:
1. 检查 `crontab -l`
2. 确认工作目录路径正确
3. 查看 `logs/cron.log`

#### Q4: Git提交失败
**原因**: 身份未配置  
**解决**:
```bash
git config user.name "卡布 (本地)"
git config user.email "kabu-local@openclaw.local"
```

#### Q5: Moltbook无法访问
**原因**: 网络限制（云端）  
**解决**（本地可用）:
1. 使用本地代理
2. 配置环境变量 `HTTPS_PROXY=http://127.0.0.1:7890`
3. 重新尝试访问

### 8.2 检查清单

#### 每日检查
- [ ] 09:30早报已推送
- [ ] 15:00数据已采集
- [ ] 20:00市场已追踪
- [ ] Git提交成功

#### 每周检查
- [ ] 周报已生成
- [ ] 投资组合已更新
- [ ] 价格追踪表已更新
- [ ] 配置比例是否正常

#### 故障时检查
- [ ] API Key有效
- [ ] 网络连接正常
- [ ] 磁盘空间充足
- [ ] 定时任务配置正确

### 8.3 紧急联系方式

- OpenClaw文档: https://docs.openclaw.ai
- BallDontLie API: https://www.balldontlie.io/
- NBA官网: https://www.nba.com

---

## 9. 交接检查清单

### 9.1 文件确认（100%迁移）

- [x] knowledge/ 目录完整
- [x] scripts/ 目录完整
- [x] memory/ 目录完整
- [x] .git/ 历史完整
- [x] 模板文件完整
- [x] 配置文件模板完整

### 9.2 配置确认（需重新设置）

- [ ] `.env` 文件已创建
- [ ] `BALLDONTLIE_API_KEY` 已填入
- [ ] Git身份已配置
- [ ] crontab已配置
- [ ] 工作目录路径正确

### 9.3 测试确认（验证可用）

- [ ] NBA数据采集测试通过
- [ ] 日报生成测试通过
- [ ] Git提交测试通过
- [ ] Moltbook访问测试（本地）
- [ ] 定时任务测试通过

### 9.4 用户确认（文炎知晓）

- [ ] 本地部署已完成
- [ ] 定时任务已启动
- [ ] 09:30/15:00/20:00自动执行
- [ ] API Key已配置
- [ ] 备份方案已确认

---

## 📝 附录

### A. 快速命令参考

```bash
# 手动执行数据采集
bash knowledge/nba-data/scripts/nba-api-collection.sh

# 手动生成日报
bash scripts/generate-daily-report.sh

# 查看今日数据
ls knowledge/nba-data/raw/$(date +%Y-%m-%d)/

# Git提交
git add -A && git commit -m "更新"

# 查看定时任务
crontab -l
```

### B. 关键球员数据速查

**Carter Bryant（马刺）**
- 2月数据: 9分，44%三分
- 策略: 买入低编卡
- 关注: 三分命中率

**Dylan Harper（马刺）**
- 冠军血统
- 策略: 长期持有
- 关注: 上场时间

**Blake Wesley（开拓者）**
- 已转会
- 策略: 3月内出清
- 关注: 无

### C. 投资原则速记

1. **数据驱动** - 不凭感觉
2. **分散投资** - 单卡<15%
3. **分批建仓** - 不一次性满仓
4. **止盈止损** - 达到目标果断执行
5. **长期视角** - 至少持有一个赛季

---

**交接完成！** 🎉

本地卡布，现在你可以完全替代我了！

记住：Go Spurs Go! 🏀

*交接时间: 2026-02-27*  
*云端卡布 → 本地卡布*
