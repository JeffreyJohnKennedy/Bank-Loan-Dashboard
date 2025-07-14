USE loandb;
SELECT * FROM financial_loan;

-- Total Loan Applications --
SELECT COUNT(id) AS Total_Loan_Applications FROM financial_loan;

-- Month to date Total Loan Applications --
SELECT COUNT(id) AS MTD_Total_Loan_Applications FROM financial_loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

-- Previous month Total Loan Applications --
SELECT COUNT(id) AS PM_Total_Loan_Applications FROM financial_loan
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

-- Month on Month calculation --
SELECT
  MTD.MTD_Total_Loan_Applications,
  PM.PM_Total_Loan_Applications,
  ROUND(
    ((MTD.MTD_Total_Loan_Applications - PM.PM_Total_Loan_Applications) * 100.0) 
    / NULLIF(PM.PM_Total_Loan_Applications, 0), 
    2
  ) AS MoM_Percent_Change
FROM
  (SELECT COUNT(id) AS MTD_Total_Loan_Applications
   FROM financial_loan
   WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021) AS MTD,
  (SELECT COUNT(id) AS PM_Total_Loan_Applications
   FROM financial_loan
   WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021) AS PM;

-- Total Funded Amount --
SELECT SUM(loan_amount) AS Total_Funded_Amount 
FROM financial_loan;

-- Month To Date Toatl Funded Amount --
SELECT SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM financial_loan
WHERE MONTH(issue_date) = 12;

-- Previous Month Total Funded Amount --
SELECT SUM(loan_amount) AS PM_Total_Funded_Amount 
FROM financial_loan
WHERE MONTH(issue_date) = 11;

-- Toatl Amount Received --
SELECT SUM(total_payment) AS Total_Amount_Received
FROM financial_loan;

-- Month To Date Toatl Amount Received --
SELECT SUM(total_payment) AS MTD_Total_Amount_Received
FROM financial_loan
WHERE MONTH(issue_date) = 12;

-- Previous Month Toatl Amount Received --
SELECT SUM(total_payment) AS PM_Total_Amount_Received
FROM financial_loan
WHERE MONTH(issue_date) = 11;

-- Average Interest rates --
SELECT AVG(int_rate)*100 AS Avg_Int_Rate FROM financial_loan;

-- Month to Date Average Interest Rates --
SELECT AVG(int_rate)*100 AS MTD_Avg_Int_Rate FROM financial_loan
WHERE MONTH(issue_date) = 12;


-- Previous Month Average Interest Rates --
SELECT AVG(int_rate)*100 AS PM_Avg_Int_Rate FROM financial_loan
WHERE MONTH(issue_date) = 11;

-- Avg DTI --
SELECT AVG(dti)*100 AS Avg_DTI FROM financial_loan;

-- MTD Avg DTI -- 
SELECT AVG(dti)*100 AS MTD_Avg_DTI FROM financial_loan
WHERE MONTH(issue_date) = 12;

-- PMTD Avg DTI --  
SELECT AVG(dti)*100 AS PMTD_Avg_DTI FROM financial_loan
WHERE MONTH(issue_date) = 11;

-- Good Loans Percentage --
SELECT 
    (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END)*100)
    /
    COUNT(id) AS Good_Loan_Percentage
    FROM financial_loan;

-- Good Loan Applications --
SELECT COUNT(id) AS Good_Loan_Applications FROM financial_loan
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'; 

-- Good Loan Funded Amounts --
SELECT SUM(loan_amount) AS Good_Loan_Funded_Amount FROm financial_loan
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'; 

-- Good Loan Amounts Received --
SELECT SUM(total_payment) AS Good_Loan_amount_received FROM financial_loan
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

-- Bad Loan Percentage --
SELECT 
   (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END)*100)
   /
   COUNT(id) AS Bad_Loan_Percentage FROM financial_loan;
   
-- Bad loan Applications --
SELECT COUNT(id) AS Bad_Loan_Applications FROM financial_loan
WHERE loan_status  = 'Charged off';

-- Bad Loan Funded Amounts --
SELECT SUM(loan_amount) AS Bad_Loan_Funded_Amounts FROM financial_loan
WHERE loan_status = 'Charged Off';

-- Bad Loan Amount received --
SELECT SUM(total_payment) AS Bad_Loan_Amount_Received FROM financial_loan
WHERE loan_status = 'Charged Off';

-- Loan Status --

	SELECT
        loan_status,
        COUNT(id) AS LoanCount,
        SUM(total_payment) AS Total_Amount_Received,
        SUM(loan_amount) AS Total_Funded_Amount,
        AVG(int_rate * 100) AS Interest_Rate,
        AVG(dti * 100) AS DTI
    FROM
        financial_loan
    GROUP BY
        loan_status;

-- Month to date Loan Status --
SELECT loan_status,
SUM(total_payment) AS MTD_Total_Loan_Received,
SUM(loan_amount) AS MTD_Total_Loan_amount
FROM financial_loan
WHERE MONTH(issue_date) = 12
GROUP BY loan_status;

-- Month --
SELECT 
    YEAR(issue_date) AS Year,
    MONTH(issue_date) AS Month_Number, 
    MONTHNAME(issue_date) AS Month_Name, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY YEAR(issue_date), MONTH(issue_date), MONTHNAME(issue_date)
ORDER BY YEAR(issue_date), MONTH(issue_date);

-- State --
SELECT 
	address_state AS State, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY address_state
ORDER BY address_state;

-- Term --
SELECT 
	term AS Term, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY term
ORDER BY term;

-- Employee Length --
SELECT 
	emp_length AS Employee_Length, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY emp_length
ORDER BY emp_length;

-- PURPOSE --
SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY purpose
ORDER BY purpose;

-- HOME OWNERSHIP --
-- HOME OWNERSHIP --
SELECT 
    home_ownership AS Home_Ownership, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY home_ownership
ORDER BY home_ownership;



