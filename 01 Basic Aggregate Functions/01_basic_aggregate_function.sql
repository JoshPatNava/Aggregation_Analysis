/*
=========================================
Basic Aggregate Functions

By: Josh Navarro

Goal: Learn how to use basic aggregate functions in SQL
=========================================
*/

-- Counting Rows
-- =========================================

-- 1 Count every row with COUNT(*)

-- Using COUNT(*) you are able to count every row 
-- in a table. Which this would include nulls as well

-- Count all of the rows in the appointments table

SELECT
    COUNT(*) AS total_appointments
FROM appointments;

/*
Output:

total_appointments
bigint
1	12
*/

-- 2 Count Non-Null values with COUNT(column)

-- To count only the non-null values you can use the
-- COUNT(column) to count the amout of values.

-- Count the rows in the appointment table that
-- have an appointment cost

SELECT
    COUNT(copay_amount) AS appointments_with_cost
FROM appointments;

/*
Output:
appointments_with_cost
bigint
1	10
*/

-- 3 Count unique values with COUNT(DISTINCT)

-- You can also count the unique values using COUNT(DISTINCT col)

-- Count the unique patients in appointments

SELECT
    COUNT(DISTINCT patient_id) AS unique_patients
FROM appointments;

/*
Output:
unique_patients
bigint
1	6
*/

-- Summing Numeric Values
-- =========================================

-- 4 Calculate a Total with SUM()

-- You are able to get a total by using SUM(),
-- which this adds all the non-null numeric values 

-- Calculate the total revenue made from all the appointments

SELECT
    SUM(copay_amount) AS total_revenue
FROM appointments;

/*
Output:
total_revenue
numeric
1	280.00
*/

-- Calculating Averages
-- =========================================

-- 5 Calculate an Average with AVG()

-- You can calculate the average or mean of
-- the non-null values in a numeric column

-- Calculate the average appointment cost

SELECT
    AVG(copay_amount) AS average_appointment_cost
FROM appointments;

/*
Output:
average_appointment_cost
numeric
1	28.0000000000000000
*/


-- Finding Minimum and Maximum Values
-- =========================================

-- 6 Find the Smallest Value with MIN()

-- You can find the smallest value by using the
-- MIN(), which return the smallest non-null value

-- Find the lowest appointment cost

SELECT
    MIN(copay_amount) AS lowest_appointment_cost
FROM appointments;

/*
Output:
lowest_appointment_cost
numeric
1	10.00
*/

-- 7 Find the Largest Value with MAX()

-- You are able to find the largest value with MAX()
-- finds the largest value in the column

-- Find the largest pay in appointments

SELECT
    MAX(copay_amount) AS largest_pay_amount
FROM appointments;

/*
Output:
	
largest_pay_amount
numeric
1	50.00
*/

-- Using Multiple Aggregate Functions
-- =========================================

-- 8 Create a summary in One Query

-- You can create a basic summary by combining the methods
-- together in the same SELECT statement

-- Show the total amount of appointments, amount of appointments
-- paid, the total revenue, the average cost, the lowest cost,
-- then the highest cost

SELECT
    COUNT(*) AS total_appointments,
    COUNT(copay_amount) AS appointments_with_cost,
    ROUND(SUM(copay_amount), 2) AS total_revenue,
    ROUND(AVG(copay_amount), 2) AS average_cost,
    MIN(copay_amount) AS lowest_cost,
    MAX(copay_amount) AS highest_cost
FROM appointments;

/*
Output:
	
total_appointments
bigint
appointments_with_cost
bigint
total_revenue
numeric
average_cost
numeric
lowest_cost
numeric
highest_cost
numeric
1	12	10	280.00	28.00	10.00	50.00
*/

-- Nulls and Aggregation
-- =========================================

-- 9 Count the Null using COUNT(*) and COUNT(column)

-- To count the amount of nulls, you can use the 
-- COUNT(*) which counts all of the rows and
-- COUNT(column) that counts only rows that are 
-- non-nulls

-- Show the total appointments, the appointments that paid,
-- then show the difference.

SELECT
    COUNT(*) AS total_appointments,
    COUNT(copay_amount) AS appointments_with_cost,
    COUNT(*) - COUNT(copay_amount) AS missing_cost_values
FROM appointments;

/*
Output:
total_appointments
bigint
appointments_with_cost
bigint
missing_cost_values
bigint
1	12	10	2
*/

-- Aggregating Filterd Rows
-- =========================================

-- 11 Filter Rows Before Aggregating

-- You can filter the rows by using the 
-- WHERE() which will only do the
-- aggregation on rows that satisfy the condition

-- Show the total completed appointments

SELECT
    COUNT(*) AS total_completed_appointments
FROM appointments
WHERE appointment_status = 'Completed';

/*
Output:
total_completed_appointments
bigint
1	6
*/


