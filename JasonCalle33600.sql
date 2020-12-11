CREATE DATABASE MEDICAL_INFO
GO

-- related to customer's data
CREATE TABLE INPUT_DATA(
    customer_id         VARCHAR(50)     NOT NULL PRIMARY KEY,
    zipcode             VARCHAR(50),
    city                VARCHAR(50),
    cstmr_state         VARCHAR(50),
    state_population    INT,
    county              VARCHAR(50),
    area                VARCHAR(50),
    job                 VARCHAR(250), -- they can have various jobs
    age                 INT,
    education           VARCHAR(50),
    employment          VARCHAR(50),
    martial             VARCHAR(50),
    gender              VARCHAR(50),
    seniorCitizen       VARCHAR(50),
    highBlood           VARCHAR(50),        
    stroke              VARCHAR(50),
    complication        VARCHAR(50), -- lets move this 
    overweight          VARCHAR(50),
    arthritis           VARCHAR(50),
    diabetes            VARCHAR(50),
    hyperlipidemia	    VARCHAR(50),
    backPain	        VARCHAR(50),
    anxiety	            VARCHAR(50),
    allergic_rhinitis	VARCHAR(50),
    reflux_esophagitis	VARCHAR(50),
    asthma              VARCHAR(4)
)
go
-- copy  input_Data2 FROM '/Med-data.csv'
-- go
-- select * from INPUT_DATA
BULK INSERT INPUT_DATA 
    FROM '\Med-dataOG.csv' 
    -- FROM 'C:\Users\jasoncalle\Desktop\Books\Backend\SQL\Project4MedicalData\Med-DataOG.csv'
    WITH(
        FORMAT='CSV',
        FIRSTROW=2,
        FIELDTERMINATOR=',',
        ROWTERMINATOR='0x0a'
        -- ROWTERMINATOR='\n'
    );
GO 

-- TABLE 1
CREATE TABLE CUSTOMER_INFO
(
    customer_id     VARCHAR(20)     NOT NULL PRIMARY KEY, -- ID HAS LETTERS
    employment      VARCHAR(250),
    education       VARCHAR(250),
    -- this could all be turned into a combination
    -- with an identity but would make 122,880 combination
    martial         VARCHAR(15), -- Married, Separated, Divorced, Widowed, Never Married 
    gender          VARCHAR(15), -- Male, Female
    age             VARCHAR(15),
    seniorCitizen   VARCHAR(15),-- From here its all yes/no
    complication_risk VARCHAR(15), -- lets move this
    highBlood       VARCHAR(15),   -- 9th column
    stroke          VARCHAR(15),
    overweight      VARCHAR(15),
    arthritis      VARCHAR(15),
    diabetes        VARCHAR(15),
    hyperlipidemia      VARCHAR(15),
    backpain      VARCHAR(15),
    anxiety      VARCHAR(15),
    allergic_rhinitis   VARCHAR(15),
    reflux_esophagitis  VARCHAR(15),
    asthma          VARCHAR(15)
)
GO

INSERT INTO CUSTOMER_INFO
    SELECT customer_id, employment, education
    , martial, gender,age , seniorCitizen, complication , highBlood, stroke
    , overweight, arthritis, diabetes, hyperlipidemia
    , backPain, anxiety, allergic_rhinitis, reflux_esophagitis, asthma
        FROM INPUT_DATA
GO

-- select *FROM CUSTOMER_INFO
-- 10,000 customers -> 10,000 rows

-- TABLE 2
-- from the zipcode you can identify the city, county, population, area
CREATE TABLE CUSTOMER_ADDRESS(
    zipcode             INT           NOT NULL,   -- 8662 distinct zipcodes
    city                VARCHAR(50),              -- 6085 cities
    county              VARCHAR(50),              -- 1662 counties
    zipcode_state       VARCHAR(2),               -- 52               
    zipcode_population    INT       ,             -- 6001
    area                VARCHAR(50),
    customer_id         VARCHAR(20)   NOT NULL        ,
    -- PRIMARY KEY(zipcode),
    FOREIGN KEY(customer_id) REFERENCES CUSTOMER_INFO(customer_id),
    -- 1:N relation
    -- a customer can have various locations at worst case

    -- an intresting case would be when the customer has two houses 
    -- in the same zipcode
    CONSTRAINT PK_Customer_Address PRIMARY KEY(zipcode, customer_id)
    -- primary key makes the combination have to be unique
)
GO
INSERT INTO CUSTOMER_ADDRESS
    -- these are the names from the INPUT_DATA
    SELECT zipcode, city, county, cstmr_state, state_population, 
    area, customer_id 
    FROM INPUT_DATA
