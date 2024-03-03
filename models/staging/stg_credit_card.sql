with
    credit_card as (
        select
            creditcardid as credit_card_id
            , cardtype as card_type
        from {{ ref('creditcard') }}            
    )
select *
from credit_card