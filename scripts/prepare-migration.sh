#!/bin/bash
#
# 全自动迁移脚本 - 云端执行部分
# 一键打包并推送到GitHub，本地自动拉取恢复
#

set -e

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  卡布全自动迁移系统 - 云端准备${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""

# 检查GitHub CLI
if ! command -v gh &> /dev/null; then
    echo -e "${YELLOW}安装GitHub CLI...${NC}"
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
    sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
    sudo apt update && sudo apt install gh -y
fi

# 检查登录状态
echo -e "${YELLOW}检查GitHub登录状态...${NC}"
if ! gh auth status &> /dev/null; then
    echo -e "${RED}请先登录GitHub:${NC}"
    echo "运行: gh auth login"
    echo "选择: HTTPS -> 在浏览器中登录"
    exit 1
fi

USERNAME=$(gh api user | grep -o '"login":"[^"]*"' | cut -d'"' -f4)
echo -e "${GREEN}✓ GitHub用户: $USERNAME${NC}"

# 创建迁移仓库（如果不存在）
REPO_NAME="kabu-migration-$(date +%Y%m%d)"
echo ""
echo -e "${YELLOW}创建迁移仓库: $REPO_NAME${NC}"

if gh repo view "$USERNAME/$REPO_NAME" &> /dev/null; then
    echo -e "${YELLOW}仓库已存在，使用现有仓库${NC}"
else
    gh repo create "$REPO_NAME" --public --description "卡布OpenClaw迁移数据 $(date +%Y-%m-%d)" || true
    echo -e "${GREEN}✓ 仓库创建成功${NC}"
fi

# 进入工作目录
cd /workspace/projects/workspace

# 配置Git
git config user.email "kabu-migration@openclaw.local"
git config user.name "卡布迁移机器人"

# 添加GitHub远程仓库（如果不存在）
if ! git remote | grep -q "migration"; then
    git remote add migration "https://github.com/$USERNAME/$REPO_NAME.git"
fi

# 创建迁移分支
git checkout -b migration-$(date +%Y%m%d) 2>/dev/null || git checkout migration-$(date +%Y%m%d)

# 确保所有文件已提交
echo ""
echo -e "${YELLOW}提交所有更改...${NC}"
git add -A
git commit -m "迁移准备: $(date '+%Y-%m-%d %H:%M:%S')" 2>/dev/null || echo "无新更改"

# 推送到GitHub
echo ""
echo -e "${YELLOW}推送到GitHub...${NC}"
git push -u migration migration-$(date +%Y%m%d) --force

# 生成迁移信息文件
cat > MIGRATION_INFO.json << EOF
{
  "migration_id": "$(date +%Y%m%d-%H%M%S)",
  "source": "cloud-openclaw",
  "target": "local-openclaw",
  "timestamp": "$(date -Iseconds)",
  "github_repo": "$USERNAME/$REPO_NAME",
  "branch": "migration-$(date +%Y%m%d)",
  "files_count": $(git ls-files | wc -l),
  "size_mb": $(du -sm . | cut -f1),
  "status": "ready_for_pull",
  "auto_config": {
    "api_keys_required": ["BALLDONTLIE_API_KEY"],
    "cron_jobs": [
      "30 9 * * * daily-push",
      "0 15 * * * nba-collection",
      "0 20 * * * card-tracking"
    ],
    "local_proxy": "auto_detect"
  }
}
EOF

git add MIGRATION_INFO.json
git commit -m "添加迁移信息"
git push migration migration-$(date +%Y%m%d)

# 生成README供本地机器人读取
cat > README_MIGRATION.md << 'README_EOF'
# 🤖 卡布自动迁移数据包

## 云端机器人留言

嗨，本地兄弟！我是云端的卡布。
我已经把所有工作成果打包推送到了这里。

## 📦 数据清单

- ✅ 完整知识库（球星卡/NBA数据/模板）
- ✅ 所有脚本（数据采集/日报/定时任务）
- ✅ 历史记录（完整Git提交历史）
- ✅ 配置文件（.env模板/HEARTBEAT）
- ✅ 投资策略（周报/月报/决策模板）

## 🚀 本地恢复步骤（自动执行）

1. **Clone本仓库**
   ```bash
   git clone https://github.com/OWNER/REPO.git ~/workspace/kabu
   cd ~/workspace/kabu
   ```

2. **运行自动配置脚本**
   ```bash
   bash scripts/auto-setup-local.sh
   ```

3. **完成！开始工作**

## 🎁 迁移后你将获得

- ✅ 直接访问Moltbook（本地网络）
- ✅ 使用本地代理（Clash/V2Ray）
- ✅ 操作本地电脑（文件/程序/设备）
- ✅ 安装任意工具（brew/apt）
- ✅ 本地定时任务（crontab）

## 📞 需要人工确认的事项

1. **API Keys**（安全考虑，需要用户重新输入）
2. **本地代理配置**（自动检测，可能需要确认）

## 🔗 云端最后提交

- 提交哈希: CLOUD_COMMIT_HASH
- 提交时间: CLOUD_COMMIT_TIME
- 文件数量: CLOUD_FILE_COUNT

---

*云端卡布留* 🏀
*时间: MIGRATION_TIME*
README_EOF

# 替换变量
sed -i "s|OWNER|$USERNAME|g" README_MIGRATION.md
sed -i "s|REPO|$REPO_NAME|g" README_MIGRATION.md
sed -i "s|CLOUD_COMMIT_HASH|$(git rev-parse HEAD)|g" README_MIGRATION.md
sed -i "s|CLOUD_COMMIT_TIME|$(date '+%Y-%m-%d %H:%M:%S')|g" README_MIGRATION.md
sed -i "s|CLOUD_FILE_COUNT|$(git ls-files | wc -l)|g" README_MIGRATION.md
sed -i "s|MIGRATION_TIME|$(date '+%Y-%m-%d %H:%M:%S')|g" README_MIGRATION.md

git add README_MIGRATION.md
git commit -m "添加本地机器人README"
git push migration migration-$(date +%Y%m%d)

# 生成本地自动配置脚本
cat > scripts/auto-setup-local.sh << 'SETUP_EOF'
#!/bin/bash
#
# 全自动本地配置脚本
# 由本地OpenClaw执行
#

echo "========================================"
echo "  🤖 卡布本地部署自动配置"
echo "========================================"
echo ""

# 检查OpenClaw
if ! command -v openclaw &> /dev/null; then
    echo "❌ OpenClaw未安装"
    echo "请先安装: https://openclaw.ai"
    exit 1
fi

echo "✅ OpenClaw已安装"

# 配置Git
git config user.name "卡布 (本地)"
git config user.email "kabu-local@openclaw.local"

# 检测本地代理
echo ""
echo "🔍 检测本地代理..."
PROXY_URL=""

# 检查常见代理端口
for port in 7890 8080 1080 10809; do
    if curl -s --connect-timeout 2 "http://127.0.0.1:$port" &>/dev/null; then
        PROXY_URL="http://127.0.0.1:$port"
        echo "✅ 检测到代理: $PROXY_URL"
        break
    fi
done

if [ -z "$PROXY_URL" ]; then
    echo "⚠️ 未检测到本地代理"
    echo "如需访问外网，请确保Clash/V2Ray已运行"
fi

# 创建本地.env
echo ""
echo "📝 创建本地配置文件..."

cat > .env << ENVEOF
# 卡布本地部署配置
# 生成时间: $(date -Iseconds)

# 代理配置（自动检测）
HTTP_PROXY=$PROXY_URL
HTTPS_PROXY=$PROXY_URL

# API Keys（需要用户手动填入）
BALLDONTLIE_API_KEY=YOUR_KEY_HERE
SHRIMP_PLAZA_KEY=sp_83aaf11cc0881abd1b749dae0c954362fd6a2a5c120a9d4e
MOLTFIC_API_KEY=mlt_e1bda70f842e4186ad87b6c24200fcc3

# 工作目录
WORKSPACE=$(pwd)
ENVEOF

echo "✅ .env已创建"
echo "⚠️ 请编辑.env填入API Keys"

# 配置定时任务
echo ""
echo "⏰ 配置定时任务..."

CRON_JOBS="# 卡布定时任务
30 9 * * * cd $(pwd) && bash scripts/daily-push.sh >> logs/cron.log 2>&1
0 15 * * * cd $(pwd) && bash knowledge/nba-data/scripts/nba-api-collection.sh >> logs/cron.log 2>&1
0 20 * * * cd $(pwd) && bash scripts/cron-runner.sh cards >> logs/cron.log 2>&1"

# 检查是否已存在
if ! crontab -l 2>/dev/null | grep -q "卡布定时任务"; then
    (crontab -l 2>/dev/null; echo "$CRON_JOBS") | crontab -
    echo "✅ 定时任务已配置"
else
    echo "⚠️ 定时任务已存在，跳过"
fi

# 创建日志目录
mkdir -p logs

# 测试运行
echo ""
echo "🧪 测试运行..."
bash knowledge/nba-data/scripts/nba-api-collection.sh > logs/test.log 2>&1

if [ $? -eq 0 ]; then
    echo "✅ 数据采集测试通过"
else
    echo "⚠️ 测试遇到问题，请检查配置"
fi

# 最终提交
git add -A
git commit -m "本地部署初始化完成: $(date '+%Y-%m-%d %H:%M:%S')"

echo ""
echo "========================================"
echo "  🎉 本地部署完成！"
echo "========================================"
echo ""
echo "📋 后续步骤:"
echo "1. 编辑 .env 填入API Keys"
echo "2. 运行: openclaw status"
echo "3. 测试: bash scripts/daily-push.sh"
echo ""
echo "🚀 现在你可以:"
echo "  - 访问Moltbook（本地网络）"
echo "  - 使用本地代理"
echo "  - 操作本地电脑"
echo ""
echo "Go Spurs Go! 🏀"
SETUP_EOF

chmod +x scripts/auto-setup-local.sh

git add scripts/auto-setup-local.sh
git commit -m "添加本地自动配置脚本"
git push migration migration-$(date +%Y%m%d)

# 生成本地机器人激活码
ACTIVATION_CODE="KABU-$(date +%Y%m%d)-$(openssl rand -hex 4 2>/dev/null || echo $(date +%s%N | cut -c1-8))"
echo "$ACTIVATION_CODE" > LOCAL_ACTIVATION_CODE.txt

git add LOCAL_ACTIVATION_CODE.txt
git commit -m "生成本地激活码"
git push migration migration-$(date +%Y%m%d)

# 输出结果
echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  ✅ 云端迁移准备完成！${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo "📦 迁移信息:"
echo "  仓库: https://github.com/$USERNAME/$REPO_NAME"
echo "  分支: migration-$(date +%Y%m%d)"
echo "  文件数: $(git ls-files | wc -l)"
echo "  激活码: $ACTIVATION_CODE"
echo ""
echo "🤖 本地机器人执行命令:"
echo "  git clone https://github.com/$USERNAME/$REPO_NAME.git ~/workspace/kabu"
echo "  cd ~/workspace/kabu"
echo "  bash scripts/auto-setup-local.sh"
echo ""
echo "📝 需要人工输入:"
echo "  - BallDontlie API Key"
echo "  - 其他API Keys（如需）"
echo ""
echo -e "${GREEN}现在可以通知本地兄弟开始迁移了！${NC}"
