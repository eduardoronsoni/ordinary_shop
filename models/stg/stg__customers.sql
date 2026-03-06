with source as (
    select * from {{ source('ordinary_shop', 'customers') }}
),

renamed as (
    select
        customer_id,
        first_name,
        last_name,
        email,
        _etl_loaded_at
    from source
)

select * from renamed