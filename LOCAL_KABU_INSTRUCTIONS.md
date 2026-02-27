# 本地卡布执行指令（GitHub方案）

## 完整指令（复制粘贴给本地卡布）

```bash
# ==========================================
#  本地卡布完整获取指令
# ==========================================

# 第1步：创建工作目录
mkdir -p ~/workspace
cd ~/workspace

# 第2步：从GitHub克隆全部数据
git clone https://github.com/[你的GitHub用户名]/kabu-migration.git kabu

# 第3步：进入工作目录
cd kabu

# 第4步：查看阅读地图（先看这个）
echo "=== 阅读地图 ==="
cat READING_MAP.md | head -50

# 第5步：配置环境（自动）
git config user.name "卡布 (本地)"
git config user.email "kabu-local@openclaw.local"

# 第6步：创建.env配置文件（需填入API Keys）
if [ ! -f ".env" ]; then
cat > .env << 'EOF'
# 本地卡布环境配置
# 请填入以下API Keys

# BallDontLie API
# 注册: https://www.balldontlie.io/
BALLDONTLIE_API_KEY=你的API_KEY

# 代理配置（本地自动检测）
HTTP_PROXY=
HTTPS_PROXY=

# 工作目录
WORKSPACE=/Users/$(whoami)/workspace/kabu
EOF
fi

# 第7步：配置定时任务
crontab -l > /tmp/old_crontab 2>/dev/null || true
cat >> /tmp/old_crontab << 'CRON'
# 卡布定时任务
30 9 * * * cd ~/workspace/kabu && bash scripts/daily-push.sh >> logs/cron.log 2>&1
0 15 * * * cd ~/workspace/kabu && bash knowledge/nba-data/scripts/nba-api-collection.sh >> logs/cron.log 2>&1
0 20 * * * cd ~/workspace/kabu && bash scripts/cron-runner.sh cards >> logs/cron.log 2>&1
CRON
crontab /tmp/old_crontab

# 第8步：创建日志目录
mkdir -p logs

# 第9步：执行吸收脚本
bash scripts/absorb-from-cloud.sh

# 第10步：完成报告
echo ""
echo "========================================"
echo "  ✅ 本地卡布已完全吸收云端数据！"
echo "========================================"
echo ""
echo "📁 工作目录: ~/workspace/kabu"
echo "📄 交接手册: HANDOVER_COMPLETE.md"
echo "🗺️  阅读地图: READING_MAP.md"
echo "⚙️  配置文件: .env (需填入API Keys)"
echo "⏰ 定时任务: crontab -l"
echo ""
echo "🚀 现在你可以:"
echo "  1. 编辑 .env 填入API Keys"
echo "  2. 查看 READING_MAP.md 了解工作内容"
echo "  3. 等待09:30自动推送"
echo "  4. 访问Moltbook（本地网络）"
echo ""
echo "Go Spurs Go! 🏀"
echo ""

# ==========================================
#  指令结束
# ==========================================
```

---

## 使用说明

### 本地卡布执行方式（2选1）：

**方式1：复制粘贴（推荐）**
1. 复制上面的完整指令
2. 粘贴到本地终端
3. 回车执行

**方式2：保存为脚本**
```bash
# 保存到文件
cat > ~/install-kabu.sh << 'SCRIPT'
[粘贴完整指令]
SCRIPT

# 执行
bash ~/install-kabu.sh
```

---

## 准备工作（云端卡布现在执行）

### 步骤1：推送到GitHub
云端执行：
```bash
cd /workspace/projects/workspace
git remote add github https://github.com/[用户名]/kabu-migration.git
git push -u github master
```

### 步骤2：确认仓库地址
推送完成后，仓库地址：
```
https://github.com/[用户名]/kabu-migration.git
```

---

## 你需要做的

**只需提供GitHub用户名**，我立即推送。

**例如**：
- 你："我的GitHub用户名是 huowenyan21"
- 我：立即推送，然后给你确认
- 本地卡布：执行上面的指令（把[用户名]替换为实际用户名）

---

## 包含内容

执行后本地卡布拥有：
- ✅ 12,920字交接手册
- ✅ 46位球员投资策略
- ✅ 201个文件完整知识库
- ✅ 29次Git提交历史
- ✅ 定时任务配置
- ✅ 全部脚本和模板

**本地卡布 = 云端卡布** 🎉