GO

-- table 3
-- lets verify this relation late
CREATE TABLE CARDIAC_PATIENTS(
    patient_id          INT IDENTITY(1,1) NOT NULL, -- start with index 1 and increment by 1
    customer_id         VARCHAR(20)       NOT NULL  UNIQUE ,
    highBlood          VARCHAR(15),
    overweight      VARCHAR(15),
    stroke          VARCHAR(15),
    hyperlipidemia      VARCHAR(15),

    PRIMARY KEY(patient_id),
    -- patient should not be allowed to have two records
    -- thats why customer_id is set to unique IF YOU TRY to insert you get duplicate key
    FOREIGN KEY (customer_id) REFERENCES CUSTOMER_INFO(customer_id),
    -- basically customer_id and patient are the primary key
)
GO

INSERT INTO CARDIAC_PATIENTS
    SELECT customer_id, highBlood, overweight, stroke, hyperlipidemia 
    FROM CUSTOMER_INFO where hyperlipidemia='YES' OR highBlood='YES'
GO
-- 6105 patients
-- THIS WORKS (STORED PROCEDURE THAT RETURNS VALUE - START) 2nd iteration
CREATE PROCEDURE countFunction2 (@DiseaseInput VARCHAR(50), @DiseaseCount INT OUTPUT )
AS -- do we need an alias?
BEGIN
    -- now we want to see why it works 
    -- DECLARE @DiseaseInput VARCHAR(50) -- for prototype purposes
    -- SET @DiseaseInput='asthma'        --  for prototype purposes
    -- DECLARE @DiseaseCount INT         --  for prototype purposes
    DECLARE @sqlCommand nvarchar(1000)
    -- declare @counts int
    -- DECLARE @disease varchar(50)
    -- set @disease='highblood'
    if(@DiseaseInput='asthma')
        BEGIN
        SET @sqlCommand = 'SELECT @DiseaseCount=COUNT(*) FROM customer_INFO WHERE LEN(asthma)=4 AND seniorCitizen='+ '''yes'' '
        -- print @sqlCommand --  for prototype purposes
        EXECUTE sp_executesql @sqlCommand, N'@DiseaseInput nvarchar(50), @DiseaseCount int OUTPUT ', @DiseaseInput=@DiseaseInput, @DiseaseCount=@DiseaseCount OUTPUT
        END
    ELSE
        BEGIN                                                                 
        SET @sqlCommand = 'SELECT @DiseaseCount=COUNT(*) FROM customer_INFO WHERE '+ @DiseaseInput + '='+ '''yes'' ' + 'AND seniorCitizen='+ '''yes'' '
    -- print @sqlCommand --  for prototype purposes
        EXECUTE sp_executesql @sqlCommand, N'@DiseaseInput nvarchar(50), @DiseaseCount int OUTPUT ', @DiseaseInput=@DiseaseInput, @DiseaseCount=@DiseaseCount OUTPUT
        END
    -- PRINT @DiseaseCount --  for prototype purposes
END

-- example of how it works
-- DECLARE @var11  VARCHAR(50)
-- set @var11 = 'highblood'
-- DECLARE @var12  INT
-- EXEC countFunction2 @var11, @DiseaseCount=@var12 OUTPUT
-- PRINT @VAR12
-- THIS WORKS (STORED PROCEDURE THAT RETURNS VALUE - END)

