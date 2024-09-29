/* generating dates using the macro from the dbt-utils package */
with 
    dates_raw as (
    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="cast('1990-01-01' as date)",
        end_date="date_add(current_date(), interval 100 year)"
        )
    }}
)

/* extracting some date information and renaming columns */
    , days_info as (
        select 
            cast(date_day as date) as date_day
            , extract(dayofweek from date_day) as week_day
            , extract(month from date_day) as month
            , extract(quarter from date_day) as quarter
            , extract(dayofyear from date_day) as day_of_the_year
            , extract(year from date_day) as year
            , format_date('%d-%m', date_day) as month_day
        from dates_raw
    )

/* renaming the column meanings */
    , days_named as (
        select
            *
            , case
                when week_day = 1 then 'Sunday'
                when week_day = 2 then 'Monday'
                when week_day = 3 then 'Tuesday'
                when week_day = 4 then 'Wednesday'
                when week_day = 5 then 'Thursday'
                when week_day = 6 then 'Friday'
                else 'Saturday' 
            end as day_name
            , case
                when month = 1 then 'January'
                when month = 2 then 'February'
                when month = 3 then 'March'
                when month = 4 then 'April'
                when month = 5 then 'May'
                when month = 6 then 'June'
                when month = 7 then 'July'
                when month = 8 then 'August'
                when month = 9 then 'September'
                when month = 10 then 'October'
                when month = 11 then 'November'
                else 'December' 
            end as month_name
            , case
                when month = 1 then 'Jan'
                when month = 2 then 'Feb'
                when month = 3 then 'Mar'
                when month = 4 then 'Apr'
                when month = 5 then 'May'
                when month = 6 then 'Jun'
                when month = 7 then 'Jul'
                when month = 8 then 'Aug'
                when month = 9 then 'Sep'
                when month = 10 then 'Oct'
                when month = 11 then 'Nov'
                else 'Dec' 
            end as month_abrv
            , case
                when quarter = 1 then '1º Quarter'
                when quarter = 2 then '2º Quarter'
                when quarter = 3 then '3º Quarter'
                else '4º Quarter' 
            end as quarter_name
            , case
                when quarter in(1,2) then 1
                else 2
            end as semester
            , case
                when quarter in(1,2) then '1º Semester'
                else '2º Semester'
            end as semester_name
        from days_info
    )

/* rearranging the columns */
    , final_cte as (
        select
            {{
                dbt_utils.generate_surrogate_key([
                    'date_day'
                    , 'month'
                    , 'year'
                ])
            }} as date_sk
            , date_day
            , week_day
            , day_name
            , month
            , month_name
            , month_abrv
            , quarter
            , quarter_name
            , semester
            , semester_name
            , day_of_the_year
            , year
        from days_named
    )

select * 
from final_cte