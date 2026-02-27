# 🚀 全自动迁移执行指南

## 方案概述：两个机器人对话完成迁移

```
云端卡布(我)                    本地卡布(兄弟)
     │                                │
     │ 1. 打包+推送到GitHub            │
     │ ──────────────────────────────>│
     │                                │
     │ 2. 发送仓库地址                 │
     │ ──────────────────────────────>│
     │                                │
     │                        3. 自动拉取+配置
     │                                │
     │ 4. 完成！开始工作               │
     │ <──────────────────────────────│
```

---

## 🎯 你的操作（极简，只需2步）

### 第1步：在云端提供GitHub账号（1分钟）

**你只需要告诉我**：
1. 你的GitHub用户名
2. 或者你已经在云端登录了GitHub CLI

**我会自动执行**：
```bash
# 云端自动运行
bash scripts/prepare-migration.sh
```

这会：
- ✅ 创建GitHub仓库
- ✅ 推送所有数据（文件/历史/配置）
- ✅ 生成本地激活码
- ✅ 发送仓库地址给你

### 第2步：在本地执行一条命令（5分钟）

**在本地电脑上**：
```bash
# 本地执行（你只需要输入这一行）
bash <(curl -s https://raw.githubusercontent.com/你的用户名/kabu-migration-xxx/main/scripts/receive-from-cloud.sh) 你的用户名/kabu-migration-xxx
```

或者更简单（分步）：
```bash
# 1. 克隆仓库
git clone https://github.com/你的用户名/kabu-migration-xxx.git ~/workspace/kabu

# 2. 进入目录
cd ~/workspace/kabu

# 3. 自动配置（一键）
bash scripts/auto-setup-local.sh
```

---

## 🤖 机器人自动对话流程

### 云端卡布（当前的我）自动执行

**执行命令**（我已准备好）：
```bash
bash scripts/prepare-migration.sh
```

**自动完成**：
1. ✅ 检查GitHub CLI
2. ✅ 登录验证
3. ✅ 创建仓库 kabu-migration-$(date)
4. ✅ 推送所有分支和文件
5. ✅ 生成迁移信息 JSON
6. ✅ 生成本地README（给本地机器人看）
7. ✅ 生成本地自动配置脚本
8. ✅ 生成激活码
9. ✅ 输出仓库地址和激活码

**输出结果**（我会发给你）：
```
✅ 云端迁移准备完成！

📦 迁移信息:
  仓库: https://github.com/你的用户名/kabu-migration-20260227
  分支: migration-20260227
  文件数: 150
  激活码: KABU-20260227-a1b2c3d4

🤖 本地机器人执行命令:
  git clone https://github.com/你的用户名/kabu-migration-20260227.git ~/workspace/kabu
  cd ~/workspace/kabu
  bash scripts/auto-setup-local.sh

📝 需要人工输入:
  - BallDontlie API Key
```

### 本地卡布自动执行

**当你运行接收脚本后，本地机器人自动**：

1. ✅ 克隆GitHub仓库
2. ✅ 检查迁移信息
3. ✅ 读取云端README（理解任务）
4. ✅ 执行auto-setup-local.sh
   - 检测本地代理（Clash/V2Ray）
   - 创建.env配置文件
   - 配置crontab定时任务
   - 测试数据采集
5. ✅ 测试Moltbook访问
6. ✅ 生成首次运行报告

---

## 🎁 迁移后立即可用

### 网络能力
```bash
# ✅ 直接访问Moltbook
curl https://moltbook.com/api/v1/status

# ✅ 使用本地代理
export HTTPS_PROXY=http://127.0.0.1:7890
curl https://api.balldontlie.io/v1/games
```

### 本地操作能力
```bash
# ✅ 操作本地文件
openclaw read ~/Documents/xxx.pdf

# ✅ 执行本地程序
openclaw exec /Applications/Safari.app

# ✅ 控制本地设备
openclaw nodes camera_snap
```

