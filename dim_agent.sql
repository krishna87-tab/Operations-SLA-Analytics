{{ config(materialized = 'table') }}

with source as (

    select distinct
        upper(trim(agent_level)) as agent_level

    from {{ ref('stg_operations') }}
    where agent_level is not null

)

select
    {{ dbt_utils.generate_surrogate_key(['agent_level']) }} as agent_key,
    agent_level,

    case 
        when agent_level = 'L1' then 'Entry Level'
        when agent_level = 'L2' then 'Intermediate'
        when agent_level = 'L3' then 'Senior'
        else 'Unknown'
    end as agent_level_desc,

    case 
        when agent_level = 'L1' then 1
        when agent_level = 'L2' then 2
        when agent_level = 'L3' then 3
        else 0
    end as agent_level_rank

from source