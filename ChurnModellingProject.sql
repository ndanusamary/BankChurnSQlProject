-- BASIC COSTUMER INSIGHTS

-- 1.How many customers are in the dataset 
select count(customerid)
from churn_modelling;

-- 2.How many customers have exited vs stayed?
SELECT Exited, 
COUNT(*) AS total FROM churn_modelling
GROUP BY Exited;

-- 3. What is the average age and balance of all customers?
SELECT AVG(Age) AS avg_age,
round(AVG(Balance), 2)  AS avg_balance 
FROM churn_modelling;

-- 4.What is the gender distribution among customers?
SELECT Gender, 
COUNT(*) AS total FROM churn_modelling
GROUP BY Gender;

-- 5.Which geography has the most customers?
SELECT geography, 
COUNT(*) AS total_customers FROM churn_modelling
GROUP BY Geography;


-- BEHAVIORAL TRENDS & PATTERNS

-- 1.What is the churn rate by geography?
SELECT Geography, COUNT(*) AS total_customers,
       SUM(Exited) AS churned_customers,
       ROUND(100 * SUM(Exited) / COUNT(*), 2) AS churn_rate
FROM churn_modelling
GROUP BY Geography;

-- 2.What’s the average balance of customers who exited vs those who didn’t?
SELECT Exited, 
ROUND(AVG(Balance), 2) AS avg_balance 
FROM churn_modelling 
GROUP BY Exited;

-- 3. Do active members have lower churn rates?
SELECT IsActiveMember, COUNT(*) AS total,
       SUM(Exited) AS churned,
       ROUND(100 * SUM(Exited) / COUNT(*), 2) AS churn_rate
FROM churn_modelling
GROUP BY IsActiveMember;

-- 4. Distribution of customers by number of products
SELECT NumOfProducts, 
COUNT(*) AS total 
FROM churn_modelling 
GROUP BY NumOfProductS;

-- 5. Churn rate by credit score range
SELECT 
  CASE 
    WHEN CreditScore < 400 THEN '<400'
    WHEN CreditScore BETWEEN 400 AND 599 THEN '400-599'
    WHEN CreditScore BETWEEN 600 AND 799 THEN '600-799'
    ELSE '800+'
  END AS credit_score_range,
  COUNT(*) AS total,
  SUM(Exited) AS churned,
  ROUND(100 * SUM(Exited) / COUNT(*), 2) AS churn_rate
FROM churn_modelling
GROUP BY credit_score_range;

-- 6. Churn by age group
SELECT 
  CASE 
    WHEN Age < 30 THEN 'Below 30'
    WHEN Age BETWEEN 30 AND 50 THEN '30-50'
    ELSE 'Above 50'
  END AS age_group,
  COUNT(*) AS total,
  SUM(Exited) AS churned,
  ROUND(100 * SUM(Exited) / COUNT(*), 2) AS churn_rate
FROM churn_modelling
GROUP BY age_group;

-- 7. Churn by tenure
SELECT Tenure, 
COUNT(*) AS total, 
SUM(Exited) AS churned, 
ROUND(100 * SUM(Exited) / COUNT(*), 2) AS churn_rate
FROM churn_modelling 
GROUP BY Tenure 
ORDER BY Tenure;

-- 8. Credit card holders who are active and their churn rate
SELECT HasCrCard, IsActiveMember, 
COUNT(*) AS total,
       SUM(Exited) AS churned,
       ROUND(100 * SUM(Exited) / COUNT(*), 2) AS churn_rate
FROM churn_modelling
GROUP BY HasCrCard, IsActiveMember;


-- BUSINESS IMPACT & DECISION MAKING QUERIES

-- 1. Top 10 highest-balance churned customers
SELECT CustomerId, Surname, Balance
FROM churn_modelling
WHERE Exited = 1
ORDER BY Balance DESC
LIMIT 10;

-- 2. Churn rate for customers with 1 products vs 2 and more products
SELECT 
  CASE 
    WHEN NumOfProducts = 1 THEN 'One Product'
    ELSE 'Multiple Products'
  END AS product_segment,
  COUNT(*) AS total,
  SUM(Exited) AS churned,
  ROUND(100 * SUM(Exited) / COUNT(*), 2) AS churn_rate
FROM churn_modelling
GROUP BY product_segment;

-- 3. Geography and Gender churn rate
SELECT Geography, Gender, COUNT(*) AS total,
       SUM(Exited) AS churned,
       ROUND(100 * SUM(Exited) / COUNT(*), 2) AS churn_rate
FROM churn_modelling
GROUP BY Geography, Gender;

--  4. Do High Earners Churn More or Less?
SELECT 
  CASE 
    WHEN EstimatedSalary < 50000 THEN 'Low (<50k)'
    WHEN EstimatedSalary BETWEEN 50000 AND 100000 THEN 'Medium (50k-100k)'
    ELSE 'High (>100k)'
  END AS salary_segment,
  COUNT(*) AS total,
  SUM(Exited) AS churned,
  ROUND(100 * SUM(Exited) / COUNT(*), 2) AS churn_rate
FROM churn_modelling
GROUP BY salary_segment;


-- 5. Risk Score: Active + High Balance + Exited
SELECT CustomerID, Balance, IsActiveMember, Exited,
  CASE 
    WHEN IsActiveMember = 1 AND Balance > 100000 AND Exited = 1 THEN '⚠️ High Risk Churn'
    ELSE 'Normal'
  END AS RiskFlag
FROM churn_modelling
WHERE Exited = 1 AND IsActiveMember = 1 AND Balance > 100000;

-- 6. Risk Score: Active + High Balance + Exited
SELECT CustomerID, Balance, IsActiveMember, Exited,
  CASE 
    WHEN IsActiveMember = 1 AND Balance > 100000 AND Exited = 1 THEN '⚠️ High Risk Churn'
    ELSE 'Normal'
  END AS RiskFlag
FROM churn_modelling
WHERE Exited = 1 AND IsActiveMember = 1 AND Balance > 100000;

 SELECT * FROM practice.churn_modelling;