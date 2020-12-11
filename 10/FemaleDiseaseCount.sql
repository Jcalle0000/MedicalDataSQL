-- 10.	Generate a list of patients with name, 
--ordered by AGE, showing which is the least common 
-- disease amongst Female Patients.
-- part 10 (1/3)
CREATE PROCEDURE FemaleDiseaseCount ( @DiseaseInput VARCHAR(50),@DiseaseCount INT OUTPUT )
AS
BEGIN
      -- now we want to see why it works 
    -- DECLARE @DiseaseInput VARCHAR(50) -- for prototype purposes
    -- SET @DiseaseInput='highblood'        --  for prototype purposes
    -- DECLARE @DiseaseCount INT         --  for prototype purposes
    DECLARE @sqlCommand nvarchar(1000)
    -- declare @counts int
    -- DECLARE @disease varchar(50)
    -- set @disease='highblood'
    if(@DiseaseInput='asthma')
        BEGIN
        SET @sqlCommand = 'SELECT @DiseaseCount=COUNT(*) FROM customer_INFO WHERE LEN(asthma)=4 AND gender='+ '''female'' '
        -- print @sqlCommand --  for prototype purposes
        EXECUTE sp_executesql @sqlCommand, N'@DiseaseInput nvarchar(50), @DiseaseCount int OUTPUT ', @DiseaseInput=@DiseaseInput, @DiseaseCount=@DiseaseCount OUTPUT
        END
    ELSE
        BEGIN      
        SET @sqlCommand = 'SELECT @DiseaseCount=COUNT(*) FROM customer_INFO WHERE gender='+ '''Female''' + ' AND ' + @DiseaseInput + '='+ '''yes'' ' 
        -- print @sqlCommand --  for prototype purposes
        EXECUTE sp_executesql @sqlCommand, N'@DiseaseInput nvarchar(50), @DiseaseCount int OUTPUT ', @DiseaseInput=@DiseaseInput, @DiseaseCount=@DiseaseCount OUTPUT
        -- PRINT @DiseaseCount --  for prototype purposes
        END
    -- PRINT @DiseaseCount --  for prototype purposes
END -- END OF PROCEDURE

-- Example
-- DECLARE @Out int
-- EXECUTE FemaleDiseaseCount 'highblood', @DiseaseCount=@Out OUTPUT 
--                             -- have to specify output or else it wont print
-- print @Out



