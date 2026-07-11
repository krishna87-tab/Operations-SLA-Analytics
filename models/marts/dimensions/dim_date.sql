{{ config(materialized = 'table') }}

with dates as (

    select distinct date
    from {{ ref('stg_operations') }}

)

select
    {{ dbt_utils.generate_surrogate_key(['date']) }} as date_key,
    date,

    extract(year from date) as year,
    extract(month from date) as month,
    extract(quarter from date) as quarter,
    dayofweek(date) as day_of_week,
    dayname(date) as day_name

from dates