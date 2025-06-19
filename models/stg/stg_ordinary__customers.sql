/* This overwrites the materialization config passed on dbt_project */
{{ config(
    materialized='table' 
) }}

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

, generate_sk as (
    select 
        {{ dbt_utils.generate_surrogate_key(['customer_id']) }} as customer_sk
        , *
    from source_data
)

select *
from generate_sk