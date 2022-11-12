-- Query 1 -- 
SELECT J.*
FROM Job_View AS J
LEFT JOIN Client AS C
ON J.ClientID = C.ClientID
WHERE C.ClientEmailAddress LIKE '%bmail.com'
ORDER BY DateStarted DESC;

-- Query 2 -- 

SELECT A.FirstName + ' ' + A.LastName AS 'Accountant Name', T.JobTypeName AS 'Job Type Name'
FROM Specialization AS S
INNER JOIN Accountant AS A
ON S.AccountantID = A.AccountantID
INNER JOIN JobType AS T
ON S.JobTypeID = T.JobTypeID
ORDER BY T.JobTypeName, 'Accountant Name';

-- Query 3 --

SELECT  A.FirstName + ' ' + A.LastName AS Accountant,  C.ClientFirstName + ' ' + C.ClientLastName AS Client, 
 T.JobTypeName AS JobType, DATEDIFF(Minute, J.StartTime, J.EndTime) AS Duration FROM AccountingFirm.dbo.job J 
 LEFT OUTER JOIN  AccountingFirm.dbo.Accountant A ON J.AccountantID = A.AccountantID 
 LEFT OUTER JOIN  AccountingFirm.dbo.Client C ON J.ClientID = C.ClientID
 LEFT OUTER JOIN  AccountingFirm.dbo.JobType T ON J.JobTypeID = T.JobTypeID
 WHERE T.JobTypeName LIKE '%Planning%' AND DATEDIFF(Minute, J.StartTime, J.EndTime) BETWEEN 30 AND 60 
 ORDER BY 4


 -- Query 4 -- 

 SELECT  A.FirstName + ' ' + A.LastName AS Accountant,  A.HireDate, P.PayLevelName, DATEDIFF(YEAR,A.HireDate, GETDATE()) AS Exp_Exp
 FROM AccountingFirm.dbo.Accountant A 
 LEFT OUTER JOIN  AccountingFirm.dbo.PayLevel P
 ON A.PayLevel = P.PayLevelID WHERE DATEDIFF(YEAR,A.HireDate, GETDATE()) < 8


 -- Query 5 --

 SELECT  A.FirstName + ' ' + A.LastName AS Accountant,  C.ClientFirstName + ' ' + C.ClientLastName AS Client, 
 DATEDIFF(Minute, J.StartTime, J.EndTime)*5 AS Cost FROM AccountingFirm.dbo.job J 
 LEFT OUTER JOIN  AccountingFirm.dbo.Accountant A ON J.AccountantID = A.AccountantID
 LEFT OUTER JOIN  AccountingFirm.dbo.Client C ON J.ClientID = C.ClientID
  WHERE C.TaxFileNo LIKE '555%'
