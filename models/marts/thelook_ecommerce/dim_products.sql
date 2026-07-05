{{
    config(
        materialized='table'
    )
}}

with products as (

    select * from {{ ref('stg_products') }}

),

product_perf as (

    select * from {{ ref('int_product_performance') }}

),

final as (

    select
        {{ dbt_utils.generate_surrogate_key(['p.product_id']) }} as product_key,
        p.product_id,
        p.product_name,
        p.brand,
        p.category,
        p.department,
        p.retail_price,
        p.cost,
        p.sku,
        p.distribution_center_id,

        -- Measures
        pp.items_returned,
        pp.return_rate_pct,
        pp.items_sold,
        pp.gross_profit,
        pp.total_revenue
    from products p
    join product_perf pp on p.product_id = pp.product_id

)

select * from final
