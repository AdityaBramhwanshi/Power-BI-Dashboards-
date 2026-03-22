SELECT * FROM sql_analysis.loanapproval;

# Author : Aditya Bramhwanshi
# Loan Approval and Lending Performance Analysis 

#Total Applications 
Select count(*) from sql_analysis.loanapproval; 

#Total Loan Amount Approved 
Select sum(loan_amount)/1000000 as Total_Loan_Amount_Approved from sql_analysis.loanapproval ; 

#Approval Rate 
select sum(case when loan_approved = 1 then 1 else 0 end ) * 100 / count(loan_approved) as Approval_Rate from 
sql_analysis.loanapproval ; 

select count(*) AS Total_Applications, SUM(case when loan_approved = 1 then 1 else 0 end) AS Approved,
round(SUM(case when loan_approved = 1 THEN 1 ELSE 0 END) * 1.0 / COUNT(*), 2) AS Approval_Rate
from sql_analysis.loanapproval ;

#Average Loan Amount 
select avg(loan_amount) / 1000 as Average_Loan_Amount from sql_analysis.loanapproval ; 

#Average Credit Score 
select avg(credit_score) as Avg_Credit_Score from sql_analysis.loanapproval ; 

#Average Income 
select avg(annual_income) / 1000 as Avg_Income from sql_analysis.loanapproval ; 

#Approval Distribution 
select loan_approved , count(*) as Total_Customers from sql_analysis.loanapproval group by loan_approved; 

#Loan Approval based on employment status 
select employment_status , count(*) as Total_Customers , sum(case when loan_approved = 1 then 1 else 0 end ) as Loan_Approved 
from sql_analysis.loanapproval group by employment_status order by loan_approved desc ; 

#Loan Approval Amount by Gender 
select Gender , Round(sum(loan_amount)/1000000,2) as Total_Loan_Amount_in_Millions 
from sql_analysis.loanapproval group by gender ; 

#Income to Loan Amount 
select annual_income , loan_amount from sql_analysis.loanapproval order by annual_income desc ; 

#Loan Approval based on Credit Score 
select 
	case 
		when credit_score < 500 then 'Low'
        when credit_score between 500 and 700 then 'Medium'
        else 'High'
        end as Credit_Score_Category , 
        Count(*) as Total_Applications ,
        sum(case when loan_approved = 1 then 1 else 0 end) * 100 / count(*) as Approval_Rate
from sql_analysis.loanapproval group by Credit_Score_Category ; 

#Loan Burden Analysis 
Select 
    case 
        when annual_income < 50000 then 'Low Income'
        when annual_income between 50000 and 100000 then 'Middle Income'
        else 'High Income'
    end as Income_Group,
    
    round(avg(loan_amount / annual_income), 2) as Loan_Burden_Ratio
from sql_analysis.loanapproval
group by Income_Group;

#Marital Status Analysis 
select marital_status , count(*) as Total_Application , sum(case when loan_approved = 1 then 1 else 0 end ) as Approved 
from sql_analysis.loanapproval group by marital_status ; 

#High Risk Applciations 
select applicant_id, annual_income, loan_amount, credit_score, employment_status
from sql_analysis.loanapproval where credit_score < 575 and loan_amount > 30000 and loan_approved = 0;

#Approval Rate by Income Group 
select  
    case  
        when annual_income < 50000 then 'Low Income'
        when annual_income between 50000 and 100000 then 'Middle Income'
        else 'High Income'
    end as Income_Group,
    
    count(*) as Total,
    sum(case when loan_approved = 1 then 1 else 0 end) * 100 / count(*) as Approval_Rate
from sql_analysis.loanapproval group by Income_Group;

#Top Loan Amounts 
select loan_amount , applicant_id , employment_status
from sql_analysis.loanapproval order by loan_amount desc limit 5 ; 

#Loan Rejection Reason 
select 
	case 
		when credit_score < 500 then 'Low Credit Score'
        when annual_income < 40000 then 'Low Annual Income'
        else 'Others' end as Rejection_Reasons ,
        Count(*) as Total_Rejected 
from sql_analysis.loanapproval where loan_approved = 0 group by Rejection_Reasons ; 