/* 
=======================================
Multi Level Aggregation

By: Josh Navarro

Goal: Learn how to do Multi Level Aggregation in SQL
=======================================
*/

-- Grouping At Multiple Levels
-- ====================================

-- 1 Group by Multiple Columns

-- You can use GROUP BY with multiple columns, that is able
-- to create one result for each unique combination of values

-- Show the appointment type, status, and then total appointments
-- group by the appointment type, and the status

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

-- 2 Group by Category and Time Period

-- You can also GROUP BY category and
-- and time period 

-- You can change the time column using TO_CHAR(col, '')

-- Show the appointment month, appointment type,
-- total appointments, group by the time, and type

SELECT
    TO_CHAR(appointment_date, 'YYYY-MM') AS appointment_month,
    appointment_type,
    COUNT(*) AS total_appointments
FROM appointments
GROUP BY
    TO_CHAR(appointment_date, 'YYYY-MM'),
    appointment_type;

/* 
Output:
appointment_month
text
appointment_type
character varying
total_appointments
bigint
1	2026-01	Follow-Up	4
2	2026-01	Sick Visit	1
3	2026-01	Consultation	4
4	2026-01	Diagnostic Test	1
5	2026-01	Annual Exam	2
*/

-- Summarizing Already Grouped Results
-- ====================================

-- 3 Aggregate Results from a Subquery

-- You can aggregate results from a subquery by doing
-- doing another query within another query using FROM (query)

-- Show the average type cost for each type using subquery

SELECT 
    ROUND(AVG(type_cost), 2) AS average_type_cost
FROM(
    SELECT
        appointment_type,
        SUM(copay_amount) AS type_cost
    FROM appointments
    GROUP BY appointment_type
) AS appointment_type_summary;

/* 
Output:
average_type_cost
numeric
1	56.00
*/

-- 4 Use a CTE for Multi-Level Aggregation

-- A CTE or a common table expression is able to make the
-- multilevel aggregation much easier to read. This is done by 
-- using WITH to create the seperate query

-- Do the previous query but use the WITH

WITH type_grouping AS (
    SELECT
        appointment_type,
        SUM(copay_amount) AS type_cost
    FROM appointments
    GROUP BY appointment_type
)

SELECT 
    ROUND(AVG(type_cost), 2) AS average_type_cost
FROM type_grouping;


/* 
Output:
average_type_cost
numeric
1	56.00
*/

-- Comparing Groups to Overall Results
-- ====================================

-- 5 Calculate Each Group's Percentage of the Total

-- You can use the groups percentage of the total to compare
-- the groups with the overall total

-- Show the appointment type, total revenue, then the percentage of total

SELECT
    appointment_type,
    SUM(copay_amount) AS department_revenue,

    ROUND(
        100.0 * SUM(copay_amount)
        / (
            SELECT SUM(copay_amount)
            FROM appointments
        ),
        2
    ) AS percentage_of_total_revenue

FROM appointments
GROUP BY appointment_type;

/* 
Output:	
appointment_type
character varying
department_revenue
numeric
percentage_of_total_revenue
numeric
1	Sick Visit	15.00	5.36
2	Consultation	50.00	17.86
3	Annual Exam	60.00	21.43
4	Diagnostic Test	50.00	17.86
5	Follow-Up	105.00	37.50
*/

-- Filtering Multi Level Results
-- ====================================

-- 6 Filter at Different Aggregation Stages

-- You can filter at different aggregation stages by using the
-- WHERE and HAVING either in the inner query or outer query

-- Show the appointment type, and the type revenue, for the outer, then in the 
-- inner show the type, find the total revenue of the completed appointments, where 
-- the total is more than 1

SELECT
    appointment_type,
    type_revenue
FROM (
    SELECT
        appointment_type,
        SUM(copay_amount) AS type_revenue
    FROM appointments
    WHERE appointment_status = 'Completed'
    GROUP BY appointment_type
    HAVING COUNT(*) >= 1
) AS department_summary
WHERE type_revenue >= 25;

/* 
Output:

appointment_type
character varying
type_revenue
numeric
1	Annual Exam	60.00
2	Diagnostic Test	50.00
3	Follow-Up	50.00
*/
