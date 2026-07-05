{% snapshot scd_users %}

{{
    config(
        target_schema='snapshots',
        unique_key='user_id',
        strategy='check',
        check_cols=[
            'country',
            'city',
            'state',
            'traffic_source',
            'email'
        ]
    )
}}

select * from {{ ref('stg_users') }}

{% endsnapshot %}