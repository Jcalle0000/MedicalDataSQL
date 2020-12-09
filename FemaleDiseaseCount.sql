-- Generate a list of patients with name
-- 10.	Generate a list of patients with name, 
--ordered by AGE, showing which is the least common 
-- disease amongst Female Patients.

CREATE PROCEDURE FemaleDiseaseCount ( 
    @DiseaseInput VARCHAR(50),
    @DiseaseCount INT OUTPUT )
AS
BEGIN
    DECLARE @sqlCommand VARCHAR(1000) -- is nvarchar any different?
    SET @sqlCommand='SELECT @DiseaseCount=COUNT(*) FROM customer_INFO WHERE '
        + 'gender='+ '''Female''' +' AND @DiseaseInput=' + 'yes'

        -- DECLARE @DiseaseCount INT
        -- DECLARE @DiseaseInput VARCHAR(50)
        -- SET @DiseaseInput = 'HighBlood'
        -- SELECT @DiseaseCount=COUNT(*) FROM customer_INFO WHERE 
        -- gender='Female' AND @DiseaseInput='yes'
        -- PRINT @DiseaseCount
    PRINT @sqlCommand
END