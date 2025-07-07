with ab as 
(
    select * from {{ ref('int_ordinary__order_items_product') }}
),

bc as (
    select *
    from {{ ref('int_ordinary__customer_orders') }}
)

select * from ab