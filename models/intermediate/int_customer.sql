with 
    customer as (
        select
            businessentityid
            , customerid
            , personid
            , persontype
            , namestyle
            , title
            , firstname
            , middlename
            , lastname
            , customer_full_name
        from {{ ref('stg_customer') }}
    )

    , territory as (
        select 
            businessentityid
            , city
            , province_name
            , country_name
        from {{ ref('stg_territory') }}
    )

    , join_customer_territory as (
        select
            customer.businessentityid
            , customer.customerid
            , customer.personid
            , customer.persontype
            , customer.namestyle
            , customer.title
            , customer.firstname
            , customer.middlename
            , customer.lastname
            , customer.customer_full_name
            , territory.city
            , territory.province_name
            , territory.country_name
        from customer
        left join territory
            on territory.businessentityid = customer.businessentityid
    )

select *
from join_customer_territory