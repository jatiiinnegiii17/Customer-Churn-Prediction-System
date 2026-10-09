-- create database Churn;
-- use Churn;


-- desc customer_churn;


-- select * from customer_churn;

-- Indexing for fast query execution across Power BI and SQL analytical queries
-- CREATE INDEX idx_is_churned ON customer_churn(is_churned_numeric);
-- CREATE INDEX idx_segment ON customer_churn(customer_segment(50));
-- CREATE INDEX idx_country ON customer_churn(customer_country(50));
-- CREATE INDEX idx_health ON customer_churn(customer_health_category(50));


-- Executive KPI Overview & Financial Loss Baseline
-- SELECT 
--     COUNT(*) AS total_customers,
--     SUM(CASE WHEN is_churned = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
--     SUM(CASE WHEN is_churned = 'No' THEN 1 ELSE 0 END) AS active_customers,
--     ROUND(AVG(is_churned_numeric) * 100, 2) AS churn_rate_pct,
--     ROUND(SUM(churn_revenue_impact_usd), 2) AS gross_revenue_impact_usd,
--     ROUND(SUM(recovery_revenue_usd), 2) AS total_recovered_revenue_usd,
--     ROUND(SUM(net_churn_loss), 2) AS net_churn_loss_usd
-- FROM customer_churn;

-- Regional Churn Performance (Top 10 High-Risk Countries)
-- SELECT 
--     customer_country,
--     COUNT(*) AS total_customers,
--     SUM(is_churned_numeric) AS churned_customers,
--     ROUND(AVG(is_churned_numeric) * 100, 2) AS churn_rate_pct,
--     ROUND(AVG(customer_health_score), 2) AS avg_health_score,
--     ROUND(SUM(net_churn_loss), 2) AS total_net_loss_usd
-- FROM customer_churn
-- GROUP BY customer_country
-- HAVING total_customers >= 100
-- ORDER BY churn_rate_pct DESC
-- LIMIT 10;

-- Behavioral Comparison Profile (Active vs. Churned)
-- SELECT 
--     is_churned,
--     COUNT(*) AS customer_count,
--     ROUND(AVG(total_spend_usd), 2) AS avg_total_spend_usd,
--     ROUND(AVG(avg_order_value_usd), 2) AS avg_order_value_usd,
--     ROUND(AVG(num_purchases), 1) AS avg_num_purchases,
--     ROUND(AVG(days_since_last_purchase), 1) AS avg_recency_days,
--     ROUND(AVG(support_tickets), 2) AS avg_support_tickets,
--     ROUND(AVG(satisfaction_score), 2) AS avg_satisfaction_score,
--     ROUND(AVG(customer_health_score), 2) AS avg_health_score
-- FROM customer_churn
-- GROUP BY is_churned;


-- Root Cause Analysis — Top Primary Churn Reasons
-- SELECT 
--     churn_reason,
--     churn_category,
--     COUNT(*) AS churned_count,
--     ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS pct_of_total_churn,
--     ROUND(SUM(churn_revenue_impact_usd), 2) AS gross_revenue_impact_usd
-- FROM customer_churn
-- WHERE is_churned = 'Yes' AND churn_reason != 'not applicable'
-- GROUP BY churn_reason, churn_category
-- ORDER BY churned_count DESC;

-- Impact of Support Channels on Churn Rate
-- SELECT 
--     last_support_channel,
--     COUNT(*) AS total_interactions,
--     SUM(is_churned_numeric) AS churned_count,
--     ROUND(AVG(is_churned_numeric) * 100, 2) AS churn_rate_pct,
--     ROUND(AVG(support_tickets), 2) AS avg_support_tickets
-- FROM customer_churn
-- GROUP BY last_support_channel
-- ORDER BY churn_rate_pct DESC;


-- Customer Health Category vs Actual Churn Rates
-- SELECT 
--     customer_health_category,
--     churn_risk_category,
--     COUNT(*) AS customer_count,
--     SUM(is_churned_numeric) AS actual_churns,
--     ROUND(AVG(is_churned_numeric) * 100, 2) AS actual_churn_rate_pct,
--     ROUND(AVG(churn_probability) * 100, 2) AS avg_predicted_prob_pct
-- FROM customer_churn
-- GROUP BY customer_health_category, churn_risk_category
-- ORDER BY actual_churn_rate_pct DESC;


-- Monthly Churn Loss Trend Analysis
-- SELECT 
--     churn_month,
--     COUNT(*) AS monthly_churns,
--     ROUND(SUM(churn_revenue_impact_usd), 2) AS gross_loss_usd,
--     ROUND(SUM(recovery_revenue_usd), 2) AS recovered_revenue_usd,
--     ROUND(SUM(net_churn_loss), 2) AS net_loss_usd
-- FROM customer_churn
-- WHERE is_churned = 'Yes' AND churn_month > 0
-- GROUP BY churn_month
-- ORDER BY churn_month ASC;
