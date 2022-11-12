SELECT A.FirstName + ' ' + A.LastName AS 'Accountant Name', T.JobTypeName AS 'Job Type Name'
FROM Specialization AS S
INNER JOIN Accountant AS A
ON S.AccountantID = A.AccountantID
INNER JOIN JobType AS T
ON S.JobTypeID = T.JobTypeID
ORDER BY T.JobTypeName, 'Accountant Name';