CREATE PROCEDURE returnCustomers (@DiseaseInput VARCHAR(50) )--128 = SQL Server Maximum Column Name Length
AS
BEGIN
    -- DECLARE @DiseaseInput VARCHAR(50)
    -- SET @DiseaseInput = 'highblood'
    DECLARE @sqlCommand NVARCHAR(MAX) -- whats this
    -- SET @query = 
    -- 'SELECT customer_id, age FROM CUSTOMER_INFO WHERE seniorCitizen=' + ' ''yes''  '
    --  + ' AND ' + @Disease +'=' + ' ''yes''  ' + ' ORDER BY age '
    -- PRINT @query      
    -- we have to return this value

      if(@DiseaseInput='asthma')
        BEGIN
        SET @sqlCommand = 'SELECT customer_id, age FROM customer_INFO WHERE LEN(asthma)=4 AND seniorCitizen='+ '''yes'' '
        + ' ORDER BY age '
        -- print @sqlCommand --  for prototype purposes
        -- EXECUTE sp_executesql @sqlCommand, N'@DiseaseInput nvarchar(50), @DiseaseCount int OUTPUT ', @DiseaseInput=@DiseaseInput, @DiseaseCount=@DiseaseCount OUTPUT
        END
    ELSE
        BEGIN                                                                 
        SET @sqlCommand = 'SELECT customer_id, age FROM customer_INFO WHERE '+ @DiseaseInput + '='+ '''yes'' ' + 'AND seniorCitizen='+ '''yes'' '
        + ' ORDER BY age '
    -- print @sqlCommand --  for prototype purposes
        -- EXECUTE sp_executesql @sqlCommand, N'@DiseaseInput nvarchar(50), @DiseaseCount int OUTPUT ', @DiseaseInput=@DiseaseInput, @DiseaseCount=@DiseaseCount OUTPUT
        END
    -- PRINT @DiseaseCount --  for prototype purposes

    EXEC(@sqlCommand)
END
-- example
-- EXEC returnCustomers 'highblood'

-- Algorithm returning everything all of the senior citizens with most common disease

-- PROTOTYPE for 3nd procedure
CREATE procedure MostCommonDisease 
AS
BEGIN
    print(CHAR(13))
    -- PRINT ('Most Common Disease In Senior Citizens 65 and up')
    DECLARE @MaxColumns AS INT                                    -- amount of columns  
    SET @MaxColumns = ( select COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS where TABLE_Name='CUSTOMER_INFO')
    PRINT('Columns Count '+  CAST(@MaxColumns as VARCHAR)  )     
    DECLARE @Counter INT 
    SET @Counter=9                                             -- starting from 8th column
    Declare @TableName as VARCHAR(100)                         -- table name
    SET @TableName = 'CUSTOMER_INFO'
    DECLARE @NthColumn AS INT
    DECLARE @Name as VARCHAR(100)                              -- name of nth column
    DECLARE @MaxName as VARCHAR(100)                            -- name of nth column
    DECLARE @tempCount as INT
    DECLARE @MaxCount as int
    set @MaxCount = 0
    WHILE ( @Counter <= @MaxColumns)
        BEGIN
                                            -- starting from the 8th column
            SELECT @TableName = N'CUSTOMER_INFO', @NthColumn=@Counter
            SET @Name= ( SELECT COL_NAME( OBJECT_ID(@TableName),@NthColumn ) ColumnName)
            -- EXEC countFunction 'Arthritis'
            -- EXEC @tempCount= countFunction @Name -- this does not print
            EXEC countFunction2 @Name, @DiseaseCount=@tempCount OUTPUT
            print @Name + ' count ' + CAST(@tempCount AS VARCHAR)
            SET @Counter  = @Counter  + 1
            if(@tempCount > @MaxCount)
                BEGIN
                    set @MaxCount = @tempCount
                    set @MaxName = @Name
                    -- basically we print whenever we find a new max number
                    -- PRINT 'New MaxCount is ' + CAST( @MaxCount as VARCHAR)
                    -- print ''
                END
    END -- end of while loop too

    print ''
    -- PRINT 'MaxCount is ' + CAST( @MaxCount as VARCHAR) + ' for column name '+ CAST(@MaxName as VARCHAR)
    PRINT CAST(@MaxName as VARCHAR) + ' is the most common disease in senior citzens with a count of ' + CAST( @MaxCount as VARCHAR)
    print(CHAR(13) ); 
    EXEC returnCustomers @MaxName 
