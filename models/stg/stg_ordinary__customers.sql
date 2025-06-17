with source_data as (
    select 
        customer_id
        , name as customer_name
        , email as customer_email
        , cast(created_at as timestamp) as created_at
        , cast(updated_at as timestamp) as updated_at
        , cast(loaded_at as timestamp) as loaded_at
    from {{ source('ordinary_shop', 'customers') }}
)

select *
from source_data