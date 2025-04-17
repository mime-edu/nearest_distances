-- See README.md for usage instructions

-- How many nearest matches do you want to return (in descending order)
SET VARIABLE nearest_matches = 5;

DROP TABLE IF EXISTS matching_source;

CREATE TABLE matching_source AS
    SELECT * FROM read_csv_auto('matching_source.csv', HEADER = True);

-- Distance calculations
CREATE OR REPLACE VIEW match_output_v AS
WITH distances AS (
    SELECT
        s.*,
        p.id  as matched_id,
        sqrt(((s.easting - p.easting)^2) + (s.northing - p.northing)^2) AS distance_away
    FROM
        matching_source s
        INNER JOIN matching_source p
            ON s.id <> p.id
),
ordered_distances AS (
    -- Order these distances, by school
    SELECT
        p.id,
        p.matched_id,
        p.distance_away,
        row_number() OVER (PARTITION BY p.id ORDER BY distance_away) AS distance_order
    FROM
        distances p
)
SELECT
    d.*,
    m.distance_order
FROM
    distances d
    INNER JOIN ordered_distances m
        ON d.id = m.id
        AND d.matched_id = m.matched_id
        AND m.distance_order <= getvariable('nearest_matches')
ORDER BY
    d.id,
    m.distance_away
;

COPY (SELECT * FROM match_output_v) TO 'match_output_v.csv' (HEADER, DELIMITER ',');
