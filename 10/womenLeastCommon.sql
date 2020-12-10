-- LeastCommonDisease in women
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
    -- Continue here, work on returning these customers             -- dosent recognize @minName
    select customer_id, age from CUSTOMER_INFO where gender='female' and @MinName='yes' 
    -- EXEC 
END

exec womenLeastCommonDisease

select customer_id, age from CUSTOMER_INFO where gender='female' and stroke='yes' 