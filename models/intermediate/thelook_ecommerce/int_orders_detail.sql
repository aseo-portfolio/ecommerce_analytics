with orders as (

    select
        order_id,
        user_id,
        date(created_at) as created_date,
        status,
        num_of_item,
        date_diff(date(shipped_at), date(created_at), day) as days_to_ship,
        date_diff(date(delivered_at), date(created_at), day) as days_to_deliver
    from {{ ref('stg_orders') }}
    where status in ('Complete','Returned')

),

order_items as (

    select
        order_id,
        round(sum(sale_price), 2) as order_revenue
    from {{ ref('stg_order_items') }}
    group by order_id

),

final as (

    select
        o.order_id,
        o.user_id,
        o.created_date,
        o.status,

        -- Measures
        o.num_of_item,
        o.days_to_ship,
        o.days_to_deliver,
        oi.order_revenue
    from orders o
    join order_items oi on o.order_id = oi.order_id

)

select *
from final
