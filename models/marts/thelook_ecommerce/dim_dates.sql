{{
    config(
        materialized='table'
    )
}}

with date_spine as (

    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="cast('2019-01-01' as date)",
        end_date="cast('2030-12-31' as date)"
    ) }}

),

final as (

    select
        cast(date_day as date) as date_id,
        extract(day from date_day) as day,
        extract(dayofweek from date_day) as day_of_week,
        format_date('%A', date_day) as day_name,
        extract(week from date_day) as week_of_year,
        extract(month from date_day) as month_number,
        format_date('%B', date_day) as month_name,
        extract(quarter from date_day) as quarter,
        extract(year from date_day) as year,

        -- Additional
        extract(dayofweek from date_day) not in (1, 7) as is_weekday,
        date_trunc(date_day, month) as first_date_of_month,
        last_day(date_day) as last_date_of_month,
        date_trunc(date_day, year) as first_day_of_year,
        last_day(date_day, year) as last_day_of_year
    from date_spine

)

select * from final
