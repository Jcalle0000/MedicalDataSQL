-- TABLE 1
CREATE TABLE CUSTOMER_INFO
(
    customer_id     VARCHAR(20)     NOT NULL PRIMARY KEY, -- ID HAS LETTERS
    employment      VARCHAR(250),
    education       VARCHAR(250),
    -- this could all be turned into a combination
    -- with an identity but would make 122,880 combination
    martial         VARCHAR(15), -- Married, Separated, Divorced, Widowed, Never Married 
    gender          VARCHAR(15), -- Male, Female
    age             VARCHAR(15),
    seniorCitizen   VARCHAR(15),-- From here its all yes/no
    complication_risk VARCHAR(15), -- lets move this
    highBlood       VARCHAR(15),   -- 9th column
    stroke          VARCHAR(15),
    overweight      VARCHAR(15),
    arthritis      VARCHAR(15),
    diabetes        VARCHAR(15),
    hyperlipidemia      VARCHAR(15),
    backpain      VARCHAR(15),
    anxiety      VARCHAR(15),
    allergic_rhinitis   VARCHAR(15),
    reflux_esophagitis  VARCHAR(15),
    asthma          VARCHAR(15)
)
GO



INSERT INTO CUSTOMER_INFO
    SELECT customer_id, employment, education
    , martial, gender,age , seniorCitizen, complication , highBlood, stroke
    , overweight, arthritis, diabetes, hyperlipidemia
    , backPain, anxiety, allergic_rhinitis, reflux_esophagitis, asthma
        FROM INPUT_DATA
GO

select *FROM CUSTOMER_INFO
-- 10,000 customers -> 10,000 rows

-- TABLE 2
-- from the zipcode you can identify the city, county, population, area
CREATE TABLE CUSTOMER_ADDRESS(
    zipcode             INT           NOT NULL,   -- 8662 distinct zipcodes
    city                VARCHAR(50),              -- 6085 cities
    county              VARCHAR(50),              -- 1662 counties
    zipcode_state       VARCHAR(2),               -- 52               
    zipcode_population    INT       ,             -- 6001
    area                VARCHAR(50),
    
    customer_id         VARCHAR(20)   NOT NULL        ,

    -- PRIMARY KEY(zipcode),
    FOREIGN KEY(customer_id) REFERENCES CUSTOMER_INFO(customer_id),
    -- 1:N relation
    -- a customer can have various locations at worst case

    -- an intresting case would be when the customer has two houses 
    -- in the same zipcode
    CONSTRAINT PK_Customer_Address PRIMARY KEY(zipcode, customer_id)
    -- primary key makes the combination have to be unique
)
GO

INSERT INTO CUSTOMER_ADDRESS
    -- these are the names from the INPUT_DATA
    SELECT zipcode, city, county, cstmr_state, state_population, 
    area, customer_id 
    FROM INPUT_DATA
GO

-- table 3
-- lets verify this relation late
CREATE TABLE CARDIAC_PATIENTS(
    patient_id          INT IDENTITY(1,1) NOT NULL, -- start with index 1 and increment by 1
    customer_id         VARCHAR(20)       NOT NULL  UNIQUE ,
    highBlood          VARCHAR(15),
    overweight      VARCHAR(15),
    stroke          VARCHAR(15),
    hyperlipidemia      VARCHAR(15),

    PRIMARY KEY(patient_id),
    -- patient should not be allowed to have two records
    -- thats why customer_id is set to unique IF YOU TRY to insert you get duplicate key
    FOREIGN KEY (customer_id) REFERENCES CUSTOMER_INFO(customer_id),
    -- basically customer_id and patient are the primary key
)
GO

INSERT INTO CARDIAC_PATIENTS
    SELECT customer_id, highBlood, overweight, stroke, hyperlipidemia 
    FROM CUSTOMER_INFO where hyperlipidemia='YES' OR highBlood='YES'
GO
-- 6105 patients
