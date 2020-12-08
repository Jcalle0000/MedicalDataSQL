-- CREATE PROCEDURE countFunction @Disease NVARCHAR(128)--128 = SQL Server Maximum Column Name Length
-- AS
-- BEGIN
--     DECLARE @query NVARCHAR(MAX) -- whats this
--     SET @query = 
--     'SELECT count(*) FROM CUSTOMER_INFO '
--     + 'WHERE age>=65 AND ' + @Disease +'=' + ' ''yes''  '
--     -- PRINT @query      
--     -- we have to return this value

--     EXEC(@query)
-- END

-- -- Demonstration of CountFunction
-- EXEC countFunction 'Arthritis' -- this returns a count
-- EXEC countFunction 'highblood'
-- DECLARE @tempCount  INT
-- EXEC @tempCount= countFunction 'Arthritis' -- saving the return value to a local variable
-- print ' the count is  '+ CAST( @tempCount as VARCHAR ) -- print 0

-- THIS WORKS (STORED PROCEDURE THAT RETURNS VALUE - START) 2nd iteration
CREATE PROCEDURE countFunction2 (@DiseaseInput VARCHAR(50), @DiseaseCount INT OUTPUT )
AS -- do we need an alias?
BEGIN
    -- now we want to see why it works 
    DECLARE @sqlCommand nvarchar(1000)
    -- declare @counts int
    -- DECLARE @disease varchar(50)
    -- set @disease='highblood'
                                                                        -- this is 65
    SET @sqlCommand = 'SELECT @DiseaseCount=COUNT(*) FROM customer_INFO WHERE age >= 65 AND '+ @DiseaseInput + ' ='+ '''yes'' '
    -- print @sqlCommand
    EXECUTE sp_executesql @sqlCommand, N'@DiseaseInput nvarchar(50), @DiseaseCount int OUTPUT ', @DiseaseInput=@DiseaseInput, @DiseaseCount=@DiseaseCount OUTPUT

    -- select @counts as Counts
    -- print @counts
END

DECLARE @var11  VARCHAR(50)
set @var11 = 'highBlood'
DECLARE @var12  INT
EXEC countFunction2 @var11, @DiseaseCount=@var12 OUTPUT
PRINT @VAR12
-- THIS WORKS (STORED PROCEDURE THAT RETURNS VALUE - END)


-- PROTOTYPE for 3nd procedure
print(CHAR(13))
-- PRINT ('Most Common Disease In Senior Citizens 65 and up')
DECLARE @MaxColumns AS INT                                    -- amount of columns  
SET @MaxColumns = ( select COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS where TABLE_Name='CUSTOMER_INFO')
PRINT('Columns Count '+  CAST(@MaxColumns as VARCHAR)  )     
DECLARE @Counter INT 
SET @Counter=8                                             -- starting from 8th column
Declare @TableName as VARCHAR(100)                         -- table name
SET @TableName = 'CUSTOMER_INFO'
DECLARE @NthColumn AS INT
DECLARE @Name as VARCHAR(100)                              -- name of nth column
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
                -- basically we print whenever we find a new max number
                -- PRINT 'New MaxCount is ' + CAST( @MaxCount as VARCHAR)
                -- print ''
            END
    END
print ''
PRINT 'MaxCount is ' + CAST( @MaxCount as VARCHAR)
print(CHAR(13)); print(CHAR(13))


-- Grabbing the name of the column
-- https://social.msdn.microsoft.com/Forums/sqlserver/en-US/bbae3471-6694-4502-b27c-33db18c5dc1b/get-nth-column-in-a-table?forum=transactsql

-- what i want to do (start)
DECLARE @Name as VARCHAR(100)  
set @Name='Arthritis'
EXEC countFunction @Name
DECLARE @tempCount as INT
SET @tempCount = EXEC countFunction @Name
-- what i want to do (end)

SELECT COLUMN_NAME AS columns
FROM INFORMATION_SCHEMA.COLUMNS 
    WHERE TABLE_NAME ='customer_info'

-- Starting at the nth column
DECLARE @TableName as nVarchar(100);
DECLARE @NthColumn as Int

--we are fetching 1st column here.

SELECT 
@TableName =N'CUSTOMER_INFO',
@NthColumn=4 --Change if necessary

DECLARE @ColumnName as varchar(100);
SELECT @ColumnName = Col_name(object_id(@TableName),@NthColumn); 

EXEC ('SELECT ' + @ColumnName + ' FROM ' + @TableName);

 create proc myproc
 as 
 begin
     return 1
 end

 go
 declare @i int
 exec @i = myproc
print @i

