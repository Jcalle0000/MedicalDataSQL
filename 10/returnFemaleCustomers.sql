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