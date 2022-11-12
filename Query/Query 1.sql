SELECT J.*
FROM Job_View AS J
LEFT JOIN Client AS C
ON J.ClientID = C.ClientID
WHERE C.ClientEmailAddress LIKE '%bmail.com'
ORDER BY DateStarted DESC;