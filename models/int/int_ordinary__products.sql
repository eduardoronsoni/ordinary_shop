/*
Intermediate model for products.

This model builds on the staging data for products. Its purpose is to:
1. Clean and standardize the data (e.g., handle NULLs, trim whitespace, standardize casing).
2. Select and rename columns into a final, clean format for downstream use.
3. Exclude any raw source columns that are not needed for analytics.
*/

with stg_products as (
    -- It's a best practice to select from a staging model using the ref() function.
    -- I'm assuming your previous model file is named 'stg_products.sql'.
    select * from {{ ref('stg_ordinary__products') }}
),

cleaned_and_transformed as (
    select
        -- Keys
        product_sk,
        product_id,

        -- Product details:
        -- - Trim whitespace to remove leading/trailing spaces.
        -- - Coalesce NULL names to a standard 'Unknown' value.
        coalesce(trim(product_name), 'Unknown') as product_name,
        
        -- Category details:
        -- - Standardize to uppercase for consistency.
        -- - Coalesce NULL categories to 'N/A'.
        coalesce(upper(trim(category)), 'N/A') as category,

        -- Numeric fields:
        -- - Ensure price is never NULL, defaulting to 0.
        coalesce(price, 0) as price,

        -- Timestamps
        created_at,
        updated_at,
        loaded_at

        -- The 'test' column from the source is intentionally excluded
        -- as it is assumed to not be needed for downstream models.

    from stg_products
)

-- Final SELECT statement
select *
from cleaned_and_transformed
