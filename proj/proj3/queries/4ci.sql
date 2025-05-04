DROP VIEW IF EXISTS forward;
CREATE VIEW forward AS
-- BEGIN SOLUTION
SELECT *,
    SUM(CASE WHEN value IS NULL THEN 0 ELSE 1 END)
        OVER (PARTITION BY id ORDER BY time) AS run,
    coalesce_agg(value)
        OVER (PARTITION BY id ORDER BY time) AS run_start,
    CASE 
        WHEN value IS NULL THEN 
            LEAD(value) OVER (PARTITION BY id ORDER BY time)
        ELSE NULL
    END AS next_val
FROM complete;
-- END SOLUTION
SELECT * FROM forward WHERE next_val IS NOT NULL ORDER BY run LIMIT 100;