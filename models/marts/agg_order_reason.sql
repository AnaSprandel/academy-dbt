with
    fct_order as (
        select 
            sales_order_id
            , subtotal
            , tax_amt
            , freight
            , total_due
            , order_qty
        from {{ ref('fct_order') }}
    )

    , sales_order_sales_reason as (
        select 
            sales_order_id
            , sales_reason_id
        from {{ ref('stg_sales_order_sales_reason') }}
    )

    , sales_reason as (
        select 
            sales_reason_id
            , sales_reason
            , reason_type
        from {{ ref('stg_sales_reason') }}
    )

    , join_sales_reason as (
        select 
            sales_order_sales_reason.sales_order_id
            , sales_order_sales_reason.sales_reason_id
            , sales_reason.sales_reason
            , sales_reason.reason_type
        from sales_order_sales_reason
        left join sales_reason
            on sales_reason.sales_reason_id = sales_order_sales_reason.sales_reason_id
    )

    , join_sales_order as (
        select
            join_sales_reason.sales_reason
            , join_sales_reason.reason_type
            , count(distinct fct_order.sales_order_id) as number_of_orders
            , sum(fct_order.subtotal) as subtotal
            , sum(fct_order.tax_amt) as tax_amt
            , sum(fct_order.freight) as freight
            , sum(fct_order.total_due) as total_due
            , sum(fct_order.order_qty) as order_qty 
        from join_sales_reason    
        left join fct_order
            on fct_order.sales_order_id = join_sales_reason.sales_order_id
        group by all
    )

select *
from join_sales_order