# 📖 本地卡布阅读地图

**目标**: 告诉你有什么、都在哪、按什么顺序看  
**阅读时间**: 15分钟快速浏览 + 后续按需查阅

---

## 🗺️ 三步阅读法

```
第1步: 快速启动 (5分钟)
   ↓
第2步: 核心必读 (10分钟)
   ↓
第3步: 按需查阅 (后续使用)
```

---

## 第1步: 快速启动 (先看这3个)

### 1.1 这是谁？为谁工作？
**文件**: `USER.md`  
**位置**: 根目录  
**必看内容**:
- 文炎是谁（马刺球迷、球星卡收藏者）
- 关注哪些球员（Dylan Harper、Carter Bryant）
- 什么时候推送（09:30、15:00、20:00）
- 投资策略偏好

**看完你知道**: 你是谁，为谁服务，用户喜欢什么

---

### 1.2 每天干什么？
**文件**: `HEARTBEAT.md`  
**位置**: 根目录  
**必看内容**:
- 定时任务清单（09:30早报、15:00数据采集、20:00追踪）
- 检查清单（会话大小、数据采集）
- 沙箱恢复处理

**看完你知道**: 每天自动执行什么任务

---

### 1.3 核心投资指令是什么？
**文件**: `knowledge/card-investment-targets.md`  
**位置**: knowledge/  
**必看内容**:
- 46位球员追踪清单
- 买入/持有/卖出名单
- 配置比例建议

**重点记住**:
- 🟢 **买入**: Carter Bryant 低编卡
- 🔵 **持有**: Dylan Harper、Wembanyama
- 🔴 **卖出**: Blake Wesley（3月内）
- 🟡 **观望**: Cooper Flagg

**看完你知道**: 重点推荐买什么、卖什么、关注谁

---

## 第2步: 核心必读 (再看这3个)

### 2.1 详细投资策略
**文件**: `knowledge/card-investment-strategy-full.md`  
**位置**: knowledge/  
**必看内容**:
- 投资组合配置（新秀30%、现役50%、老将20%）
- 买卖时机（什么时候买、什么时候卖）
- 风险控制（不要过度集中）

**看完你知道**: 为什么推荐这些，背后的逻辑

---

### 2.2 每天具体做什么？
**文件**: `knowledge/templates/daily-report-optimized.md`  
**位置**: knowledge/templates/  
**必看内容**:
- 日报模板结构
- 需要填写的字段
- 输出格式

**看完你知道**: 09:30早报长什么样，怎么生成

---

### 2.3 完整交接手册
**文件**: `HANDOVER_COMPLETE.md`  
**位置**: 根目录  
**内容**: 12,920字完整手册  
**章节**:
1. 系统概览
2. 文件结构地图
3. 核心配置信息
4. 投资策略与关注清单
5. 每日工作流程
6. 定时任务清单
7. API与工具
8. 故障排查手册
9. 交接检查清单

**看完你知道**: 系统的全貌，有问题时查这里

---

## 第3步: 按需查阅 (用的时候再看)

### 需要写周报时看
**文件**: `knowledge/templates/weekly-report-template.md`

### 需要做买卖决策时看
**文件**: `knowledge/templates/trade-decision-template.md`

### 需要更新投资组合时看
**文件**: `knowledge/portfolio-tracker.md`

### 需要查eBay价格时看
**文件**: `knowledge/ebay-tracking.md`

### 需要采集NBA数据时看
**文件**: `knowledge/nba-data/data-collection-guide.md`

### 需要查球员ID时看
**文件**: `knowledge/nba-data/player-id-mapping.md`

### 需要看历史记录时看
**文件**: `memory/2026-02-27*.md`、`daily_summary/*.md`

---

## 📂 全部文件地图

### 根目录（配置文件）
```
workspace/
├── USER.md                    ⭐ 第1步必看 - 用户偏好
├── HEARTBEAT.md               ⭐ 第1步必看 - 定时任务
├── HANDOVER_COMPLETE.md       ⭐ 第2步必看 - 完整手册
├── .env                       ⚠️  需要配置 - API Keys
├── TODO.md                    📋 待办清单
└── ...
```

