-- models/int/int_customer_orders.sql -- Created on gemini just to test features

with customers as (
    select
        customer_sk,
        customer_id,
        customer_name, -- Corrigido de 'name'
        customer_email -- Corrigido de 'email'
        -- Adicione outras colunas de cliente que sejam relevantes
    from {{ ref('stg_ordinary__customers', v='1') }}
),

orders as (
    select
        order_sk,
        order_id,
        customer_id,
        order_date,
        order_status
        -- Adicione outras colunas de pedido que sejam relevantes
    from {{ ref('stg_ordinary__orders') }}
)

select
    -- Chaves Substitutas (SKs)
    o.order_sk,
    c.customer_sk,

    -- IDs Naturais
    o.order_id,
    c.customer_id,

    -- Detalhes do Pedido
    o.order_date,
    o.order_status,

    -- Detalhes do Cliente
    c.customer_name,    -- Corrigido
    c.customer_email    -- Corrigido
    -- Removi a coluna 'customer_full_name' já que 'customer_name' já está consolidado.
    -- Se 'customer_name' puder ser dividido, você pode reintroduzir algo como:
    -- split_part(c.customer_name, ' ', 1) as first_name,
    -- split_part(c.customer_name, ' ', -1) as last_name
    -- mas isso dependeria da sua sintaxe SQL (ex: BigQuery, Snowflake, PostgreSQL)

from orders o
left join customers c
    on o.customer_id = c.customer_id