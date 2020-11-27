
CREATE DATABASE MEDICAL_INFO
GO

-- related to customer's data
CREATE TABLE INPUT_DATA(
    customer_id         VARCHAR(50)     NOT NULL PRIMARY KEY,
    zipcode             VARCHAR(50),
    city                VARCHAR(50),
    cstmr_state         VARCHAR(50),
    state_population    INT,
    county              VARCHAR(50),
    area                VARCHAR(50),
    job                 VARCHAR(250), -- they can have various jobs
    age                 INT,
    education           VARCHAR(50),
    employment          VARCHAR(50),
    martial             VARCHAR(50),
    gender              VARCHAR(50),
    seniorCitizen       VARCHAR(50),
    highBlood           VARCHAR(50),        
    stroke              VARCHAR(50),
    complication        VARCHAR(50),
    overweight          VARCHAR(50),
    arthritis           VARCHAR(50),
    diabetes            VARCHAR(50),
    hyperlipidemia	    VARCHAR(50),
    backPain	        VARCHAR(50),
    anxiety	            VARCHAR(50),
    allergic_rhinitis	VARCHAR(50),
    reflux_esophagitis	VARCHAR(50),
    asthma              VARCHAR(50)
)
go

-- LOAD DATA LOCAL infile

-- copy  input_Data2 FROM '/Med-data.csv'
-- go

BULK INSERT INPUT_DATA 
    FROM '\Med-dataOG.csv' 
    -- UNC naming convention

    -- FROM 'C:\Users\jasoncalle\Desktop\Books\Backend\SQL\Project4MedicalData\Med-DataOG.csv'
    WITH(
        FORMAT='CSV',
        FIRSTROW=2,
        FIELDTERMINATOR=',',
        ROWTERMINATOR='0x0a'
        -- ROWTERMINATOR='\n'
    );
GO   

select *FROM INPUT_DATA

select *FROM INPUT_DATA WHERE customer_id='C412403'