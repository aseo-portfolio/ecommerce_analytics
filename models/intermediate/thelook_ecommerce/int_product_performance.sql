with products as (

    select * from {{ ref('stg_products') }}

),

order_items as (

    select * from {{ ref('stg_order_items') }}

),

final as (

    select
        p.product_id,
        
        -- Measures
        countif(oi.status = 'Returned') as items_returned,
        count(oi.order_item_id) as items_sold,
        round(safe_divide(countif(oi.status = 'Returned'),count(oi.order_item_id)),2) as return_rate_pct,
        round(sum(sale_price) - sum(p.cost), 2) as gross_profit,
        round(sum(sale_price), 2) as total_revenue
    from products p
    join order_items oi on p.product_id = oi.product_id
    group by p.product_id

)

select * from final