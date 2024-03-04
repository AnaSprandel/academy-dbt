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
            , productsubcategoryid as product_subcategory_id
        from {{ ref('product') }}
    )
    
    , product_subcategory as (
        select 
            productsubcategoryid as product_subcategory_id
            , productcategoryid as product_category_id
            , name as product_subcategory
        from {{ ref('productsubcategory') }}
    )

    , product_category as (
        select
            productcategoryid as product_category_id
            , name as product_category
        from {{ ref('productcategory') }}
    )

    , join_subcategory as (
        select 
            products.product_id
            , products.product_name
            , products.product_number
            , products.makeflag
            , products.finished_goods_flag
            , products.product_color
            , products.safety_stock_level
            , products.standard_cost
            , products.list_price
            , products.product_subcategory_id
            , product_subcategory.product_category_id
            , product_subcategory.product_subcategory
        from products
        left join product_subcategory
            on product_subcategory.product_subcategory_id = products.product_subcategory_id
    )

    , join_product_category as (
        select 
            join_subcategory.product_id
            , join_subcategory.product_name
            , join_subcategory.product_number
            , join_subcategory.makeflag
            , join_subcategory.finished_goods_flag
            , join_subcategory.product_color
            , join_subcategory.safety_stock_level
            , join_subcategory.standard_cost
            , join_subcategory.list_price
            , join_subcategory.product_subcategory
            , product_category.product_category
        from join_subcategory
        left join product_category
            on product_category.product_category_id = join_subcategory.product_category_id        
    )

select *
from join_product_category