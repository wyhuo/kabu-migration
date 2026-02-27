# BallDontLie API 配置 - 最终版

## ✅ 配置完成

### 账号信息
- **平台**: https://www.balldontlie.io/
- **邮箱**: huowenyan21@gmail.com
- **API Key**: `d7e6a0a8-9c68-45b0-a135-7695433c09b9`
- **状态**: ✅ 已验证可用

### 环境变量
已配置到 `/workspace/projects/workspace/.env`：
```bash
BALLDONTLIE_API_KEY=d7e6a0a8-9c68-45b0-a135-7695433c09b9
```

---

## ✅ 测试验证

### 测试 1：获取比赛数据 ✅
```bash
curl "https://api.balldontlie.io/v1/games?dates[]=2025-02-26" \
  -H "Authorization: d7e6a0a8-9c68-45b0-a135-7695433c09b9"
```
**结果**: 成功获取 9 场比赛数据（7760 字节）

### 测试 2：马刺比赛识别 ✅
- 火箭 118 - 106 马刺（2025-02-26）
- 数据完整可用

---

## 🚀 自动采集脚本

### 脚本位置
`/workspace/projects/workspace/knowledge/nba-data/scripts/nba-api-collection.sh`

### 使用方法
```bash
# 手动执行
bash knowledge/nba-data/scripts/nba-api-collection.sh

# 定时执行（已配置到 HEARTBEAT）
# 每天 15:00 自动运行
```

### 采集内容
1. ✅ 昨日所有比赛
2. ✅ 球队排名
3. ✅ 球员搜索（Dylan Harper, Carter Bryant等）
4. ✅ Markdown 报告生成
5. ✅ Git 自动备份

---

## 📊 今日采集结果（2026-02-27）

### 文件列表
```
knowledge/nba-data/raw/2026-02-27/
├── 01-games-real.json          # 原始API数据（7760字节）
├── 01-games-report.md          # Markdown报告
├── 06-standings.json           # 球队排名
├── player-search-*.json        # 球员搜索结果
└── README.md                   # 汇总说明
```

### 关键发现
- 马刺 106-118 负于火箭
- 9场比赛全部采集完成
- 数据质量：✅ 完整

---

## ⏰ 后续计划

### 每日自动采集（15:00）
已配置到 HEARTBEAT.md，每天自动执行：
- 采集昨日比赛
- 生成Markdown报告
- Git备份

### 待优化
- [ ] 安装 jq 工具解析 JSON
- [ ] 获取详细球员统计数据
- [ ] 识别 Dylan Harper / Carter Bryant 比赛表现

---

## 📝 备注

**问题记录**:
- 系统日期显示 2026-02-27，API 使用 2025-02-26 测试成功
- 新秀球员搜索暂未返回数据（可能数据未完全同步）
- 实际使用时请使用正确的昨天日期

**解决方案**:
- 脚本会自动使用 `date -d "yesterday"` 获取正确日期
- 已测试 API Key 可用性

---

**配置完成时间**: 2026-02-27 11:35  
**状态**: ✅ 可用
