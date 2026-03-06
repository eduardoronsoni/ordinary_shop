with source as (
    select * from {{ source('ordinary_shop', 'orders') }}
),

renamed as (
    select
        order_id,
        customer_id,
        cast(order_date as date) as order_date,
        status,
        _etl_loaded_at
    from source
)

select * from renamed