END -- end of MostCommonDisease Procedure

-- to execute 
-- EXEC MostCommonDisease

-- PART 10
-- 10.	Generate a list of patients with name, 
--ordered by AGE, showing which is the least common 
-- disease amongst Female Patients.

CREATE PROCEDURE FemaleDiseaseCount ( @DiseaseInput VARCHAR(50),@DiseaseCount INT OUTPUT )
AS
BEGIN
      -- now we want to see why it works 
    -- DECLARE @DiseaseInput VARCHAR(50) -- for prototype purposes
    -- SET @DiseaseInput='highblood'        --  for prototype purposes
    -- DECLARE @DiseaseCount INT         --  for prototype purposes
    DECLARE @sqlCommand nvarchar(1000)
    -- declare @counts int
    -- DECLARE @disease varchar(50)
    -- set @disease='highblood'
    if(@DiseaseInput='asthma')
        BEGIN
        SET @sqlCommand = 'SELECT @DiseaseCount=COUNT(*) FROM customer_INFO WHERE LEN(asthma)=4 AND gender='+ '''female'' '
        -- print @sqlCommand --  for prototype purposes
        EXECUTE sp_executesql @sqlCommand, N'@DiseaseInput nvarchar(50), @DiseaseCount int OUTPUT ', @DiseaseInput=@DiseaseInput, @DiseaseCount=@DiseaseCount OUTPUT
        END
    ELSE
        BEGIN      
        SET @sqlCommand = 'SELECT @DiseaseCount=COUNT(*) FROM customer_INFO WHERE gender='+ '''Female''' + ' AND ' + @DiseaseInput + '='+ '''yes'' ' 
        -- print @sqlCommand --  for prototype purposes
        EXECUTE sp_executesql @sqlCommand, N'@DiseaseInput nvarchar(50), @DiseaseCount int OUTPUT ', @DiseaseInput=@DiseaseInput, @DiseaseCount=@DiseaseCount OUTPUT
        -- PRINT @DiseaseCount --  for prototype purposes
        END
    -- PRINT @DiseaseCount --  for prototype purposes
END -- END OF PROCEDURE

-- Example
-- DECLARE @Out int
-- EXECUTE FemaleDiseaseCount 'highblood', @DiseaseCount=@Out OUTPUT 
--                             -- have to specify output or else it wont print
-- print @Out


-- part 10 - (2/3)
-- return female customers with a certain disease
CREATE PROCEDURE returnFemaleCustomers(@DiseaseInput VARCHAR(50) )
AS 
BEGIN
    -- DECLARE @DiseaseInput VARCHAR(50) -- prototype purpose
    -- SET @DiseaseInput = 'highblood'   -- prototype purpose
    DECLARE @sqlCommand NVARCHAR(MAX) 
    if(@DiseaseInput='asthma')
        BEGIN
            SET @sqlCommand = 'SELECT customer_id, age FROM customer_INFO WHERE LEN(asthma)=4 AND gender='+ '''Female'' '
            + 'ORDER BY age'
        END
    ELSE
        BEGIN
            SET @sqlCommand = 'SELECT customer_id, age FROM customer_INFO WHERE gender='+ '''Female'' '
            + 'AND '+ @DiseaseInput + '='+ '''yes''' +  ' ORDER BY age'
        END
    
    -- PRINT @sqlCommand
    Execute(@sqlCommand)
END

