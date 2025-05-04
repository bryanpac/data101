-- BEGIN SOLUTION
WITH multi_match_buildings AS(
    SELECT building_name
    FROM real_estate_metadata
    GROUP BY building_name
    HAVING COUNT (*) > 1
)
SELECT 
    bsm.building,
    JSON_AGG(rem.*) AS json_agg
FROM multi_match_buildings mm
JOIN real_estate_metadata rem
    ON mm.building_name = rem.building_name
JOIN buildings_site_mapping bsm
    ON bsm.building = rem.building_name
GROUP BY bsm.building
ORDER BY bsm.building;
-- END SOLUTION
