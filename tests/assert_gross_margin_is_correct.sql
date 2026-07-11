
select *
from {{ ref('fct_cases') }}
where gross_margin != revenue - processing_cost