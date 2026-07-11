{{ config(materialized = 'table') }}

with base as (

    select 
        f.*,
        ds.sla_flag
    from {{ ref('fct_cases') }} f

    left join {{ ref('dim_sla') }} ds
        on f.sla_key = ds.sla_key

)

select
    date_trunc('month', date) as month,

    -- Financial KPIs
    sum(revenue) as total_revenue,
    sum(profit) as total_profit,
    sum(claim_amount) / nullif(sum(premium_amount), 0) as loss_ratio,

    -- Operational KPIs
    avg(tat_hours) as avg_tat,
    sum(case when sla_flag = 0 then 1 else 0 end) * 1.0 / count(*) as sla_breach_pct,

    -- Customer KPIs
    avg(customer_satisfaction) as avg_customer_satisfaction

from base

group by 1