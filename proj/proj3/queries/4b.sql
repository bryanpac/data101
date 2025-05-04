DROP VIEW IF EXISTS complete;
CREATE VIEW complete AS

-- BEGIN SOLUTION
SELECT id, time, value
FROM data

UNION ALL

SELECT id, generate_series(
    lag_time + INTERVAL '15 minutes',
    time - INTERVAL '15 minutes',
    INTERVAL '15 minutes'
) AS time,
NULL:: FLOAT AS value 
FROM gaps;
-- END SOLUTION

SELECT * FROM complete ORDER BY id, time LIMIT 100;
