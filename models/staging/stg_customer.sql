with
    customer_code as (
        select 
            customerid
            , personid
        from {{ ref('customer') }}
    )

    , business_entity_code as(
        select
            businessentityid
            , personid
        from {{ ref('businessentitycontact') }}
    )

    , join_business_code as (
        select
            customer_code.customerid
            , customer_code.personid
            , business_entity_code.businessentityid
        from customer_code
        left join business_entity_code
            on business_entity_code.personid = customer_code.personid
    )

    , customer as (
        select
            businessentityid
            , persontype
            , namestyle
            , title
            , firstname
            , middlename
            , lastname
        from {{ ref('person') }}
    )

    , customer_person as (
        select
            customer.businessentityid
            , join_business_code.customerid
            , join_business_code.personid
            , customer.persontype
            , customer.namestyle
            , customer.title
            , customer.firstname
            , customer.middlename
            , customer.lastname
            , case
                when customer.middlename is null
                    then concat(customer.firstname, ' ', customer.lastname)
                else concat(customer.firstname, ' ', customer.middlename, ' ', customer.lastname)
            end as customer_full_name
        from customer
        left join join_business_code
            on join_business_code.businessentityid = customer.businessentityid
    )

select *
from customer_person