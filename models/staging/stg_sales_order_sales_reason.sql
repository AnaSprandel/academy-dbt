with
    sales_order_reason as (
        select
            salesorderid as sales_order_id
            , salesreasonid as sales_reason_id
        from {{ ref('salesorderheadersalesreason') }}
    )
select *
from sales_order_reason
