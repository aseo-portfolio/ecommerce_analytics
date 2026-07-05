with purchased_events as (
    select
        session_id,
        user_id,
        created_at,
        event_type
    from {{ ref('stg_events') }}

),

final as (

    select
        session_id,
        max(user_id) as user_id,
        min(created_at) as session_start,
        max(created_at) as session_end,
        count(*) as total_events,
        timestamp_diff(
            max(created_at), min(created_at), second
        ) as session_duration,
        countif(event_type = 'purchase') as purchase_events,
        max(if(event_type = 'purchase', 1, 0)) as has_purchased
    from purchased_events
    group by session_id

)

select * from final
