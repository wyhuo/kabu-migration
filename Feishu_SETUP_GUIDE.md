# 本地卡布读取Feishu群消息配置指南

## 当前状态确认

**云端卡布** ✅ 可以读取和回复（就是我，正在说话的这个）
**本地卡布** ❓ 需要配置后才能读取

---

## 配置步骤

### 1. 检查OpenClaw Gateway是否运行

```bash
openclaw gateway status
```

应该显示：`running`

如果不是，启动它：
```bash
openclaw gateway start
```

---

### 2. 检查Feishu配置

```bash
openclaw config get feishu
```

应该显示：
- webhook URL
- app_id / app_secret（如果使用自建应用）

---

### 3. 配置Feishu Webhook（最简单方式）

#### 步骤A：在Feishu创建Webhook

1. 打开要接入的群聊
2. 点击群设置 → 群机器人 → 添加机器人
3. 选择 "自定义机器人"
4. 复制Webhook地址

#### 步骤B：配置本地OpenClaw

```bash
openclaw config set feishu.webhook "https://open.feishu.cn/open-apis/bot/v2/hook/xxxxxx"
```

---

### 4. 配置Feishu Bot（高级方式，推荐）

如果要用完整的Bot功能（接收群消息、主动发送）：

#### 步骤A：创建Feishu应用

1. 访问 https://open.feishu.cn/app
2. 创建企业自建应用
3. 获取 App ID 和 App Secret
4. 添加权限：
   - `im:chat:readonly` (读取群信息)
   - `im:message:send` (发送消息)
   - `im:message.group_msg` (接收群消息)

#### 步骤B：配置OpenClaw

```bash
# 设置App凭证
openclaw config set feishu.app_id "cli_xxxxx"
openclaw config set feishu.app_secret "xxxxxxxx"

# 设置事件订阅（用于接收消息）
openclaw config set feishu.encrypt_key "xxxxx"
openclaw config set feishu.verification_token "xxxxx"
```

#### 步骤C：设置事件订阅URL

在Feishu开放平台：
1. 进入应用 → 事件订阅
2. 设置请求URL：
   ```
   http://你的本地IP:端口号/feishu/webhook
   ```
   或
   ```
   https://你的公网域名/feishu/webhook
   ```

---

### 5. 验证配置

#### 测试发送消息

```bash
openclaw message send --channel feishu --target "群名称" --message "本地卡布测试消息"
```

#### 测试接收消息

在群里发消息@机器人，看本地OpenClaw是否收到。

---

## 常见问题

### Q: 本地OpenClaw收不到消息？

**检查1**：网络连通性
```bash
# 测试能否访问Feishu API
curl "https://open.feishu.cn/open-apis/auth/v3/tenant_access_token/internal"
```

**检查2**：事件订阅URL是否可达
- 如果在局域网，需要内网穿透（ngrok/frp）
- 如果在公网，检查防火墙

**检查3**：权限是否足够
- 确认应用有 `im:message.group_msg` 权限
- 确认机器人已在群里

### Q: 如何快速测试？

**最快方式**：使用Webhook发送

1. 获取群Webhook地址
2. 配置到OpenClaw
3. 本地卡布就能发送消息到群

**接收消息需要**：事件订阅配置（稍微复杂）

---

## 快速启动方案

如果只是想快速测试本地卡布：

### 方案A：仅发送（最简单）
```bash
# 1. 获取群Webhook
# 在Feishu群 → 设置 → 机器人 → 添加自定义机器人

# 2. 配置
openclaw config set feishu.webhook "你的Webhook地址"

# 3. 测试
openclaw message send --channel feishu --message "本地卡布上线测试"
```

### 方案B：收发完整（推荐）
1. 创建Feishu应用
2. 配置App ID / Secret
3. 设置事件订阅（需要公网URL或内网穿透）
4. 本地卡布可以正常收发消息

---

## 云端卡布 vs 本地卡布消息接收

| 方式 | 云端卡布 | 本地卡布 |
|------|----------|----------|
| Coze平台 | ✅ 自动接收 | - |
| Feishu Webhook | - | ✅ 需要配置 |
| Feishu Bot | - | ✅ 需要配置 |

---

## 建议配置流程

1. **先测试Webhook发送**（5分钟）
   - 让本地卡布能说话

2. **再配置Bot接收**（15-30分钟）
   - 让本地卡布能听
   - 可能需要内网穿透

3. **验证完整功能**
   - 群里@本地卡布，看它是否回复

---

*配置指南生成时间：2026-02-27*  
*本地卡布请按此配置*
