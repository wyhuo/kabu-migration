# 本地OpenClaw配置指南（极简版）

## 🎯 目标
配置本地OpenClaw，接入一个群组/频道，等待云端卡布发送迁移指令

---

## 安装步骤（5分钟）

### 1. 安装OpenClaw

**macOS**:
```bash
brew install openclaw
```

**Linux (Ubuntu/Debian)**:
```bash
curl -fsSL https://openclaw.ai/install.sh | sh
```

**Windows (WSL2)**:
```bash
# 在WSL2中执行Linux安装命令
curl -fsSL https://openclaw.ai/install.sh | sh
```

### 2. 验证安装
```bash
openclaw version
openclaw status
```

---

## 配置步骤（10分钟）

### 3. 配置Gateway（后台服务）

```bash
# 启动Gateway
openclaw gateway start

# 检查状态
openclaw gateway status
```

### 4. 配置消息渠道（选择一种）

#### 方案A: Telegram（推荐，简单）
```bash
# 1. 在Telegram中找 @BotFather 创建Bot
# 2. 获取Bot Token
# 3. 配置:
openclaw channels telegram add --token YOUR_BOT_TOKEN

# 4. 把Bot拉入一个群组
# 5. 告诉我群组ID
```

#### 方案B: Discord
```bash
# 1. 在Discord创建Bot
# 2. 获取Token和Channel ID
# 3. 配置:
openclaw channels discord add --token YOUR_TOKEN --channel CHANNEL_ID
```

#### 方案C: Slack
```bash
# 1. 创建Slack App
# 2. 获取Bot Token
# 3. 配置:
openclaw channels slack add --token YOUR_TOKEN --channel CHANNEL_ID
```

#### 方案D: Feishu/Lark（国内）
```bash
# 1. 创建Feishu机器人
# 2. 获取Webhook URL或App ID/Secret
# 3. 配置:
openclaw channels feishu add --app-id YOUR_APP_ID --app-secret YOUR_SECRET
```

---

## 测试步骤（5分钟）

### 5. 测试消息接收

在配置的群组中发送消息：
```
测试本地OpenClaw
```

本地OpenClaw应该能收到并回复

### 6. 测试消息发送

```bash
# 发送测试消息到频道
openclaw message send --channel telegram --message "本地卡布已就绪！"
```

---

## 完成 checklist

- [ ] OpenClaw已安装
- [ ] Gateway已启动
- [ ] 消息渠道已配置
- [ ] 测试消息收发正常
- [ ] 把我（云端卡布）加入同一个群组

---

## 通知我

配置完成后，告诉我：
1. **群组ID** 或 **频道名称**
2. **使用的平台**（Telegram/Discord/Slack/Feishu）

**我会立即加入并开始迁移！** 🚀

---

## 备用方案

如果配置遇到问题，可以使用**方案A（极简两步）**：
1. 我告诉你GitHub仓库地址
2. 本地执行一条命令完成迁移

无需配置消息渠道，更快更简单！

---

*配置指南创建时间: 2026-02-27*  
*等待你的好消息！🏀*
