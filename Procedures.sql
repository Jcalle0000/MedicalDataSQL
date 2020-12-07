CREATE PROCEDURE countFunction @Disease NVARCHAR(128)--128 = SQL Server Maximum Column Name Length
AS
BEGIN

    DECLARE @query NVARCHAR(MAX) -- whats this
    
    SET @query = 
    'SELECT count(*) FROM CUSTOMER_INFO '
    + 'WHERE age>65 AND ' + @Disease +'=' + ' ''yes''  '
    -- PRINT @query
    EXEC(@query)

END

EXEC countFunction 'Arthritis' -- this returns a count
EXEC countFunction 'highblood'


-- PROTOTYPE
print(CHAR(13))
-- PRINT ('Most Common Disease In Senior Citizens 65 and up')
DECLARE @MaxColumns AS INT                                    -- amount of columns  
SET @MaxColumns = (
    select COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
    where TABLE_Name='CUSTOMER_INFO'
)
PRINT('Columns Count '+  CAST(@MaxColumns as VARCHAR)  )     
DECLARE @Counter INT 
SET @Counter=8                                             -- starting from nth column
Declare @TableName as VARCHAR(100)                         -- table name
SET @TableName = 'CUSTOMER_INFO'
DECLARE @NthColumn AS INT
DECLARE @Name as VARCHAR(100)                        -- name of nth column
DECLARE @tempCount as INT
DECLARE @MaxCount as int
-- DECLARE @currentDisease as VARCHAR(50)

WHILE ( @Counter <= @MaxColumns)
BEGIN
    -- PRINT 'The counter value is = ' + CONVERT(VARCHAR,@Counter)
    SELECT @TableName = N'CUSTOMER_INFO', @NthColumn=@Counter
    SET @Name= ( SELECT COL_NAME( OBJECT_ID(@TableName),@NthColumn ) ColumnName)
    PRINT ('Name '+ @Name)
    EXEC countFunction 'Arthritis'

    SET @Counter  = @Counter  + 1

    -- EXEC countFunction
END
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

oh no