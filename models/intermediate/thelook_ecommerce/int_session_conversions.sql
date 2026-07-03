with purchased_events as (
    select
        session_id,
        user_id,
        date(created_at) as created_date,
        event_type
    from {{ ref('stg_events') }}

),

final as (

    select
        session_id,
        user_id,
        created_date,
        if(event_type = 'purchase',1,0) as has_purchased
    from purchased_events

)

select * from final