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



