-- ================================================================
-- Project  : Cyclistic Bike-Share Rider Conversion Analysis
-- Script   : 01_combine_months.sql
-- Purpose  : Combine 12 monthly CSV tables into a single raw table
-- Tool     : Google BigQuery
-- Dataset  : model-myth-487516-u3.cyclistic_analysis
-- Input    : cyclistic_2025_01 through cyclistic_2025_12
-- Output   : cyclistic_2025_raw  (5,549,796 rows)
-- Author   : [Your Name]
-- Date     : 2026
-- ================================================================

-- NOTE: Upload each monthly CSV to BigQuery as separate tables first.
-- File naming convention: cyclistic_2025_01, cyclistic_2025_02, etc.
-- All 12 tables must have identical schema before running this script.

CREATE OR REPLACE TABLE
  `model-myth-487516-u3.cyclistic_analysis.cyclistic_2025_raw`
AS

SELECT * FROM `model-myth-487516-u3.cyclistic_analysis.cyclistic_2025_01`
UNION ALL
SELECT * FROM `model-myth-487516-u3.cyclistic_analysis.cyclistic_2025_02`
UNION ALL
SELECT * FROM `model-myth-487516-u3.cyclistic_analysis.cyclistic_2025_03`
UNION ALL
SELECT * FROM `model-myth-487516-u3.cyclistic_analysis.cyclistic_2025_04`
UNION ALL
SELECT * FROM `model-myth-487516-u3.cyclistic_analysis.cyclistic_2025_05`
UNION ALL
SELECT * FROM `model-myth-487516-u3.cyclistic_analysis.cyclistic_2025_06`
UNION ALL
SELECT * FROM `model-myth-487516-u3.cyclistic_analysis.cyclistic_2025_07`
UNION ALL
SELECT * FROM `model-myth-487516-u3.cyclistic_analysis.cyclistic_2025_08`
UNION ALL
SELECT * FROM `model-myth-487516-u3.cyclistic_analysis.cyclistic_2025_09`
UNION ALL
SELECT * FROM `model-myth-487516-u3.cyclistic_analysis.cyclistic_2025_10`
UNION ALL
SELECT * FROM `model-myth-487516-u3.cyclistic_analysis.cyclistic_2025_11`
UNION ALL
SELECT * FROM `model-myth-487516-u3.cyclistic_analysis.cyclistic_2025_12`;

-- ================================================================
-- VERIFICATION: Run after creation to confirm row count
-- Expected: ~5,549,796 rows
-- ================================================================

SELECT
  COUNT(*)                          AS total_rows,
  COUNT(DISTINCT member_casual)     AS rider_types,
  MIN(started_at)                   AS earliest_ride,
  MAX(started_at)                   AS latest_ride
FROM `model-myth-487516-u3.cyclistic_analysis.cyclistic_2025_raw`;
