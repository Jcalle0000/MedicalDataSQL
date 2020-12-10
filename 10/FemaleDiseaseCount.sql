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

DECLARE @Out int
EXECUTE FemaleDiseaseCount 'highblood', @DiseaseCount=@Out OUTPUT 
                            -- have to specify output or else it wont print
print @Out

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
                    -- basically we print whenever we find a new max number
                    -- PRINT 'New MaxCount is ' + CAST( @MaxCount as VARCHAR)
                    -- print ''
                END
        END
PRINT ''
PRINT CAST(@MinName as VARCHAR) + ' is the least common disease in women with a count of ' + CAST( @MinCount as VARCHAR)

select customer_id, gender, asthma from INPUT_DATA 
where asthma = 'Yes' -- OR asthma= 'YES' OR asthma= 'yes'

select customer_id, gender, asthma from CUSTOMER_INFO -- 10000

select customer_id, gender, asthma from CUSTOMER_INFO -- 4832
WHERE gender='female' 

