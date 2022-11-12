SELECT  A.FirstName + ' ' + A.LastName AS Accountant,  A.HireDate, P.PayLevelName, DATEDIFF(YEAR,A.HireDate, GETDATE()) AS Exp_Exp
 FROM AccountingFirm.dbo.Accountant A 
 LEFT OUTER JOIN  AccountingFirm.dbo.PayLevel P
 ON A.PayLevel = P.PayLevelID WHERE DATEDIFF(YEAR,A.HireDate, GETDATE()) < 8

 