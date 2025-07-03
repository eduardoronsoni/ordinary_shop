
  
    

    create or replace table `dbt-studies-462323`.`ordinary_shop_dbt_prod`.`stg_ordinary__customers`
        
  (
    customer_sk string not null,
    customer_id string not null,
    customer_name string not null,
    customer_email string not null,
    created_at TIMESTAMP,
    updated_at TIMESTAMP not null,
    loaded_at TIMESTAMP not null
    
    )

      
    
    

    OPTIONS()
    as (
      
    select customer_sk, customer_id, customer_name, customer_email, created_at, updated_at, loaded_at
    from (
        /* This overwrites the materialization config passed on dbt_project */


with source_data as (
    select 
        customer_id
        , name as customer_name
        , email as customer_email
        , cast(created_at as timestamp) as created_at
        , cast(updated_at as timestamp) as updated_at
        , cast(loaded_at as timestamp) as loaded_at
    from `dbt-studies-462323`.`source_data`.`customers`
)

, generate_sk as (
    select 
        to_hex(md5(cast(coalesce(cast(customer_id as string), '_dbt_utils_surrogate_key_null_') as string))) as customer_sk
        , *
    from source_data
)

select *
from generate_sk
    ) as model_subq
    );
  