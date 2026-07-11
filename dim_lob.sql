
{{ config(materialized = 'table') }}

with clean_lob as (

    select distinct 
        upper(trim(lob)) as lob
    from {{ ref('stg_operations') }}
    where lob is not null

)

select 
    {{ dbt_utils.generate_surrogate_key(['lob']) }} as lob_key,
    lob,

    case 
        when lob = 'MOTOR' then 'Motor Insurance'
        when lob = 'HEALTH' then 'Health Insurance'
        when lob = 'PL' then 'Professional Liability'
        when lob = 'PCL' then 'Public Company Limited'
        else 'Unknown'
    end as lob_desc,

    case 
        when lob = 'MOTOR' then 1
        when lob = 'HEALTH' then 2
        when lob = 'PL' then 3
        when lob = 'PCL' then 4
        else 0
    end as lob_rank

from clean_lob