DROP VIEW IF EXISTS labeled_data;
CREATE VIEW labeled_data AS

-- BEGIN SOLUTION
WITH median AS (
    SELECT
      id,
      PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY value) AS median
    FROM data
    GROUP BY id
),
abs_dev AS (
    SELECT
      d.*,
      m.median,
      ABS(d.value - m.median) AS abs_diff
    FROM data d
    JOIN median m ON d.id = m.id
),
mad_table AS (
    SELECT 
      id,
      median,
      PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY abs_diff) AS mad
    FROM abs_dev
    GROUP BY id, median
)

SELECT 
  d.time,
  d.id,
  d.value,
  m.median,
  m.mad,
  CASE 
    WHEN m.mad = 0 THEN FALSE
    WHEN ABS(d.value - m.median) > (3 * 1.4826 * m.mad) THEN TRUE
    ELSE FALSE
  END AS is_outlier
FROM data d
JOIN mad_table m ON d.id = m.id
ORDER BY d.time, d.id;

-- END SOLUTION

(SELECT * FROM labeled_data WHERE is_outlier ORDER BY time, id LIMIT 50)
UNION ALL
(SELECT * FROM labeled_data WHERE NOT is_outlier ORDER BY time, id LIMIT 50);