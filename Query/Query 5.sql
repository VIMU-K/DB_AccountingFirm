SELECT  A.FirstName + ' ' + A.LastName AS Accountant,  C.ClientFirstName + ' ' + C.ClientLastName AS Client, 
 DATEDIFF(Minute, J.StartTime, J.EndTime)*5 AS Cost FROM AccountingFirm.dbo.job J 
 LEFT OUTER JOIN  AccountingFirm.dbo.Accountant A ON J.AccountantID = A.AccountantID
 LEFT OUTER JOIN  AccountingFirm.dbo.Client C ON J.ClientID = C.ClientID
  WHERE C.TaxFileNo LIKE '555%'
