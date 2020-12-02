-- TABLE 1
CREATE TABLE CUSTOMER_INFO
(
    customer_id     VARCHAR(20)     NOT NULL PRIMARY KEY, -- ID HAS LETTERS
    employment      VARCHAR(250),
    education       VARCHAR(250)
)
GO

INSERT INTO CUSTOMER_INFO
    SELECT customer_id, employment, education
    FROM INPUT_DATA

-- 10,000 customers -> 10,000 rows
SELECT *FROM CUSTOMER_INFO


-- TABLE 2
-- from the zipcode you can identify the city, county, population, area
CREATE TABLE CUSTOMER_ADDRESS(
    zipcode             INT           NOT NULL,   -- 8662 zipcodes
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
)
GO

INSERT INTO CUSTOMER_ADDRESS
    -- these are the names from the INPUT_DATA
    SELECT zipcode, city, county, cstmr_state, state_population, 
    area, customer_id FROM INPUT_DATA

-- Lets found out if a customer is repeated twice

select distinct customer_id from CUSTOMER_INFO -- 10000 customers - so they will all have unique addresses


