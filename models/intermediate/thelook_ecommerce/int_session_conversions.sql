with purchased_events as (
    select
        session_id,
        user_id,
        traffic_source,
        browser,
        created_at,
        event_type
    from {{ ref('stg_events') }}

),

final as (

    select
        session_id,
        user_id,
        traffic_source,
        browser,
        min(created_at) as session_start,
        max(created_at) as session_end,
        count(*) as total_events,
        timestamp_diff(
            max(created_at), min(created_at), second
        ) as session_duration,
        countif(event_type = 'purchase') as purchase_events,
        max(if(event_type = 'purchase', 1, 0)) as has_purchased
    from purchased_events
    group by session_id, user_id, traffic_source, browser

    qualify row_number() over(
        partition by session_id
        order by min(created_at) asc
    ) = 1

)

select * from final
