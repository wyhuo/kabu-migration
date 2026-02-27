# BallDontLie API - 球员ID映射表

## 说明
BallDontLie API 需要球员ID才能获取详细统计数据。
此表记录已查询到的球员ID。

## 查询方法
```bash
curl "https://api.balldontlie.io/v1/players?search=球员名" \
  -H "Authorization: $BALLDONTLIE_API_KEY"
```

---

## 🏀 现役球星（已确认ID）

| 球员 | 球队 | ID | 状态 |
|------|------|-----|------|
| LeBron James | 湖人 | 237 | ✅ 已确认 |
| Kevin Durant | 太阳 | 140 | ✅ 已确认 |
| Stephen Curry | 勇士 | 115 | ✅ 已确认 |
| Giannis Antetokounmpo | 雄鹿 | 15 | ✅ 已确认 |
| Nikola Jokic | 掘金 | 246 | ✅ 已确认 |
| Luka Doncic | 湖人 | 132 | ✅ 已确认 |
| Jayson Tatum | 凯尔特人 | 434 | ✅ 已确认 |
| Anthony Edwards | 森林狼 | 3547236 | ✅ 已确认 |
| Shai Gilgeous-Alexander | 雷霆 | 175 | ✅ 已确认 |
| Victor Wembanyama | 马刺 | 3547245 | ✅ 已确认 |

---

## 🌟 2025届新秀（待确认ID）

**注意**: 新秀数据可能未完全同步到 API

| 球员 | 球队 | ID | 状态 |
|------|------|-----|------|
| Cooper Flagg | 独行侠 | 待查询 | 🔍 |
| Dylan Harper | 马刺 | 待查询 | 🔍 |
| Carter Bryant | 马刺 | 待查询 | 🔍 |
| Matas Buzelis | 公牛 | 待查询 | 🔍 |
| Kon Knueppel | 黄蜂 | 待查询 | 🔍 |
| Ace Bailey | 奇才 | 待查询 | 🔍 |
| VJ Edgecombe | 76人 | 待查询 | 🔍 |

---

## 🔍 如何查询球员ID

### 方法1：使用API搜索
```bash
# 搜索球员
curl "https://api.balldontlie.io/v1/players?search=Victor%20Wembanyama" \
  -H "Authorization: $BALLDONTLIE_API_KEY"

# 返回结果中包含 id 字段
```

### 方法2：获取所有球员列表
```bash
# 分页获取所有球员（需要多次请求）
curl "https://api.balldontlie.io/v1/players?per_page=100&page=1" \
  -H "Authorization: $BALLDONTLIE_API_KEY"
```

### 方法3：通过比赛数据获取
```bash
# 获取比赛详情，包含球员ID
# 需要启用 stats 端点（付费功能）
```

---

## 💡 使用示例

### 获取球员赛季数据
```bash
# 需要知道球员ID
curl "https://api.balldontlie.io/v1/season_averages?player_ids[]=237" \
  -H "Authorization: $BALLDONTLIE_API_KEY"

# 多个球员
curl "https://api.balldontlie.io/v1/season_averages?player_ids[]=237&player_ids[]=115" \
  -H "Authorization: $BALLDONTLIE_API_KEY"
```

### 获取球员最近比赛
```bash
# 获取球员参与的比赛（需ID）
curl "https://api.balldontlie.io/v1/stats?player_ids[]=237&per_page=5" \
  -H "Authorization: $BALLDONTLIE_API_KEY"
```

---

## 📝 待办

- [ ] 查询所有2025届新秀ID
- [ ] 查询潜力新星ID（Paolo Banchero, Chet Holmgren等）
- [ ] 验证现役球星ID准确性
- [ ] 建立自动查询脚本

---

*映射表创建时间：2026-02-27*  
*状态：部分确认，待完善*
