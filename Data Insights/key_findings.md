# Key Findings – Logistics Performance KPI Analysis

## Dataset
- **500,000 delivery records** across 5 regions, 5 distribution centers, 5 carriers, 4 product types
- **Time period:** January 2023 – December 2024

---

## Finding 1: Empty Miles Are Concentrated in Southwest and Northeast

- **Southwest DC (DC_Phoenix)** had the highest empty miles rate at **~17.2%** of total miles driven
- Empty miles cost across the dataset exceeded **$8.5M** — roughly 15.7% of total spend
- **Root cause hypothesis:** Low backhaul utilization; routes running empty on return legs
- **Recommended action:** Consolidate outbound loads from Phoenix to improve return-load pairing with regional carriers

---

## Finding 2: Fill Rate Gaps on 58K+ Routes Represent $4.2M in Underutilization

- Routes with fill rate below 65% accounted for **~11.6% of all deliveries**
- Sliding Glass and Specialty product types had disproportionately low fill rates
- **CarrierD** had the worst fill rate alignment across low-volume routes
- **Recommended action:** Re-sequence Sliding Glass loads with Window loads to improve consolidated fills

---

## Finding 3: CarrierC Has the Worst On-Time Performance at Above-Average Cost

| Carrier    | On-Time % | Avg CPM ($) |
|------------|-----------|-------------|
| CarrierA   | 73.4%     | 3.14        |
| CarrierB   | 72.1%     | 3.19        |
| CarrierC   | 69.8%     | 3.22        |
| CarrierD   | 71.5%     | 3.16        |
| CarrierE   | 72.6%     | 3.17        |

- CarrierC underperforms on both service (OTD) and cost — a renegotiation or replacement candidate
- **Recommended action:** Issue a carrier scorecard review; consider redistributing volume to CarrierA

---

## Finding 4: CPM Variance Reduced 12% After Q3 2024 Route Consolidation

- Cost per mile variance was highest in H1 2023 (range: $2.40–$4.10)
- Consolidation of DC_Dallas and DC_Columbus outbound routes in Q3 2024 stabilized CPM
- Post-consolidation CPM range narrowed to **$2.85–$3.55**
- **Impact:** 12% reduction in CPM variance, improved pricing predictability

---

## Finding 5: Sliding Glass Drives Disproportionate Late Deliveries

- Sliding Glass = 11% of volume, but 34% of late deliveries
- Average days late for Sliding Glass: 2.4 days vs 1.6 days overall
- Likely driven by fragility handling requirements and limited carrier eligibility
- **Recommended action:** Create dedicated Sliding Glass routing rules with carrier pre-qualification

---

## Summary KPIs

| Metric                  | Value        |
|-------------------------|--------------|
| Total Deliveries        | 500,000      |
| On-Time Delivery %      | 72.0%        |
| Avg Fill Rate           | 77.8%        |
| Avg Cost Per Mile       | $3.17        |
| Avg Empty Miles %       | 15.7%        |
| Total Spend             | ~$502M       |
| Empty Mile Cost         | ~$8.5M       |
