-- ================================================================
-- Project  : Cyclistic Bike-Share Rider Conversion Analysis
-- Script   : 02_transform.sql
-- Purpose  : Enrich raw data with 8 calculated columns for analysis
-- Tool     : Google BigQuery
-- Input    : cyclistic_2025_raw
-- Output   : cyclistic_2025_transformed
-- New cols : ride_duration, hour_of_day, month_num, month_name,
--            day_of_week, day_type, season, trip_type,
--            distance_miles, duration_bucket, time_segment
-- Author   : [Your Name]
-- Date     : 2026
-- ================================================================

CREATE OR REPLACE TABLE
  `model-myth-487516-u3.cyclistic_analysis.cyclistic_2025_transformed`
AS
SELECT

  -- ── Original columns ──────────────────────────────────────────
  ride_id,
  rideable_type,
  started_at,
  ended_at,
  start_station_name,
  end_station_name,
  start_lat,
  start_lng,
  end_lat,
  end_lng,
  member_casual,

  -- ── Time calculations ─────────────────────────────────────────
  TIMESTAMP_DIFF(ended_at, started_at, MINUTE)    AS ride_duration,
  EXTRACT(HOUR   FROM started_at)                 AS hour_of_day,
  EXTRACT(MONTH  FROM started_at)                 AS month_num,
  EXTRACT(YEAR   FROM started_at)                 AS year,
  FORMAT_TIMESTAMP('%A', started_at)              AS day_of_week,
  FORMAT_TIMESTAMP('%B', started_at)              AS month_name,

  -- ── Day type (Weekend vs Weekday) ─────────────────────────────
  CASE
    WHEN FORMAT_TIMESTAMP('%A', started_at)
         IN ('Saturday', 'Sunday') THEN 'Weekend'
    ELSE 'Weekday'
  END AS day_type,

  -- ── Season classification ─────────────────────────────────────
  CASE
    WHEN EXTRACT(MONTH FROM started_at) IN (12, 1, 2) THEN 'Winter'
    WHEN EXTRACT(MONTH FROM started_at) IN (3, 4, 5)  THEN 'Spring'
    WHEN EXTRACT(MONTH FROM started_at) IN (6, 7, 8)  THEN 'Summer'
    ELSE 'Autumn'
  END AS season,

  -- ── Trip type: Round Trip if start = end station ──────────────
  CASE
    WHEN start_station_name IS NOT NULL
     AND end_station_name   IS NOT NULL
     AND start_station_name = end_station_name
    THEN 'Round Trip'
    ELSE 'One Way'
  END AS trip_type,

  -- ── Geospatial distance in miles ──────────────────────────────
  -- Uses BigQuery ST_DISTANCE for straight-line distance
  ROUND(
    (ST_DISTANCE(
      ST_GEOGPOINT(start_lng, start_lat),
      ST_GEOGPOINT(end_lng,   end_lat)
    ) / 1000) * 0.621371, 3
  ) AS distance_miles,

  -- ── Ride duration bucket (for histogram grouping) ─────────────
  CASE
    WHEN TIMESTAMP_DIFF(ended_at, started_at, MINUTE) <= 10  THEN '0–10 min'
    WHEN TIMESTAMP_DIFF(ended_at, started_at, MINUTE) <= 20  THEN '11–20 min'
    WHEN TIMESTAMP_DIFF(ended_at, started_at, MINUTE) <= 40  THEN '21–40 min'
    ELSE '40+ min'
  END AS duration_bucket,

  -- ── Time of day segment (for campaign timing analysis) ────────
  CASE
    WHEN EXTRACT(HOUR FROM started_at) BETWEEN 6  AND 9  THEN 'Morning (6–9am)'
    WHEN EXTRACT(HOUR FROM started_at) BETWEEN 10 AND 14 THEN 'Midday (10am–2pm)'
    WHEN EXTRACT(HOUR FROM started_at) BETWEEN 15 AND 18 THEN 'Afternoon (3–6pm)'
    WHEN EXTRACT(HOUR FROM started_at) BETWEEN 19 AND 22 THEN 'Evening (7–10pm)'
    ELSE 'Night (11pm–5am)'
  END AS time_segment

FROM `model-myth-487516-u3.cyclistic_analysis.cyclistic_2025_raw`;

-- ================================================================
-- VERIFICATION: Preview first 5 rows to confirm new columns
-- ================================================================

SELECT
  ride_id,
  member_casual,
  ride_duration,
  day_of_week,
  day_type,
  month_name,
  season,
  trip_type,
  distance_miles,
  duration_bucket,
  time_segment
FROM `model-myth-487516-u3.cyclistic_analysis.cyclistic_2025_transformed`
LIMIT 5;
