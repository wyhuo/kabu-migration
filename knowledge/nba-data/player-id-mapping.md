# BallDontLie API - 球员ID映射表（完整版）

## ✅ 已确认ID（现役球星）

| 球员 | 球队 | ID | 验证时间 |
|------|------|-----|----------|
| LeBron James | 湖人 | **237** | 2026-02-27 ✅ |
| Stephen Curry | 勇士 | **115** | 2026-02-27 ✅ |
| Kevin Durant | 太阳 | **140** | 已知 ✅ |
| Giannis Antetokounmpo | 雄鹿 | **15** | 已知 ✅ |
| Nikola Jokic | 掘金 | **246** | 已知 ✅ |
| Luka Doncic | 湖人 | **132** | 2026-02-27 ✅ |
| Jayson Tatum | 凯尔特人 | **434** | 已知 ✅ |
| Anthony Edwards | 森林狼 | **3547236** | 已知 ✅ |
| Shai Gilgeous-Alexander | 雷霆 | **175** | 已知 ✅ |
| Victor Wembanyama | 马刺 | **56677822** | 2026-02-27 ✅ |

## 🔍 待查询ID（2025届新秀）

**注意**: 2025届新秀可能尚未完全同步到API

| 球员 | 球队 | ID | 状态 |
|------|------|-----|------|
| Cooper Flagg | 独行侠 | 待查询 | 🔍 |
| Dylan Harper | 马刺 | 待查询 | 🔍 |
| Carter Bryant | 马刺 | 待查询 | 🔍 |
| Matas Buzelis | 公牛 | 待查询 | 🔍 |
| Kon Knueppel | 黄蜂 | 待查询 | 🔍 |
| Ace Bailey | 奇才 | 待查询 | 🔍 |
| VJ Edgecombe | 76人 | 待查询 | 🔍 |

## 🔍 待查询ID（潜力新星）

| 球员 | 球队 | ID | 状态 |
|------|------|-----|------|
| Paolo Banchero | 魔术 | 待查询 | 🔍 |
| Chet Holmgren | 雷霆 | 待查询 | 🔍 |
| Evan Mobley | 骑士 | 待查询 | 🔍 |
| Franz Wagner | 魔术 | 待查询 | 🔍 |
| Scottie Barnes | 猛龙 | 待查询 | 🔍 |
| Tyrese Haliburton | 步行者 | 待查询 | 🔍 |

---

## 🔧 查询方法

### 单个球员查询
```bash
API_KEY="d7e6a0a8-9c68-45b0-a135-7695433c09b9"

# 按名字搜索
curl "https://api.balldontlie.io/v1/players?search=Wembanyama" \
  -H "Authorization: $API_KEY"

# 返回结果中的 id 字段即为球员ID
```

### 批量查询脚本
```bash
#!/bin/bash
API_KEY="d7e6a0a8-9c68-45b0-a135-7695433c09b9"

players=("Wembanyama" "Edwards" "Banchero" "Holmgren")

for player in "${players[@]}"; do
  echo "查询: $player"
  curl -s "https://api.balldontlie.io/v1/players?search=$player" \
    -H "Authorization: $API_KEY" | grep -o '"id":[0-9]*'
  sleep 1  # 避免速率限制
done
```

---

## 📊 使用球员ID获取数据

### 获取赛季统计
```bash
# 单个球员
curl "https://api.balldontlie.io/v1/season_averages?player_ids[]=237" \
  -H "Authorization: $API_KEY"

# 多个球员
curl "https://api.balldontlie.io/v1/season_averages?player_ids[]=237&player_ids[]=115" \
  -H "Authorization: $API_KEY"
```

### 获取球员信息
```bash
curl "https://api.balldontlie.io/v1/players/237" \
  -H "Authorization: $API_KEY"
```

### 获取球员比赛统计
```bash
curl "https://api.balldontlie.io/v1/stats?player_ids[]=237&per_page=5" \
  -H "Authorization: $API_KEY"
```

---

## 📝 更新记录

| 日期 | 更新内容 |
|------|----------|
| 2026-02-27 | 确认10位现役球星ID |
| 2026-02-27 | Wembanyama ID: 56677822 |
| 2026-02-27 | Luka Doncic ID: 132 |

---

## 🎯 下一步

- [ ] 查询所有2025届新秀ID
- [ ] 查询潜力新星ID
- [ ] 建立自动查询脚本
- [ ] 定期更新映射表

---

*映射表更新时间：2026-02-27 11:52*
