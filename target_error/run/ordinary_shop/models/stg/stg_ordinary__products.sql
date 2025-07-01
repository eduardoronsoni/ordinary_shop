
  
    

    create or replace table `dbt-studies-462323`.`ordinary_shop_dbt`.`stg_ordinary__products`
      
    
    

    OPTIONS()
    as (
      with source_data as (
    select 
        product_id
        , name as product_name
        , category
        , cast(price as float64) as price
        , cast(created_at as timestamp) as created_at
        , cast(updated_at as timestamp) as updated_at
        , cast(loaded_at as timestamp) as loaded_at,
        test
    from `dbt-studies-462323`.`source_data`.`products`
)

, generate_sk as (
    select 
        to_hex(md5(cast(coalesce(cast(product_id as string), '_dbt_utils_surrogate_key_null_') as string))) as product_sk
        , *
    from source_data
)

select *
from generate_sk
    );
  