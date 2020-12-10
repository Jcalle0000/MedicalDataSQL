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
EXECUTE returnCustomers11 'asthma'
