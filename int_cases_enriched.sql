{{ config(materialized = 'view') }}

with base as (

    select
        case_id,
        date,
        upper(trim(lob)) as lob,
        upper(trim(region)) as region,
        upper(trim(agent_level)) as agent_level,
        upper(trim(case_type)) as case_type,
        upper(trim(sla_status)) as sla_status,
        premium_amount,
        claim_amount,
        processing_cost,
        revenue,
        profit,
        tat_hours,
        customer_satisfaction

    from {{ ref('stg_operations') }}

),

enriched as (

    select
        *,

        (revenue - processing_cost) as gross_margin,

        case 
            when claim_amount > premium_amount then 'LOSS'
            else 'PROFIT'
        end as profitability_flag,

        case 
            when customer_satisfaction >= 4 then 'HIGH'
            when customer_satisfaction >= 3 then 'MEDIUM'
            else 'LOW'
        end as satisfaction_bucket,

        case 
            when tat_hours <= 24 then 'FAST'
            when tat_hours <= 72 then 'NORMAL'
            else 'DELAYED'
        end as tat_bucket

    from base

)

select * from enriched