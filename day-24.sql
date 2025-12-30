-- SQL Advent Calendar - Day 24
-- Title: New Year Goals - User Type Analysis
-- Difficulty: hard
--
-- Question:
-- As the New Year begins, the goals tracker team wants to understand how user types differ. How many completed goals does the average user have in each user_type?
--
-- As the New Year begins, the goals tracker team wants to understand how user types differ. How many completed goals does the average user have in each user_type?
--

-- Table Schema:
-- Table: user_goals
--   user_id: INT
--   user_type: VARCHAR
--   goal_id: INT
--   goal_status: VARCHAR
--

-- My Solution:

WITH countTotal AS (SELECT user_id, user_type, COUNT(CASE WHEN goal_status = 'Completed' THEN 1 END) AS total_goal
FROM user_goals
GROUP BY user_id, user_type)
SELECT user_type, ROUND(AVG(total_goal),2) as avg_goal
FROM countTotal
GROUP BY user_type
