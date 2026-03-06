with source as (
    select * from {{ source('ordinary_shop', 'products') }}
),

renamed as (
    select
        product_id,
        name as product_name,
        category,
        price,
        _etl_loaded_at
    from source
)

select * from renamed