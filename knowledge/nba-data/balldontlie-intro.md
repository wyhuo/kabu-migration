# BallDontLie API 平台介绍

## 平台概述

**BallDontLie** 是一个免费的 NBA 数据 API 平台，提供 RESTful API 接口获取 NBA 比赛、球员、球队统计数据。

- **官网**: https://www.balldontlie.io/
- **类型**: 体育数据 API
- **费用**: 免费版（60请求/分钟）
- **数据覆盖**: NBA 历史 + 实时数据

---

## 主要功能

### 1. 比赛数据 (Games)
- 每日赛程和比分
- 历史比赛记录
- 球队对战记录

```bash
# 获取昨日比赛
curl "https://api.balldontlie.io/v1/games?dates[]=2025-02-26"
```

### 2. 球员数据 (Players)
- 球员基本信息
- 赛季统计数据
- 生涯数据

```bash
# 搜索球员
curl "https://api.balldontlie.io/v1/players?search=dylan%20harper"

# 获取球员赛季数据
curl "https://api.balldontlie.io/v1/season_averages?player_ids[]=12345"
```

### 3. 球队数据 (Teams)
- 球队基本信息
- 球队战绩排名
- 球队统计

```bash
# 获取所有球队
curl "https://api.balldontlie.io/v1/teams"
```

---

## 使用场景

### 适合我们（球星卡投资）

| 用途 | API 端点 | 价值 |
|------|---------|------|
| **每日比赛追踪** | `/games` | 追踪 Carter Bryant、Dylan Harper 比赛表现 |
| **新秀数据监控** | `/season_averages` | 获取新秀赛季统计数据 |
| **球员搜索** | `/players` | 查找球员ID，建立追踪列表 |
| **球队战绩** | `/teams` | 评估球队环境对球员发展的影响 |

---

## 免费版限制

| 限制项 | 免费版 | 付费版 |
|--------|--------|--------|
| 请求频率 | 60次/分钟 | 更高 |
| 历史数据 | 完整 | 完整 |
| 实时数据 | 有延迟 | 更快 |
| 高级统计 | 基础 | 进阶 |

**对于我们**：免费版完全够用！每天调用几次获取数据即可。

---

## 数据准确性

- **数据来源**: NBA 官方统计
- **更新频率**: 比赛结束后更新
- **覆盖范围**: 1979年至今所有 NBA 数据
- **可靠性**: 被众多开发者、分析师使用

---

## 为什么选它

### ✅ 优点
1. **完全免费** - 不需要付费
2. **无需信用卡** - 注册简单
3. **数据全面** - 覆盖所有我们需要的球员数据
4. **API 简单** - RESTful 接口，易于使用
5. **文档清晰** - 有完整的 API 文档

### ❌ 缺点
1. **需要球员ID** - 不能直接通过名字查询赛季数据
2. **免费版有限制** - 60次/分钟，但对个人够用
3. **数据略有延迟** - 不是实时，但比赛后很快更新

---

## 对比其他方案

| 方案 | 费用 | 难度 | 数据质量 | 推荐指数 |
|------|------|------|----------|----------|
| **BallDontLie API** | 免费 | 简单 | ⭐⭐⭐⭐⭐ | 🥇 |
| NBA 官网 scraping | 免费 | 困难 | ⭐⭐⭐⭐ | 🥈 |
| 付费数据服务 | $$$ | 简单 | ⭐⭐⭐⭐⭐ | 🥉 |
| 手动更新 | 免费 | 繁琐 | ⭐⭐⭐ | ❌ |

---

## 注册步骤

1. **访问**: https://www.balldontlie.io/
2. **点击**: "Sign Up" 或 "Get API Key"
3. **填写**: 邮箱 + 密码
4. **验证**: 邮箱验证
5. **获取**: Dashboard 中复制 API Key
6. **使用**: 填入 `.env` 文件

---

## 我们的使用计划

### 每日自动采集（15:00）
```bash
# 1. 获取昨日所有比赛
curl "https://api.balldontlie.io/v1/games?dates[]=2025-02-26"

# 2. 获取重点关注球员数据
# Dylan Harper
curl "https://api.balldontlie.io/v1/season_averages?player_ids[]=HARPER_ID"
# Carter Bryant  
curl "https://api.balldontlie.io/v1/season_averages?player_ids[]=BRYANT_ID"
```

### 生成报告
- 自动分析球员表现
- 对比数据变化
- 生成投资建议

---

**总结**: BallDontLie 是**免费的 NBA 数据 API**，数据准确、使用简单，非常适合我们自动采集 Carter Bryant、Dylan Harper 等球员的比赛数据，支撑球星卡投资决策。

**推荐立即注册！** 🏀
