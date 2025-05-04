-- BEGIN STARTER CODE
-- 
-- END STARTER CODE

-- BEGIN SOLUTION 
WITH sensor_children AS (
     SELECT subject AS sensor_child
     FROM ontology
     WHERE predicate = 'http://www.w3.org/2000/01/rdf-schema#subClassOf'
        AND object = 'https://brickschema.org/schema/Brick#Sensor'
)
SELECT sc.sensor_child, COUNT(DISTINCT md.id) AS COUNT
FROM metadata AS md
INNER JOIN mapping AS map ON md.class = map.rawname
INNER JOIN transitive_subClassOf AS t ON t.subject = map.brickclass
INNER JOIN sensor_children AS sc ON sc.sensor_child = t.object
GROUP BY sc.sensor_child
ORDER BY sc.sensor_child;
-- END SOLUTION
