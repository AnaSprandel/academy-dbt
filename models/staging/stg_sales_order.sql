with
    sales_order as (
        select
            salesorderid as sales_order_id
            , revisionnumber
            , cast(cast(orderdate as timestamp) as date) as order_date
            , cast(cast(duedate as timestamp) as date) as duedate
            , cast(cast(shipdate as timestamp) as date) as shipdate
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
        from {{ ref('salesorderheader') }}
    )
select *
from sales_order