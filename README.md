# 🏨 Hotel Booking Cancellation Analysis

## Business Problem
The hotel industry faces a significant challenge with high cancellation rates, which leads to uncertain revenue forecasting and operational inefficiencies. 

**Objective:** This project analyzes a dataset of 119,000+ hotel bookings to identify key predictors of cancellations and quantify the financial impact ("Revenue at Risk") to propose data-driven strategies for mitigation.

## 🔍 Key Findings & Insights

### 1. The "Lead Time" Risk
* **Insight:** Booking lead time is directly correlated with cancellation risk.
* **Data:** Last-minute bookings (0-7 days) are the safest, with only a **9.6%** cancellation rate. In contrast, bookings made more than 6 months in advance have a **57% probability of being canceled**.
* **Strategy:** Implement stricter deposit policies for long-term bookings to secure commitment.

### 2. The $4.6 Million Leakage
* **Insight:** Cancellations are not just an operational nuance; they disproportionately affect high-value bookings.
* **Data:** The Average Daily Rate (ADR) for canceled bookings is **$104.97**, compared to **$99.99** for stayed bookings. This suggests price sensitivity plays a role in churn.
* **Impact:** The total value of canceled bookings analyzed amounts to approx. **$4.6 Million USD** in revenue at risk.

### 3. Operational Anomaly in "Groups"
* **Insight:** The 'Groups' market segment showed an unusually high cancellation rate.
* **Deep Dive:** A SQL drill-down revealed that 'Groups' with 'Non-Refundable' deposits have a **99.32% cancellation rate**.
* **Conclusion:** This indicates a data quality or process issue where tentative group blocks are likely recorded as 'Non-Refundable' before payment is confirmed, skewing the hotel's demand forecasting.

## 🛠️ Technical Skills Demonstrated
* **SQL (BigQuery):** * `CASE` statements to categorize continuous variables (Lead Time buckets).
    * `GROUP BY` and Aggregation functions (`COUNT`, `SUM`, `AVG`) for summary statistics.
    * Data cleaning and anomaly detection.
* **Business Intelligence:** Translating raw data metrics (ADR, Cancellation %) into actionable business recommendations.

## 📊 Recommendations
Based on the analysis, the following actions are recommended to the Revenue Management team:
1.  **Dynamic Cancellation Policy:** Remove "Free Cancellation" options for bookings made >90 days in advance.
2.  **Process Audit:** Review the sales protocol for the 'Groups' segment to prevent unpaid blocks from being categorized as 'Non-Refundable' in the PMS.
3.  **Value Retention:** Offer value-added incentives (e.g., free breakfast) instead of price discounts for high-ADR bookings to reduce the likelihood of cancellation due to price shopping.

---
*Author: [Tu Nombre]* *Tools: SQL, BigQuery*
