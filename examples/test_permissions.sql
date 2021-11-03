-- Use this file to run an end to end test

------------------
-- Replace <USERNAME> with your current user
------------------

-- USE ROLE ACCOUNTADMIN;

-- GRANT ROLE ROLE_INGEST TO USER <USERNAME>;
-- GRANT ROLE ROLE_TRANSFORM TO USER <USERNAME>;
-- GRANT ROLE ROLE_REPORT TO USER <USERNAME>;


------------------
-- TEST LOAD
------------------
USE ROLE ROLE_INGEST; 
USE WAREHOUSE WAREHOUSE_INGEST;
CREATE OR REPLACE SCHEMA RAW.SOURCE_NAME;

CREATE OR REPLACE TABLE RAW.SOURCE_NAME.MYTABLE (AMOUNT NUMBER);

INSERT INTO MYTABLE VALUES(1);

SELECT * FROM MYTABLE;


------------------
-- TEST TRANSFORM
------------------
USE ROLE ROLE_TRANSFORM; 
USE WAREHOUSE WAREHOUSE_TRANSFORM;
CREATE OR REPLACE SCHEMA ANALYTICS.BUSINESS;

CREATE OR REPLACE TABLE ANALYTICS.BUSINESS.MATERIALISED_TABLE AS (SELECT AMOUNT*2.5 AS SALES_AMOUNT FROM RAW.SOURCE_NAME.MYTABLE);
CREATE OR REPLACE VIEW ANALYTICS.BUSINESS.BUSINESS_VIEW AS (SELECT * FROM MATERIALISED_TABLE);

SELECT * FROM BUSINESS_VIEW;


------------------
-- TEST REPORT
------------------
USE ROLE ROLE_REPORT; 
USE WAREHOUSE WAREHOUSE_REPORT;
USE SCHEMA ANALYTICS.BUSINESS;

SELECT * FROM MATERIALISED_TABLE;
SELECT * FROM BUSINESS_VIEW;


