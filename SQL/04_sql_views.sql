use google_play_store;

-- 1. Category performance

create view vw_category_performance as
select
    Category,
    count(*) as Total_Apps,
    round(avg(Rating), 2) as Average_Rating,
    sum(Installs) as Total_Installs,
    sum(Reviews) as Total_Reviews,
    round(avg(Reviews), 0) as Average_Reviews,
    sum(case when Price = 0 then 1 else 0 end) as Free_Apps,
    sum(case when Price > 0 then 1 else 0 end) as Paid_Apps,
    round(avg(Size_MB), 2) as Average_Size_MB
from apps
group by Category;

select *
from vw_category_performance
order by Total_Installs desc;

-- 2. Free vs paid apps

create view vw_free_vs_paid as
select
    case
        when Price = 0 then 'Free'
        else 'Paid'
    end AS App_Type,
    count(*) as Total_Apps,
    round(avg(Rating), 2) as Average_Rating,
    sum(Installs) as Total_Installs,
    sum(Reviews) as Total_Reviews,
    round(avg(Price), 2) as Average_Price
from apps
group by App_Type;

select *
from vw_free_vs_paid;

-- 3. Rating distribution

create view vw_rating_distribution as
select
    case
        when Rating >= 4.5 then '4.5–5.0'
        when Rating >= 4.0 then '4.0–4.49'
        when Rating >= 3.0 then '3.0–3.99'
        when Rating >= 2.0 then '2.0–2.99'
        else '1.0–1.99'
    end as Rating_Group,
    count(*) as Total_Apps,
    round(avg(Installs), 0) as Average_Installs
from apps
where Rating is not null
group by Rating_Group;

select *
from vw_rating_distribution;

-- 4. App update trends

create view vw_app_update_trends as
select
    year(Last_Updated) as Update_Year,
    count(*) as Total_Apps_Updated
from apps
where Last_Updated is not null
group by year(Last_Updated);

select *
from vw_app_update_trends
order by Update_Year;

-- 5. Top-performing apps

create view vw_top_performing_apps as
select
    App,
    Category,
    Rating,
    Reviews,
    Installs,
    Price
from apps
where Rating >= 4.5
  and Installs >= 10000000;
  
select *
from vw_top_performing_apps
order by Installs desc, Rating desc, Reviews desc
limit 20;