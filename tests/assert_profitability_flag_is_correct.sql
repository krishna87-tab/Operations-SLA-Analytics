
select *
from {{ ref('fct_cases') }}
where profitability_flag != case
    when claim_amount > premium_amount then 'LOSS'
    else 'PROFIT'
end