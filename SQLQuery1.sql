-- BANK LOAN DATA ANALYSIS PROJECT
-- This SQL script analyzes bank loan data, covering: Dataset Overview and Basic Statistics, 
-- Total Loan Applications and Funding Analysis, Month-to-Date (MTD) Analysis, Loan Quality Assessment, 
-- Interest Rate and Debt-to-Income Ratio Analysis, Geographic Distribution of Loans, 
-- Loan Purpose Analysis, Loan Term Analysis, Employment Length Impact on Loans, 
-- Seasonal Trends in Loan Applications, Portfolio Performance Metrics, Risk Assessment Queries,  
-- The project aims to provide comprehensive insights into loan performance, risk factors, 


USE bank_data;

-- Getting the overview of the dataset
SELECT * FROM loan_data;


--Find the total number of Appliation
SELECT COUNT(id) AS Total_Loan_Appication FROM loan_data;


--Find the Month to date Loan Application
SELECT COUNT(id) AS MTD_Total_Loan_Appications 
FROM loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021


-- Find the Per Month over Month loan applications
SELECT COUNT(id) AS PMTD 
FROM loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021


-- Find the total funded/loan amount form the dataset
SELECT SUM(loan_amount) as Total_Funded_Amount FROM loan_data;

-- Find the total funded/loan amount Month to Date form the dataset
SELECT SUM(loan_amount) as MTD_Total_Funded_Amount
FROM loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;


-- Find the total funded/loan amount Peevious Month to Date form the dataset
SELECT SUM(loan_amount) as Previous_Month_to_date
FROM loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;


-- Find the total amount received from the dataset
SELECT SUM(total_payment) AS Total_amount_received
FROM loan_data;

-- Find the total month to date amount received from the data 
SELECT SUM(total_payment) AS MTD_Total_amount_received
FROM loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

-- Find the previous total month to date amount received from the data 
SELECT SUM(total_payment) AS PMTD_Total_amount_received
FROM loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;


-- Find the average interest rate from the data 
SELECT ROUND(AVG(int_rate)*100,2) AS Average_interest_rate
FROM loan_data;


-- Find the month to date average interest rate from the data 
SELECT ROUND(AVG(int_rate)*100,2) AS MTD_Average_interest_rate
FROM loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;


-- Find the last month to date average interest rate from the data 
SELECT ROUND(AVG(int_rate)*100,2) AS PMTD_Average_interest_rate
FROM loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;


 -- Find the Debt-to -income ratio(DTI)
 SELECT ROUND(AVG(dti) *100,2) AS Average_dti FROM loan_data;


  -- Find the Debt-to -income ratio(DTI) for the current month
 SELECT ROUND(AVG(dti) *100,2) AS MTD_Average_dti 
 FROM loan_data
 WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

   -- Find the Debt-to -income ratio(DTI) for the previous month
 SELECT ROUND(AVG(dti) *100,2) AS PMTD_Average_dti 
 FROM loan_data
 WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;


------------------------------------------------  GOOD LOAN DATA ------------------------------------------------

-- Find the percentage of Good loans

SELECT 
	(COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100) / 
	COUNT(id) AS Good_Loan_Percentage
FROM loan_data;

 
 -- Find the total good loan application 
SELECT COUNT(id) AS Good_loan_aapications
FROM loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';


-- Find the good loan funded amount 
SELECT SUM(loan_amount) AS Good_loan_funded_amount
FROM loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';


-- Find the total amount received by good loan applicantions
SELECT SUM(total_payment) AS Good_loan_received_amount
FROM loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';


---------------------------------------------------- BAD LOAN DATA ---------------------------------------------

-- Find the percentage of bad loan
SELECT (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100) /
		COUNT(id) AS Bad_loan_percentage
		FROM loan_data;

--Find the total bad loan applications
SELECT COUNT(id) as Bad_loan_applications
FROM loan_data
WHERE loan_status = 'Charged off'


--Find the bad loan funded amount
SELECT SUM(loan_amount) as Bad_loan_funded_amount
FROM loan_data
WHERE loan_status = 'Charged off'


--Find the bad loan amount received
SELECT SUM(total_payment) as Bad_loan_received_amount
FROM loan_data
WHERE loan_status = 'Charged off'




----------------------------------------- LOAN STATUS ------------------------------------------
SELECT loan_status, 
		COUNT(id) AS Total_loan_applications, 
		SUM(total_payment) AS Total_Amount_Received, 
		SUM(loan_amount) AS Total_Funded_Amount, 
		AVG(int_rate * 100 ) AS Interest_rate, 
		AVG(dti * 100 ) AS DTI
	FROM loan_data
	GROUP BY loan_status;


SELECT loan_status, 
		SUM(total_payment) AS MTD_Total_Amount_Received, 
		SUM(loan_amount) AS MTD_Total_Funded_Amount 
	FROM loan_data
	WHERE MONTH(issue_date) = 12
	GROUP BY loan_status;


------------------------------------------ BANK LOAN REPORT OVERVIEW--------------------------------
-- MONTH

select 
		Month(issue_date) as Month_Number,
		datename(MONTH,issue_date) AS Month_Name,
		COUNT(id) as Total_Loan_Applications,
		SUM(loan_amount) as Total_Funded_Amount,
		SUM(total_payment) as Total_Amount_Received
FROM loan_data
GROUP BY MONTH(issue_date), datename(MONTH,issue_date)
ORDER BY MONTH(issue_date);



-- STATE
select 
		address_state as State,
		COUNT(id) as Total_Loan_Applications,
		SUM(loan_amount) as Total_Funded_Amount,
		SUM(total_payment) as Total_Amount_Received
FROM loan_data
GROUP BY address_state
ORDER BY SUM(loan_amount) desc;


-- TERM of Loan
select 
		term as Term,
		COUNT(id) as Total_Loan_Applications,
		SUM(loan_amount) as Total_Funded_Amount,
		SUM(total_payment) as Total_Amount_Received
FROM loan_data
GROUP BY term
ORDER BY term;



-- EMPLOYEE LENGTH
select 
		emp_length as Employee_length,
		COUNT(id) as Total_Loan_Applications,
		SUM(loan_amount) as Total_Funded_Amount,
		SUM(total_payment) as Total_Amount_Received
FROM loan_data
GROUP BY emp_length
ORDER BY Total_Amount_Received desc;


-- PURPOSE of loan
select 
		purpose as Loan_Purpose,
		COUNT(id) as Total_Loan_Applications,
		SUM(loan_amount) as Total_Funded_Amount,
		SUM(total_payment) as Total_Amount_Received
FROM loan_data
GROUP BY purpose
ORDER BY Total_Funded_Amount desc;


-- HOME Ownership
select 
		home_ownership as Home_Ownership,
		COUNT(id) as Total_Loan_Applications,
		SUM(loan_amount) as Total_Funded_Amount,
		SUM(total_payment) as Total_Amount_Received
FROM loan_data
GROUP BY home_ownership
ORDER BY Total_Funded_Amount desc;



SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM loan_data
WHERE grade = 'A'
GROUP BY purpose
ORDER BY purpose

