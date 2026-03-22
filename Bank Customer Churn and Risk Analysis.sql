SELECT * FROM sql_analysis.customer_churn_records;

# Count of Total Customer
select count(*) as Total_Customers from sql_analysis.customer_churn_records;

#Count of total customers who have churned and credit_Score > 650 
select Count(*) as total_records from sql_analysis.customer_churn_records where creditScore > 650 && Exited = 1 ;

#Count of Total Churned Customers 
Select Count(*) as churned_customers from sql_analysis.customer_churn_records where Exited = 1; 

#Total Credit Score Churned 
select avg(CreditScore) as Credit_Score_Churned from sql_analysis.customer_churn_records where Exited = 1 ; 

#Total Balance at Risk means Churned Balance 
select sum(Balance) / 1000000 as Balance_at_Risk from sql_analysis.customer_churn_records where Exited = 1 ;

#Churned balance by Average Age , Geography 
select avg(Age) , Geography , sum(Balance) / 1000000 as Total_Balance , SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS Total_Customer_Churned 
from sql_analysis.customer_churn_records group by Geography order by Total_Customer_Churned desc;  

#Churn Rate 
select SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) * 100 / count(*) as Churn_Rate from sql_analysis.customer_churn_records ; 

#Churn Rate by Customer having credit card 
select SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) * 100 / count(*) as Churn_Rate , HasCrCard from sql_analysis.customer_churn_records where HasCrCard = 1 ; 

#Total customer churned Gender wise 
select Count(*) , Gender , Sum(Case when Exited = 1 then 1 else 0 end ) as Churned_Customers from sql_analysis.customer_churn_records group by Gender ; 

#Region wise Total balance 
select Geography , round(sum(Balance)/1000000,2) as Total_Balance_Millions from sql_analysis.customer_churn_records group by Geography ; 

#CreditScore to Churn Analysis 
Select 
	case 
		when CreditScore < 500 then 'Low '
		when CreditScore between 500 and 700 then 'Medium'
        else 'High' END as Credit_Category , 
	count(*) as Total_Customers , Sum(case when Exited = 1 then 1 else 0 End ) as Churned_Customers 
	from sql_analysis.customer_churn_records group by Credit_Category ;
    
#Age Group to churn Analysis 
Select 
	case 
		when Age < 30 then 'Young'
		when Age between 30 and 50 then 'Middle Age'
        else 'Senior' END as Age_Group , 
	count(*) as Total_Customers , Sum(case when Exited = 1 then 1 else 0 End ) as Churned_Customers 
	from sql_analysis.customer_churn_records group by Age_Group ;   
    
#Active member who churned 
select IsActiveMember ,Count(*) as Total_Customers , sum(case when Exited = 1 then 1 else 0 End ) as Churned_Customer 
from sql_analysis.customer_churn_records group by IsActiveMember ;   

#Products to churn analysis 
Select NumOfProducts ,COUNT(*) AS Total_Customers ,sum(case when Exited = 1 then 1 else 0 end ) as Churned_Customers
from sql_analysis.customer_churn_records group by NumOfProducts order by NumOfProducts desc ;   

#Estimated Salary group by churn 
select round(avg(EstimatedSalary),2) as Avg_Salary , Exited from sql_analysis.customer_churn_records group by Exited ; 

#High Risk Customer Segment 
SELECT CustomerId ,Surname ,Geography ,Age ,Balance ,IsActiveMember ,NumOfProducts
FROM sql_analysis.customer_churn_records WHERE Exited = 1 AND IsActiveMember = 0 AND Balance > 100000 ;