with
    sales_order as (
        select
            salesorderid as sales_order_id
            , revisionnumber
            , orderdate
            , duedate
            , shipdate
            , status
            , onlineorderflag as online_order_flag
            , purchaseordernumber
            , accountnumber
            , customerid as customer_id
            , salespersonid as sales_person_id
            , territoryid as territory_id
            , billtoaddressid as bill_to_address_id
            , shiptoaddressid as ship_to_address_id
            , shipmethodid as ship_method_id
            , creditcardid as credit_card_Id
            , creditcardapprovalcode
            , currencyrateid
            , subtotal as subtotal
            , taxamt as tax_amt
            , freight
            , totaldue as total_due
            , comment
            , modifieddate
        from {{ ref('stg_sales_order') }}
    )
    , order_qty as (
        select
            sales_order_id
            , order_qty
        from {{ ref('stg_sales_order_detail') }}
    )
    , join_tables as (
        select
            sales_ordersales_order_id
            , sales_order.revisionnumber
            , sales_order.orderdate
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
            , sales_order.subtotal
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
from sales_order