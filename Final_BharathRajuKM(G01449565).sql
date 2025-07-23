create database men_t20i_match_results;
use men_t20i_match_results;

CREATE TABLE men_t20i_match_results (
    Result VARCHAR(10),
    Margin INT,
    Result_cat VARCHAR(20),
    Team_1 VARCHAR(50),
    Team_2 VARCHAR(50),
    Home_Away VARCHAR(10),
    Ground VARCHAR(100),
    Match_Date VARCHAR(100),
    Match_Month VARCHAR(10),
    Match_Year INT,
    Match_Period VARCHAR(10),
    Matches INT,
    Country VARCHAR(50)
);
Describe men_t20i_match_results;
Select * from men_t20i_match_results;

SELECT 
    Match_Month, 
    Result, 
    COUNT(*) AS Total_Matches,
    ROUND((COUNT(*) / (SELECT COUNT(*) FROM men_t20i_match_results) * 100), 2) AS Percentage_of_Total_Matches
FROM 
    men_t20i_match_results
GROUP BY 
    Match_Month, Result
Order BY 
	Match_Month;

SELECT 
    Ground,
    Team_1 AS Team,
    Result,
    COUNT(*) AS Total_Matches
FROM 
    men_t20i_match_results
GROUP BY 
    Ground, Team, Result
ORDER BY 
    Ground, Team;
    
SELECT 
    Home_Away, 
    Result, 
    COUNT(*) AS Total_Matches
FROM 
    men_t20i_match_results
GROUP BY 
    Home_Away, Result
ORDER BY 
    Home_Away, Result;