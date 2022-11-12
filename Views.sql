-- Accountant View -- 

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


-- High Quality View -- 

CREATE VIEW High_Quality_Accountants_view 
AS SELECT AccountantName, (AVG(JobCost)) AS 'Average Job Cost'
   FROM Job_View
   GROUP BY AccountantName
   HAVING (AVG(JobCost)) > ALL(SELECT AVG(JobCost) 
							    FROM Job_View);

-- Job View -- 

CREATE VIEW Job_View
AS SELECT J.*, A.FirstName + ' ' + A.LastName AS 'Accountant Name', 
			C.ClientFirstName + ' ' + C.ClientLastName AS 'Client Name', 
			T.JobTypeName AS 'Job Type Name',
			DATEDIFF(MI, J.StartTime, J.EndTime) AS 'Job Duration',
			T.CostPerMinute * DATEDIFF(MI, J.StartTime, J.EndTime) AS 'Job Cost'

FROM Job AS J
LEFT JOIN Accountant AS A
ON J.AccountantID = A.AccountantID
LEFT JOIN Client AS C
ON J.ClientID = C.ClientID
LEFT JOIN JobType As T
ON J.JobTypeID = T.JobTypeID;




