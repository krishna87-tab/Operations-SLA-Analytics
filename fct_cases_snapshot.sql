
-- Snapshot tracks historical changes in case-level SLA, TAT, financial,


{% snapshot fct_cases_snapshot %}

{{
    config(
        target_schema = 'snapshots',
        unique_key = 'case_id',
        strategy = 'check',
        check_cols = [
            'date',
            'lob',
            'region',
            'agent_level',
            'case_type',
            'sla_status',
            'tat_hours',
            'premium_amount',
            'claim_amount',
            'processing_cost',
            'revenue',
            'profit',
            'customer_satisfaction',
            'gross_margin',
            'profitability_flag',
            'satisfaction_bucket',
            'tat_bucket'
        ]
    )
}}

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

{% endsnapshot %}