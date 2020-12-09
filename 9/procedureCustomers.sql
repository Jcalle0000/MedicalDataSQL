CREATE PROCEDURE returnCustomers (@Disease VARCHAR(50) )--128 = SQL Server Maximum Column Name Length
AS
BEGIN
-- DECLARE @Disease VARCHAR(50)
-- SET @Disease = 'highblood'
    DECLARE @query NVARCHAR(MAX) -- whats this
    SET @query = 
    'SELECT customer_id, age FROM CUSTOMER_INFO WHERE seniorCitizen=' + ' ''yes''  '
     + ' AND ' + @Disease +'=' + ' ''yes''  ' + ' ORDER BY age '
    -- PRINT @query      
    -- we have to return this value

    EXEC(@query)
END
-- example
EXEC returnCustomers 'overweight'