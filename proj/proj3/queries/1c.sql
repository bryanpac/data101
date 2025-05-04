-- BEGIN SOLUTION
WITH multi_match_names AS (
    SELECT building 
    FROM buildings_site_mapping
    GROUP BY building
    HAVING COUNT(*) > 1
)
SELECT 
    rem.building_name,
    JSON_AGG(bsm.*) AS json_agg
FROM multi_match_names mm
JOIN real_estate_metadata rem
    ON mm.building = rem.building_name
JOIN buildings_site_mapping bsm
    ON bsm.building = rem.building_name
GROUP BY rem.building_name
ORDER BY rem.building_name;
-- END SOLUTION
