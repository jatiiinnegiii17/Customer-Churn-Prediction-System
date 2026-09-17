-- Customer Churn Prediction System — SQL EDA Queries
-- Dataset: Bank Customer Churn (Kaggle)


-- Setup
CREATE DATABASE Bank_churn;
USE Bank_churn;

CREATE TABLE customers (
    CustomerId INT PRIMARY KEY,
    Surname VARCHAR(50),
    CreditScore INT,
    Geography VARCHAR(30),
    Gender VARCHAR(10),
    Age INT,
    Tenure INT,
    Balance DECIMAL(12,2),
    NumOfProducts INT,
    HasCrCard TINYINT,
    IsActiveMember TINYINT,
    EstimatedSalary DECIMAL(12,2),
    Exited TINYINT
);

DESC customers;


-- Q1: What is the overall churn rate of the bank's customers?

SELECT Exited, COUNT(*) 
FROM customers 
GROUP BY Exited;


-- Q2: Does churn rate vary by country (Geography)?
-- Which region has the highest customer attrition?

SELECT Geography, 
       COUNT(*) AS total, 
       SUM(Exited) AS churned,
       ROUND(SUM(Exited)*100.0/COUNT(*), 2) AS churn_rate
FROM customers
GROUP BY Geography;


-- Q3: Is churn rate different between male and female customers?

SELECT Gender, 
       COUNT(*) AS total, 
       SUM(Exited) AS churned,
       ROUND(SUM(Exited)*100.0/COUNT(*), 2) AS churn_rate
FROM customers
GROUP BY Gender;


-- Q4: Are inactive members more likely to churn than active members?

SELECT IsActiveMember, 
       COUNT(*) AS total, 
       SUM(Exited) AS churned,
       ROUND(SUM(Exited)*100.0/COUNT(*), 2) AS churn_rate
FROM customers
GROUP BY IsActiveMember;


-- Q5: How do churned customers differ from retained customers
-- in terms of average age, tenure, and account balance?

SELECT Exited, 
       AVG(Age) AS avg_age, 
       AVG(Tenure) AS avg_tenure,
       AVG(Balance) AS avg_balance
FROM customers
GROUP BY Exited;


