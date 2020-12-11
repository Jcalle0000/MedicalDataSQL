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


