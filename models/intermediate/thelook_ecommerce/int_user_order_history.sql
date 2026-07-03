with orders as (

    select
        order_id,
        user_id,
        created_date,
        order_revenue,
        status
    from {{ ref('int_orders_detail') }}
    where status != 'Cancelled'

),

final as (

    select
        order_id,
        user_id,
        created_date,
        row_number() over (partition by user_id order by created_date) as order_sequence,
        date_diff(date(created_date), date(lag(created_date) over (partition by user_id order by created_date)),day) as days_since_prev_order,
        order_revenue,
        sum(order_revenue) over (partition by user_id order by created_date rows between unbounded preceding and current row) as cumulative_user_revenue
    from orders

)

select * from final
