-- BEGIN SOLUTION
SELECT
  r.building_name,
  r.address,
  r.location,
  u.loc_name as clean_location
FROM real_estate_metadata r
JOIN LATERAL (
    SELECT loc_name
    FROM uc_locations
    ORDER BY word_similarity(r.location, loc_name) DESC
    LIMIT 1
) u ON TRUE;
-- END SOLUTION