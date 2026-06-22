# 🚚 Logistics Performance – Route & Delivery KPI Dashboard

**Tools:** SQL · Excel · Power BI · Python  
**Dataset:** 500,000 delivery records across 5 regions, 5 distribution centers, 5 carriers  
**Period:** January 2023 – December 2024

---

## Project Overview

Built an end-to-end logistics analytics solution to identify root cause performance gaps across a manufacturing distribution network. Integrated 500K+ delivery and routing records to surface insights on empty miles, fill rate gaps, and cost per mile variance — enabling data-driven decisions on carrier selection, route consolidation, and scheduling optimization.

---

## Business Questions Answered

- Where are empty miles concentrated, and what's the cost impact?
- Which carriers have the worst on-time delivery performance — and at what cost?
- Where are fill rate gaps pulling down load efficiency?
- How has cost per mile trended, and what drove variance reduction?
- Which product types drive the most late deliveries?

---

## Key Findings

| Finding | Impact |
|---|---|
| Southwest DC has highest empty miles % (~17.2%) | ~$8.5M empty mile cost across dataset |
| 58K+ routes with fill rate < 65% | ~$4.2M in underutilization cost |
| CarrierC: lowest OTD (69.8%) at highest CPM | Renegotiation / reallocation candidate |
| Q3 2024 route consolidation | 12% reduction in CPM variance |
| Sliding Glass = 11% volume, 34% of late deliveries | Dedicated routing rules recommended |

---

## Repository Structure

```
logistics-kpi-project/
├── data/
│   └── routes_deliveries.csv        # 500K row synthetic dataset
├── sql/
│   ├── schema.sql                   # Table + index definitions
│   └── analysis_queries.sql         # 8 KPI queries (OTD, fill rate, empty miles, CPM)
├── excel/
│   └── logistics_kpi_analysis.xlsx  # 5-tab workbook with pivot tables + charts
├── powerbi/
│   └── powerbi_setup_guide.md       # DAX measures + 4-page dashboard layout
└── insights/
    └── key_findings.md              # Full findings write-up with recommendations
```

---

## Dataset Schema

| Column | Type | Description |
|---|---|---|
| delivery_id | VARCHAR | Unique delivery identifier |
| scheduled_date | DATE | Planned delivery date |
| actual_delivery_date | DATE | Actual delivery date |
| region | VARCHAR | Geographic region |
| distribution_center | VARCHAR | Source DC |
| carrier | VARCHAR | Carrier name |
| product_type | VARCHAR | Product category |
| planned_miles | DECIMAL | Planned route miles |
| empty_miles | DECIMAL | Miles driven without load |
| total_miles | DECIMAL | Total miles driven |
| fill_rate | DECIMAL | Load utilization rate (0–1) |
| cost_per_mile | DECIMAL | Fully-loaded CPM |
| total_delivery_cost | DECIMAL | Total delivery cost |
| delivery_status | VARCHAR | On Time / Late / Early |
| days_variance | INT | Actual vs scheduled (days) |

---

## SQL Highlights

**Empty miles cost by region:**
```sql
SELECT region, distribution_center,
    ROUND(AVG(empty_miles / NULLIF(total_miles, 0)) * 100, 2) AS empty_miles_pct,
    ROUND(SUM(empty_miles * cost_per_mile), 2)                AS empty_mile_cost_impact
FROM deliveries
GROUP BY region, distribution_center
ORDER BY empty_miles_pct DESC;
```

**Fill rate gap analysis (routes < 65%):**
```sql
SELECT region, carrier, product_type,
    ROUND(AVG(fill_rate) * 100, 2) AS avg_fill_rate_pct,
    ROUND(SUM((load_capacity_lbs - actual_load_lbs) * 1.0 / load_capacity_lbs * total_delivery_cost), 2)
        AS estimated_underutil_cost
FROM deliveries
WHERE fill_rate < 0.65
GROUP BY region, carrier, product_type
HAVING COUNT(*) > 100
ORDER BY estimated_underutil_cost DESC;
```

---

## Excel Workbook Tabs

1. **Executive Summary** — KPI cards + key findings
2. **Monthly Trends** — OTD %, fill rate, CPM with line chart
3. **Carrier Scorecard** — Performance table + bar chart
4. **Region Analysis** — Empty miles + cost by region
5. **Data Sample** — 10K row sample for reference

---

## Power BI Dashboard

4-page dashboard built on the CSV dataset:
- Page 1: Executive KPI summary with slicers
- Page 2: Empty miles & fill rate deep-dive
- Page 3: Carrier scorecard with threshold-based coloring
- Page 4: Monthly trend lines

See [`powerbi/powerbi_setup_guide.md`](powerbi/powerbi_setup_guide.md) for DAX measures and layout instructions.

---

## How to Run

```bash
# Load dataset into PostgreSQL
psql -d your_db -f sql/schema.sql
\copy deliveries FROM 'data/routes_deliveries.csv' CSV HEADER

# Run KPI queries
psql -d your_db -f sql/analysis_queries.sql
```

Open `excel/logistics_kpi_analysis.xlsx` directly in Excel — no setup needed.

---

*Built as part of a logistics analytics portfolio focused on manufacturing distribution networks.*
