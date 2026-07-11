

{{config(materialized= 'table')}}

with clean_sla as

(

    select distinct upper(trim(sla_status)) as sla_status

    from 
    {{ref('stg_operations')}}
 )

 select 
 sla_status,
 {{dbt_utils.generate_surrogate_key(['sla_status'])}} as sla_key,

 case 
 when sla_status in ('WITHIN SLA', 'MET') then 'Within SLA'
 when sla_status in ('Breached', 'FAIL') then 'Breached'
 end as case_status,

  case 
    when sla_status in ('WITHIN SLA', 'MET') then 1
    when sla_status in ('BREACHED', 'FAIL') then 0
    else null
end as sla_flag

 from
 clean_sla