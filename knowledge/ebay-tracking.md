# eBay 球星卡价格追踪配置

## 搜索链接模板

### 基础搜索URL
```
https://www.ebay.com/sch/i.html?_nkw={关键词}&_sacat=0&LH_Sold=1&LH_Complete=1
```

### 关注球员搜索链接

#### Dylan Harper
- **Prizm Silver**: 
  `https://www.ebay.com/sch/i.html?_nkw=dylan+harper+prizm+silver&_sacat=0&LH_Sold=1`
- **低编（/25 /99）**: 
  `https://www.ebay.com/sch/i.html?_nkw=dylan+harper+prizm+%2F25+%2F99&_sacat=0&LH_Sold=1`
- **签字卡**: 
  `https://www.ebay.com/sch/i.html?_nkw=dylan+harper+auto+autograph&_sacat=0&LH_Sold=1`

#### Carter Bryant
- **Prizm Silver**: 
  `https://www.ebay.com/sch/i.html?_nkw=carter+bryant+prizm+silver&_sacat=0&LH_Sold=1`
- **低编**: 
  `https://www.ebay.com/sch/i.html?_nkw=carter+bryant+prizm+%2F10+%2F25&_sacat=0&LH_Sold=1`

#### Victor Wembanyama
- **Prizm Silver**: 
  `https://www.ebay.com/sch/i.html?_nkw=wembanyama+prizm+silver&_sacat=0&LH_Sold=1`
- **签字卡**: 
  `https://www.ebay.com/sch/i.html?_nkw=wembanyama+auto+autograph&_sacat=0&LH_Sold=1`

#### Cooper Flagg
- **Prizm**: 
  `https://www.ebay.com/sch/i.html?_nkw=cooper+flagg+prizm&_sacat=0&LH_Sold=1`

---

## 搜索技巧

### 关键词组合
```
基础: 球员名 + 系列名
示例: dylan harper prizm

低编: 球员名 + 系列名 + /编数
示例: dylan harper prizm /25

评级卡: 球员名 + PSA/BGS + 分数
示例: dylan harper prizm psa 10

签字卡: 球员名 + auto/autograph
示例: dylan harper auto
```

### 过滤条件
- `LH_Sold=1` - 只显示已成交（看真实价格）
- `LH_Complete=1` - 已完成交易
- `_sacat=0` - 全部分类

### 排序方式
- **Best Match** - 默认排序
- **Time: newly listed** - 最新上架（追踪实时市场）
- **Price + Shipping: lowest first** - 价格从低到高

---

## 价格记录表

### Dylan Harper Prizm

| 日期 | 卡片 | 成交价格 | 趋势 |
|------|------|----------|------|
| 2026-02-27 | Silver Base | $-- | -- |
| 2026-02-27 | /25 Purple | $-- | -- |
| 2026-02-27 | /99 Blue | $-- | -- |

### Carter Bryant Prizm

| 日期 | 卡片 | 成交价格 | 趋势 |
|------|------|----------|------|
| 2026-02-27 | Silver Base | $-- | -- |
| 2026-02-27 | /10 Gold | $-- | -- |
| 2026-02-27 | /25 Purple | $-- | -- |

### Victor Wembanyama Prizm

| 日期 | 卡片 | 成交价格 | 趋势 |
|------|------|----------|------|
| 2026-02-27 | Silver Base | $-- | -- |
| 2026-02-27 | Auto | $-- | -- |

---

## 手动追踪流程

### 每日 20:00 检查
1. 打开 eBay 搜索链接
2. 筛选 "Sold items"（已成交）
3. 查看最近 24 小时成交
4. 记录关键价格到上表
5. 对比前几日，判断趋势

### 关注指标
- **成交量**: 成交数量多 = 流动性好
- **价格区间**: 最低价~最高价，判断合理价位
- **评级卡溢价**: PSA 10 vs 裸卡价差

---

## 自动化方案（未来）

### 方案1：eBay API
- 需要注册 eBay 开发者账号
- API Key 申请较复杂
- 可获取真实成交数据

### 方案2：网页抓取
- 使用爬虫工具（如 puppeteer）
- 需要处理反爬机制
- 技术难度中等

### 方案3：第三方服务
- 130point.com（免费，但需手动查询）
- Card Ladder（付费，专业指数）

---

## 快速访问命令

```bash
# Dylan Harper Prizm Silver
open "https://www.ebay.com/sch/i.html?_nkw=dylan+harper+prizm+silver&LH_Sold=1"

# Carter Bryant Prizm
open "https://www.ebay.com/sch/i.html?_nkw=carter+bryant+prizm&LH_Sold=1"

# Wembanyama Prizm
open "https://www.ebay.com/sch/i.html?_nkw=wembanyama+prizm&LH_Sold=1"
```

---

*配置时间：2026-02-27*  
*状态：手动追踪，待自动化*
