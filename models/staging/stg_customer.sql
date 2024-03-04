    with
        customer_code as (
            select 
                customerid
                , personid + 1 as personid
            from {{ ref('customer') }}
            where customerid is not null 
            and personid is not null
        )

        , business_entity_code as(
            select
                businessentityid
                , personid
            from {{ ref('businessentitycontact') }}
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

        , join_customer_person as (
            select
                customer.businessentityid
                , customer_code.customerid
                , customer_code.personid
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
            left join customer_code
                on customer_code.personid = customer.businessentityid        
        )

    select *
    from join_customer_person
