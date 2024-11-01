with
    business_entity_address as (
        select
            businessentityid
            , addressid
            , row_number() over(partition by businessentityid order by modifieddate) as dedup_address
        from {{ ref('businessentityaddress') }}
        qualify dedup_address = 1

    )

    , address as (
        select
            addressid
            , city
            , stateprovinceid
        from {{ ref('address') }}
        where addressid is not null
    )
    
    , state_province as (
        select 
            stateprovinceid
            , stateprovincecode
            , countryregioncode
            , name as province_name
            , territoryid
        from {{ ref('stateprovince') }}
    )
    
    , country_region as (
        select 
            countryregioncode
            , name as country_name
        from {{ ref('countryregion') }}
    )

    , join_city as (
        select 
            business_entity_address.businessentityid
            , address.stateprovinceid
            , address.city
        from business_entity_address
        left join address
            on business_entity_address.addressid = address.addressid
    )

    , join_state_province as (
        select
            join_city.businessentityid
            , state_province.countryregioncode
            , join_city.city
            , state_province.province_name
        from join_city
        left join state_province
            on join_city.stateprovinceid = state_province.stateprovinceid
    )

    , join_country as (
        select distinct
            join_state_province.businessentityid
            , join_state_province.city
            , join_state_province.province_name
            , country_region.country_name
        from join_state_province
        left join country_region
            on country_region.countryregioncode = join_state_province.countryregioncode
    )

select *
from join_country