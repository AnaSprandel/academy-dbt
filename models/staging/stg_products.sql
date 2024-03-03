with 
    products as (
        select 
            productid as product_id
            , name as product_name
            , productnumber as product_number
            , makeflag as makeflag
            , finishedgoodsflag as finished_goods_flag
            , color as product_color
            , safetystocklevel as safety_stock_level
            , standardcost as standard_cost
            , listprice as list_price
        from {{ ref('product') }}
    )
select *
from products