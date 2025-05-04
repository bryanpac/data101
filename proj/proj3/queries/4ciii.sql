DROP VIEW IF EXISTS likely_data;
CREATE VIEW likely_data AS
-- BEGIN SOLUTION
SELECT *,
    CASE
        WHEN value IS NOT NULL THEN value
        WHEN run_size = 1 THEN run_start
        ELSE 3.918905::DOUBLE PRECISION
    END AS interpolated
FROM backward;
-- END SOLUTION

SELECT * FROM likely_data WHERE run_size > 2 ORDER BY id, time LIMIT 100;
