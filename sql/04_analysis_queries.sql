-- ================================================================
-- Project  : Cyclistic Bike-Share Rider Conversion Analysis
-- Script   : 04_analysis_queries.sql
-- Purpose  : 12 exploratory analysis queries answering the
--            business question: How do members and casual riders
--            use Cyclistic bikes differently?
-- Tool     : Google BigQuery
-- Input    : cyclistic_2025_cleaned
-- Author   : [Your Name]
-- Date     : 2026
-- ================================================================


-- ── QUERY 1: Rider Type Summary ────────────────────────────────
-- Understanding the volume and behavioral split between groups

SELECT
  member_casual,
  COUNT(*)                                                   AS total_rides,
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2)         AS pct_of_total,
  ROUND(AVG(ride_duration), 2)                              AS avg_duration_mins,
  APPROX_QUANTILES(ride_duration, 100)[OFFSET(50)]          AS median_duration_mins,
  ROUND(AVG(distance_miles), 2)                             AS avg_distance_miles
FROM `model-myth-487516-u3.cyclistic_analysis.cyclistic_2025_cleaned`
GROUP BY member_casual;

/*
RESULTS:
member_casual | total_rides | pct_of_total | avg_duration | median_duration | avg_distance
casual        | 1,915,649   | 35.48%       | 19.37        | 11              | 1.39
member        | 3,484,147   | 64.52%       | 11.68        | 8               | 1.41
*/


-- ── QUERY 2: Rides by Hour of Day ──────────────────────────────
-- Reveals commute peaks for members and leisure patterns for casual

SELECT
  member_casual,
  hour_of_day,
  COUNT(*) AS total_rides
FROM `model-myth-487516-u3.cyclistic_analysis.cyclistic_2025_cleaned`
GROUP BY member_casual, hour_of_day
ORDER BY hour_of_day;

/*
KEY INSIGHT:
  Members peak at 08:00 (252,029 rides) and 17:00 (375,145 rides) → commuter pattern
  Casual riders build gradually from midday, peak at 17:00 (183,257 rides) → leisure pattern
*/


-- ── QUERY 3: Rides by Day of Week ──────────────────────────────
-- Weekday vs weekend behavioral difference

SELECT
  member_casual,
  day_of_week,
  day_type,
  COUNT(*)                                                          AS total_rides,
  ROUND(AVG(ride_duration), 2)                                     AS avg_duration,
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(PARTITION BY member_casual), 2) AS pct_of_type
FROM `model-myth-487516-u3.cyclistic_analysis.cyclistic_2025_cleaned`
GROUP BY member_casual, day_of_week, day_type
ORDER BY CASE day_of_week
  WHEN 'Monday'    THEN 1 WHEN 'Tuesday'   THEN 2
  WHEN 'Wednesday' THEN 3 WHEN 'Thursday'  THEN 4
  WHEN 'Friday'    THEN 5 WHEN 'Saturday'  THEN 6
  WHEN 'Sunday'    THEN 7 END;

/*
KEY RESULTS:
  casual  Saturday  Weekend  395,551  21.81 min  20.65%
  casual  Sunday    Weekend  316,929  22.56 min  16.54%
  member  Thursday  Weekday  565,172  11.23 min  16.22%
  member  Tuesday   Weekday  552,511  11.34 min  15.86%
*/


-- ── QUERY 4: Monthly Seasonal Trends ───────────────────────────
-- Shows the 5-month winter conversion window for casual riders

SELECT
  member_casual,
  month_num,
  month_name,
  season,
  COUNT(*)                    AS total_rides,
  ROUND(AVG(ride_duration), 2) AS avg_duration
FROM `model-myth-487516-u3.cyclistic_analysis.cyclistic_2025_cleaned`
GROUP BY member_casual, month_num, month_name, season
ORDER BY month_num;

/*
KEY INSIGHT:
  Casual ridership peak:  August   → 323,523 rides
  Casual ridership trough: January  → 23,405 rides  (93.5% drop)
  Member ridership peak:  Sept     → 440,951 rides
  Member trough:          January  → 112,331 rides  (74.5% drop — far more resilient)
*/


-- ── QUERY 5: Weekday vs Weekend Summary ────────────────────────

SELECT
  member_casual,
  day_type,
  COUNT(*)                    AS total_rides,
  ROUND(AVG(ride_duration), 2) AS avg_duration,
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(PARTITION BY member_casual), 2) AS pct
FROM `model-myth-487516-u3.cyclistic_analysis.cyclistic_2025_cleaned`
GROUP BY member_casual, day_type;

/*
RESULTS:
  casual  Weekday  1,203,169  17.72 min  62.81%
  casual  Weekend    712,480  22.14 min  37.19%
  member  Weekday  2,669,747  11.32 min  76.63%
  member  Weekend    814,400  12.86 min  23.37%
*/


