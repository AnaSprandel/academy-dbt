with
    sales_order_detail as (
        select 
            salesorderid as sales_order_id
            , salesorderdetailid as sales_order_detail_id
            , carriertrackingnumber as carriertrackingnumber
            , orderqty as order_qty
            , productid as product_id
            , specialofferid as special_offer_id
            , unitprice as unit_price
            , unitpricediscount as unit_price_discount
            , rowguid
            , modifieddate
        from {{ ref('salesorderdetail') }}
    )
select *
from sales_order_detail