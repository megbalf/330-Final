CREATE TABLE one_nf AS
SELECT
    id,
    REPLACE(REPLACE(REPLACE(REPLACE(genres, ']', ''), '[', ''), '"', ''), '''', '') AS cleaned_genres
FROM
    artists;


CREATE TABLE final_one AS
SELECT *, trim(value) AS value
FROM one_nf,
	json_each(' [" ' || replace(cleaned_genres, ',', ' ","') || ' "] ')
WHERE value <> ' ';
-- remove all extra [,] characters
UPDATE final_one
SET value = REPLACE(value, '[', '');
UPDATE final_one
SET value = REPLACE(value, ']', '');
UPDATE final_one
SET value = REPLACE(value, '''', '');


CREATE TABLE final_one_nf AS
SELECT id, value AS genre
FROM final_one;

DROP TABLE final_one;
DROP TABLE one_nf;
