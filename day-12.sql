-- SQL Advent Calendar - Day 12
-- Title: North Pole Network Most Active Users
-- Difficulty: hard
--
-- Question:
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--

-- Table Schema:
-- Table: npn_users
--   user_id: INT
--   user_name: VARCHAR
--
-- Table: npn_messages
--   message_id: INT
--   sender_id: INT
--   sent_at: TIMESTAMP
--

-- My Solution:

WITH totalMessage AS (SELECT sent_at::DATE, sender_id, COUNT(message_id) AS total_message
FROM npn_messages
GROUP BY sent_at::DATE, sender_id
ORDER BY sent_at::DATE ASC, total_message DESC)
SELECT * FROM (SELECT *,
RANK() OVER (
  PARTITION BY sent_at
  ORDER BY total_message DESC
) as rowRanking
FROM totalMessage)
WHERE rowRanking = 1
