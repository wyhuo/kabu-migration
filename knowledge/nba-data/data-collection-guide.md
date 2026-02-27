# NBA数据采集指南 - 球星卡投资版

## 📊 数据来源汇总

### 1. NBA官方数据（最准确）
**网站**: https://www.nba.com

**关键页面**:
- 昨日比赛: https://www.nba.com/games?date=YYYY-MM-DD
- 球员统计: https://www.nba.com/stats/players/traditional
- 新秀统计: https://www.nba.com/stats/players/traditional?PlayerPosition=ROOKIE
- 球队排名: https://www.nba.com/standings

**采集频率**: 每日比赛后

---

### 2. Basketball-Reference（历史数据）
**网站**: https://www.basketball-reference.com

**优势**:
- 历史数据完整
- 高级统计丰富
- 球员对比功能

**采集频率**: 需要详细分析时

---

### 3. ESPN NBA
**网站**: https://www.espn.com/nba/

**优势**:
- 新闻及时
- 伤病报告
- 交易动态

**采集频率**: 每日查看新闻

---

## 🎯 重点追踪球员清单

### 马刺核心（必须每日追踪）
| 球员 | 数据页面 | 关注指标 |
|------|----------|----------|
| Victor Wembanyama | NBA Stats | 得分/篮板/盖帽/上场时间 |
| Dylan Harper | NBA Stats | 得分/助攻/上场时间/效率 |
| Carter Bryant | NBA Stats | 得分/三分命中率/防守数据 |

### 2025届新秀（重点关注）
| 球员 | 球队 | 追踪频率 |
|------|------|----------|
| Cooper Flagg | 独行侠 | 每场比赛 |
| Dylan Harper | 马刺 | 每场比赛 |
| Carter Bryant | 马刺 | 每场比赛 |
| Matas Buzelis | 公牛 | 每场比赛 |
| Kon Knueppel | 黄蜂 | 每2-3场 |
| Ace Bailey | 奇才 | 每2-3场 |

### 现役球星（定期关注）
| 球员 | 球队 | 追踪频率 |
|------|------|----------|
| Anthony Edwards | 森林狼 | 每周2-3次 |
| Shai Gilgeous-Alexander | 雷霆 | 每周2-3次 |
| Luka Dončić | 湖人 | 每周2-3次 |
| Nikola Jokić | 掘金 | 每周1-2次 |
| Stephen Curry | 勇士 | 每周1-2次 |
| LeBron James | 湖人 | 每周1-2次 |

---

## 📈 球星卡价格追踪

### eBay（主要价格参考）
**网址**: https://www.ebay.com

**搜索技巧**:
```
# Dylan Harper Prizm
dylan harper prizm

# Carter Bryant 低编
carter bryant prizm /5 /10 /25

# Wembanyama 签字
victor wembanyama auto

# 添加过滤
+psa 10 +bgs 9.5
```

**查看**: Sold Listings（已成交）获取真实价格

### 130point（综合价格搜索）
**网址**: https://130point.com

**优势**:
- 跨平台价格对比
- 历史价格趋势
- 卡片数据库

### Card Ladder（价格指数）
**网址**: https://www.cardladder.com

**优势**:
- 专业价格指数
- 市场趋势分析
- 投资组合追踪

---

## 📅 每日数据采集流程

### 09:30 - 早报生成
1. 查看昨晚比赛结果
2. 记录关注球员数据
3. 生成日报模板
4. 推送给文炎

### 15:00 - 详细数据采集
1. 访问 NBA 官网
2. 记录所有关注球员数据
3. 更新日报
4. Git 备份

### 20:00 - 市场追踪
1. 查看 eBay 成交记录
2. 更新价格趋势
3. 评估持仓价值
4. 制定买卖计划

---

## 🛠️ 数据采集工具

### BallDontLie API（已配置）
**状态**: ✅ API Key 已配置
**限制**: 60请求/分钟
**数据**: 比赛、球员基础数据

**使用方法**:
```bash
export BALLDONTLIE_API_KEY=d7e6a0a8-9c68-45b0-a135-7695433c09b9
bash knowledge/nba-data/scripts/nba-api-collection.sh
```

### 手动更新模板
位置: `knowledge/nba-data/daily-reports/report-YYYY-MM-DD.md`

**更新内容**:
- 球员得分/篮板/助攻
- 上场时间
- 比赛表现评级
- eBay成交价格

---

## ⚠️ 数据质量注意事项

### 常见问题
1. **新秀数据缺失**: BallDontLie API 2025届数据不完整
2. **数据延迟**: API数据比赛后更新
3. **球员重名**: 搜索时注意确认球队

### 解决方案
- 主要依赖 NBA 官网手动采集
- API作为辅助验证
- 建立球员ID映射表

---

## 📊 数据分析要点

### 影响卡片价值的数据指标
1. **基础数据**: 得分 > 25 分（爆发）
2. **效率**: 投篮命中率 > 50%
3. **上场时间**: > 30 分钟（核心地位）
4. **球队战绩**: 胜率 > 60%
5. **连胜/连败**: 影响市场情绪

### 新闻事件影响
- ✅ 全明星入选: +20-30%
- ✅ 月最佳球员: +15-20%
- ✅ 关键绝杀: +10-15%
- ❌ 伤病（长期）: -30-50%
- ❌ 球队交易: -10-20%

---

*指南创建时间: 2026-02-27*  
*适用对象: 文炎的球星卡投资决策*
