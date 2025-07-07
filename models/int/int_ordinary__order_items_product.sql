-- models/int/int_orders_items_products.sql 
--created by gemini just to test features

{{ config(
    materialized='table' 
) }}

with order_items as (
    select
        order_item_sk,
        order_id,
        product_id,
        quantity,
        unit_price
    from {{ ref('stg_ordinary__order_items',v='1') }}
),

orders as (
    select
        order_sk,
        order_id,
        customer_id,
        order_date,
        order_status
    from {{ ref('stg_ordinary__orders') }}
),

products as (
    select
        product_sk,
        product_id,
        product_name,
        category,
        price as product_catalog_price -- Renomeando para clareza
    from {{ ref('stg_ordinary__products') }}
)

select
    -- Chaves Substitutas (SKs)
    oi.order_item_sk,
    o.order_sk,
    p.product_sk,

    -- IDs Naturais
    oi.order_id,
    o.customer_id,
    oi.product_id,

    -- Detalhes do Pedido
    o.order_date,
    o.order_status,

    -- Detalhes do Item do Pedido
    oi.quantity,
    oi.unit_price, -- Preço unitário no momento da compra (pode ser diferente do preço de catálogo)

    -- Detalhes do Produto
    p.product_name,
    p.category,
    p.product_catalog_price,

    -- Métricas Calculadas
    (oi.quantity * oi.unit_price) as total_item_revenue,
    (oi.quantity * p.product_catalog_price) as total_item_price_at_catalog_calc -- Para comparação, se o preço de catálogo for o de venda
    -- Adicione outras métricas ou colunas calculadas aqui
    -- Por exemplo: (oi.unit_price - p.product_catalog_price) as price_difference

from order_items oi
left join orders o
    on oi.order_id = o.order_id
left join products p
    on oi.product_id = p.product_id