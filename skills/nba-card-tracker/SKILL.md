---
name: nba-card-tracker
description: Track NBA player performance and generate basketball card investment recommendations. Use when the user wants to analyze NBA player stats for sports card collecting, track rookie performance, monitor player value trends, or generate daily/weekly card market insights. Activate for queries about player stats, card investment advice, rookie tracking, or NBA market analysis.
---

# NBA Card Tracker

## Overview

Transform NBA player performance data into actionable sports card investment insights. This skill helps collectors track player trends, identify breakout candidates, and make informed buying/selling decisions.

**Core capabilities:**
- Analyze player stats for card value indicators
- Track rookie performance and development
- Generate investment recommendations
- Monitor team/context changes affecting card values

## Quick Start

### Analyze a Player for Card Investment

```
"分析 Anthony Edwards 的球星卡投资价值"
"Should I buy or sell Paolo Banchero cards?"
"Is Cason Wallace a good long-term hold?"
```

### Track Rookie Class

```
"2025届新秀谁最值得投资？"
"Compare Cooper Flagg vs Dylan Harper cards"
"Which rookies are breaking out this month?"
```

### Generate Market Report

```
"生成今日球星卡市场简报"
"What happened in NBA last night that affects card prices?"
```

## Analysis Framework

### Key Metrics for Card Value

| Category | Indicators | Card Impact |
|----------|-----------|-------------|
| **Scoring** | PPG, efficiency, clutch performance | High - star power drives demand |
| **Defense** | Stocks (steals+blocks), All-Defense | Medium - undervalued by casual collectors |
| **Context** | Team success, playoff appearances | High - national exposure boosts value |
| **Rookie Status** | Draft position, minutes, rookie awards | Critical - first-year cards premium |
| **Injuries** | Games played, severity | Negative - availability concerns |

### Investment Signals

**BUY Signals:**
- 🔥 Performance breakout (连续高分)
- 📈 上场时间增加
- 🏆 获得奖项/荣誉
- 🎯 球队地位提升

**SELL Signals:**
- 📉 数据下滑
- 🏥 伤病风险
- 🔄 球队变更（可能失去中国市场）
- ⏰ 年龄/巅峰期考量

**HOLD Signals:**
- 💎 稳定输出，长期核心
- 🌱 新秀正常发展波动
- ⏳ 等待季后赛表现

## Resources

### scripts/
- `generate_report.py` - Generate card market reports from NBA data
- `player_analysis.py` - Analyze individual player card potential

### references/
- `rookie_tracker.md` - Current rookie class tracking
- `market_trends.md` - Card market patterns and historical data

## Usage Examples

### Example 1: Player Investment Analysis

User: "分析 Jaden McDaniels 的卡片"

Analysis approach:
1. Check recent stats (29分6板3断5帽 = elite defense + scoring)
2. Evaluate context (森林狼核心，防守体系关键)
3. Compare to market (防守型球员通常被低估)
4. Recommendation: BUY - DPOY潜力，价值未充分反映

### Example 2: Rookie Comparison

User: "Carter Bryant vs Dylan Harper，投资谁？"

Analysis approach:
1. Compare current stats and trajectory
2. Evaluate team situation (马刺培养体系)
3. Consider draft position and expectations
4. Market liquidity and card availability
5. Recommendation based on risk/reward profile

### Example 3: Market Briefing

User: "昨天NBA有什么影响卡价的新闻？"

Process:
1. Run `generate_report.py` with yesterday's data
2. Identify standout performances
3. Flag injury news or trades
4. Highlight rookie breakouts
5. Deliver formatted brief with actionable insights
