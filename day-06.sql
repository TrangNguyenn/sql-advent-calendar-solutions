-- SQL Advent Calendar - Day 6
-- Title: Ski Resort Snowfall Rankings
-- Difficulty: hard
--
-- Question:
-- Buddy is planning a winter getaway and wants to rank ski resorts by annual snowfall. Can you help him bucket these ski resorts into quartiles?
--
-- Buddy is planning a winter getaway and wants to rank ski resorts by annual snowfall. Can you help him bucket these ski resorts into quartiles?
--

-- Table Schema:
-- Table: resort_monthly_snowfall
--   resort_id: INT
--   resort_name: VARCHAR
--   snow_month: INT
--   snowfall_inches: DECIMAL
--

-- My Solution:

WITH rankingSnow AS (SELECT resort_name, SUM(snowfall_inches) as total_snowfall,
       ROW_NUMBER() OVER (
       ORDER BY SUM(snowfall_inches) ASC
       ) AS ranking
FROM resort_monthly_snowfall
GROUP BY resort_name)
SELECT resort_name, ROUND(total_snowfall,2),
  CASE
  WHEN ranking <= 0.25*(SELECT COUNT(resort_name) FROM rankingSnow) THEN 'First Quartile'
  WHEN ranking <= 0.5*(SELECT COUNT(resort_name) FROM rankingSnow) THEN 'Second Quartile'
  WHEN ranking > 0.75*(SELECT COUNT(resort_name) FROM rankingSnow) THEN 'Fourth Quartile'
  ELSE 'Third Quartile'
  END AS quartile
FROM rankingSnow
