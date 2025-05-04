DROP VIEW IF EXISTS gaps;
CREATE VIEW gaps AS

-- BEGIN SOLUTION
WITH lagged_data AS (
    SELECT 
        id,
        time,
        value,
        DATE_TRUNC('minute', time) AS rounded_time,
        LAG(DATE_TRUNC('minute', time)) OVER(PARTITION BY id ORDER BY time) AS lag_time,
        LAG(value) OVER(PARTITION BY id ORDER BY time) AS lag_value
    FROM data
)
SELECT
    id,
    DATE_TRUNC('minute', time) AS time,
    value,
    lag_time,
    lag_value,
    rounded_time - lag_time as time_diff 
FROM lagged_data
WHERE rounded_time - lag_time >= INTERVAL '30 minutes';
-- END SOLUTION

SELECT * FROM gaps ORDER BY id, time;
