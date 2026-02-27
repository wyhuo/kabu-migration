# NBA数据采集配置

## balldontlie API 配置

### API Key（需要手动设置）
```bash
# 访问 https://www.balldontlie.io/ 注册获取
# 然后设置环境变量
export BALLDONTLIE_API_KEY="your_api_key_here"
```

### 球员ID映射表（2025届新秀）

| 球员 | 球队 | 预估ID | 状态 |
|------|------|--------|------|
| Cooper Flagg | 独行侠 | 待查询 | 🔍 |
| Dylan Harper | 马刺 | 待查询 | 🔍 |
| Carter Bryant | 马刺 | 待查询 | 🔍 |
| Kon Knueppel | 黄蜂 | 待查询 | 🔍 |
| Matas Buzelis | 公牛 | 待查询 | 🔍 |

### 查询球员ID方法
```bash
# 通过名字搜索
curl "https://api.balldontlie.io/v1/players?search=dylan%20harper" \
  -H "Authorization: $BALLDONTLIE_API_KEY"
```

### 数据采集脚本（简化版）

由于 balldontlie API 需要 Key，且球员ID需要手动查询，
暂时使用简化方案：手动更新 + browser 工具辅助。

### 当前状态
- ✅ 方案已设计
- ⏳ 等待 API Key 配置
- ⏳ 球员ID映射表待完善

---

*配置时间：2026-02-27*
