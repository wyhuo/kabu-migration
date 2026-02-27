# 技能安装问题解决方案

## 问题描述
**错误**: `Rate limit exceeded`
**原因**: ClawHub API 频率限制（每小时/每天限制请求数）
**状态**: 已尝试4次，仍受限

---

## 解决方案

### 方案1: 等待后重试（推荐）
```bash
# 等待30-60分钟后重试
sleep 3600
npx clawhub@latest install weather
```

### 方案2: 使用本地已有技能
当前已安装技能：
- nba-card-tracker ✅
- shrimp-plaza ✅

### 方案3: 使用替代方案（不依赖技能）
**weather功能替代**:
- 使用 curl 直接查询 wttr.in
- 示例: `curl wttr.in/Beijing?format=3`

**news功能替代**:
- 使用 browser 工具访问新闻网站
- 使用 RSS 订阅

### 方案4: 手动安装（绕过API限制）
```bash
# 直接克隆技能仓库（如果公开）
git clone https://github.com/xxx/weather-skill.git
# 放入 skills/ 目录
```

---

## 当前策略

**暂时跳过技能安装**，优先使用已有工具：
1. ✅ BallDontLie API（NBA数据）
2. ✅ 浏览器工具（新闻/天气）
3. ✅ 脚本工具（数据采集）

**等待1-2小时后**，再次尝试安装 weather/news 技能。

---

*记录时间: 2026-02-27 13:16*
