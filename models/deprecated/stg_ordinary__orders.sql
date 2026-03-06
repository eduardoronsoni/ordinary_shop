with source_data as (
    select 
        order_id	
        , customer_id	
        , order_date	
        , status as order_status	
        , cast(created_at as timestamp) as created_at
        , cast(updated_at as timestamp) as updated_at
        , cast(loaded_at as timestamp) as loaded_at
    from {{ source('ordinary_shop','orders') }}
)

, generate_sk as (
    select 
        {{ dbt_utils.generate_surrogate_key(['order_id']) }} as order_sk
        , *
    from source_data
)

select *
from generate_sk