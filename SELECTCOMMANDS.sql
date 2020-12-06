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




-- 5971
select customer_id, age, highBlood, hyperlipidemia 
    FROM CUSTOMER_INFO 
    where   
            (highBlood='YES' AND age>55) 
            OR (overweight ='YES' AND age>55) 
            OR (stroke = 'YES'  AND age>55) 
            OR (hyperlipidemia='yes' AND age>55)
GO

-- so what are the differences in these two groups?



-- returns 4236
-- patients with diseases and the age of 55 
-- so this is good
select 
    a.customer_id, a.age,
     -- we get the customer_id to be able to use it as reference and check requirements
    b.customer_id ,b.highBlood, b.overweight, b.stroke,  b.hyperlipidemia
FROM
    CUSTOMER_INFO a, CARDIAC_PATIENTS b
WHERE
        (a.customer_id=b.customer_id AND a.age>55 AND b.highBlood='yes')
    OR  (a.customer_id=b.customer_id AND a.age>55 AND b.overweight='yes')
    OR  (a.customer_id=b.customer_id AND a.age>55 AND b.stroke='yes')
    OR  (a.customer_id=b.customer_id AND a.age>55 AND b.hyperlipidemia='yes')
   
select b.customer_id from cardiac_patients b
-- a total of 6105 patients (Patients with diseases )
select * from cardiac_patients



-- results in 4236    
SELECT a.customer_id, a.age, b.highblood From CUSTOMER_INFO a, CARDIAC_PATIENTS b
    where  (a.customer_id=b.customer_id  AND  a.age>55 AND b.highBlood='YES')
            OR (a.customer_id=b.customer_id  AND  a.age>55 AND b.hyperlipidemia='YES')

SELECT * From CARDIAC_PATIENTS

-- this is correct
-- patiens inside cardiac_patients are there because they 
    -- have highblood or hyperlipidemia disease OR Both
-- Output 2032
select 
    a.customer_id, a.age,
     -- we get the customer_id to be able to use it as reference and check requirements
    b.highBlood, b.overweight, b.stroke,  b.hyperlipidemia
FROM
    CUSTOMER_INFO a, CARDIAC_PATIENTS b
WHERE
    a.age>65 AND a.customer_id=b.customer_id
    AND 
    (b.highBlood='YES' 
    OR b.overweight ='YES' 
    OR 
    b.stroke = 'YES' 
    OR 
    b.hyperlipidemia='yes')

SELECT overweight, count(*)
from INPUT_DATA
GROUP BY overweight

-- HighBlood
DECLARE @HighBloodCount AS INT 
set @HighBloodCount = (SELECT count(*) -- as 'highBloodCount'
    FROM CUSTOMER_INFO a, CARDIAC_PATIENTS b
    WHERE
        a.age>65 AND a.customer_id=b.customer_id AND b.highBlood='yes' 
    GROUP BY b.highBlood)

-- PRINT 'HighBlood Count ' + CAST(@HighBloodCount as VARCHAR) 
-- Overweight 
DECLARE @OverweightCount AS INT 
set @OverweightCount = (SELECT count(*) -- as 'OverweightCount'
    FROM CUSTOMER_INFO a, CARDIAC_PATIENTS b
    WHERE
        a.age>=65 AND a.customer_id=b.customer_id AND b.overweight='yes' 
    GROUP BY b.overweight)

-- PRINT 'Overweight Count ' + CAST(@OverweightCount as VARCHAR) 
-- Stroke
DECLARE @StrokeCount AS INT 
set @StrokeCount = (
    SELECT count(*) -- as 'OverweightCount'
    FROM CUSTOMER_INFO a, CARDIAC_PATIENTS b
    WHERE
        a.age>=65 AND a.customer_id=b.customer_id AND b.stroke='yes' 
    GROUP BY b.stroke)

-- PRINT 'Stroke Count ' + CAST(@StrokeCount as VARCHAR) 
-- Hyperlipidemia
DECLARE @HyperlipidemiaCount AS INT 
set @HyperlipidemiaCount = (
    SELECT count(*) -- as 'OverweightCount'
    FROM CUSTOMER_INFO a, CARDIAC_PATIENTS b
    WHERE
        a.age>=65 AND a.customer_id=b.customer_id AND b.hyperlipidemia='yes' 
    GROUP BY b.hyperlipidemia)

-- PRINT 'Hyperlipidemia Count ' + CAST(@HyperlipidemiaCount as VARCHAR) 

-- if( @HighBloodCount>@OverweightCount )
if( @OverweightCount>@HighBloodCount)
BEGIN 
    PRINT @OverweightCount--@HyperlipidemiaCount
END
else IF
    
ELSE print 'n'

