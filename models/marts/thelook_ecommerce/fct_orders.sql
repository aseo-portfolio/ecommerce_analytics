{{
    config(
        materialized='incremental',
        unique_key='order_key',
        incremental_strategy='merge',
        partition_by={
            "field": "created_date",
            "data_type": "date",
            "granularity": "day"
        }
    )
}}

with orders as (

    select * from {{ ref('int_orders_detail') }}

    {% if is_incremental() %}
        where date(created_at) > (select max(created_date) from {{this}})
    {% endif %}
),

final as (

    select
        {{ dbt_utils.generate_surrogate_key(['order_id']) }} as order_key,
        order_id,
        user_id,
        date(created_at) as created_date,
        status,

        -- Measures
        num_of_item,
        days_to_ship,
        days_to_deliver,
        order_revenue
    from orders

)

select * from final
