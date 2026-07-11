

{{ config(materialized = 'table') }}

with clean_region as (

    select distinct 
        upper(trim(region)) as region
    from {{ ref('stg_operations') }}
    where region is not null

)

select 
    {{ dbt_utils.generate_surrogate_key(['region']) }} as region_key,
    region,

    case 
        when region = 'EMEA' then 'EMEA'
        when region = 'APAC' then 'APAC'
        when region = 'NA' then 'NA'
        else 'OTHER'
    end as region_group,

    case 
        when region = 'EMEA' then 1
        when region = 'APAC' then 2
        when region = 'NA' then 3
        else 0
    end as region_rank,

    case 
        when region = 'EMEA' then 'Europe, Middle East & Africa'
        when region = 'APAC' then 'Asia Pacific'
        when region = 'NA' then 'North America'
        else 'Other'
    end as region_desc

from clean_region