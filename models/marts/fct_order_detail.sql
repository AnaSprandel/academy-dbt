with
    order_detail as (
        select 
            sales_order_id
            , sales_order_detail_id
            , carriertrackingnumber
            , order_qty
            , product_id
            , special_offer_id
            , unit_price
            , unit_price_discount
            , order_date
        from {{ ref('stg_sales_order_detail') }}
    )

    , dim_products as (
        select 
            product_sk
            , product_id
        from {{ ref('dim_products') }}
    )

    , final as (
        select
            dim_products.product_sk as product_fk 
            , order_detail.sales_order_id
            , order_detail.sales_order_detail_id
            , order_detail.carriertrackingnumber
            , order_detail.order_qty
            , order_detail.product_id
            , order_detail.special_offer_id
            , order_detail.unit_price
            , order_detail.unit_price_discount
            , order_detail.order_date
        from order_detail
        left join dim_products
            on dim_products.product_id = order_detail.product_id     
    )

select *
from order_detail