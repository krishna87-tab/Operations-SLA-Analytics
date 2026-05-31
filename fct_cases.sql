{{ config(
    materialized = 'incremental',
    unique_key = 'case_id'
) }}

with source as (

    select
        case_id,
        date,
        lob,
        region,
        agent_level,
        case_type,
        sla_status,
        tat_hours,
        premium_amount,
        claim_amount,
        processing_cost,
        revenue,
        profit,
        customer_satisfaction,
        gross_margin,
        profitability_flag,
        satisfaction_bucket,
        tat_bucket

    from {{ ref('int_cases_enriched') }}
),

dim_joined as (

    select
        s.case_id,
        s.date,
        dd.date_key,
        dl.lob_key,
        dr.region_key,
        da.agent_key,
        dct.case_type_key,
        ds.sla_key,

        -- measures
        s.premium_amount,
        s.claim_amount,
        s.processing_cost,
        s.revenue,
        s.profit,
        s.gross_margin,
        s.tat_hours,
        s.customer_satisfaction,

        -- flags
        s.profitability_flag,
        s.satisfaction_bucket,
        s.tat_bucket,

        1 as case_count

    from source s

    left join {{ ref('dim_date') }} dd
        on s.date = dd.date

    left join {{ ref('dim_lob') }} dl
        on s.lob = dl.lob

    left join {{ ref('dim_region') }} dr
        on s.region = dr.region

    left join {{ ref('dim_agent') }} da
        on s.agent_level = da.agent_level

    left join {{ ref('dim_case_type') }} dct
        on s.case_type = dct.case_type

    left join {{ ref('dim_sla') }} ds
        on s.sla_status = ds.sla_status

),

final as (
    select * from dim_joined
)

select * from final

{% if is_incremental() %}

where date > (select max(date) from {{ this }})

{% endif %}