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

,  generate_sk as (
    select 
        {{ dbt_utils.generate_surrogate_key(['order_id','product_id']) }} as order_item_sk
        , *
    from source_data
)

select *
from generate_sk
