#!/bin/bash
#
# 本地卡布完整性验证脚本
# 检查是否完整接收了云端卡布的全部内容
#

echo "========================================"
echo "  🔍 本地卡布完整性验证"
echo "========================================"
echo ""

WORKSPACE_DIR="${1:-~/workspace/kabu}"
cd "$WORKSPACE_DIR" 2>/dev/null || {
    echo "❌ 错误：工作目录不存在: $WORKSPACE_DIR"
    echo "请先执行: git clone https://github.com/wyhuo/kabu-migration.git $WORKSPACE_DIR"
    exit 1
}

echo "📁 检查工作目录: $WORKSPACE_DIR"
echo ""

# 统计
total_checks=0
passed_checks=0
failed_checks=0

check_item() {
    local item="$1"
    local path="$2"
    total_checks=$((total_checks + 1))
    
    if [ -e "$path" ]; then
        echo "✅ $item"
        passed_checks=$((passed_checks + 1))
        return 0
    else
        echo "❌ $item (缺失: $path)"
        failed_checks=$((failed_checks + 1))
        return 1
    fi
}

check_file_content() {
    local item="$1"
    local path="$2"
    local keyword="$3"
    total_checks=$((total_checks + 1))
    
    if [ -f "$path" ] && grep -q "$keyword" "$path" 2>/dev/null; then
        echo "✅ $item"
        passed_checks=$((passed_checks + 1))
        return 0
    else
        echo "❌ $item (内容不完整)"
        failed_checks=$((failed_checks + 1))
        return 1
    fi
}

echo "【一】核心配置文件检查"
echo "--------------------"
check_item "用户配置 USER.md" "USER.md"
check_item "定时任务 HEARTBEAT.md" "HEARTBEAT.md"
check_item "交接手册 HANDOVER_COMPLETE.md" "HANDOVER_COMPLETE.md"
check_item "阅读地图 READING_MAP.md" "READING_MAP.md"
check_item "环境配置 .env" ".env"
check_item "Git配置 .git/config" ".git/config"
echo ""

echo "【二】知识库目录检查"
echo "--------------------"
check_item "知识库目录 knowledge/" "knowledge"
check_item "球星卡指南 knowledge/basketball-cards/" "knowledge/basketball-cards"
check_item "NBA数据 knowledge/nba-data/" "knowledge/nba-data"
check_item "报告模板 knowledge/templates/" "knowledge/templates"
check_item "投资策略 card-investment-targets.md" "knowledge/card-investment-targets.md"
check_item "投资策略 card-investment-strategy-full.md" "knowledge/card-investment-strategy-full.md"
check_item "eBay追踪 ebay-tracking.md" "knowledge/ebay-tracking.md"
check_item "组合跟踪 portfolio-tracker.md" "knowledge/portfolio-tracker.md"
echo ""

echo "【三】脚本文件检查"
echo "--------------------"
check_item "脚本目录 scripts/" "scripts"
check_item "早报脚本 daily-push.sh" "scripts/daily-push.sh"
check_item "定时任务执行器 cron-runner.sh" "scripts/cron-runner.sh"
check_item "数据采集脚本 nba-api-collection.sh" "knowledge/nba-data/scripts/nba-api-collection.sh"
check_item "本地吸收脚本 absorb-from-cloud.sh" "scripts/absorb-from-cloud.sh"
echo ""

echo "【四】模板文件检查"
echo "--------------------"
check_item "日报模板 daily-report-optimized.md" "knowledge/templates/daily-report-optimized.md"
check_item "周报模板 weekly-report-template.md" "knowledge/templates/weekly-report-template.md"
check_item "月报模板 monthly-report-template.md" "knowledge/templates/monthly-report-template.md"
check_item "买卖决策模板 trade-decision-template.md" "knowledge/templates/trade-decision-template.md"
echo ""

echo "【五】历史记录检查"
echo "--------------------"
check_item "历史记录目录 memory/" "memory"
check_item "每日摘要目录 daily_summary/" "daily_summary"
check_item "重置标记 RESET_*.md" "memory/RESET_20260227.md"
echo ""

echo "【六】内容完整性检查"
echo "--------------------"
check_file_content "USER.md包含文炎信息" "USER.md" "文炎"
check_file_content "交接手册包含投资策略" "HANDOVER_COMPLETE.md" "Carter Bryant"
check_file_content "HEARTBEAT包含定时任务" "HEARTBEAT.md" "09:30"
check_file_content "环境配置包含API Key" ".env" "BALLDONTLIE_API_KEY"
echo ""

echo "【七】文件数量统计"
echo "--------------------"
file_count=$(find . -type f | wc -l)
echo "总文件数: $file_count"

if [ -d "knowledge" ]; then
    knowledge_count=$(find knowledge -type f | wc -l)
    echo "知识库文件: $knowledge_count"
fi

if [ -d "scripts" ]; then
    scripts_count=$(find scripts -type f | wc -l)
    echo "脚本文件: $scripts_count"
fi

if [ -d "memory" ]; then
    memory_count=$(find memory -type f | wc -l)
    echo "历史记录: $memory_count"
fi

git_log_count=$(git log --oneline 2>/dev/null | wc -l)
echo "Git提交数: $git_log_count"
echo ""

echo "【八】可执行性检查"
echo "--------------------"
for script in "scripts/daily-push.sh" "scripts/cron-runner.sh" "scripts/absorb-from-cloud.sh"; do
    if [ -f "$script" ]; then
        if [ -x "$script" ]; then
            echo "✅ $script 可执行"
        else
            echo "⚠️  $script 存在但不可执行 (运行: chmod +x $script)"
        fi
    fi
done
echo ""

echo "========================================"
echo "  📊 验证结果统计"
echo "========================================"
echo "总检查项: $total_checks"
echo "✅ 通过: $passed_checks"
echo "❌ 失败: $failed_checks"

if [ $failed_checks -eq 0 ]; then
    echo ""
    echo "🎉 恭喜！完整性验证100%通过！"
    echo "本地卡布已完全接收云端卡布的全部内容！"
    echo ""
    echo "下一步操作:"
    echo "1. 编辑 .env 填入API Keys"
    echo "2. 配置定时任务: crontab -e"
    echo "3. 测试数据采集: bash knowledge/nba-data/scripts/nba-api-collection.sh"
    echo "4. 开始工作！"
    exit 0
else
    echo ""
    echo "⚠️  验证未通过！"
    echo "缺失 $failed_checks 项内容，请重新克隆或补充缺失文件。"
    exit 1
fi
