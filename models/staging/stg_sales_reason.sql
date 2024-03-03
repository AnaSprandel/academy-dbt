with
    sales_reason as (
        select
            salesreasonid as sales_reason_id
            , name as sales_reason
            , reasontype as reason_type
        from {{ ref('salesreason') }}  
    )
select *
from sales_reason