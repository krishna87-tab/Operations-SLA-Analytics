

{{ config(materialized = 'table') }}

with clean_case_type as (

    select distinct
        upper(trim(case_type)) as case_type
    from {{ ref('stg_operations') }}
    where case_type is not null

)

select 
    {{ dbt_utils.generate_surrogate_key(['case_type']) }} as case_type_key,
    case_type,

    case 
        when case_type = 'SUBMISSION' then 'New Case'
        when case_type = 'REFERRAL' then 'Referred Case'
        when case_type = 'CLAIM' then 'Claim Case'
        else 'Unknown'
    end as case_type_flag,

    case 
        when case_type = 'SUBMISSION' then 1
        when case_type = 'REFERRAL' then 2
        when case_type = 'CLAIM' then 3
        else 0
    end as case_type_rank

from clean_case_type