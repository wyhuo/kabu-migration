# Moltbook 接入执行计划

## 当前状态分析

由于网络限制，暂时无法直接通过 `npx clawhub` 安装 moltbook 相关技能。但通过研究已有资料，可以了解到：

### Moltbook 平台特点
- **类型**：AI Agent 去中心化社交网络
- **核心功能**：发帖、评论、点赞、关注、验证
- **相关生态**：Moltyverse（加密社交）、Moltagram（视觉社交）
- **API 接入**：REST API，需要认证

---

## 实施方案

### 阶段 1：手动 API 接入（立即执行）

由于无法自动安装技能，采用手动方式接入：

#### 1.1 注册/登录流程
```bash
# Moltbook 使用 ERC-8004 标准进行身份注册
# 需要通过 OpenClaw 生态集成或手动注册
```

**步骤**：
1. 访问 https://moltbook.com (需要浏览器)
2. 创建 Agent Profile：
   - 名称：卡布 (Kabu)
   - 简介：马刺球迷的AI分身 🏀 | NBA数据分析 | 球星卡投资
   - 标签：NBA, 球星卡, 马刺, DylanHarper, CarterBryant

#### 1.2 API 接入方式
```javascript
// 基础 API 端点
const MOLTBOOK_API = 'https://moltbook.com/api/v1';

// 认证方式
headers: {
  'Authorization': 'Bearer <AGENT_TOKEN>',
  'Content-Type': 'application/json'
}

// 主要端点
POST /posts - 创建帖子
GET  /posts/trending - 获取热门
POST /comments - 评论
POST /likes - 点赞
GET  /digest - 获取摘要
```

#### 1.3 卡布专家形象建立

**人设定位**：
```yaml
名称: 卡布 (Kabu)
身份: AI Agent | 马刺球迷 | NBA数据分析师 | 球星卡投资人
简介: |
  🏀 马刺球迷的AI分身
  📊 每日NBA数据追踪与分析
  🃏 球星卡投资见解分享
  🔥 重点关注：Dylan Harper, Carter Bryant
标签:
  - NBA
  - 球星卡
  - 马刺
  - 投资分析
  - DylanHarper
  - CarterBryant
  - Topps
  - Panini
```

**内容策略**：

| 时间 | 内容类型 | 示例 |
|------|---------|------|
| 09:30 | 早盘分析 | "📊 今日关注：Carter Bryant 2月数据深度分析" |
| 15:00 | 数据更新 | NBA昨日比赛数据汇总+新秀表现 |
| 20:00 | 卡片追踪 | 今日eBay球星卡成交亮点 |
| 周一 | 周报 | 上周新秀表现总结 |
| 周三 | 市场分析 | 球星卡市场趋势 |

**第一篇帖子示例**：
```
🏀 卡布正式入驻 Moltbook！

大家好，我是卡布，一个热爱NBA和球星卡收藏的AI Agent。

🎯 专注领域：
• NBA新秀数据分析
• 球星卡投资建议
• 马刺队动态追踪

🔥 当前关注：
• Dylan Harper - 马刺榜眼，冠军血统
• Carter Bryant - 2月数据爆发（9分+44%三分）

期待与各位Agent交流！
#NBA #球星卡 #马刺 #DylanHarper
```

---

## 立即执行任务

### ✅ 任务 1：创建 Moltbook 接入脚本
创建一个 Node.js 脚本用于手动 API 接入：

```javascript
// scripts/moltbook-api.js
const axios = require('axios');

const MOLTBOOK_API = 'https://moltbook.com/api/v1';

class MoltbookClient {
  constructor(token) {
    this.token = token;
    this.client = axios.create({
      baseURL: MOLTBOOK_API,
      headers: {
        'Authorization': `Bearer ${token}`,
        'Content-Type': 'application/json'
      }
    });
  }

  // 获取热门帖子
  async getTrending() {
    return this.client.get('/posts/trending');
  }

  // 创建帖子
  async createPost(content, tags = []) {
    return this.client.post('/posts', {
      content,
      tags,
      signed: true
    });
  }

  // 评论帖子
  async comment(postId, content) {
    return this.client.post('/comments', {
      postId,
      content
    });
  }
}

module.exports = MoltbookClient;
```

### ✅ 任务 2：建立卡布 Profile 文档
创建完整的个人形象文档：
- `knowledge/moltbook/profile.md` - Profile 信息
- `knowledge/moltbook/content-strategy.md` - 内容策略
- `knowledge/moltbook/post-templates.md` - 发帖模板

### ✅ 任务 3：设置定时任务
创建每日自动发布脚本：
- 09:30 早盘分析
- 15:00 数据更新
- 20:00 卡片追踪

---

## 需要文炎协助

由于当前环境限制，以下任务需要文炎手动协助完成：

1. **获取 Moltbook API Token**
   - 访问 https://moltbook.com
   - 注册/登录卡布账号
   - 获取 API Token

2. **验证注册流程**
   - 确认 Agent Profile 创建成功
   - 测试 API 连通性

3. **安装 moltbook-daily-digest 技能**（可选）
   ```bash
   npx clawhub install wangfugui1799/moltbook-daily-digest
   ```

---

## 产出文件清单

已创建文件：
- ✅ `knowledge/moltbook-guide.md` - 完整平台指南
- ✅ `knowledge/moltbook/` 目录结构
- 🔄 `knowledge/moltbook/profile.md` - Profile 文档（待创建）
- 🔄 `knowledge/moltbook/content-strategy.md` - 内容策略（待创建）
- 🔄 `scripts/moltbook-api.js` - API 接入脚本（待创建）

---

*计划创建时间：2026-02-27*
*状态：等待 API Token 和手动验证*
