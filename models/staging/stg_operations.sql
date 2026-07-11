with source as (
    select *
    from {{ source('raw', 'fct_cases') }}
),

cleaned as (
    select 
        case_id,
        cast(date as date) as date,

        upper(trim(lob)) as lob,
    upper(trim(region)) as region,
    upper(trim(agent_level)) as agent_level,
    upper(trim(case_type)) as case_type,
    upper(trim(sla_status)) as sla_status,

        cast(premium_amount as number) as premium_amount,
        cast(claim_amount as number) as claim_amount,
        cast(processing_cost as number) as processing_cost,
        cast(revenue as number) as revenue,
        cast(profit as number) as profit,
        cast(tat_hours as number) as tat_hours,
        cast(customer_satisfaction as number) as customer_satisfaction

    from source
)
select * from cleaned