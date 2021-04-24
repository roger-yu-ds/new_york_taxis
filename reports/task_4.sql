-- MDSI BDE AT1 Task 4 SQL Queries
-- a.i. What was the total number of trips?
SELECT 
  pickup_year
, pickup_month
, COUNT(*) AS n_trips
FROM df
GROUP BY 1, 2
ORDER BY 1, 2
-- a.ii. Which weekday had the most trips?
SELECT 
  pickup_year
, pickup_month
, FIRST(pickup_dayofweek) AS pickup_dayofweek
, MAX(n_trips)

FROM (
    SELECT 
      pickup_year
    , pickup_month
    , pickup_dayofweek
    , COUNT(*) AS n_trips
    FROM df
    GROUP BY 1, 2, 3
    ORDER BY 1, 2, 4 DESC
    ) temp

GROUP BY 1, 2
ORDER BY 1, 2
-- a.iii. Which hour of the day had the most trips?
SELECT 
  pickup_year
, pickup_month
, FIRST(pickup_hourofday) AS pickup_hourofday
, MAX(n_trips)

FROM (
    SELECT 
      pickup_year
    , pickup_month
    , pickup_hourofday
    , COUNT(*) AS n_trips
    FROM df
    GROUP BY 1, 2, 3
    ORDER BY 1, 2, 4 DESC
    ) temp

GROUP BY 1, 2
ORDER BY 1, 2
-- a.iv. What was the average number of passengers?
SELECT 
  pickup_year
, pickup_month
, AVG(Passenger_count) AS mean_Passenger_count
FROM df
GROUP BY 1, 2
ORDER BY 1, 2
-- a.iv. What was the average number of passengers?
SELECT 
  pickup_year
, pickup_month
, AVG(Total_amount) AS mean_Total_amount
FROM df
GROUP BY 1, 2
ORDER BY 1, 2
-- a.vi. What was the average amount paid per passenger (total_amount)?
SELECT 
  pickup_year
, pickup_month
, SUM(Passenger_count) / SUM(Total_amount) AS average_amount_per_passenger
FROM df
GROUP BY 1, 2
ORDER BY 1, 2
-- b.i. What was the average, median, minimum and maximum trip duration in seconds?
SELECT 
  colour
, AVG(trip_duration) AS average_trip_duration
, PERCENTILE(trip_duration, 0.5) AS median_trip_duration
, MIN(trip_duration) AS mininum_trip_duration
, MAX(trip_duration) AS maximum_trip_duration
FROM df
GROUP BY 1
-- b.ii. What was the average, median, minimum and maximum trip distance in km?
SELECT 
  colour
, AVG(trip_distance_km) AS average_trip_distance_km
, PERCENTILE(trip_distance_km, 0.5) AS median_trip_distance_km
, MIN(trip_distance_km) AS mininum_trip_distance_km
, MAX(trip_distance_km) AS maximum_trip_distance_km
FROM df
GROUP BY 1
-- b.iii. What was the average, median, minimum and maximum speed in km per hour?
SELECT 
  colour
, AVG(speed) AS average_speed
, PERCENTILE(speed, 0.5) AS median_speed
, MIN(speed) AS mininum_speed
, MAX(speed) AS maximum_speed
FROM df
GROUP BY 1
-- c. What was the percentage of trips where the driver received tips?
SELECT 
  colour
, AVG(tip_ind) AS perc_received_tips
FROM (
    SELECT 
      colour
    , CASE WHEN tip_amount > 0 THEN 1 ELSE 0 END AS tip_ind
    FROM df
    ) temp
GROUP BY 1
-- d. For trips where the driver received tips, what was the percentage where the driver received tips of at least $10.

SELECT 
  CASE WHEN tip_amount >= 10 THEN 1 ELSE 0 END AS gt_10_ind
, COUNT(*) AS n_trips
, FORMAT_STRING('%.6e', COUNT(*) / SUM(COUNT(*)) OVER ()) AS perc_trips

FROM df
GROUP BY 1
-- e. Classify each trip into bins of durations
SELECT 
  CASE
    WHEN trip_duration < 5 * 60 THEN 'lt_5'
    WHEN trip_duration >= 5 * 60 AND trip_duration < 10 * 60 THEN 'bt_5_10'
    WHEN trip_duration >= 10 * 60 AND trip_duration < 20 * 60 THEN 'bt_10_20'
    WHEN trip_duration >= 20 * 60 AND trip_duration < 30 * 60 THEN 'bt_20_30'
    WHEN trip_duration >= 30 * 60 THEN 'gt_30'
  END as duration_group
, AVG(speed) AS avg_speed
, SUM(trip_distance_km) / SUM(Total_amount) AS km_dollar
FROM df
GROUP BY 1
ORDER BY 3
