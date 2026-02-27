#!/usr/bin/env python3
"""
Analyze individual NBA player for card investment potential.

Usage:
    python3 player_analysis.py "Anthony Edwards"
    python3 player_analysis.py "Cason Wallace" --rookie
    python3 player_analysis.py "Paolo Banchero" --verbose
"""

import argparse
import json
from typing import Dict, List

# Player database with key attributes for card analysis
PLAYER_PROFILES = {
    "Anthony Edwards": {
        "team": "森林狼",
        "age": 24,
        "position": "SG",
        "archetype": "明星得分手",
        "card_tier": "精英",
        "pros": ["全明星级别", "爆发力极强", "季后赛证明"],
        "cons": ["效率波动", "带队成绩待突破"],
        "recommendation": "💎 核心持有",
        "rationale": "已确立为联盟顶级得分手，季后赛表现验证大心脏属性。卡片价值稳定，适合长期持有。"
    },
    "Cason Wallace": {
        "team": "雷霆",
        "age": 21,
        "position": "SG/PG", 
        "archetype": "3D后卫",
        "card_tier": "潜力",
        "pros": ["防守精英", "球队核心替补", "效率稳定"],
        "cons": ["自主进攻有限", "上限可能受限"],
        "recommendation": "💎 长期持有",
        "rationale": "雷霆体系中的关键拼图，防守价值被低估。卡片价格相对合理，适合价值投资者。"
    },
    "Paolo Banchero": {
        "team": "魔术",
        "age": 22,
        "position": "PF",
        "archetype": "全能前锋",
        "card_tier": "明星",
        "pros": ["得分能力出色", "关键时刻可靠", "年轻核心"],
        "cons": ["效率有提升空间", "球队成绩一般"],
        "recommendation": "🔵 推荐买入",
        "rationale": "已展现绝杀能力，是魔术建队核心。卡片价格已部分反映价值，但仍具上涨空间。"
    },
    "Dylan Harper": {
        "team": "马刺",
        "age": 19,
        "position": "SG",
        "archetype": "冠军血统新秀",
        "card_tier": "新秀潜力",
        "pros": ["马刺培养", "父亲冠军背景", "选秀榜眼"],
        "cons": ["新秀波动大", "数据不突出"],
        "recommendation": "🌱 长期布局",
        "rationale": "马刺重点培养对象，冠军血统加分。当前卡片价格已较高，适合逢低吸纳。"
    },
    "Carter Bryant": {
        "team": "马刺",
        "age": 20,
        "position": "SF/PF",
        "archetype": "3D锋线",
        "card_tier": "新秀潜力",
        "pros": ["2月数据爆发", "三分命中率提升", "最佳捡漏"],
        "cons": ["样本量小", "轮换地位不稳"],
        "recommendation": "📈 积极关注",
        "rationale": "2月表现验证潜力，从26%提升到44%三分命中率。如果持续，卡片有翻倍空间。"
    },
    "Cooper Flagg": {
        "team": "独行侠",
        "age": 19,
        "position": "SF/PF",
        "archetype": "状元全能",
        "card_tier": "顶级新秀",
        "pros": ["状元身份", "数据全面", "即战力"],
        "cons": ["市场预期过高", "价格已 premium"],
        "recommendation": "⏳ 观望",
        "rationale": "天赋毋庸置疑，但卡片价格已透支预期。除非出现明显回调，否则不建议追高。"
    },
    "Matas Buzelis": {
        "team": "公牛",
        "age": 20,
        "position": "SF",
        "archetype": "欧洲锋线",
        "card_tier": "新秀黑马",
        "pros": ["近期爆发", "32分高光", "上涨空间大"],
        "cons": ["稳定性待验证", "球队环境一般"],
        "recommendation": "🔥 短线关注",
        "rationale": "32分表现值得关注，但需观察持续性。卡片相对便宜，可以小仓位尝试。"
    },
    "Jaden McDaniels": {
        "team": "森林狼",
        "age": 24,
        "position": "SF/PF",
        "archetype": "防守专家",
        "card_tier": "被低估",
        "pros": ["DPOY潜力", "攻防一体", "年轻"],
        "cons": ["进攻角色有限", "市场关注度低"],
        "recommendation": "🔥 价值洼地",
        "rationale": "防守型球员被市场低估，但29+6+3断5帽的数据证明全面性。卡片性价比高。"
    }
}

