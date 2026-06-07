SLA Operations/Finance Portfolio Project

## Project Overview

This project analyzes operational service level agreement performance using a modern analytics workflow with dbt for data transformation and Power BI for reporting.

The dashboard focuses on case volume, SLA achievement, turnaround time, process capability, customer satisfaction, and profitability. It is designed to help operations teams understand whether service targets are being met, where breaches are happening, and whether the process is capable of consistently meeting the SLA target.

## Business Problem

Operations teams often track whether cases are completed within SLA, but simple pass/fail reporting does not explain why performance changes or whether the process is stable.

This project answers questions such as:

a) Are we meeting the SLA target?
b) Which regions, lines of business, case types, or agent levels are driving SLA breaches?
c) How long do cases take to complete?
d) Is turnaround time stable enough to meet the SLA target consistently?
e) How do SLA performance, satisfaction, revenue, cost, and profit relate to each other? 

## Portfolio Highlights

This project demonstrates:

a) dbt staging, intermediate, mart, and snapshot modeling.
b) Dimensional modeling for operational analytics.
c) Incremental fact table design using `case_id`.
d) SLA and TAT performance analysis.
e) Process capability analysis using CPK.
f) Power BI dashboard design for executive and operational users.
g) DAX measures for SLA, year-over-year performance, dynamic labels, and conditional formatting.
h) Portfolio-ready documentation and project structure.


## Key Metrics

a) Total Cases :: Count of operational cases.
b) SLA Met % :: Percentage of cases completed within SLA.
c) SLA Breach % :: Percentage of cases that missed SLA.
d) Average TAT Hours :: Average turnaround time in hours.
e) TAT CPK :: Process capability index for turnaround time.
f) Revenue :: Total revenue generated.
g) Processing Cost :: Total operational processing cost.
h) Profit :: Revenue minus cost and claims impact.
i) Gross Margin :: Profitability ratio.
j) Customer Satisfaction :: Average satisfaction score.

## Tools Used

- dbt
- SQL
- Power BI
- DAX
- GitHub

## SLA And CPK Logic

The SLA target is 98%, with turnaround time expected to complete within 72 hours.

For process capability, the project uses `tat_hours` as the continuous measurable process:

## Specification

Lower Spec Limit is 0 hours.
Upper Spec Limit is 72 hours.
Process Metric = `tat_hours`

CPK is calculated as:

CPK = MIN(CPU, CPL)
CPU = (USL - Average TAT) / (3 * TAT Std Dev)
CPL = (Average TAT - LSL) / (3 * TAT Std Dev)

## Data Modeling Approach

The dbt project follows a layered modeling pattern:

a) Staging = Clean raw source data, standardize text fields, cast numeric fields.
b) Intermediate = Add business logic such as buckets, flags, and enrichment.
c) Marts = Build final fact and dimension tables for Power BI.
d) Snapshots = Track historical changes in case-level operational attributes.

## dbt models 
stg_operations
int_cases_enriched
fct_cases
dim_date
dim_lob
dim_region
dim_agent
dim_case_type
dim_sla
fct_cases_snapshot

## Snapshot Strategy

The project uses a dbt snapshot to preserve historical changes in case-level operational data.

Because the source data does not contain a reliable `updated_at` column, the snapshot uses the `check` strategy and tracks important business fields such as:

SLA status
Turnaround time
TAT bucket
Agent level
Profitability flag
Satisfaction bucket
Customer satisfaction
Revenue, cost, and profit fields

## Power BI Dashboard Pages

### 1. Executive Overview

a) KPI cards for Total Cases, SLA Met %, SLA Breach %, Average TAT, P90 TAT, and TAT CPK
b) Monthly trend of SLA Met %
c) Total Cases by month
d) SLA status breakdown
e) SLA target comparison: actual 79.60% vs target 98%

![image_alt](https://github.com/krishna87-tab/Operations-SLA-Analytics/blob/be247985262eef4f2fe712bc211b96e41401c08c/Executive%20Overview.png)

## Process Excellence Page

a) Implemented Lean Six Sigma metrics including DPMO, DPO, DPU, Sigma Level (ZST), and Process Capability (CPK) to measure operational quality.
b) Evaluated defect trends and process stability across multiple Lines of Business to identify improvement opportunities.
c) Monitored Rolled Throughput Yield (RTY) to assess end-to-end process efficiency and effectiveness.
d) Analyzed monthly variations in defect rates and process capability to support continuous improvement initiatives.
e) Delivered a data-driven process excellence framework that enables performance benchmarking against predefined quality targets.

![image_alt](https://github.com/krishna87-tab/Operations-SLA-Analytics/blob/8426971ea74694904898ea150d6f70fe711bf9ff/process%20exce.png)

## Financial Insights Page

a) Analyzed revenue, profit, gross margin, and case volume trends to provide a comprehensive view of financial performance across the organization.
b) Monitored Month-over-Month (MoM) growth patterns to identify peak-performing and underperforming periods throughout the year.
c) Compared profitability and revenue contribution across Lines of Business (LOBs) to highlight key revenue drivers.
d) Tracked year-over-year performance improvements using dynamic KPI indicators and variance analysis measures.
e) Enabled executives to evaluate financial health, profitability trends, and business segment performance through an interactive dashboard experience.

![image_alt](https://github.com/krishna87-tab/Operations-SLA-Analytics/blob/bfbfdb68e2d6034039185c8ec8f21dd7fc02008a/finance%20analysis.png)

## Operations Insights Page

a) Tracked SLA compliance performance by monitoring cases completed within and outside target service levels.
b) Measured Average Turnaround Time (TAT) and SLA breach volumes to identify operational bottlenecks and service risks.
c) Compared operational performance across Lines of Business using SLA achievement rates, claim volumes, and premium contribution metrics.
d) Analyzed monthly trends in service delivery performance to support workload planning and resource optimization.
e) Provided operational leaders with actionable insights into service quality, productivity, and customer commitment adherence.

![image_alt](https://github.com/krishna87-tab/Operations-SLA-Analytics/blob/0350c9565f341f9ae8c06f551eef0922b4c6634a/opernations%20analysis.png)










