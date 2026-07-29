/*
====================================
Grouping and Group Filters

By: Josh Navarro

Goal: Learn how to group and use group filters
====================================
*/

-- Creating Groups
-- ==================================

-- 1 Group Rows by a Category

-- The GROUP BY divides the rows into categories based on the
--  unique values that are found in the column

-- Show the appointment type, and the total appointments grouped by the department 

SELECT
    appointment_type,
    COUNT(*) AS total_appointments
FROM appointments 
GROUP BY appointment_type;

/*
Output:
appointment_type
character varying
total_appointments
bigint
1	Sick Visit	1
2	Consultation	4
3	Annual Exam	2
4	Diagnostic Test	1
5	Follow-Up	4
*/

-- 2 Grouping by Multiple Columns

-- You are able to use the GROUP BY on more than one column, 
-- For each column a group is created for each unique value

-- Show the appointment type, status, and then the total appointments

SELECT
    appointment_type,
    appointment_status,
    COUNT(*) AS total_appointments
FROM appointments 
GROUP BY 
    appointment_type,
    appointment_status;

/*
Output:
appointment_type
character varying
appointment_status
character varying
total_appointments
bigint
1	Follow-Up	Completed	2
2	Consultation	Scheduled	1
3	Consultation	Cancelled	2
4	Sick Visit	Completed	1
5	Follow-Up	No-Show	1
6	Annual Exam	Completed	2
7	Diagnostic Test	Completed	1
8	Consultation	No-Show	1
9	Follow-Up	Scheduled	1
*/

-- Summarizing Groups
-- ==================================

-- 3 Using Aggregate Function w/ Groups

-- Aggregate functions can be used to calculate 
-- a seperate result for each of the groups.
-- Such as: SUM(), COUNT(), MIN(), etc..

-- show the appointment type, total appointments, total cost, and average cost 

SELECT 
    appointment_type,
    COUNT(*) AS total_appointments,
    ROUND(SUM(copay_amount), 2) AS total_paid,
    ROUND(AVG(copay_amount), 2) AS average_appointment_cost
FROM appointments
GROUP BY appointment_type;

/*
Output:
appointment_type
character varying
total_appointments
bigint
total_paid
numeric
average_appointment_cost
numeric
1	Sick Visit	1	15.00	15.00
2	Consultation	4	50.00	25.00
3	Annual Exam	2	60.00	30.00
4	Diagnostic Test	1	50.00	50.00
5	Follow-Up	4	105.00	26.25
*/

-- Filtering Grouped Analysis 
-- ==================================

-- 4 Filtering rows with WHERE

-- You are able to filter the rows before grouping by, 
-- only the rows that statisfy the condition will show

-- Show the appointment type, the total for completed appointments
SELECT
    appointment_type,
    COUNT(*) AS total_completed_appointments
FROM appointments 
WHERE appointment_status = 'Completed'
GROUP BY appointment_type;

/*
Output:
appointment_type
character varying
total_completed_appointments
bigint
1	Annual Exam	2
2	Diagnostic Test	1
3	Follow-Up	2
4	Sick Visit	1
*/

-- 5 Filtering Groups with HAVING

-- You can filter the groups after the aggregation by using the HAVING
-- commonly used with COUNT(), SUM(), and AVG()

-- Show the appointment type, the total appointments,
-- and group by type, and those having more than 3

SELECT
    appointment_type,
    COUNT(*) AS total_appointments
FROM appointments
GROUP BY appointment_type
HAVING COUNT(*) >= 3;

/*
Output:
appointment_type
character varying
total_appointments
bigint
1	Consultation	4
2	Follow-Up	4
*/

-- 6 Using WHERE and HAVING together

-- You can also use both where an having together,
-- for further filtering.

-- Show the appointment type, the total, and filter for completed, 
-- then the total being more than 2

SELECT
    appointment_type,
    COUNT(*) AS completed_appointments
FROM appointments
WHERE appointment_status = 'Completed'
GROUP BY appointment_type
HAVING COUNT(*) >= 2;

/*
Output:
appointment_type
character varying
completed_appointments
bigint
1	Annual Exam	2
2	Follow-Up	2
*/

-- Organizing Grouped Results
-- ==================================

-- 7 Sorting Grouped Results

-- You can sort the grouped results by using the 
-- ORDER BY, which after the aggregation and group by will sort

-- Show the appointment type, then the total paid, 
-- group by the appointment type, and sort by total paid

SELECT
    appointment_type,
    ROUND(SUM(copay_amount), 2) AS total_cost
FROM appointments
GROUP BY appointment_type
ORDER BY total_cost DESC;

/*
Output:
appointment_type
character varying
total_cost
numeric
1	Follow-Up	105.00
2	Annual Exam	60.00
3	Consultation	50.00
4	Diagnostic Test	50.00
5	Sick Visit	15.00
*/

