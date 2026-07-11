
select *
from {{ ref('fct_cases') }}
where satisfaction_bucket != case
    when customer_satisfaction >= 4 then 'HIGH'
    when customer_satisfaction >= 3 then 'MEDIUM'
    else 'LOW'
end