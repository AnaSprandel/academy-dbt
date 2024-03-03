with 
    dim_products as (
        select 
            product_id
            , product_name
            , product_number
            , makeflag
            , finished_goods_flag
            , product_color
            , safety_stock_level
            , standard_cost
            , list_price
        from {{ ref('stg_products') }}
    )
select *
from products