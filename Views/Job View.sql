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


