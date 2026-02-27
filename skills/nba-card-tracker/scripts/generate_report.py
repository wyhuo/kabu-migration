#!/usr/bin/env python3
"""
Generate NBA card market reports from player performance data.

Usage:
    python3 generate_report.py --date 2026-02-25
    python3 generate_report.py --yesterday
    python3 generate_report.py --file /path/to/nba_data.json
"""

import argparse
import json
import os
from datetime import datetime, timedelta
from typing import Dict, List, Any

def get_data_path(date_str: str) -> str:
    """Get path to NBA data for specific date."""
    base_path = "/workspace/projects/workspace/knowledge/nba-data/raw"
    return os.path.join(base_path, date_str)

def parse_player_stats(data_file: str) -> List[Dict]:
    """Parse player statistics from data file."""
    players = []
    if not os.path.exists(data_file):
        return players
    
    with open(data_file, 'r') as f:
        content = f.read()
        # Simple parsing for markdown tables
        lines = content.split('\n')
        for line in lines:
            if '|' in line and '球员' not in line and '---' not in line:
                parts = [p.strip() for p in line.split('|') if p.strip()]
                if len(parts) >= 4:
                    players.append({
                        'name': parts[0],
                        'team': parts[1] if len(parts) > 1 else '',
                        'stats': parts[2] if len(parts) > 2 else '',
                        'note': parts[3] if len(parts) > 3 else ''
                    })
    return players

def analyze_card_potential(player: Dict) -> Dict:
    """Analyze card investment potential based on stats."""
    stats = player.get('stats', '')
    name = player.get('name', '')
    note = player.get('note', '')
    
    signals = []
    score = 50  # Base score
    
    # Scoring analysis
    if '30+' in stats or '30分' in stats:
        signals.append("🔥 高分爆发")
        score += 20
    elif '25+' in stats or '25分' in stats:
        signals.append("📈 稳定得分")
        score += 15
    
    # Defense analysis
    if '断' in stats or '帽' in stats or 'steal' in stats.lower() or 'block' in stats.lower():
        if ('3断' in stats or '3steal' in stats.lower() or 
            '5帽' in stats or '5block' in stats.lower()):
            signals.append("🛡️ 统治级防守")
            score += 15
        else:
            signals.append("✋ 防守贡献")
            score += 5
    
    # Rebounds/assists (all-around game)
    if '10板' in stats or '10reb' in stats.lower():
        signals.append("🏀 两双表现")
        score += 10
    if '10助' in stats or '10ast' in stats.lower():
        signals.append("🎯 组织核心")
        score += 10
    
    # Rookie bonus
    if 'rook' in note.lower() or '新秀' in note:
        signals.append("🌟 新秀关注")
        score += 10
    
    # Clutch/important note
    if '绝杀' in note or 'clutch' in note.lower() or 'career high' in note.lower():
        signals.append("💎 关键表现")
        score += 15
    
    # Determine recommendation
    if score >= 80:
        recommendation = "🟢 强力买入"
    elif score >= 65:
        recommendation = "🔵 推荐关注"
    elif score >= 50:
        recommendation = "🟡 持有观察"
    else:
        recommendation = "⚪ 暂不关注"
    
    return {
        'name': name,
        'score': score,
        'signals': signals,
        'recommendation': recommendation,
        'raw_stats': stats
    }

def generate_report(date_str: str) -> str:
    """Generate full card market report."""
    data_path = get_data_path(date_str)
    
    if not os.path.exists(data_path):
        return f"❌ 未找到 {date_str} 的数据"
    
    report_lines = [
        f"# 🏀 球星卡市场简报 ({date_str})",
        "",
        "## 📊 今日重点关注",
        ""
    ]
    
    # Parse games data
    games_file = os.path.join(data_path, "01-games.md")
    if os.path.exists(games_file):
        players = parse_player_stats(games_file)
        
        analyses = []
        for player in players:
            analysis = analyze_card_potential(player)
            analyses.append(analysis)
        
        # Sort by score
        analyses.sort(key=lambda x: x['score'], reverse=True)
        
        # Top picks
        report_lines.append("### 🌟 投资推荐 TOP 5")
        report_lines.append("")
        for i, a in enumerate(analyses[:5], 1):
            report_lines.append(f"**{i}. {a['name']}** - {a['recommendation']}")
            report_lines.append(f"   - 数据: {a['raw_stats']}")
            if a['signals']:
                report_lines.append(f"   - 信号: {' | '.join(a['signals'])}")
            report_lines.append("")
        
        # Rookie watch
        rookies = [a for a in analyses if '新秀' in str(a.get('signals', [])) or 'rook' in str(a).lower()]
        if rookies:
            report_lines.append("### 🌱 新秀追踪")
            report_lines.append("")
            for r in rookies[:3]:
                report_lines.append(f"- **{r['name']}**: {r['recommendation']} (得分: {r['score']})")
            report_lines.append("")
    
    # Add summary
    report_lines.append("---")
    report_lines.append("")
    report_lines.append("## 💡 今日要点")
    report_lines.append("")
    report_lines.append("- 关注高分爆发球员的短期卡片机会")
    report_lines.append("- 防守型球员通常被低估，可能有价值洼地")
    report_lines.append("- 新秀表现波动大，适合长期持有而非短线")
    report_lines.append("")
    
    return '\n'.join(report_lines)

def main():
    parser = argparse.ArgumentParser(description='Generate NBA card market reports')
    parser.add_argument('--date', help='Specific date (YYYY-MM-DD)')
    parser.add_argument('--yesterday', action='store_true', help='Use yesterday\'s data')
    parser.add_argument('--output', '-o', help='Output file path')
    
    args = parser.parse_args()
    
    if args.yesterday:
        date_str = (datetime.now() - timedelta(days=1)).strftime('%Y-%m-%d')
    elif args.date:
        date_str = args.date
    else:
        # Default to most recent data
        base_path = "/workspace/projects/workspace/knowledge/nba-data/raw"
        if os.path.exists(base_path):
            dirs = sorted([d for d in os.listdir(base_path) if d.startswith('2026')], reverse=True)
            date_str = dirs[0] if dirs else datetime.now().strftime('%Y-%m-%d')
        else:
            date_str = datetime.now().strftime('%Y-%m-%d')
    
    report = generate_report(date_str)
    
    if args.output:
        with open(args.output, 'w') as f:
            f.write(report)
        print(f"✅ 报告已保存: {args.output}")
    else:
        print(report)

if __name__ == "__main__":
    main()
