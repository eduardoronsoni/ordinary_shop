with source as (
    select * from {{ source('ordinary_shop', 'order_items') }}
),

renamed as (
    select
        order_item_id,
        order_id,
        product_id,
        quantity,
        unit_price,
        _etl_loaded_at
    from source
)

select * from renamed