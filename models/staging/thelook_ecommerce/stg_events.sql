with source as (
    select * from {{ source('thelook_ecommerce','events') }}
),

renamed as (
    select
        id as event_id,
        user_id,
        session_id,
        sequence_number,
        event_type,
        traffic_source,
        browser,
        uri,
        city,
        state,
        created_at
    from source
)

select * from renamed
