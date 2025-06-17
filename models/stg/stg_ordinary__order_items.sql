with source_data as (
    select 
        order_id
        , product_id
        , cast(quantity as int) as quantity
        , cast(unit_price as float64) as unit_price
        , cast(created_at as timestamp) as created_at
        , cast(updated_at as timestamp) as updated_at
        , cast(loaded_at as timestamp) as loaded_at
    from {{ source('ordinary_shop', 'order_items')}}
)

select *
from source_data