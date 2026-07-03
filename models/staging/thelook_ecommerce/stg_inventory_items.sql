with source as (
    select * from {{ source('thelook_ecommerce','inventory_items') }}
),

renamed as (
    select
        id as inventory_item_id,
        product_id,
        cost,
        created_at,
        sold_at,
        product_category,
        product_name,
        product_brand,
        product_retail_price,
        product_department
    from source
)

select * from renamed
