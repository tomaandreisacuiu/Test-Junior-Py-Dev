SELECT
    p.Locatie,
    p.First_Name,
    p.Last_Name,
    COUNT(v.ID) AS Number_of_votes,
    GROUP_CONCAT(v.quality, ', ') AS Qualities
FROM
    persons p
INNER JOIN
    Votes v ON p.ID = v.chosen_person AND v.valid = 1
GROUP BY
    Locatie,
    First_Name,
    Last_Name


