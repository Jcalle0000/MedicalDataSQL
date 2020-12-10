-- Generate a list of patients with names who have 
-- anxiety, and are overweight and have Reflux_esophagitis 
-- and/or Allergic_rhinitis and/or Asthma. 

-- needs to have anxiety, overweight, relux_esophagitis
-- and/or allergic_rhinitis and/or asthma

    DECLARE @DiseaseInput VARCHAR(50) -- prototype purpose
    SET @DiseaseInput = 'stroke'   -- prototype purpose
    DECLARE @sqlCommand NVARCHAR(MAX) 
    if(@DiseaseInput='asthma')
        BEGIN
            -- worst case scenario where the (113 )patient has everything
            SET @sqlCommand = 'SELECT customer_id, age FROM customer_INFO WHERE '
            + 'anxiety='+ '''yes'''  -- returns 3215
            + ' AND '
            + 'overweight='+ '''yes''' -- returns 7094
            + ' AND '
            + 'reflux_esophagitis='+ '''yes''' -- returns 4135
            + ' AND '
            +'allergic_rhinitis='+ '''yes''' -- returns 3941
            + ' AND '
            + 'LEN(asthma)=4' -- returns 2893
            + ' ORDER BY age'
        END

    PRINT(@sqlCommand)
    EXECUTE(@sqlCommand)

    DECLARE @sqlCommand NVARCHAR(MAX) 
    DECLARE @DiseaseCount INT         --  for prototype purposes

    DECLARE @anxietyInput varchar(50)
    DECLARE @overWeightInput varchar(50)
    DECLARE @reflux_esophagitis_Input varchar(50)
    DECLARE @allergic_rhinitis_Input varchar(50)
    SET @anxietyInput = 'anxiety'   -- prototype purpose
    SET @overWeightInput = 'overweight'   -- prototype purpose
    SET @reflux_esophagitis_Input = 'reflux_esophagitis'   -- prototype purpose
    SET @allergic_rhinitis_Input = 'allergic_rhinitis'   -- prototype purpose

    SET @sqlCommand='SELECT @DiseaseCount=COUNT(*) FROM customer_INFO WHERE '
    + @anxietyInput='''yes'''
    + ' AND '
    + @overWeightInput='YES  '

-- CASE 1 - all 5 diseases=yes
    select customer_id, age FROM CUSTOMER_INFO
    WHERE anxiety='yes' AND overweight='yes' AND reflux_esophagitis='yes' 
    AND allergic_rhinitis='yes' AND len(asthma)=4 ORDER by age
-- CASE 2 - returns 1953
select customer_id, age FROM CUSTOMER_INFO
    WHERE (anxiety='yes' AND overweight='yes'AND reflux_esophagitis='yes') 
    OR ( allergic_rhinitis='yes' AND LEN(asthma)=4 )
-- CASE 3  returns 6057
select customer_id, age FROM CUSTOMER_INFO
    WHERE (anxiety='yes' AND overweight='yes'AND reflux_esophagitis='yes') 
    OR allergic_rhinitis='yes'
    OR len(asthma)='4'
-- CASE 4  returns 3162
select customer_id, age FROM CUSTOMER_INFO
    WHERE (anxiety='yes' AND overweight='yes'AND reflux_esophagitis='yes'
    AND allergic_rhinitis='yes') OR len(asthma)=4 
-- CASE 5 returns 4102
select customer_id, age FROM CUSTOMER_INFO
    WHERE (anxiety='yes' AND overweight='yes'AND reflux_esophagitis='yes'
    AND len(asthma)=4) OR allergic_rhinitis='yes'

    