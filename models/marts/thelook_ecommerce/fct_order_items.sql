{{
    config(
        materialized='incremental',
        unique_key='order_item_key',
        incremental_strategy='merge',
        partition_by={
            "field": "created_date",
            "data_type": "date",
            "granularity": "day"
        }
    )
}}

with order_items as (

    select * from {{ ref('stg_order_items') }}

    {% if is_incremental() %}
        where date(created_at) > (select max(created_date) from {{this}})
    {% endif %}
),

final as (

    select
        {{ dbt_utils.generate_surrogate_key(['order_item_id']) }} as order_item_key,
        order_item_id,
        order_id,
        user_id,
        product_id,
        inventory_item_id,
        status,
        sale_price,
        date(created_at) as created_date,
        date(shipped_at) as shipped_date,
        date(delivered_at) as delivered_date

    from order_items

)

select * from final
