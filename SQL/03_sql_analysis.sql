-- 1. Which app categories have the largest number of apps in the Google Play Store dataset?
select 
	Category, 
    count(*) as Total_Apps
from apps 
group by category 
order by Total_Apps desc;

-- 2. Which categories attract the most installs across all their apps?

select
	Category,
    sum(Installs) as Total_Installs
from apps
group by Category
order by Total_Installs desc
limit 10;

-- 3. Which categories have the highest average ratings among categories with at least 20 rated app records?

select 
	Category,
    round(avg(Rating),2) as Average_Rating,
    count(Category) as Rated_Apps
from apps
group by Category
having count(Rating) >= 20
order by Average_Rating desc;


-- 4. Are free apps more common than paid apps?
-- 5. Which group has the higher average rating?
-- 6. How do total installs differ between free and paid apps?

-- Compare free and paid app performance
select
    case
        when Price = 0 then 'Free'
        else 'Paid'
    end as App_Type,
    count(*) as Total_Apps,
    round(avg(Rating), 2) as Average_Rating,
    sum(Installs) as Total_Installs
from  apps
group by App_Type
order by Total_Apps desc;

-- 6. Which apps have the highest number of reviews, and how do their ratings and installs compare?

select
	App,
    Category,
    Reviews,
    Rating,
    Installs
from apps
order by Reviews desc
limit 10;

-- 7. Which apps have the highest install counts when we select only one record per app name?

with Ranked_Apps as (
	select 
		App,
		Category,
        Rating,
        Reviews,
        Installs,
        row_number() over(
			partition by App 
			order by Reviews desc
		)as Row_Num
	from apps
)
select 
	App,
	Category,
	Rating,
	Reviews,
	Installs
from Ranked_Apps
where Row_Num = 1
order by Installs desc, Reviews desc
limit 10;

-- 8. Do apps with higher ratings also tend to receive more reviews on average?

-- Classify apps by rating and compare review engagement
with Rating_Groups AS (
    select
        App,
        Rating,
        Reviews,
        case
            when Rating >= 4.5 then 'High Rating'
            when Rating >= 4.0 then 'Good Rating'
            else 'Below 4.0'
        end as Rating_Group
    from apps
    where Rating is not null
)
select
    Rating_Group,
    count(*) as Total_Apps,
    round(avg(Reviews), 0) as Average_Reviews
from rating_groups
group by Rating_Group
order by Average_Reviews desc;

-- 9. Which categories have the highest average app prices?

select
	Category,
    count(*) AS Paid_Apps,
    round(avg(Price),2) as Avg_Price
from apps
where Price > 0
group by Category
having Count(*) >= 10
order by Avg_Price desc;

-- 10.  Which categories have the highest percentage of highly rated apps?

select 
	Category,
    count(*) as Total_Rated_Apps,
    sum(
		case 
				when Rating >= 4.5 then 1
				else 0
			end) as Highly_Rated_Apps,
	round(100.0 * 
		sum(
			case
				when Rating >= 4.5 then 1
				else 0
			end
		) / count(*),
		2
	)as Highly_Rated_Percentage
from apps
where Rating is not null
group by Category
having count(*) >= 20
order by Highly_Rated_Apps desc;

-- 11. Which app categories have the highest average installs per app?

select 
	Category,
    Count(*) as Total_Apps,
    round(avg(Installs),0) AS Average_Installs
from apps
group by Category
having count(*) >= 20
order by Average_Installs desc
limit 10;

-- 12. How many apps were updated each year?
-- How is the number of app records distributed across their last-update years?

select 
	year(Last_Updated) as Update_Year,
    count(*) as T0tal_Apps
from apps
where Last_Updated is not null
group by year(Last_Updated)
order by Update_Year;


-- 13. Which categories have the highest average app size?

select
	Category,
    count(Size_MB) as Apps_WIth_Size,
    round(avg(Size_MB),2) AS Average_Size_MB
from apps
group by Category
having count(Size_MB) >= 20
order by Average_Size_MB desc
limit 10;

-- 14. Which categories have the highest total reviews?

select 
	Category,
    sum(Reviews) as Total_Reviews,
    count(*) as Total_Apps,
    round(avg(Reviews),0) as Average_Reviews
from apps
group by Category
order by Total_Reviews desc
limit 10;

-- 15. Which categories have the highest average installs relative to their review counts?

-- Compare installs with review activity by category
select
    Category,
    sum(Installs) as Total_Installs,
    sum(Reviews) as Total_Reviews,
    round(
        sum(Installs) / nullif(sum(Reviews), 0),
        2
    ) as Installs_Per_Review
from apps
group by Category
having sum(Reviews) > 0
order by Installs_Per_Review DESC
limit 10;

-- 16. Which apps have high ratings and substantial installs?

with app_performance as (
    select
        App,
        Category,
        Rating,
        Reviews,
        Installs,
        case
            when Installs >= 100000000 then 'Very High'
            when Installs >= 10000000 then 'High'
            else 'Moderate'
        end as Install_Level
    from apps
    where Rating >= 4.5
      and Installs >= 10000000
)
select
    App,
    Category,
    Rating,
    Reviews,
    Installs,
    Install_Level
FROM app_performance
order by Installs desc, Rating desc, Reviews desc
limit 20;
