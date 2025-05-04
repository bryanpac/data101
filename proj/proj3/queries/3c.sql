-- BEGIN SOLUTION
WITH class_unit_counts AS (
    SELECT class, COUNT(DISTINCT units) AS unit_count
    FROM metadata
    GROUP BY class
)

SELECT
  1 = ALL (SELECT unit_count FROM class_unit_counts) AS are_units_consistent; 
-- END SOLUTION
