with
    sales_order as (
        select
            sales_order_id
            , revisionnumber
            , order_date
            , duedate
            , shipdate
            , status
            , online_order_flag
            , purchaseordernumber
            , accountnumber
            , customer_id
            , sales_person_id
            , territory_id
            , bill_to_address_id
            , ship_to_address_id
            , ship_method_id
            , credit_card_Id
            , creditcardapprovalcode
            , currencyrateid
            , subtotal
            , tax_amt
            , freight
            , total_due
            , comment
            , modifieddate
        from {{ ref('stg_sales_order') }}
    )

    , order_qty as (
        select
            sales_order_id
            , sum(order_qty * unit_price) as subtotal
            , sum(order_qty) as order_qty
        from {{ ref('stg_sales_order_detail') }}
        group by 1
    )

    , join_tables as (
        select
            sales_order.sales_order_id
            , sales_order.revisionnumber
            , sales_order.order_date
            , sales_order.duedate
            , sales_order.shipdate
            , sales_order.status
            , sales_order.online_order_flag
            , sales_order.purchaseordernumber
            , sales_order.accountnumber
            , sales_order.customer_id
            , sales_order.sales_person_id
            , sales_order.territory_id
            , sales_order.bill_to_address_id
            , sales_order.ship_to_address_id
            , sales_order.ship_method_id
            , sales_order.credit_card_Id
            , sales_order.creditcardapprovalcode
            , sales_order.currencyrateid
            , order_qty.subtotal
            , sales_order.tax_amt
            , sales_order.freight
            , sales_order.total_due
            , order_qty.order_qty
            , sales_order.comment
            , sales_order.modifieddate
        from sales_order
        left join order_qty
            on order_qty.sales_order_id = sales_order.sales_order_id   
    )
    
select *
from join_tables