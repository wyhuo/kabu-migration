# BallDontLie API 配置

## 账号信息
- **平台**: https://www.balldontlie.io/
- **邮箱**: huowenyan21@gmail.com
- **API Key**: d7e6a0a8-9c68-45b0-a135-7695433c09b9
- **状态**: ✅ 已验证可用

## API 测试记录

### 2025-02-27 测试
- ✅ 获取比赛数据成功
- ✅ API Key 有效
- ⏳ 球员搜索（新秀数据可能未完全同步）

## 使用方法

### 环境变量
```bash
export BALLDONTLIE_API_KEY=d7e6a0a8-9c68-45b0-a135-7695433c09b9
```

### 常用命令

#### 获取昨日比赛
```bash
YESTERDAY=$(date -d "yesterday" +%Y-%m-%d)
curl "https://api.balldontlie.io/v1/games?dates[]=$YESTERDAY" \
  -H "Authorization: $BALLDONTLIE_API_KEY"
```

#### 搜索球员
```bash
curl "https://api.balldontlie.io/v1/players?search=player_name" \
  -H "Authorization: $BALLDONTLIE_API_KEY"
```

#### 获取球员赛季数据
```bash
curl "https://api.balldontlie.io/v1/season_averages?player_ids[]=ID" \
  -H "Authorization: $BALLDONTLIE_API_KEY"
```

## 注意事项

1. **免费版限制**: 60请求/分钟
2. **数据延迟**: 比赛结束后更新
3. **新秀数据**: 2025届新秀可能数据不完整

---

*配置更新时间：2026-02-27*
