with
    orders as (
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
            , order_qty
            , comment
        from {{ ref('int_sales_order') }}
    )

    , credit_card as (
        select
            credit_card_id
            , card_type
        from {{ ref('stg_credit_card') }}
    )

    , dim_customer as (
        select 
            customer_sk
            , customer_id
        from {{ ref('dim_customer') }}
    )

    , dim_dates as (
        select
            date_sk
            , date_day
        from {{ ref('dim_dates') }}
    )

    , final as (
        select
            dim_customer.customer_sk as customer_fk
            , dim_dates.date_sk as date_fk
            , orders.sales_order_id
            , credit_card.card_type
            , orders.revisionnumber
            , orders.order_date
            , orders.duedate
            , orders.shipdate
            , orders.status
            , orders.online_order_flag
            , orders.purchaseordernumber
            , orders.accountnumber
            , orders.customer_id
            , orders.sales_person_id
            , orders.territory_id
            , orders.bill_to_address_id
            , orders.ship_to_address_id
            , orders.ship_method_id
            , orders.credit_card_Id
            , orders.creditcardapprovalcode
            , orders.currencyrateid
            , orders.subtotal
            , orders.tax_amt
            , orders.freight
            , orders.total_due
            , orders.order_qty
            , orders.comment
        from orders
        left join dim_customer
            on dim_customer.customer_id = orders.customer_id
        left join credit_card
            on credit_card.credit_card_id = orders.credit_card_id
        left join dim_dates
            on dim_dates.date_day = cast(orders.shipdate as date)
    )

select *
from final
