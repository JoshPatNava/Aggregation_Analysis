/*
=========================================
Conditional Aggregations

By: Josh Navarro

Goal: Learn how to create Conditional Aggregations in SQL
=========================================
*/

-- Conditional Counts
-- =========================================

-- 1 Count Matching Rows with SUM()

-- You can do condtional counting with SUM() and CASE(), 
-- having the condition returning 1 else 0

-- Show the total completed the appointments using CASE() and SUM()

SELECT
    SUM(
        CASE
            WHEN appointment_status = 'Completed' THEN 1
            ELSE 0
        END
    ) AS completed_appointments
FROM appointments;

/*
Output:
completed_appointments
bigint
1	6
*/

-- 2 Count Matching Rows with COUNT()

-- You can also use COUNT to do conditional counting,
-- for the CASE() only include the condition.

-- Show the total completed appointments using COUNT() and CASE() 

SELECT
    COUNT(
        CASE
            WHEN appointment_status = 'Completed' THEN 1
        END
    ) AS total_completed_appointments
FROM appointments;

/*
Output:
total_completed_appointments
bigint
1	6
*/

-- 3 Create Multiple Conditional Counts

-- You can stack the counts to have mutltiple different counts
-- for differing conditions

-- Show the total for completed, cancelled, and then scheduled

SELECT
    SUM(
        CASE
            WHEN appointment_status = 'Completed' THEN 1
            ELSE 0
        END
    ) AS completed_appointments,

    SUM(
        CASE
            WHEN appointment_status = 'Cancelled' THEN 1
            ELSE 0
        END
    ) AS cancelled_appointments,

    SUM(
        CASE
            WHEN appointment_status = 'Scheduled' THEN 1
            ELSE 0
        END
    ) AS scheduled_appointments
FROM appointments;

/*
Output:
completed_appointments
bigint
cancelled_appointments
bigint
scheduled_appointments
bigint
1	6	2	2
*/

-- Conditional Total
-- =========================================

-- 4 Sum Values that Meet a Condition

-- You can find the total for the sums by using the SUM() and 
-- CASE() by chaning the condtion outcome to a numeric column

-- Show the total revenue that was created from the completed appointments

SELECT
    SUM(
        CASE
            WHEN appointment_status = 'Completed'
                THEN copay_amount
            ELSE 0
        END
    ) AS completed_revenue
FROM appointments;

/*
Output:
completed_revenue
numeric
1	175.00
*/

-- Conditional Averages
-- =========================================

-- 5 Average Values That Meet a Condition

-- You can find the averages of the values from a numeric value column
-- using a condition. 

-- Find the average cost for the completed appointments

SELECT
    ROUND(
        AVG(
            CASE
                WHEN appointment_status = 'Completed'
                    THEN copay_amount
                ELSE NULL
            END
        ),
        2
    ) AS average_completed_cost
FROM appointments;

/*
Output:
average_completed_cost
numeric
1	29.17
*/

-- Conditional Minimum and Maximum
-- =========================================

-- 6 Find the conditional Minimum and Maximum Values

-- You can also find the Min and the Max by using the same
-- MIN() or MAX() and then the CASE()

-- Show the max payment and the lowest payment
-- for the completed appointments

SELECT
    MIN(
        CASE
            WHEN appointment_status = 'Completed'
                THEN copay_amount
        END
    ) AS lowest_completed_cost,

    MAX(
        CASE
            WHEN appointment_status = 'Completed'
                THEN copay_amount
        END
    ) AS highest_completed_cost
FROM appointments;

/*
Output:
lowest_completed_cost
numeric
highest_completed_cost
numeric
1	15.00	50.00
*/

-- Conditional Aggregation with GROUP BY
-- =========================================

-- 7 Calculate Conditional Results for Each GROUP

-- You can also group the conditional aggregation by a category column

-- Show the appointment type, then the total appointments,
-- Count the completed appointments, group by appointment type

SELECT
    appointment_type,

    COUNT(*) AS total_appointments,

    SUM(
        CASE
            WHEN appointment_status = 'Completed' THEN 1
            ELSE 0
        END
    ) AS completed_appointments,

    SUM(
        CASE
            WHEN appointment_status = 'Cancelled' THEN 1
            ELSE 0
        END
    ) AS cancelled_appointments

FROM appointments
GROUP BY appointment_type;

/*
Output:
appointment_type
character varying
total_appointments
bigint
completed_appointments
bigint
cancelled_appointments
bigint
1	Sick Visit	1	1	0
2	Consultation	4	0	2
3	Annual Exam	2	2	0
4	Diagnostic Test	1	1	0
5	Follow-Up	4	2	0
*/

-- Conditional Rates and Percentages
-- =========================================

-- 8 Calculate a Conditional Percentage

-- You can calculate the conditional percentages by dividing the conditional count by 
-- the total count

SELECT
    ROUND(
        100.0
        * SUM(
            CASE
                WHEN appointment_status = 'Completed' THEN 1
                ELSE 0
            END
        )
        / COUNT(*),
        2
    ) AS completion_percentage
FROM appointments;

/*
Output:
completion_percentage
numeric
1	50.00
*/

-- Multiple Conditions
-- =========================================

-- 9 Combine Conditions with AND

-- Inside the CASE you can use the AND, OR, IN, and BETWEEN for 
-- more filtering

SELECT
    SUM(
        CASE
            WHEN appointment_status = 'Completed'
             AND copay_amount >= 50
                THEN 1
            ELSE 0
        END
    ) AS completed_high_cost_appointments
FROM appointments;

/*
Output:
completed_high_cost_appointments
bigint
1	1
*/
