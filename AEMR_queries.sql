SELECT Status, Reason, YEAR(Start_Time) AS Year, ROUND(AVG(Outage_MW),2) AS Avg_Outage_MW_Loss,
ROUND(AVG(ROUND((TIMESTAMPDIFF(MINUTE, Start_Time, End_Time)),2)),2) AS Average_Outage_Duration_Time_Minutes
FROM AEMR
WHERE Status = 'Approved'
GROUP BY Year, Reason
ORDER BY Year, Average_Outage_Duration_Time_Minutes DESC;

SELECT Status, Reason, COUNT(*) AS Total_Number_Outage_Events,  MONTH(Start_Time) AS Month
FROM AEMR
WHERE Status = 'Approved' AND YEAR(Start_Time) = 2017
GROUP BY Reason, Month
ORDER BY Reason, Month;

SELECT Participant_Code,
COUNT(Participant_Code) AS AmbientCounts,
ROUND(SUM(Outage_MW),2) AS Summed_Energy_Lost,
ROUND(AVG(Outage_MW),2) AS Avg_Outage_MW_Loss,
ROUND((AVG(TIMESTAMPDIFF(MINUTE, Start_Time, End_Time))),2) AS Average_Outage_Duration_Time_Minutes,
ROUND(AVG(Outage_MW),2) / ROUND(SUM(ROUND((TIMESTAMPDIFF(MINUTE, Start_Time, End_Time)/60)/24,2)),2) AS avg_loss_rate
FROM AEMR
WHERE Participant_Code = 'AURICON' AND Status = 'Approved' and Reason = 'Forced' AND Description LIKE '%ambient%'
Group By Participant_Code
Order By AmbientCounts DESC;

SELECT
COUNT(CASE WHEN Reason = 'Forced' THEN Reason END) AS Total_Number_Forced_Outage_Events,
COUNT(*) AS Total_Number_Outage_Events,
ROUND((COUNT(CASE WHEN Reason = 'Forced' THEN Reason END) / COUNT(*))*100,2) AS Forced_Outage_Percentage,
YEAR(Start_Time) As Year
FROM AEMR
WHERE Status = 'Approved' AND Participant_Code = "AURICON"
GROUP BY Year;
