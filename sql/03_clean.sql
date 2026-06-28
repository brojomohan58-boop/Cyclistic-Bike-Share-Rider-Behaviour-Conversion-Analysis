-- ================================================================
-- Project  : Cyclistic Bike-Share Rider Conversion Analysis
-- Script   : 03_clean.sql
-- Purpose  : Remove bad data and produce final clean dataset
-- Tool     : Google BigQuery
-- Input    : cyclistic_2025_transformed
-- Output   : cyclistic_2025_cleaned  (5,399,796 rows)
-- Filters  : bad durations, year outliers, NULL coords,
--            NULL rider type, duplicate ride IDs
-- Author   : [Your Name]
-- Date     : 2026
-- ================================================================

CREATE OR REPLACE TABLE
  `model-myth-487516-u3.cyclistic_analysis.cyclistic_2025_cleaned`
AS
SELECT *
FROM `model-myth-487516-u3.cyclistic_analysis.cyclistic_2025_transformed`
WHERE

  -- ── Remove bad ride durations ─────────────────────────────────
  -- < 1 min  = false starts, accidental undocks/redocks
  -- > 1440 min (24 hrs) = lost or stolen bikes
  ride_duration BETWEEN 1 AND 1440

  -- ── Keep only 2025 data (remove timestamp outliers) ──────────
  AND year = 2025

  -- ── Remove NULL GPS coordinates (required for map visuals) ────
  AND start_lat IS NOT NULL
  AND start_lng IS NOT NULL
  AND end_lat   IS NOT NULL
  AND end_lng   IS NOT NULL

  -- ── Remove rides with missing rider type ─────────────────────
  AND member_casual IS NOT NULL

  -- ── Remove duplicate ride_ids (keep first occurrence only) ────
  AND ride_id IN (
    SELECT ride_id
    FROM (
      SELECT
        ride_id,
        ROW_NUMBER() OVER (
          PARTITION BY ride_id ORDER BY started_at
        ) AS rn
      FROM `model-myth-487516-u3.cyclistic_analysis.cyclistic_2025_transformed`
    )
    WHERE rn = 1
  );

-- ================================================================
-- VALIDATION QUERIES — Run all three after cleaning
-- ================================================================

-- 1. Row count (expected: 5,399,796)
SELECT COUNT(*) AS total_rows
FROM `model-myth-487516-u3.cyclistic_analysis.cyclistic_2025_cleaned`;

-- 2. Duration range check (min=1, max=1439, avg≈14.41)
SELECT
  MIN(ride_duration)              AS min_dur,
  MAX(ride_duration)              AS max_dur,
  ROUND(AVG(ride_duration), 2)   AS avg_dur
FROM `model-myth-487516-u3.cyclistic_analysis.cyclistic_2025_cleaned`;

-- 3. NULL check — all should be 0
SELECT
  COUNTIF(member_casual   IS NULL) AS null_type,
  COUNTIF(ride_duration   IS NULL) AS null_dur,
  COUNTIF(start_lat       IS NULL) AS null_lat,
  COUNTIF(ride_id         IS NULL) AS null_ride_id
FROM `model-myth-487516-u3.cyclistic_analysis.cyclistic_2025_cleaned`;

-- ================================================================
-- ACTUAL VALIDATION RESULTS (from project run):
--
--   total_rows : 5,399,796
--   min_dur    : 1
--   max_dur    : 1,439
--   avg_dur    : 14.41
--   null_type  : 0
--   null_dur   : 0
--   null_lat   : 0
-- ================================================================
