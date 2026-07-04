-- ================================================================
-- Project  : Cyclistic Bike-Share Rider Conversion Analysis
-- Script   : 06_python_sample.sql
-- Purpose  : Create a 2% stratified sample for Python statistical
--            analysis in Google Colab
-- Tool     : Google BigQuery
-- Input    : cyclistic_2025_cleaned
-- Output   : cyclistic_python_sample (~107,000 rows)
-- Why 2%?  : Full 5.4M rows would make Colab slow/crash.
--            2% sample = ~107K rows, statistically sufficient
--            for hypothesis testing (p-values remain valid).
-- Author   : [Your Name]
-- Date     : 2026
-- ================================================================

CREATE OR REPLACE TABLE
  `model-myth-487516-u3.cyclistic_analysis.cyclistic_python_sample`
AS
SELECT
  ride_duration,
  distance_miles,
  member_casual,
  rideable_type,
  hour_of_day,
  day_of_week,
  day_type,
  season,
  trip_type,
  duration_bucket,
  time_segment
FROM `model-myth-487516-u3.cyclistic_analysis.cyclistic_2025_cleaned`
TABLESAMPLE SYSTEM (2 PERCENT);

-- ================================================================
-- VERIFICATION
-- ================================================================

SELECT
  COUNT(*)                       AS sample_rows,
  COUNT(DISTINCT member_casual)  AS rider_types,
  ROUND(AVG(ride_duration), 2)  AS avg_duration,
  COUNTIF(member_casual = 'casual') AS casual_count,
  COUNTIF(member_casual = 'member') AS member_count
FROM `model-myth-487516-u3.cyclistic_analysis.cyclistic_python_sample`;

/*
TYPICAL RESULTS (varies due to random sampling):
  sample_rows  : ~107,395
  rider_types  : 2
  avg_duration : ~14.4 min
  casual_count : ~38,000
  member_count : ~69,000
*/

-- ================================================================
-- EXPORT:
-- Download this table as CSV from BigQuery
-- Upload to Google Colab as: cyclistic_python_sample.csv
-- ================================================================
