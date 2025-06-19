with source_data as (
    select 
        product_id
        , name as product_name
        , category
        , cast(price as float64) as price
        , cast(created_at as timestamp) as created_at
        , cast(updated_at as timestamp) as updated_at
        , cast(loaded_at as timestamp) as loaded_at
    from {{ source('ordinary_shop', 'products') }}
)

, generate_sk as (
    select 
        {{ dbt_utils.generate_surrogate_key(['product_id']) }} as product_sk
        , *
    from source_data
)

select *
from generate_sk