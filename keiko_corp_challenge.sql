/*
* First step
*/

CREATE VIEW suspected_rides AS
SELECT * FROM "public"."vehicle_location_histories" AS vlh
WHERE
    city = 'new york' AND
    long BETWEEN 40.5 and 40.6 AND
    lat BETWEEN -74.997 AND -74.9968 AND
    vlh.timestamp::date = '2020-06-23'::date
ORDER BY long;


/*
* Second step
*/

SELECT DISTINCT r.vehicle_id
FROM suspected_rides AS sr
JOIN rides AS r ON r.id = sr.ride_id