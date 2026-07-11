{{ config(materialized = 'table') }}

select
    month,

    total_revenue,

    -- Rolling 3-month revenue
    avg(total_revenue) over (
        order by month
        rows between 2 preceding and current row
    ) as rolling_3m_revenue,

    -- Running total
    sum(total_revenue) over (
        order by month
        rows between unbounded preceding and current row
    ) as cumulative_revenue

from {{ ref('kpi_monthly_summary') }}