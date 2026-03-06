--use free-sql-db-8913638;

CREATE TABLE Fact_SubscriptionRevenue (
    SubscriptionID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID VARCHAR(50),
    Tenure INT,
    MonthlyCharges FLOAT,
    TotalCharges FLOAT,
    Churn BIT,
    ContractType VARCHAR(50),
    PaymentMethod VARCHAR(50)
);



CREATE TABLE Dim_Customer (
    CustomerID VARCHAR(50) PRIMARY KEY,
    Gender VARCHAR(10),
    SeniorCitizen BIT,
    Partner BIT,
    Dependents BIT
);


CREATE TABLE Dim_Service (
    ServiceID INT IDENTITY(1,1) PRIMARY KEY,
    InternetService VARCHAR(50),
    OnlineSecurity VARCHAR(50),
    TechSupport VARCHAR(50)
);


--DELETE 
select * FROM Fact_SubscriptionRevenue
WHERE MonthlyCharges IS NULL;



ALTER TABLE Fact_SubscriptionRevenue
ADD CONSTRAINT chk_monthly CHECK (MonthlyCharges >= 0);


CREATE TABLE ETL_ErrorLog (
    ErrorID INT IDENTITY(1,1),
    ErrorMessage VARCHAR(500),
    ErrorDate DATETIME DEFAULT GETDATE()
);




--drop table fact_large


select * from Fact_SubscriptionRevenue
where Tenure>24


SELECT DISTINCT ContractType
INTO Dim_Contract 
FROM Fact_SubscriptionRevenue;



DROP TABLE Dim_Customer;

CREATE TABLE Dim_Customer (
    CustomerKey INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID VARCHAR(50) UNIQUE,
    Gender VARCHAR(10),
    SeniorCitizen BIT,
    Partner BIT,
    Dependents BIT
);




DROP TABLE Dim_Contract;

CREATE TABLE Dim_Contract (
    ContractKey INT IDENTITY(1,1) PRIMARY KEY,
    ContractType VARCHAR(50) UNIQUE
);



ALTER TABLE Fact_SubscriptionRevenue
ADD CustomerKey INT,
    ContractKey INT;

UPDATE f
SET f.CustomerKey = d.CustomerKey
FROM Fact_SubscriptionRevenue f
JOIN Dim_Customer d
    ON f.CustomerID = d.CustomerID;



UPDATE f
SET f.ContractKey = d.ContractKey
FROM Fact_SubscriptionRevenue f
JOIN Dim_Contract d
    ON f.ContractType = d.ContractType;



SELECT TOP 10 CustomerID, CustomerKey
FROM Fact_SubscriptionRevenue;

select * from Dim_Contract


SELECT TOP 10 ContractType, ContractKey
FROM Fact_SubscriptionRevenue;


ALTER TABLE Fact_SubscriptionRevenue
ADD CONSTRAINT FK_Fact_Customer
FOREIGN KEY (CustomerKey)
REFERENCES Dim_Customer(CustomerKey);




ALTER TABLE Fact_SubscriptionRevenue
ADD CONSTRAINT FK_Fact_Contract
FOREIGN KEY (ContractKey)
REFERENCES Dim_Contract(ContractKey);

ALTER TABLE Fact_SubscriptionRevenue
DROP COLUMN CustomerID, ContractType;


SELECT f1.*
INTO Fact_Large
FROM Fact_SubscriptionRevenue f1
CROSS JOIN (
    SELECT TOP 200 *
    FROM Fact_SubscriptionRevenue
) f2;


SET STATISTICS IO ON;
SET STATISTICS TIME ON;
SELECT *
FROM Fact_Large WHERE Tenure > 24;


--CREATE NONCLUSTERED INDEX idx_tenure ON Fact_Large (Tenure);

CREATE NONCLUSTERED INDEX idx_tenure_covering
ON Fact_Large (Tenure)
INCLUDE (
    SubscriptionID,
    MonthlyCharges,
    TotalCharges,
    Churn,
    PaymentMethod,
    CustomerKey,
    ContractKey
);



SELECT *
FROM Fact_Large
WHERE Tenure > 24;


SELECT Tenure, MonthlyCharges
FROM Fact_Large
WHERE Tenure > 24;



SELECT 
    COUNT(*) AS TotalRows,
    COUNT(CASE WHEN Tenure > 24 THEN 1 END) AS FilteredRows
FROM Fact_Large;

SET STATISTICS IO ON;
SET STATISTICS TIME ON;

SELECT *
FROM Fact_Large
WHERE Tenure = 72;


INSERT INTO ETL_ErrorLog (ErrorMessage)
SELECT 'Negative Monthly Charge Found'
WHERE EXISTS (
    SELECT 1 FROM Fact_SubscriptionRevenue
    WHERE MonthlyCharges < 0
);