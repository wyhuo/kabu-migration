#!/bin/bash
# GitHub推送脚本 - 在云端执行

cd /workspace/projects/workspace

# 配置远程仓库
git remote add github https://github.com/wyhuo/kabu-migration.git 2>/dev/null || true
git remote set-url github https://github.com/wyhuo/kabu-migration.git

# 确保所有更改已提交
git add -A
git commit -m "最终完整版：全部知识库+投资策略+交接手册+阅读地图" --allow-empty

# 推送
echo "正在推送到 https://github.com/wyhuo/kabu-migration ..."
git push -u github master --force

echo "✅ 推送完成！"
