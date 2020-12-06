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

EXEC countFunction 'highblood'


