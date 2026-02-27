# NBA数据采集 - balldontlie API 方案

## 方案说明

使用 balldontlie API（免费）获取NBA数据，替代 coze-web-search。

## API 信息

- **文档**: https://www.balldontlie.io/
- **免费额度**: 60 requests/minute
- **数据覆盖**: 比赛、球员、球队、统计数据

## 使用方法

### 1. 获取 API Key（可选，免费版有限制）
访问 https://www.balldontlie.io/ 注册获取 API Key

### 2. 基本请求

#### 获取昨日比赛
```bash
YESTERDAY=$(date -d "yesterday" +%Y-%m-%d)
curl "https://api.balldontlie.io/v1/games?dates[]=$YESTERDAY" \
  -H "Authorization: YOUR_API_KEY"
```

#### 获取球员数据
```bash
# Dylan Harper (假设ID是 12345)
curl "https://api.balldontlie.io/v1/season_averages?player_ids[]=12345"

# Carter Bryant (假设ID是 12346)
curl "https://api.balldontlie.io/v1/season_averages?player_ids[]=12346"
```

#### 获取新秀数据
```bash
# 2025届新秀
# 需要知道具体球员ID，然后查询赛季数据
```

### 3. Node.js 脚本示例

```javascript
const axios = require('axios');

const API_KEY = process.env.BALLDONTLIE_KEY;
const BASE_URL = 'https://api.balldontlie.io/v1';

async function getYesterdayGames() {
  const yesterday = new Date();
  yesterday.setDate(yesterday.getDate() - 1);
  const dateStr = yesterday.toISOString().split('T')[0];
  
  const response = await axios.get(`${BASE_URL}/games`, {
    headers: { 'Authorization': API_KEY },
    params: { 'dates[]': dateStr }
  });
  
  return response.data;
}

async function getPlayerStats(playerId) {
  const response = await axios.get(`${BASE_URL}/season_averages`, {
    headers: { 'Authorization': API_KEY },
    params: { 'player_ids[]': playerId }
  });
  
  return response.data;
}

// 导出函数
module.exports = { getYesterdayGames, getPlayerStats };
```

## 当前限制

1. **球员ID映射**: 需要手动维护球员ID映射表（Dylan Harper、Carter Bryant等）
2. **数据延迟**: API数据可能有延迟
3. **免费版限制**: 60 requests/minute

## 下一步

- [ ] 注册 balldontlie API Key
- [ ] 创建球员ID映射表
- [ ] 实现自动采集脚本
