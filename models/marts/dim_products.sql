with 
    dim_products as (
        select
            cast(product_id as string) || '-' || cast(product_name as string) as product_sk
            , product_id
            , product_name
            , product_number
            , makeflag
            , finished_goods_flag
            , product_color
            , safety_stock_level
            , standard_cost
            , list_price
            , product_subcategory
            , product_category
        from {{ ref('stg_products') }}
    )
select *
from dim_products