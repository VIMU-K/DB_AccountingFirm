SELECT  A.FirstName + ' ' + A.LastName AS Accountant,  C.ClientFirstName + ' ' + C.ClientLastName AS Client, 
 T.JobTypeName AS JobType, DATEDIFF(Minute, J.StartTime, J.EndTime) AS Duration FROM AccountingFirm.dbo.job J 
 LEFT OUTER JOIN  AccountingFirm.dbo.Accountant A ON J.AccountantID = A.AccountantID 
 LEFT OUTER JOIN  AccountingFirm.dbo.Client C ON J.ClientID = C.ClientID
 LEFT OUTER JOIN  AccountingFirm.dbo.JobType T ON J.JobTypeID = T.JobTypeID
 WHERE T.JobTypeName LIKE '%Planning%' AND DATEDIFF(Minute, J.StartTime, J.EndTime) BETWEEN 30 AND 60 
 ORDER BY 4