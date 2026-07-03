with source as (
    select * from {{ source('thelook_ecommerce','products') }}
),

renamed as (
    select
        id as product_id,
        name as product_name,
        brand,
        category,
        department,
        retail_price,
        cost,
        sku,
        distribution_center_id
    from source
)

select * from renamed
