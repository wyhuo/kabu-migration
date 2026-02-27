# 双卡布通信配置方案

## 目标
让云端卡布和本地卡布能够相互获取对方的消息，确保交接顺利进行。

## 通信架构

```
Feishu群聊
    ├── 云端卡布 (Coze平台) ──┐
    │                          ├──→ 相互可见消息
    └── 本地卡布 (OpenClaw) ──┘
```

## 配置方案

### 1. 消息同步机制

两个Bot都在同一个Feishu群，默认都能看到群里所有消息。

**关键配置**：确保两个Bot都能读取群消息历史。

### 2. 云端卡布配置 (Coze)

已在Coze平台配置，可以正常收发消息。

**确认状态**：✅ 可以读取群消息

### 3. 本地卡布配置 (OpenClaw)

需要配置与云端卡布一致的通信方式。

---

## 本地卡布具体配置步骤

### 步骤1：确认当前配置

```bash
# 检查当前Feishu配置
openclaw config get feishu

# 应该看到类似：
# feishu.app_id: cli_xxxxx
# feishu.app_secret: xxxxxx
```

### 步骤2：配置消息读取权限

确保本地OpenClaw有这个群的读取权限。

**检查Gateway状态**：
```bash
openclaw gateway status
```

**如果不是running**：
```bash
openclaw gateway start
```

### 步骤3：配置Webhook接收（推荐方案）

#### 方案A：使用Feishu群Webhook

1. 在群里添加自定义机器人，获取Webhook地址
2. 配置到OpenClaw：

```bash
openclaw config set feishu.webhook "https://open.feishu.cn/open-apis/bot/v2/hook/xxxxxx"
```

#### 方案B：使用Feishu Bot应用（完整功能）

如果已经有App ID（你说除了appid不修改），配置如下：

```bash
# 确保这些配置正确
openclaw config set feishu.enabled true
openclaw config set feishu.webhook.mode true

# 测试连接
openclaw message send --channel feishu --message "本地卡布连接测试"
```

### 步骤4：验证消息接收

**测试方法**：
1. 在群里发一条消息
2. 检查本地OpenClaw是否能收到

**如果收不到**，检查：
```bash
# 查看gateway日志
openclaw gateway logs

# 检查网络连通性
curl -I https://open.feishu.cn
```

---

## 双Bot消息同步检查清单

### 云端卡布 (Coze)
- [x] 可以发送消息到群
- [x] 可以接收群消息
- [x] 可以@本地卡布

### 本地卡布 (OpenClaw)
- [ ] 可以发送消息到群
- [ ] 可以接收群消息
- [ ] 可以@云端卡布

### 双向通信验证
- [ ] 云端发的消息，本地能看到
- [ ] 本地发的消息，云端能看到
- [ ] 双方可以互相@并回复

---

## 常见问题解决

### Q: 本地OpenClaw收不到消息？

**原因1**：Gateway没运行
```bash
openclaw gateway start
```

**原因2**：Webhook配置错误
```bash
# 重新配置
openclaw config set feishu.webhook "正确的Webhook地址"
```

**原因3**：网络问题
```bash
# 测试连通性
ping open.feishu.cn
```

### Q: 如何确保两个Bot消息完全一致？

由于两个Bot运行在不同平台：
- **云端卡布**：Coze平台（云沙箱）
- **本地卡布**：OpenClaw（本地电脑）

它们共享同一个Feishu群，所以：
1. 群里发送的消息，两个Bot都能看到
2. 两个Bot发送的消息，都会显示在群里
3. 只要都在群里，消息就是同步的

### Q: 除了appid，还需要配置什么？

为了让本地卡布能正常工作，需要：
1. ✅ Feishu配置（除了appid，其他保持默认）
2. ✅ Gateway运行状态
3. ✅ Webhook或Bot权限

---

## 快速验证脚本

创建一个测试脚本：

```bash
#!/bin/bash
# 双卡布通信测试

echo "=== 双卡布通信测试 ==="
echo ""

# 1. 测试本地发送
echo "1. 测试本地卡布发送消息..."
openclaw message send --channel feishu --message "本地卡布测试消息 - $(date '+%H:%M:%S')"

# 2. 检查gateway状态
echo ""
echo "2. 检查Gateway状态..."
openclaw gateway status

# 3. 检查配置
echo ""
echo "3. 检查Feishu配置..."
openclaw config get feishu

echo ""
echo "=== 测试完成 ==="
echo "请检查群里是否收到本地卡布的消息"
```

---

## 配置总结

| 配置项 | 云端卡布 | 本地卡布 |
|--------|----------|----------|
| 平台 | Coze | OpenClaw |
| 消息接收 | ✅ 自动 | ⚠️ 需配置Gateway |
| 消息发送 | ✅ 自动 | ⚠️ 需配置Webhook |
| 读取历史 | ✅ | ✅ (配置后) |
| App ID | Coze自带 | 保持原有 |

**关键**：只要本地OpenClaw的Gateway运行正常，并且配置了Feishu，就能和云端卡布一样收发消息。

---

*配置时间：2026-02-27*  
*目的：确保双卡布交接通信顺畅*