DECLARE @temp TABLE (a INTEGER)
INSERT INTO @temp VALUES(@HighBloodCount)
INSERT INTO @temp VALUES(@OverweightCount) -- this the max
INSERT INTO @temp VALUES(@StrokeCount)
INSERT INTO @temp VALUES(@HyperlipidemiaCount)

SELECT MAX(a) FROM @temp 

select 


-- In table form
-- StrokeCount = 430
SELECT b.stroke, count(*) as 'StrokeCount'
FROM CUSTOMER_INFO a, CARDIAC_PATIENTS b
WHERE
    a.age>=65 AND a.customer_id=b.customer_id AND b.stroke='YES'
GROUP BY b.stroke

SELECT b.hyperlipidemia, count(*) as HyperlipidemiaCount
FROM CUSTOMER_INFO a, CARDIAC_PATIENTS b
WHERE
    a.age>=65 AND a.customer_id=b.customer_id AND b.hyperlipidemia='YES'
GROUP BY b.hyperlipidemia

PRINT(HyperlipidemiaCount)

SELECT COUNT(b.overweight) as OverweightCount 
FROM CARDIAC_PATIENTS b
WHERE overweight='yes'



SELECT  b.overweight 
FROM CUSTOMER_INFO a, CARDIAC_PATIENTS b
WHERE
    a.age>65 AND a.customer_id=b.customer_id
    -- AND 
    --     (b.highBlood='YES' 
    --     OR b.overweight ='YES'
GROUP BY b.overweight

SELECT b.highBlood, b.overweight, b.stroke, b.hyperlipidemia
FROM CUSTOMER_INFO a, CARDIAC_PATIENTS b
WHERE
    a.age>65 AND a.customer_id=b.customer_id
ORDER BY b.highBlood, overweight, stroke, hyperlipidemia

SELECT  a.customer_id, a.age, b.highBlood , b.overweight
FROM    CUSTOMER_INFO a, CARDIAC_PATIENTS b
WHERE
    a.age>65 AND a.customer_id=b.customer_id
    AND 
        (b.highBlood='YES' 
        OR b.overweight ='YES'
GROUP BY    
        b.highBlood --, b.overweight


-- PRINT(HighBloodCount)
-- PRINT(OverweightCount)
-- PRINT(strokeCount)
-- PRINT(HyperlipidemiaCount)

-- Ask this question 
-- By common disease for senior citizens 
-- are you refering to overweight, highblood, stroke and hyperlipidemia
-- So we would get the count for this and check for those who are above 65

select 
    a.customer_id, a.age,
     -- we get the customer_id to be able to use it as reference and check requirements
    b.highBlood, b.overweight, b.stroke,  b.hyperlipidemia
    -- MAX(COUNT(*))
FROM CUSTOMER_INFO a, CARDIAC_PATIENTS b,
WHERE    a.age>65 AND a.customer_id=b.customer_id -- AND 
--     (b.highBlood='YES' 
GROUP BY a.customer_id, a.age, b.highBlood, b.overweight, b.stroke, b.hyperlipidemia

Select customer_id
FROM CARDIAC_PATIENTS 
WHERE  customer_id IN(
        SELECT  a.customer_id --, a.age, b.highblood, 
                -- b.overweight, b.stroke,  b.hyperlipidemia
        
        FROM CUSTOMER_INFO a, CARDIAC_PATIENTS b
        WHERE a.age>65 AND a.customer_id=b.customer_id AND b.highBlood='yes' 
    )

Select customer_id
FROM CARDIAC_PATIENTS 
WHERE  customer_id IN(
        
        -- return the one with the highest 
        (
            -- HighBlood List
            Declare @HighBloodCount AS INT
            set @HighBloodCount = (
                select count(*) FROM CUSTOMER_INFO a, CARDIAC_PATIENTS b
                WHERE a.age>65 AND a.customer_id=b.customer_id AND b.highBlood='yes' 
                GROUP BY b.highBlood
            )

            PRINT 'HighBlood Count ' + CAST(@HighBloodCount as VARCHAR) 
            
            -- SELECT  a.customer_id --, a.age, b.highblood, 
            --     -- b.overweight, b.stroke,  b.hyperlipidemia
            -- FROM CUSTOMER_INFO a, CARDIAC_PATIENTS b
            -- WHERE a.age>65 AND a.customer_id=b.customer_id AND b.highBlood='yes' 
        )

        OR 
        (SELECT  a.customer_id --, a.age, b.highblood, 
                -- b.overweight, b.stroke,  b.hyperlipidemia
        
        FROM CUSTOMER_INFO a, CARDIAC_PATIENTS b
        WHERE a.age>65 AND a.customer_id=b.customer_id AND b.overweight='yes' AND b.overweight='yes')
    )

I