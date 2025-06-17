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

select *
from source_data