-- SQL Advent Calendar - Day 18
-- Title: 12 Days of Data - Progress Tracking
-- Difficulty: hard
--
-- Question:
-- Over the 12 days of her data challenge, Data Dawn tracked her daily quiz scores across different subjects. Can you find each subject's first and last recorded score to see how much she improved?
--
-- Over the 12 days of her data challenge, Data Dawn tracked her daily quiz scores across different subjects. Can you find each subject's first and last recorded score to see how much she improved?
--

-- Table Schema:
-- Table: daily_quiz_scores
--   subject: VARCHAR
--   quiz_date: DATE
--   score: INTEGER
--

-- My Solution:

WITH RankedScores AS (
    SELECT 
        subject, 
        score,
        ROW_NUMBER() OVER(PARTITION BY subject ORDER BY quiz_date ASC) as rank_first,
        ROW_NUMBER() OVER(PARTITION BY subject ORDER BY quiz_date DESC) as rank_last
    FROM daily_quiz_scores
)
SELECT 
    subject,
    MAX(CASE WHEN rank_first = 1 THEN score END) as first_score,
    MAX(CASE WHEN rank_last = 1 THEN score END) as last_score
FROM RankedScores
GROUP BY subject;
