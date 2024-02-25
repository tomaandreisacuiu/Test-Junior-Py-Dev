SELECT
    p.Locatie,
    SUM(CASE 
        WHEN v.valid = 1 THEN 1 
        ELSE 0 
    END) AS Number_of_votes
FROM
    persons p
LEFT JOIN
    Votes v ON p.ID = v.chosen_person
GROUP BY
    p.Locatie
ORDER BY
    Number_of_Votes DESC,
    p.Locatie

