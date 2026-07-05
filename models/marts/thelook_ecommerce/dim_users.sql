{{
    config(
        materialized='table'
    )
}}

with users as (

    select * from {{ ref('stg_users') }}

),

final as (

    select
        {{ dbt_utils.generate_surrogate_key(['user_id']) }} as user_key,
        user_id,
        concat(first_name,' ',last_name) as user_name,
        email,
        age,
        gender,
        city,
        state,
        country,
        postal_code,
        traffic_source,
        date(created_at) as created_date

    from users

)

select * from final