def analyze_player(name: str, verbose: bool = False) -> str:
    """Generate analysis for a specific player."""
    
    # Try exact match first
    profile = None
    for key in PLAYER_PROFILES:
        if key.lower() == name.lower() or key in name or name in key:
            profile = PLAYER_PROFILES[key]
            name = key
            break
    
    if not profile:
        return f"❌ 未找到 '{name}' 的数据。目前支持: {', '.join(PLAYER_PROFILES.keys())}"
    
    lines = [
        f"# 🏀 {name} - 球星卡投资分析",
        "",
        f"**球队**: {profile['team']} | **年龄**: {profile['age']} | **位置**: {profile['position']}",
        f"**球员类型**: {profile['archetype']} | **卡片等级**: {profile['card_tier']}",
        "",
        f"## 📊 投资建议: {profile['recommendation']}",
        "",
        f"**分析**: {profile['rationale']}",
        "",
        "### ✅ 优势",
    ]
    
    for pro in profile['pros']:
        lines.append(f"- {pro}")
    
    lines.append("")
    lines.append("### ⚠️ 风险")
    
    for con in profile['cons']:
        lines.append(f"- {con}")
    
    if verbose:
        lines.extend([
            "",
            "### 🎯 操作建议",
            "",
            "| 操作 | 时机 | 目标价位 |",
            "|------|------|----------|",
        ])
        
        if "买入" in profile['recommendation'] or "持有" in profile['recommendation']:
            lines.append("| 买入 |  dips/回调 | 当前价 ±10% |")
            lines.append("| 卖出 | 爆发后的 hype peak | +30-50% |")
        else:
            lines.append("| 观望 | 等待回调 | -20% from current |")
            lines.append("| 建仓 | 重大利好确认 | 突破阻力位 |")
    
    lines.extend([
        "",
        "---",
        "*分析基于当前数据，投资有风险，决策需谨慎*"
    ])
    
    return '\n'.join(lines)

def compare_players(names: List[str]) -> str:
    """Compare multiple players for investment decision."""
    
    lines = [
        "# 🏀 球员投资对比分析",
        "",
    ]
    
    profiles = []
    for name in names:
        for key in PLAYER_PROFILES:
            if key.lower() == name.lower() or key in name or name in key:
                profiles.append((key, PLAYER_PROFILES[key]))
                break
    
    if len(profiles) < 2:
        return "❌ 需要至少2个有效球员进行对比"
    
    lines.append("| 球员 | 球队 | 类型 | 建议 | 风险等级 |")
    lines.append("|------|------|------|------|----------|")
    
    for name, p in profiles:
        risk = "低" if "持有" in p['recommendation'] else "中" if "买入" in p['recommendation'] else "高"
        lines.append(f"| {name} | {p['team']} | {p['archetype']} | {p['recommendation']} | {risk} |")
    
    lines.extend([
        "",
        "## 💡 对比建议",
        "",
        f"**短期 (1-3个月)**: 关注近期表现爆发力强的球员",
        f"**中期 (6-12个月)**: 考虑球队战绩和季后赛曝光度",  
        f"**长期 (1年+)**: 优先选择年轻核心，潜力释放空间大",
        "",
    ])
    
    return '\n'.join(lines)

def main():
    parser = argparse.ArgumentParser(description='Analyze NBA player card investment potential')
    parser.add_argument('player', help='Player name to analyze')
    parser.add_argument('--compare', '-c', help='Compare with another player')
    parser.add_argument('--verbose', '-v', action='store_true', help='Show detailed analysis')
    parser.add_argument('--rookie', '-r', action='store_true', help='Add rookie analysis context')
    
    args = parser.parse_args()
    
    if args.compare:
        result = compare_players([args.player, args.compare])
    else:
        result = analyze_player(args.player, args.verbose)
    
    print(result)

if __name__ == "__main__":
    main()
