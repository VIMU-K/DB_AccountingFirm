CREATE VIEW AccountantView
AS SELECT M.* , ISNULL(A.LastName + ', ' + A.FirstName, 'No Mentor') AS 'Mentor', 
			 ISNULL(B.BranchName,'Null') AS 'Branch_', 
			 ISNULL(CAST(P.AnnualPay AS VARCHAR),'No Mentor') AS 'Null'
FROM Accountant AS A
RIGHT JOIN Accountant AS M
ON A.AccountantID = M.MentorID
LEFT JOIN Branch AS B
ON A.Branch = B.BranchID
LEFT JOIN PayLevel AS P
ON A.PayLevel = P.PayLevelID
WHERE A.MentorID IS NULL OR A.AccountantID = M.MentorID;