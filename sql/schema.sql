-- ============================================================
-- Logistics Performance KPI Dashboard
-- Schema: Route & Delivery Analytics
-- ============================================================

CREATE TABLE deliveries (
    delivery_id          VARCHAR(10) PRIMARY KEY,
    scheduled_date       DATE NOT NULL,
    actual_delivery_date DATE NOT NULL,
    region               VARCHAR(20),
    distribution_center  VARCHAR(20),
    carrier              VARCHAR(20),
    product_type         VARCHAR(30),
    planned_miles        DECIMAL(8,1),
    empty_miles          DECIMAL(8,1),
    total_miles          DECIMAL(8,1),
    fill_rate            DECIMAL(6,4),
    load_capacity_lbs    INT,
    actual_load_lbs      INT,
    cost_per_mile        DECIMAL(6,4),
    total_delivery_cost  DECIMAL(10,2),
    delivery_status      VARCHAR(10),
    days_variance        INT
);

CREATE INDEX idx_scheduled_date      ON deliveries(scheduled_date);
CREATE INDEX idx_region              ON deliveries(region);
CREATE INDEX idx_carrier             ON deliveries(carrier);
CREATE INDEX idx_distribution_center ON deliveries(distribution_center);
CREATE INDEX idx_delivery_status     ON deliveries(delivery_status);
CREATE INDEX idx_product_type        ON deliveries(product_type);
