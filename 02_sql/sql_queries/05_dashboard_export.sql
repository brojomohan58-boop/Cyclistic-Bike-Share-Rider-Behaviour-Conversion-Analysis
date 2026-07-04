-- ================================================================
-- Project  : Cyclistic Bike-Share Rider Conversion Analysis
-- Script   : 05_dashboard_export.sql
-- Purpose  : Build optimized final table for Tableau Desktop
-- Tool     : Google BigQuery
-- Input    : cyclistic_2025_cleaned
-- Output   : cyclistic_dashboard_final (~350 MB, Tableau-ready)
-- Note     : Removes large/unused columns. Joins pre-calculated
--            conversion scores per station.
-- Author   : [Your Name]
-- Date     : 2026
-- ================================================================

-- Columns removed to reduce file size for Tableau export:
--   ride_id        → never used in any chart
--   started_at     → already extracted into hour/day/month columns
--   ended_at       → already used to calculate ride_duration
--   end_station    → not used in dashboards
--   end_lat/lng    → already used to calculate distance_miles
--   year           → all data is 2025, redundant

CREATE OR REPLACE TABLE
  `model-myth-487516-u3.cyclistic_analysis.cyclistic_dashboard_final`
AS
SELECT
  -- Core dimensions
  member_casual,
  rideable_type,
  trip_type,

  -- Time dimensions
  hour_of_day,
  day_of_week,
  day_type,
  month_num,
  month_name,
  season,

  -- Geography (for Tableau map)
  c.start_station_name,
  start_lat,
  start_lng,

  -- Metrics
  ride_duration,
  distance_miles,
  duration_bucket,
  time_segment,

  -- Pre-calculated conversion scores (expensive JOIN — done once here)
  cs.casual_pct,
  cs.conversion_priority_score

FROM `model-myth-487516-u3.cyclistic_analysis.cyclistic_2025_cleaned` c

LEFT JOIN (
  -- Conversion Priority Score subquery
  -- Weights: 40% casual %, 40% normalized volume, 20% commute-hour share
  SELECT
    start_station_name,
    ROUND(COUNTIF(member_casual = 'casual') / COUNT(*) * 100, 2)
      AS casual_pct,
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
) cs
ON c.start_station_name = cs.start_station_name;

-- ================================================================
-- VERIFICATION
-- ================================================================

SELECT
  COUNT(*)                           AS total_rows,
  COUNT(DISTINCT member_casual)      AS rider_types,
  COUNT(DISTINCT season)             AS seasons,
  COUNT(DISTINCT start_station_name) AS stations,
  COUNT(DISTINCT day_of_week)        AS days
FROM `model-myth-487516-u3.cyclistic_analysis.cyclistic_dashboard_final`;

/*
RESULTS:
  total_rows : 5,399,796
  rider_types: 2
  seasons    : 4
  stations   : 1,865
  days       : 7
*/

-- ================================================================
-- EXPORT TO CSV:
-- BigQuery Console → Select table → Export → Download as CSV
-- or Export to Google Drive for large files
-- Upload the CSV to Tableau Desktop as the data source
-- ================================================================
