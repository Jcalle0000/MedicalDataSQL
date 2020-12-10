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

EXEC MostCommonDisease