-- ── QUERY 6: Ride Duration Distribution ────────────────────────
-- Bucket analysis showing behavioural split

SELECT
  member_casual,
  duration_bucket,
  COUNT(*)                                                          AS total_rides,
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(PARTITION BY member_casual), 2) AS pct
FROM `model-myth-487516-u3.cyclistic_analysis.cyclistic_2025_cleaned`
GROUP BY member_casual, duration_bucket
ORDER BY member_casual,
  CASE duration_bucket
    WHEN '0–10 min'  THEN 1 WHEN '11–20 min' THEN 2
    WHEN '21–40 min' THEN 3 WHEN '40+ min'   THEN 4
  END;

/*
RESULTS:
  casual  0–10 min   888,075  46.36%
  casual  11–20 min  527,338  27.53%
  casual  21–40 min  318,904  16.65%
  casual  40+ min    181,332   9.47%

  member  0–10 min   2,153,686  61.81%
  member  11–20 min    886,217  25.44%
  member  21–40 min    372,233  10.68%
  member  40+ min       72,011   2.07%
*/


-- ── QUERY 7: Bike Type Analysis ────────────────────────────────

SELECT
  member_casual,
  rideable_type,
  COUNT(*)                     AS total_rides,
  ROUND(AVG(ride_duration), 2) AS avg_duration,
  ROUND(AVG(distance_miles), 2) AS avg_distance
FROM `model-myth-487516-u3.cyclistic_analysis.cyclistic_2025_cleaned`
GROUP BY member_casual, rideable_type
ORDER BY member_casual, rideable_type;

/*
RESULTS:
  casual  classic_bike   667,856   28.65 min  1.34 mi
  casual  electric_bike  1,247,793 14.40 min  1.42 mi
  member  classic_bike   1,274,408 13.11 min  1.22 mi
  member  electric_bike  2,209,739 10.85 min  1.52 mi

KEY INSIGHT: Casual classic bike rides (28.65 min) are 2.19× longer than member
classic bike rides (13.11 min) — largest behavioral gap across all categories.
*/


-- ── QUERY 8: Round Trip Analysis ───────────────────────────────
-- Proves leisure behavior: casual riders loop back to start station

SELECT
  member_casual,
  trip_type,
  COUNT(*)                    AS total_rides,
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(PARTITION BY member_casual), 2) AS pct,
  ROUND(AVG(ride_duration), 2) AS avg_duration
FROM `model-myth-487516-u3.cyclistic_analysis.cyclistic_2025_cleaned`
GROUP BY member_casual, trip_type;

/*
RESULTS:
  casual  One Way     1,808,936  94.43%  18.23 min
  casual  Round Trip    106,713   5.57%  38.70 min ← 3.74× longer than member round trips

  member  One Way     3,432,322  98.51%  11.50 min
  member  Round Trip     51,825   1.49%  23.38 min

KEY INSIGHT: Casual round trip rate (5.57%) is 3.74× higher than member rate (1.49%)
— strong indicator of leisure/tourist use vs purposeful commuting.
*/


-- ── QUERY 9: Campaign Timing Heatmap ───────────────────────────
-- Best windows to target casual riders with membership promotions

SELECT
  member_casual,
  day_of_week,
  time_segment,
  COUNT(*) AS total_rides
FROM `model-myth-487516-u3.cyclistic_analysis.cyclistic_2025_cleaned`
GROUP BY member_casual, day_of_week, time_segment
ORDER BY
  CASE day_of_week
    WHEN 'Monday'    THEN 1 WHEN 'Tuesday'   THEN 2
    WHEN 'Wednesday' THEN 3 WHEN 'Thursday'  THEN 4
    WHEN 'Friday'    THEN 5 WHEN 'Saturday'  THEN 6
    WHEN 'Sunday'    THEN 7 END,
  CASE time_segment
    WHEN 'Morning (6–9am)'    THEN 1
    WHEN 'Midday (10am–2pm)'  THEN 2
    WHEN 'Afternoon (3–6pm)'  THEN 3
    WHEN 'Evening (7–10pm)'   THEN 4
    WHEN 'Night (11pm–5am)'   THEN 5 END;

/*
TOP CASUAL CAMPAIGN WINDOWS:
  Saturday  Midday    (10am–2pm)  148,000 rides  ← HIGHEST
  Sunday    Midday    (10am–2pm)  123,000 rides
  Saturday  Afternoon (3–6pm)    120,000 rides
  Friday    Afternoon (3–6pm)    110,000 rides
*/


-- ── QUERY 10: Station Conversion Opportunity ───────────────────
-- Custom Conversion Priority Score for each station