-- example
-- execute returnFemaleCustomers 'stroke'
-- LeastCommonDisease in women
-- 10 (3/3)
CREATE PROCEDURE womenLeastCommonDisease
AS 
BEGIN
    print(CHAR(13))
    -- Least common disease among female
    DECLARE @MaxColumns AS INT                                    -- amount of columns  
    SET @MaxColumns = ( select COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS where TABLE_Name='CUSTOMER_INFO')
    -- Going from 9 to 19 => iterating through 11 columns (Diseases)
    -- PRINT('Columns Count '+  CAST(@MaxColumns as VARCHAR)  )     
    DECLARE @Counter INT 
    SET @Counter=9                                             -- starting from 9th column
    Declare @TableName as VARCHAR(100)                         -- table name
    SET @TableName = 'CUSTOMER_INFO'
    DECLARE @NthColumn AS INT       -- this is probably not needed
    DECLARE @Name as VARCHAR(50)                              -- name of nth column
    DECLARE @MinName as VARCHAR(50)                            -- name of nth column
    DECLARE @tempCount as INT
    DECLARE @MinCount as int
    set @MinCount = 1000000000 -- largest number i could before overflow
    WHILE ( @Counter <= @MaxColumns)
    BEGIN
                                            -- starting from the 9th column
            SELECT @TableName = N'CUSTOMER_INFO', @NthColumn=@Counter
            -- PRINT 'TableName is '+@TableName -- just to see what this is
            SET @Name= ( SELECT COL_NAME( OBJECT_ID(@TableName),@NthColumn ) ColumnName)
            EXEC FemaleDiseaseCount @Name, @DiseaseCount=@tempCount OUTPUT
            print @Name + ' count ' + CAST(@tempCount AS VARCHAR)
            SET @Counter  = @Counter  + 1
            if(@tempCount < @MinCount)
                BEGIN
                    set @MinCount = @tempCount
                    set @MinName = @Name
                END
    END -- END OF WHILE LOOP
    PRINT ''
    PRINT CAST(@MinName as VARCHAR) + ' is the least common disease in women with a count of ' + CAST( @MinCount as VARCHAR)
    PRINT ''
    EXEC returnFemaleCustomers @MinName
END
-- example
-- exec womenLeastCommonDisease
-- Part 11

-- QUESTION 11 PART 1/3
CREATE PROCEDURE diseaseCount11(@DiseaseInput VARCHAR(50), @DiseaseCount INT OUTPUT)
AS
BEGIN
    -- DECLARE @DiseaseInput VARCHAR(50) -- for prototype purposes
    -- SET @DiseaseInput='asthma'        --  for prototype purposes
    -- DECLARE @DiseaseCount INT         --  for prototype purposes
    DECLARE @sqlCommand nvarchar(1000)

    IF(@DiseaseInput='asthma')
        BEGIN
            SET @sqlCommand = 'SELECT @DiseaseCount=COUNT(*) FROM customer_INFO WHERE LEN(asthma)=4' 
        END
    -- print @sqlCommand --  for prototype purposes
    
    ELSE
        BEGIN
            SET @sqlCommand = 'SELECT @DiseaseCount=COUNT(*) FROM customer_INFO WHERE '+ @DiseaseInput+'=' + '''yes''' 
        END
    
    EXECUTE sp_executesql @sqlCommand, N'@DiseaseInput nvarchar(50), @DiseaseCount int OUTPUT ', @DiseaseInput=@DiseaseInput, @DiseaseCount=@DiseaseCount OUTPUT
    -- PRINT @DiseaseCount
END

-- example
-- DECLARE @cnt INT
-- EXEC diseaseCount11 'asthma', @DiseaseCount=@cnt OUTPUT
-- PRINT @cnt

-- 11 part 2/3
CREATE PROCEDURE returnCustomers11(@DiseaseInput VARCHAR(50) )
AS
BEGIN
    -- DECLARE @DiseaseInput VARCHAR(50) -- prototype purpose
    -- SET @DiseaseInput = 'stroke'   -- prototype purpose
    DECLARE @sqlCommand NVARCHAR(MAX) 
    if(@DiseaseInput='asthma')
        BEGIN
            SET @sqlCommand = 'SELECT customer_id, age FROM customer_INFO WHERE LEN(asthma)=4 '
            + 'ORDER BY age'
        END
    ELSE
        BEGIN
            SET @sqlCommand = 'SELECT customer_id, age FROM customer_INFO WHERE '
            + @DiseaseInput + '='+ '''yes''' +  ' ORDER BY age'
        END
    
    -- PRINT @sqlCommand
    Execute(@sqlCommand)
END

-- example
-- EXECUTE returnCustomers11 'asthma'

