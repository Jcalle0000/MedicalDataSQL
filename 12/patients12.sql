-- Generate a list of patients with names who have 
-- anxiety, and are overweight and have Reflux_esophagitis 
-- and/or Allergic_rhinitis and/or Asthma. 

CREATE PROCEDURE patients12
AS
BEGIN
    CREATE table #tempCustomers( 
        currentCustomers varchar(50)
    )

    insert into #tempCustomers
    --case 1
    select customer_id FROM CUSTOMER_INFO
    WHERE anxiety='yes' AND overweight='yes' AND reflux_esophagitis='yes' 
    AND allergic_rhinitis='yes' AND len(asthma)=4 
    UNION ALL
    -- CASE 2 - returns 1953
        select customer_id FROM CUSTOMER_INFO
        WHERE (anxiety='yes' AND overweight='yes'AND reflux_esophagitis='yes') 
        OR ( allergic_rhinitis='yes' AND LEN(asthma)=4 )
    UNION ALL
    -- CASE 3  returns 6057
    select customer_id FROM CUSTOMER_INFO
        WHERE (anxiety='yes' AND overweight='yes'AND reflux_esophagitis='yes') 
        OR allergic_rhinitis='yes'
        OR len(asthma)='4'
    UNION ALL
    -- CASE 4  returns 3162
    select customer_id FROM CUSTOMER_INFO
        WHERE (anxiety='yes' AND overweight='yes'AND reflux_esophagitis='yes'
        AND allergic_rhinitis='yes') OR len(asthma)=4 
    UNION ALL
    -- CASE 5 returns 4102
    select customer_id FROM CUSTOMER_INFO
        WHERE (anxiety='yes' AND overweight='yes'AND reflux_esophagitis='yes' AND len(asthma)=4) 
            OR (allergic_rhinitis='yes')
    
    select distinct * from #tempCustomers
END

-- example
-- EXEC patients12



