
select *
from {{ ref('fct_cases') }}
where tat_bucket != case
    when tat_hours <= 24 then 'FAST'
    when tat_hours <= 72 then 'NORMAL'
    else 'DELAYED'
end