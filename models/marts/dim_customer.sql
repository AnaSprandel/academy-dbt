with
    customer_person as (
       select
            cast(businessentityid as string) || '-' || cast(personid as string) as customer_sk
            , businessentityid
            , customerid as customer_id
            , personid
            , persontype
            , namestyle
            , title
            , firstname
            , middlename
            , lastname
            , customer_full_name
            , city
            , province_name
            , country_name
        from {{ ref('int_customer') }}
    )

select *
from customer_person 
