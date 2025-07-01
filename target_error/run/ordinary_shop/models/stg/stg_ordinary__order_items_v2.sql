
  
    

    create or replace table `dbt-studies-462323`.`ordinary_shop_dbt`.`stg_ordinary__order_items_v2`
        
  (
    order_item_sk string not null,
    order_id string not null,
    product_id string not null,
    quantity int not null,
    unit_price float64 not null,
    updated_at TIMESTAMP not null,
    loaded_at TIMESTAMP not null,
    created_at date
    
    )

      
    
    

    OPTIONS()
    as (
      
    select order_item_sk, order_id, product_id, quantity, unit_price, updated_at, loaded_at, created_at
    from (
        with source_data as (
    select 
        order_id
        , product_id
        , cast(quantity as int) as quantity
        , cast(unit_price as float64) as unit_price
        , cast(created_at as date) as created_at
        , cast(updated_at as timestamp) as updated_at
        , cast(loaded_at as timestamp) as loaded_at
    from `dbt-studies-462323`.`source_data`.`order_items`
)

,  generate_sk as (
    select 
        to_hex(md5(cast(coalesce(cast(order_id as string), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(product_id as string), '_dbt_utils_surrogate_key_null_') as string))) as order_item_sk
        , *
    from source_data
)

select *
from generate_sk
    ) as model_subq
    );
  