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
EXEC returnCustomers 'highblood'