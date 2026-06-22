-- ============================================================
-- Logistics KPI Analysis Queries
-- Author: Aastha Gade
-- ============================================================

-- 1. OVERALL KPI SUMMARY
SELECT
    COUNT(*)                                                                          AS total_deliveries,
    ROUND(AVG(fill_rate) * 100, 2)                                                    AS avg_fill_rate_pct,
    ROUND(SUM(CASE WHEN delivery_status = 'On Time' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2)
                                                                                      AS on_time_delivery_pct,
    ROUND(AVG(cost_per_mile), 4)                                                      AS avg_cost_per_mile,
    ROUND(AVG(empty_miles / NULLIF(total_miles, 0)) * 100, 2)                         AS avg_empty_miles_pct,
    ROUND(SUM(total_delivery_cost), 2)                                                AS total_spend
FROM deliveries;


-- 2. MONTHLY KPI TRENDS
SELECT
    DATE_TRUNC('month', scheduled_date)                                               AS month,
    COUNT(*)                                                                          AS total_deliveries,
    ROUND(AVG(fill_rate) * 100, 2)                                                    AS fill_rate_pct,
    ROUND(SUM(CASE WHEN delivery_status = 'On Time' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2)
                                                                                      AS on_time_pct,
    ROUND(AVG(cost_per_mile), 4)                                                      AS avg_cpm,
    ROUND(AVG(empty_miles / NULLIF(total_miles, 0)) * 100, 2)                         AS empty_miles_pct
FROM deliveries
GROUP BY 1
ORDER BY 1;


-- 3. CARRIER PERFORMANCE SCORECARD
SELECT
    carrier,
    COUNT(*)                                                                          AS total_deliveries,
    ROUND(AVG(fill_rate) * 100, 2)                                                    AS avg_fill_rate_pct,
    ROUND(SUM(CASE WHEN delivery_status = 'On Time' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2)
                                                                                      AS on_time_pct,
    ROUND(AVG(cost_per_mile), 4)                                                      AS avg_cpm,
    ROUND(AVG(empty_miles), 1)                                                        AS avg_empty_miles,
    ROUND(SUM(total_delivery_cost), 2)                                                AS total_spend
FROM deliveries
GROUP BY carrier
ORDER BY on_time_pct DESC;


-- 4. EMPTY MILES ROOT CAUSE BY REGION
SELECT
    region,
    distribution_center,
    COUNT(*)                                                                          AS deliveries,
    ROUND(AVG(empty_miles / NULLIF(total_miles, 0)) * 100, 2)                         AS empty_miles_pct,
    ROUND(AVG(fill_rate) * 100, 2)                                                    AS avg_fill_rate_pct,
    ROUND(SUM(empty_miles * cost_per_mile), 2)                                        AS empty_mile_cost_impact
FROM deliveries
GROUP BY region, distribution_center
ORDER BY empty_miles_pct DESC;


-- 5. FILL RATE GAP ANALYSIS (routes below 65%)
SELECT
    region,
    carrier,
    product_type,
    COUNT(*)                                                                          AS route_count,
    ROUND(AVG(fill_rate) * 100, 2)                                                    AS avg_fill_rate_pct,
    ROUND(SUM((load_capacity_lbs - actual_load_lbs) * 1.0 / load_capacity_lbs * total_delivery_cost), 2)
                                                                                      AS estimated_underutil_cost
FROM deliveries
WHERE fill_rate < 0.65
GROUP BY region, carrier, product_type
HAVING COUNT(*) > 100
ORDER BY estimated_underutil_cost DESC;


-- 6. COST PER MILE VARIANCE BY DISTRIBUTION CENTER
SELECT
    distribution_center,
    ROUND(AVG(cost_per_mile), 4)                                                      AS avg_cpm,
    ROUND(STDDEV(cost_per_mile), 4)                                                   AS cpm_stddev,
    ROUND(MIN(cost_per_mile), 4)                                                      AS min_cpm,
    ROUND(MAX(cost_per_mile), 4)                                                      AS max_cpm,
    ROUND((MAX(cost_per_mile) - MIN(cost_per_mile)) / AVG(cost_per_mile) * 100, 2)   AS cpm_variance_pct
FROM deliveries
GROUP BY distribution_center
ORDER BY cpm_variance_pct DESC;


-- 7. LATE DELIVERY ROOT CAUSE
SELECT
    region,
    carrier,
    product_type,
    COUNT(*)                                                                          AS late_deliveries,
    ROUND(AVG(days_variance), 1)                                                      AS avg_days_late,
    ROUND(AVG(fill_rate) * 100, 2)                                                    AS avg_fill_rate_pct,
    ROUND(AVG(empty_miles / NULLIF(total_miles, 0)) * 100, 2)                         AS avg_empty_miles_pct
FROM deliveries
WHERE delivery_status = 'Late'
GROUP BY region, carrier, product_type
HAVING COUNT(*) > 200
ORDER BY late_deliveries DESC
LIMIT 20;


-- 8. MONTHLY EMPTY MILES & FILL RATE REPORT
SELECT
    TO_CHAR(scheduled_date, 'YYYY-MM')                                                AS month,
    ROUND(SUM(empty_miles), 1)                                                        AS total_empty_miles,
    ROUND(AVG(empty_miles / NULLIF(total_miles, 0)) * 100, 2)                         AS empty_miles_pct,
    ROUND(AVG(fill_rate) * 100, 2)                                                    AS avg_fill_rate_pct,
    ROUND(SUM(empty_miles * cost_per_mile), 2)                                        AS empty_mile_cost
FROM deliveries
GROUP BY 1
ORDER BY 1;
