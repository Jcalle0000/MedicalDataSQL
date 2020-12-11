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




SELECT MAX(a) FROM @temp 

select 





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



SELECT COUNT(*) FROM CUSTOMER_INFO 
        WHERE age>65 AND asthma='yes'

-- numbers change slightly as an equal sign is needed

countFunction 'highBlood' -- 1443
countFunction 'stroke' -- 658
countFunction 'complication_risk' -- 0
countFunction 'overweight' -- 2235
countFunction 'arthritis' --1246
countFunction 'diabetes' -- 903
countFunction 'hyperlipidemia' -- 1083
countFunction 'backpain' -- 1374
countFunction 'anxiety' -- 1065
countFunction 'allergic_rhinitis' --1340
countFunction 'reflux_esophagitis' -- 1365
countFunction 'asthma' -- 0




DECLARE @tempCount as INT
DECLARE @Name as VARCHAR(100)                        -- name of nth column
SET @Name= 'highblood'
EXEC @tempCount= countFunction @Name -- this does not print
Print 'Count is  ' + cast  (@tempCount as VARCHAR)
-- Output parameters
-- https://www.sqlservertutorial.net/sql-server-stored-procedures/stored-procedure-output-parameters/

-- declare @S nvarchar(max) = 'select @x = 1'
-- declare @xx int
-- set @xx = 0
-- exec sp_executesql @S, N'@x int out', @xx out
-- select @xx

DECLARE @DiseaseInput VARCHAR(50)
SET @DiseaseInput='highblood'
declare @S nvarchar(max) = 'SELECT count(*) FROM CUSTOMER_INFO '
    + 'WHERE age>=65 AND ' + @DiseaseInput +'=' + ' ''yes''  '

declare @xx int
set @xx = 0
exec sp_executesql @S, N'@x int out', @xx out
select @xx
print 'count is '+ CAST( @xx as varchar)

-- create procedure Out_test1 (@inValue int, @OutValue int output)  
-- as   
-- begin  
--     set @OutValue = @InValue  
-- end  
Declare @var5 INT
set @var5= 5
Declare @var6 INT
EXEC Out_test1 @var5, @OutValue = @var6 OUTPUT
PRINT @var6
  

-- -- this works (start)
-- DECLARE @sqlCommand nvarchar(1000)
-- DECLARE @city varchar(75)
-- declare @counts int
-- DECLARE @disease varchar(50)
-- set @disease='highblood'
-- SET @city = '65'
--                                                                     -- this is 65
-- SET @sqlCommand = 'SELECT @cnt=COUNT(*) FROM customer_INFO WHERE age > @city AND '+ @disease + ' ='+ '''yes'' '
-- -- print @sqlCommand
-- EXECUTE sp_executesql @sqlCommand, N'@disease nvarchar(50),@city nvarchar(75),@cnt int OUTPUT ', @disease=@disease  ,@city = @city, @cnt=@counts OUTPUT
-- -- select @counts as Counts
-- print @counts
-- -- this works (end)

select  distinct asthma from CUSTOMER_INFO where LEN(asthma)=4 -- returns yes
select  distinct customer_id , asthma from CUSTOMER_INFO where LEN(asthma)=3 -- returns no
select  distinct asthma from CUSTOMER_INFO where LEN(asthma)=2 -- returns no
select   asthma from CUSTOMER_INFO where LEN(asthma)=4 -- returns 2893

select   asthma from CUSTOMER_INFO where LEN(asthma)=4 AND 
    seniorCitizen='1023'
-- returns 2893

select stroke from CUSTOMER_INFO where
stroke='yes'

select   asthma from CUSTOMER_INFO where LEN(asthma)=3 -- returns 7106
select   asthma from CUSTOMER_INFO where LEN(asthma)=2 -- returns 1
print 2893+7106+1

SELECT CUSTOMER_ID FROM CUSTOMER_INFO WHERE GENDER='FEMALE' AND highBlood='YES'

DECLARE @DiseaseInput VARCHAR(50)
SET @DiseaseInput='asthma'

DECLARE @DiseaseCount INT 
-- select customer_id, asthma from CUSTOMER_INFO where LEN(asthma)=4

SELECT COUNT(*) FROM CUSTOMER_INFO 
    WHERE AGE>=65 AND LEN(asthma)=4

select distinct len(asthma) from CUSTOMER_INFO
-- 2893
select distinct asthma from CUSTOMER_INFO where LEN(asthma)=5

select customer_id, complication_risk,  seniorCitizen, highBlood, stroke, overweight, arthritis ,diabetes, hyperlipidemia, backpain, anxiety, allergic_rhinitis, reflux_esophagitis, asthma
from CUSTOMER_INFO where complication_risk='High'

select customer_id, age FROM CUSTOMER_INFO where seniorCitizen='yes' and overweight='yes'

select distinct county from INPUT_DATA -- results in 1662
select distinct zipcode from INPUT_DATA -- results in 8662
select DISTINCT cstmr_state from INPUT_DATA -- 52 states

select distinct zipcode, county from INPUT_DATA -- results in 8662
select distinct zipcode, city, cstmr_state, county from INPUT_DATA --8662
select distinct zipcode, city, cstmr_state, county from INPUT_DATA --8662
select distinct zipcode, customer_id  FROM INPUT_DATA

select distinct state_population from INPUT_DATA -- results in 8662

select *FROM INPUT_DATA WHERE customer_id='C412403'
select distinct city from INPUT_DATA -- 6085 cities


select *from state_city -- 7689 rows
 
select county,   COUNT(*) from INPUT_DATA 
    GROUP BY county, zipcode HAVING COUNT(*)>1

-- results in 1206 rows that have more than duplicate 


select * from INPUT_DATA where zipcode='29684'