SELECT
  start_station_name,
  ROUND(AVG(start_lat), 4)  AS avg_lat,
  ROUND(AVG(start_lng), 4)  AS avg_lng,
  COUNT(*)                   AS total_rides,
  COUNTIF(member_casual = 'casual') AS casual_rides,
  COUNTIF(member_casual = 'member') AS member_rides,
  ROUND(COUNTIF(member_casual = 'casual') / COUNT(*) * 100, 2) AS casual_pct,

  -- Conversion Priority Score (0–100)
  -- Weights: 40% casual %, 40% normalized volume, 20% commute-hour casual share
  ROUND(
    (COUNTIF(member_casual = 'casual') / COUNT(*) * 40)
    + (COUNT(*) / 40000.0 * 40)
    + (COUNTIF(
        member_casual = 'casual'
        AND time_segment IN ('Morning (6–9am)', 'Afternoon (3–6pm)')
        AND day_type = 'Weekday'
      ) / NULLIF(COUNTIF(member_casual = 'casual'), 0) * 20)
  , 1) AS conversion_priority_score

FROM `model-myth-487516-u3.cyclistic_analysis.cyclistic_2025_cleaned`
WHERE start_station_name IS NOT NULL
GROUP BY start_station_name
HAVING COUNT(*) > 500
ORDER BY conversion_priority_score DESC
LIMIT 10;

/*
TOP 10 CONVERSION TARGET STATIONS:
  DuSable Lake Shore Dr & Monroe St  38,883 rides  78.97% casual  Score: 75.1
  Navy Pier                           34,534 rides  78.00% casual  Score: 70.3
  Streeter Dr & Grand Ave             29,570 rides  78.74% casual  Score: 66.1
  Millennium Park                     26,988 rides  69.36% casual  Score: 59.4
  Shedd Aquarium                      20,098 rides  82.19% casual  Score: 57.3
  Dusable Harbor                      20,914 rides  73.50% casual  Score: 55.3
  Field Museum                        12,023 rides  81.59% casual  Score: 49.8
  Adler Planetarium                   13,586 rides  72.85% casual  Score: 47.7
  McCormick Place                      6,796 rides  72.94% casual  Score: 41.8
  Buckingham Fountain                 10,971 rides  67.73% casual  Score: 43.3
*/


-- ── QUERY 11: Season Analysis ──────────────────────────────────

SELECT
  member_casual,
  season,
  COUNT(*)                    AS total_rides,
  ROUND(AVG(ride_duration), 2) AS avg_duration,
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(PARTITION BY member_casual), 2) AS pct
FROM `model-myth-487516-u3.cyclistic_analysis.cyclistic_2025_cleaned`
GROUP BY member_casual, season
ORDER BY member_casual,
  CASE season
    WHEN 'Spring' THEN 1 WHEN 'Summer' THEN 2
    WHEN 'Autumn' THEN 3 WHEN 'Winter' THEN 4
  END;

/*
RESULTS:
  casual  Spring   363,764   19.00 min  18.99%
  casual  Summer   910,627   21.16 min  47.54%  ← Peak season
  casual  Autumn   563,776   17.74 min  29.43%
  casual  Winter    77,482   11.91 min   4.04%  ← Best conversion window (low competition)

  member  Spring   780,370   10.98 min  22.40%
  member  Summer  1,253,034  12.53 min  35.96%
  member  Autumn  1,106,951  11.71 min  31.77%
  member  Winter   343,792   10.01 min   9.87%  ← Members remain relatively active
*/


-- ── QUERY 12: Top 20 Routes ────────────────────────────────────
-- Reveals tourist circuits and commuter corridors

SELECT
  member_casual,
  start_station_name,
  end_station_name,
  trip_type,
  COUNT(*)                    AS route_count,
  ROUND(AVG(ride_duration), 2) AS avg_duration
FROM `model-myth-487516-u3.cyclistic_analysis.cyclistic_2025_cleaned`
WHERE start_station_name IS NOT NULL
  AND end_station_name   IS NOT NULL
GROUP BY member_casual, start_station_name, end_station_name, trip_type
ORDER BY route_count DESC
LIMIT 20;

/*
TOP CASUAL ROUTES (all Round Trips — tourist corridor):
  DuSable Lake Shore Dr → DuSable Lake Shore Dr  6,057 rides  34.04 min
  Navy Pier → Navy Pier                          5,085 rides  34.99 min
  Streeter Dr & Grand Ave → Streeter Dr...       3,872 rides  36.89 min
  Michigan Ave & Oak St → Michigan Ave...        3,833 rides  44.53 min

TOP MEMBER ROUTES (all short One Way — commuter corridor):
  Ellis Ave & 60th → Ellis Ave & 55th St    3,402 rides  4.98 min
  Ellis Ave & 55th → Ellis Ave & 60th St    3,297 rides  4.18 min
  University Ave & 57th → Ellis Ave & 60th  3,099 rides  3.72 min

KEY INSIGHT: Casual top routes = long leisure loops at tourist spots.
Member top routes = fast sub-5-minute commuter shuttles near University of Chicago.
*/
