-- Select Commands

SELECT *From CUSTOMER_INFO
SELECT *From CUSTOMER_ADDRESS

select distinct diabetes from INPUT_DATA
select distinct hyperlipidemia from INPUT_DATA
select distinct backPain from INPUT_DATA
select distinct anxiety from INPUT_DATA
select distinct allergic_rhinitis from INPUT_DATA
select distinct reflux_esophagitis from INPUT_DATA
select distinct asthma from INPUT_DATA

select distinct gender from INPUT_DATA


select customer_id from INPUT_DATA

V283504
select *from INPUT_DATA WHERE customer_id='V283504'

-- lets find the count for this

--4090
 SELECT customer_id, highBlood, overweight, stroke, hyperlipidemia 
 FROM customer_INFO  
    WHERE highBlood='Yes'

 SELECT customer_id, highBlood, overweight, stroke, hyperlipidemia 
 FROM customer_INFO  
    WHERE highBlood='Yes'

select customer_id, highBlood from cardiac_patients where highBlood='Yes'

-- 3372
select customer_id, highBlood, overweight, stroke, hyperlipidemia 
FROM CUSTOMER_INFO where hyperlipidemia='YES' 

--1357
select customer_id, highBlood, overweight, stroke, hyperlipidemia 
FROM CUSTOMER_INFO where hyperlipidemia='YES' AND highBlood='YES'

-- 6105
select customer_id, highBlood, overweight, stroke, hyperlipidemia 
FROM CUSTOMER_INFO where hyperlipidemia='YES' OR highBlood='YES' 
-- 6105 no age requirements here
select customer_id, highBlood, overweight, stroke, hyperlipidemia 
FROM cardiac_Patients where hyperlipidemia='YES' OR highBlood='YES' 

select customer_id, age, highBlood, hyperlipidemia 
    FROM CUSTOMER_INFO 
    where   
            (highBlood='YES' AND age>55) OR
            (overweight ='YES' AND age>55) OR
            (stroke = 'YES'  AND age>55) OR
            (hyperlipidemia AND age>55)

-- 5971
select customer_id, age, highBlood, hyperlipidemia 
    FROM CUSTOMER_INFO 
    where   
            (highBlood='YES' AND age>55) 
            OR (overweight ='YES' AND age>55) 
            OR (stroke = 'YES'  AND age>55) 
            OR (hyperlipidemia='yes' AND age>55)
GO

select 
    a.customer_id, a.age,
     -- we get the customer_id to be able to use it as reference and check requirements
    b.highBlood, b.overweight, b.stroke,  b.hyperlipidemia
FROM
    CUSTOMER_INFO a, CARDIAC_PATIENTS b
WHERE
    a.customer_id=b.customer_id AND a.age>55 
    AND 
    (b.highBlood='YES' OR b.overweight ='YES' 
    OR b.stroke = 'YES' OR b.hyperlipidemia='yes')



-- Generate a list of patients with customer_id ordered by age
-- showing which is the most common disease among senior citizes
-- Requirements: Senior citizens have to be at least 55?
-- Generates 6451
SELECT customer_id, age From customer_info where age>55

-- we get the customer_id and the check to see if its in the cardiac patients table
-- if it is we we check to see if it has high blood pressure

-- results in 3107 rows
SELECT a.customer_id, a.age, b.highblood From CUSTOMER_INFO a, CARDIAC_PATIENTS b
    where  a.customer_id=b.customer_id  AND  a.age>55 AND b.highBlood='YES'

-- results in 4236    
SELECT a.customer_id, a.age, b.highblood From CUSTOMER_INFO a, CARDIAC_PATIENTS b
    where  (a.customer_id=b.customer_id  AND  a.age>55 AND b.highBlood='YES')
            OR (a.customer_id=b.customer_id  AND  a.age>55 AND b.hyperlipidemia='YES')