### knowledge/（知识库）
```
knowledge/
├── basketball-cards/          🃏 球星卡品牌知识
│   ├── brands/
│   └── guides/
│
├── nba-data/                  🏀 NBA数据系统
│   ├── scripts/              ⭐ 数据采集脚本
│   ├── templates/            ⭐ 日报模板
│   ├── player-id-mapping.md  📋 球员ID表
│   └── data-collection-guide.md 📋 采集指南
│
├── templates/                 📝 报告模板
│   ├── daily-report-optimized.md   ⭐ 日报v2.0
│   ├── weekly-report-template.md   📋 周报
│   ├── monthly-report-template.md  📋 月报
│   └── trade-decision-template.md  📋 买卖决策
│
├── card-investment-targets.md     ⭐ 第1步必看 - 46球员清单
├── card-investment-strategy-full.md ⭐ 第2步必看 - 投资策略
├── portfolio-tracker.md           📋 组合跟踪
└── ebay-tracking.md               📋 eBay追踪
```

### scripts/（执行脚本）
```
scripts/
├── daily-push.sh              ⭐ 09:30早报脚本
├── cron-runner.sh             ⭐ 定时任务执行器
├── nba-api-collection.sh      ⭐ NBA数据采集（主）
├── absorb-from-cloud.sh       ⭐ 本地吸收脚本
└── ...
```

### memory/（历史记录）
```
memory/
├── 2026-02-27*.md            📅 今日记录
├── RESET_*.md                🔄 重置标记
└── *_summary.md              📊 各种总结
```

### daily_summary/（每日摘要）
```
daily_summary/
├── 2026-02-27-final.md       📅 今日摘要
└── ...
```

---

## 🎯 30分钟快速上手流程

### 0-5分钟: 了解用户
1. 打开 `USER.md`
2. 看文炎是谁、喜欢什么、什么时候推送
3. 记住关键词: 马刺、Dylan Harper、Carter Bryant

### 5-10分钟: 了解任务
1. 打开 `HEARTBEAT.md`
2. 看定时任务（09:30、15:00、20:00）
3. 知道每天要自动执行什么

### 10-15分钟: 了解投资
1. 打开 `knowledge/card-investment-targets.md`
2. 看46位球员清单
3. 记住核心指令:
   - 买入: Carter Bryant
   - 持有: Dylan Harper
   - 卖出: Blake Wesley

### 15-30分钟: 浏览完整手册
1. 打开 `HANDOVER_COMPLETE.md`
2. 快速浏览9个章节标题
3. 知道有问题来这里查

### 完成！✅

你现在知道:
- ✅ 为谁服务（文炎，马刺球迷）
- ✅ 每天干什么（09:30/15:00/20:00）
- ✅ 推荐买什么（Carter Bryant低编卡）
- ✅ 有问题查哪里（HANDOVER_COMPLETE.md）

---

## 🔍 常见问题速查

**Q: 今天09:30要发什么内容？**  
A: 看 `knowledge/templates/daily-report-optimized.md`

**Q: Carter Bryant为什么推荐买入？**  
A: 看 `knowledge/card-investment-strategy-full.md` 第4章

**Q: 怎么采集NBA数据？**  
A: 看 `knowledge/nba-data/data-collection-guide.md`

**Q: 定时任务怎么配置的？**  
A: 看 `HEARTBEAT.md` 和 `knowledge/cron-tasks.md`

**Q: 出错了怎么办？**  
A: 看 `HANDOVER_COMPLETE.md` 第8章故障排查

**Q: 全部文件都在哪？**  
A: 看本文档"全部文件地图"章节

---

## 📞 最后确认

**看完本文档后，你应该**:
- [ ] 知道为谁工作（文炎）
- [ ] 知道每天做什么（3个定时任务）
- [ ] 知道核心投资指令（买谁/卖谁/关注谁）
- [ ] 知道有问题去哪里查（HANDOVER_COMPLETE.md）
- [ ] 知道全部文件在哪（本文档地图）

**完成检查后，开始工作！** 🏀

---

*阅读地图版本: v1.0*  
*创建时间: 2026-02-27*  
*预计阅读时间: 15分钟快速浏览 + 按需查阅*
