
  
    

    create or replace table `dbt-studies-462323`.`ordinary_shop_dbt`.`stg_ordinary__orders`
      
    
    

    OPTIONS()
    as (
      with source_data as (
    select 
        order_id	
        , customer_id	
        , order_date	
        , status as order_status	
        , cast(created_at as timestamp) as created_at
        , cast(updated_at as timestamp) as updated_at
        , cast(loaded_at as timestamp) as loaded_at
    from `dbt-studies-462323`.`source_data`.`orders`
)

, generate_sk as (
    select 
        to_hex(md5(cast(coalesce(cast(order_id as string), '_dbt_utils_surrogate_key_null_') as string))) as order_sk
        , *
    from source_data
)

select *
from generate_sk
    );
  