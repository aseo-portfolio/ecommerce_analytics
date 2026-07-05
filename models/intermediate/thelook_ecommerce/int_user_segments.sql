{% set purchase_thresholds = [2,4] %}
{% set purchase_labels = ['one-time','repeat','loyal'] %}
{% set revenue_thresholds = [50, 200, 500] %}
{% set revenue_labels = ['low','medium','high','vip'] %}
{% set session_thresholds = [2, 6, 11] %}
{% set session_labels = ['inactive','occasional','active','power'] %}


with order_metrics as (
    select
        user_id,
        count(distinct order_id) as total_orders,
        max(cumulative_user_revenue) as total_revenue
    from {{ ref('int_user_order_history') }}
    group by user_id
),

user_sessions as (

    select
        user_id,
        count(distinct session_id) as total_sessions
    from {{ ref('stg_events') }}
    where user_id is not null
    group by user_id

),

final as (

    select
        om.user_id,

        -- User Segments
        {{ user_segments(
            'om.total_orders',
            purchase_thresholds,
            purchase_labels
        ) }}  as orders_segment,
        {{ user_segments(
            'om.total_revenue',
            revenue_thresholds,
            revenue_labels
        ) }}  as revenue_segment,
        {{ user_segments(
            'coalesce(us.total_sessions, 0)',
            session_thresholds,
            session_labels
        ) }}  as session_segment,

        -- Measures
        om.total_orders,
        om.total_revenue,
        coalesce(us.total_sessions, 0) as total_sessions
    from order_metrics om
    left join user_sessions us on om.user_id = us.user_id

)

select * from final