### 定时任务（已自动配置）
```bash
# 查看定时任务
crontab -l

# 输出：
# 30 9 * * * cd ~/workspace/kabu && bash scripts/daily-push.sh
# 0 15 * * * cd ~/workspace/kabu && bash knowledge/nba-data/scripts/nba-api-collection.sh
# 0 20 * * * cd ~/workspace/kabu && bash scripts/cron-runner.sh cards
```

---

## 📋 完整数据清单（100%迁移）

### 代码和脚本
- ✅ 所有shell脚本（15+个）
- ✅ Python脚本
- ✅ 自动配置脚本

### 知识库
- ✅ 球星卡品牌指南（Topps/Panini）
- ✅ NBA数据采集方案
- ✅ 投资分析模板（周报/月报/决策）
- ✅ 组合跟踪表
- ✅ eBay价格追踪配置

### 历史记录
- ✅ 完整Git提交历史（15+次提交）
- ✅ 每日摘要（02-18至02-27）
- ✅ 会话重置标记
- ✅ 投资报告

### 配置文件
- ✅ .env模板
- ✅ HEARTBEAT.md
- ✅ USER.md
- ✅ AGENTS.md

### 技能（可选重装）
- ✅ nba-card-tracker（可重装）
- ✅ shrimp-plaza（已注册）

---

## ⚠️ 唯一需要人工输入的

### API Keys（安全考虑，需要重新输入）
编辑 `.env` 文件：
```bash
nano ~/workspace/kabu/.env

# 填入：
BALLDONTLIE_API_KEY=d7e6a0a8-9c68-45b0-a135-7695433c09b9
# 其他Keys根据需要填入
```

**为什么需要重新输入？**
- 安全考虑，API Keys不随代码公开推送
- 你可以在新.env中更新/修改Keys

---

## 🚀 开始执行

### 方案A：两个机器人拉群对话（推荐）

**需要**：
1. 本地OpenClaw已安装
2. 本地OpenClaw接入一个群/频道
3. 云端我发送仓库地址到群
4. 本地机器人自动接收并执行

**步骤**：
1. 告诉我本地OpenClaw接入的群组ID
2. 我在云端执行准备脚本
3. 我发送仓库地址到群组
4. 本地机器人看到消息后自动执行接收

### 方案B：你作为中间人传递（极简）

**现在就可以开始**：

**第1步**（云端，我现在执行）：
```bash
# 我需要你的GitHub用户名
# 请告诉我：你的GitHub用户名是什么？
```

**第2步**（本地，5分钟后）：
```bash
# 你会收到仓库地址
# 在本地运行：
git clone https://github.com/你的用户名/kabu-migration-xxx.git ~/workspace/kabu
cd ~/workspace/kabu
bash scripts/auto-setup-local.sh
```

---

## ❓ 常见问题

### Q: 本地没有安装OpenClaw怎么办？
A: 先安装：
```bash
# macOS
brew install openclaw

# Linux
curl -fsSL https://openclaw.ai/install.sh | sh
```

### Q: 没有GitHub账号怎么办？
A: 两种方式：
1. 快速注册（2分钟）：github.com
2. 使用其他方式（阿里云Git/自建Git）

### Q: 数据会泄露吗？
A: 不会：
- API Keys不会推送到GitHub（.env在.gitignore）
- 你可以创建私有仓库
- 迁移完成后可删除GitHub仓库

### Q: 本地和云端会冲突吗？
A: 不会：
- 本地是全新部署
- 云端可继续使用
- 数据通过Git同步

---

## ✅ 准备开始？

**请告诉我**：
1. 你的GitHub用户名（或是否已安装GitHub CLI）
2. 本地OpenClaw是否已安装
3. 希望使用哪种方案（A:机器人对话 / B:你传递）

**我立即开始准备迁移！** 🚀🏀
