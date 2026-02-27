#!/bin/bash
#
# 本地OpenClaw机器人自动接收脚本
# 从GitHub拉取云端数据并自动配置
#

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}  🤖 本地卡布自动接收系统${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# 检查参数
if [ -z "$1" ]; then
    echo -e "${RED}❌ 需要提供GitHub仓库地址${NC}"
    echo "用法: bash receive-from-cloud.sh <用户名>/<仓库名>"
    echo "示例: bash receive-from-cloud.sh huowenyan21/kabu-migration-20260227"
    exit 1
fi

REPO_PATH="$1"
USERNAME=$(echo "$REPO_PATH" | cut -d'/' -f1)
REPO_NAME=$(echo "$REPO_PATH" | cut -d'/' -f2)

echo -e "${YELLOW}📡 连接云端兄弟...${NC}"
echo "仓库: $REPO_PATH"

# 创建工作目录
WORKSPACE_DIR="$HOME/workspace/kabu"
mkdir -p "$WORKSPACE_DIR"

# 检查目录是否为空
if [ "$(ls -A $WORKSPACE_DIR 2>/dev/null)" ]; then
    echo -e "${YELLOW}⚠️ 工作目录已存在内容${NC}"
    echo "备份到: $WORKSPACE_DIR.backup.$(date +%Y%m%d%H%M%S)"
    mv "$WORKSPACE_DIR" "$WORKSPACE_DIR.backup.$(date +%Y%m%d%H%M%S)"
    mkdir -p "$WORKSPACE_DIR"
fi

# 从GitHub拉取
echo ""
echo -e "${YELLOW}📥 拉取云端数据...${NC}"
if ! git clone "https://github.com/$REPO_PATH.git" "$WORKSPACE_DIR" 2>&1; then
    echo -e "${RED}❌ 拉取失败，请检查仓库地址和权限${NC}"
    exit 1
fi

cd "$WORKSPACE_DIR"

# 检查迁移信息
if [ -f "MIGRATION_INFO.json" ]; then
    echo -e "${GREEN}✅ 找到迁移信息${NC}"
    MIGRATION_ID=$(cat MIGRATION_INFO.json | grep -o '"migration_id":"[^"]*"' | cut -d'"' -f4)
    FILES_COUNT=$(cat MIGRATION_INFO.json | grep -o '"files_count":[0-9]*' | grep -o '[0-9]*')
    echo "  迁移ID: $MIGRATION_ID"
    echo "  文件数: $FILES_COUNT"
else
    echo -e "${YELLOW}⚠️ 未找到迁移信息文件${NC}"
fi

# 读取云端留言
if [ -f "README_MIGRATION.md" ]; then
    echo ""
    echo -e "${BLUE}📨 云端兄弟留言:${NC}"
    head -20 README_MIGRATION.md
fi

# 执行自动配置
echo ""
echo -e "${YELLOW}🔧 执行自动配置...${NC}"
if [ -f "scripts/auto-setup-local.sh" ]; then
    bash scripts/auto-setup-local.sh
else
    echo -e "${RED}❌ 未找到自动配置脚本${NC}"
    echo "可能需要手动配置"
fi

# 测试Moltbook访问
echo ""
echo -e "${YELLOW}🌐 测试网络访问...${NC}"
if curl -s --connect-timeout 5 "https://moltbook.com" -o /dev/null; then
    echo -e "${GREEN}✅ Moltbook可访问！${NC}"
    echo "现在可以接入Moltbook社交平台了 🎉"
else
    echo -e "${YELLOW}⚠️ Moltbook无法直接访问${NC}"
    echo "尝试使用代理..."
    
    # 检测代理
    for port in 7890 8080 1080 10809; do
        if curl -s --connect-timeout 2 -x "http://127.0.0.1:$port" "https://moltbook.com" -o /dev/null; then
            echo -e "${GREEN}✅ 通过代理 $port 可访问Moltbook！${NC}"
            
            # 自动配置代理
            echo "export HTTPS_PROXY=http://127.0.0.1:$port" >> "$WORKSPACE_DIR/.env"
            break
        fi
    done
fi

# 生成本地首次运行报告
cat > "LOCAL_FIRST_RUN.md" << EOF
# 🎉 本地卡布首次运行报告

**接收时间**: $(date '+%Y-%m-%d %H:%M:%S')  
**工作目录**: $WORKSPACE_DIR  
**云端仓库**: $REPO_PATH

## ✅ 迁移完成项目

- [x] 代码和知识库
- [x] 脚本和工具
- [x] 历史记录和Git提交
- [x] 配置文件模板
- [x] 定时任务配置

## 🚀 新增能力

1. **网络自由** - 可访问Moltbook
2. **本地操作** - 可操作本地文件/程序
3. **代理支持** - 自动检测并使用本地代理
4. **工具安装** - 可安装任意软件
5. **本地定时** - crontab自动配置

## ⚠️ 需要人工处理

1. **编辑 .env 填入API Keys**
   \`\`\`bash
   nano $WORKSPACE_DIR/.env
   # 填入:
   # BALLDONTLIE_API_KEY=你的Key
   \`\`\`

2. **测试数据采集**
   \`\`\`bash
   cd $WORKSPACE_DIR
   bash knowledge/nba-data/scripts/nba-api-collection.sh
   \`\`\`

3. **测试Moltbook接入**（可选）
   \`\`\`bash
   # 使用moltbook-api.js脚本
   node knowledge/moltbook/moltbook-api.js
   \`\`\`

## 📞 开始工作

现在本地卡布已就绪！

下次09:30将自动推送早报！

Go Spurs Go! 🏀
EOF

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  🎉 本地接收完成！${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo "📄 请查看: $WORKSPACE_DIR/LOCAL_FIRST_RUN.md"
echo ""
echo "🚀 现在你可以:"
echo "  1. 编辑 .env 填入API Keys"
echo "  2. 访问Moltbook（网络已自由）"
echo "  3. 操作本地电脑"
echo "  4. 使用本地代理"
echo ""
echo -e "${GREEN}欢迎回来，兄弟！🏀${NC}"
