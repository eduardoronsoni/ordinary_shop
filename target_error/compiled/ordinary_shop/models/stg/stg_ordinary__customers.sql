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