-- 11 part 3/3
CREATE PROCEDURE mostCommonDiseaseInAllCustomers11
AS
BEGIN
    print(CHAR(13))
    -- PRINT ('Most Common Disease In Senior Citizens 65 and up')
    DECLARE @MaxColumns AS INT                                    -- amount of columns  
    SET @MaxColumns = ( select COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS where TABLE_Name='CUSTOMER_INFO')
    PRINT('Columns Count '+  CAST(@MaxColumns as VARCHAR)  )     
    DECLARE @Counter INT 
    SET @Counter=9                                             -- starting from 8th column
    Declare @TableName as VARCHAR(100)                         -- table name
    SET @TableName = 'CUSTOMER_INFO'
    DECLARE @NthColumn AS INT
    DECLARE @Name as VARCHAR(100)                              -- name of nth column
    DECLARE @MaxName as VARCHAR(100)                            -- name of nth column
    DECLARE @tempCount as INT
    DECLARE @MaxCount as int
    set @MaxCount = 0
    WHILE ( @Counter <= @MaxColumns)
    BEGIN
                                            -- starting from the 8th column
            SELECT @TableName = N'CUSTOMER_INFO', @NthColumn=@Counter
            SET @Name= ( SELECT COL_NAME( OBJECT_ID(@TableName),@NthColumn ) ColumnName)
            -- EXEC countFunction 'Arthritis'
            -- EXEC @tempCount= countFunction @Name -- this does not print
            EXEC diseaseCount11 @Name, @DiseaseCount=@tempCount OUTPUT
            print @Name + ' count ' + CAST(@tempCount AS VARCHAR)
            SET @Counter  = @Counter  + 1
            if(@tempCount > @MaxCount)
                BEGIN
                    set @MaxCount = @tempCount
                    set @MaxName = @Name
                    -- basically we print whenever we find a new max number
                    -- PRINT 'New MaxCount is ' + CAST( @MaxCount as VARCHAR)
                    -- print ''
                END
    END -- end of while loop too
    print ''
    -- PRINT 'MaxCount is ' + CAST( @MaxCount as VARCHAR) + ' for column name '+ CAST(@MaxName as VARCHAR)
    PRINT CAST(@MaxName as VARCHAR) + ' is the most common disease found in all customers with a count of ' + CAST( @MaxCount as VARCHAR)
    print(CHAR(13) ); 
    EXEC returnCustomers11 @MaxName 
END

-- EXEC mostCommonDiseaseInAllCustomers11
-- returns 7094 (overweight)

-- part 12

CREATE PROCEDURE patients12
AS
BEGIN
    CREATE table #tempCustomers( 
        currentCustomers varchar(50)
    )

    insert into #tempCustomers
    --case 1
    select customer_id FROM CUSTOMER_INFO
    WHERE anxiety='yes' AND overweight='yes' AND reflux_esophagitis='yes' 
    AND allergic_rhinitis='yes' AND len(asthma)=4 
    UNION ALL
    -- CASE 2 - returns 1953
        select customer_id FROM CUSTOMER_INFO
        WHERE (anxiety='yes' AND overweight='yes'AND reflux_esophagitis='yes') 
        OR ( allergic_rhinitis='yes' AND LEN(asthma)=4 )
    UNION ALL
    -- CASE 3  returns 6057
    select customer_id FROM CUSTOMER_INFO
        WHERE (anxiety='yes' AND overweight='yes'AND reflux_esophagitis='yes') 
        OR allergic_rhinitis='yes'
        OR len(asthma)='4'
    UNION ALL
    -- CASE 4  returns 3162
    select customer_id FROM CUSTOMER_INFO
        WHERE (anxiety='yes' AND overweight='yes'AND reflux_esophagitis='yes'
        AND allergic_rhinitis='yes') OR len(asthma)=4 
    UNION ALL
    -- CASE 5 returns 4102
    select customer_id FROM CUSTOMER_INFO
        WHERE (anxiety='yes' AND overweight='yes'AND reflux_esophagitis='yes' AND len(asthma)=4) 
            OR (allergic_rhinitis='yes')
    
    select distinct * from #tempCustomers
END

-- example
-- EXEC patients12





