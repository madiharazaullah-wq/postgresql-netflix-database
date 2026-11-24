select * from netflix_titles;
-- Qno1:Count the total number of Movies and TV Shows available on Netflix?
select type,count(*) as Total from netflix_titles group by type;
-- Qno2:Find the most common rating for Netflix content?
select rating ,count(*) as Total from netflix_titles group by rating order by count(*) desc  limit 1 ;
-- Qno3:Display all Movies released in the year 2020?
select * from netflix_titles where release_year=2020 and type='Movie';
-- Qno4:List the top 5 countries with the highest number of Netflix titles?
SELECT 
    TRIM(UNNEST(STRING_TO_ARRAY(country, ','))) AS country_name,
    COUNT(*) AS total_titles
FROM netflix_titles
WHERE country IS NOT NULL
GROUP BY country_name
ORDER BY total_titles DESC
LIMIT 5;
-- Qno5:Find the oldest and the newest release year available on Netflix?
select MIN (release_year) as oldest_year ,Max(release_year) as  newest_year  from  netflix_titles;
-- Qno6:Find all content directed by Rajiv Chilaka?
select * from  netflix_titles where director='Rajiv Chilaka';
-- Qno:7Find all content where the director information is missing?
select * from  netflix_titles where  director  is null;
-- Qno8:Find the number of titles in each rating category, showing only ratings that have more than 100 titles?
select rating, count(title) from netflix_titles group by rating having count(title)>100 order by count(title) desc;
-- Qno9:Display all titles that belong to the Documentaries genre?
SELECT  title  FROM netflix_titles  where  listed_in like '%Documentaries%';
-- Qno:10 Find the average release year for Movies and TV Shows separately?
select type,avg(release_year) as avg from  netflix_titles group by type;
-- Qno:11 Display the title, release year, and extract the year, month, and day from the date_added column.
select title,release_year, extract(year from date_added::date) as extract_year,extract(month from date_added::date) as extract_month, extract(day from date_added::date) as extract_day
from netflix_titles;
-- Qno:12 Display the first 10 titles along with:
-- The first 5 characters of the title.
-- The last 5 characters of the title.
-- The total length of the title
select title,left(title,5) as First,right(title,5) as Last, length(title) as total_length from netflix_titles limit 10;
-- Qno:13 Categorize the content using a CASE statement:
-- Movies released before 2015 → Classic
-- Movies released in or after 2015 → Modern
-- TV Shows → Series
select *,
case 
when type='Movie' and  release_year<2015 then 'Classic'
when  type='Movie' and release_year>=2015 then 'Modern'
when  type='TV Show' then 'Series'
 ELSE 'Unknown'
end as Categrory
 from netflix_titles;
-- Qno:14 Categorize the ratings into Family, Teen, Adult, and Other, 
-- then count how many titles fall into each category?
SELECT 
    CASE 
        WHEN rating IN ('PG', 'TV-Y') THEN 'Family'
        WHEN rating IN ('PG-13', 'TV-14') THEN 'Teen'
        WHEN rating IN ('R', 'TV-MA', 'NC-17') THEN 'Adult'
        ELSE 'Other'
    END AS category,
    COUNT(*) AS total_titles
FROM netflix_titles
GROUP BY 
    CASE 
        WHEN rating IN ('PG', 'TV-Y') THEN 'Family'
        WHEN rating IN ('PG-13', 'TV-14') THEN 'Teen'
        WHEN rating IN ('R', 'TV-MA', 'NC-17') THEN 'Adult'
        ELSE 'Other'
    END;