CREATE VIEW High_Quality_Accountants_view 
AS SELECT AccountantName, (AVG(JobCost)) AS 'Average Job Cost'
   FROM Job_View
   GROUP BY AccountantName
   HAVING (AVG(JobCost)) > ALL(SELECT AVG(JobCost) 
							    FROM Job_View);