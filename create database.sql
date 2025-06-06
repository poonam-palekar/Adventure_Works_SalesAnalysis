create database adventurework;
use adventurework;

CREATE TABLE DimCustomer (
    CustomerKey INT PRIMARY KEY,
    GeographyKey INT,
    CustomerAlternateKey VARCHAR(100),
    Name VARCHAR(255),
    BirthDate DATE,
    MaritalStatus VARCHAR(50),
    Gender VARCHAR(10),
    EmailAddress VARCHAR(255),
    YearlyIncome DECIMAL(18, 2),
    TotalChildren INT,
    NumberChildrenAtHome INT,
    EnglishEducation VARCHAR(100),
    SpanishEducation VARCHAR(100),
    FrenchEducation VARCHAR(100),
    EnglishOccupation VARCHAR(100),
    SpanishOccupation VARCHAR(100),
    FrenchOccupation VARCHAR(100),
    HouseOwnerFlag CHAR(1),  -- Assuming 'Y' or 'N' values
    NumberCarsOwned INT,
    Address VARCHAR(255),
    Phone VARCHAR(50),
    DateFirstPurchase DATE,
    CommuteDistance VARCHAR(50)
);

CREATE TABLE dimdate (
    DateKey INT,  -- Primary key or unique key
    FullDateAlternateKey DATE,
    DayNumberOfWeek INT,
    EnglishDayNameOfWeek VARCHAR(20),
    SpanishDayNameOfWeek VARCHAR(20),
    FrenchDayNameOfWeek VARCHAR(20),
    DayNumberOfMonth INT,
    DayNumberOfYear INT,
    WeekNumberOfYear INT,
    EnglishMonthName VARCHAR(20),
    SpanishMonthName VARCHAR(20),
    FrenchMonthName VARCHAR(20),
    MonthNumberOfYear INT,
    CalendarQuarter VARCHAR(10),
    CalendarYear INT,
    CalendarSemester VARCHAR(10),
    FiscalQuarter VARCHAR(10),
    FiscalYear INT,
    FiscalSemester VARCHAR(10)
);

CREATE TABLE DimProduct (
    ProductKey INT PRIMARY KEY,
    UnitPrice DECIMAL(18, 2),
    ProductAlternateKey INT,
    ProductSubcategoryKey INT,
    EnglishProductName VARCHAR(255),
    StandardCost DECIMAL(18, 2),
    FinishedGoodsFlag CHAR(1),
    Color VARCHAR(50),
    SafetyStockLevel INT,
    ReorderPoint INT,
    ListPrice DECIMAL(18, 2),
    Size_Sizerange VARCHAR(50),
    Weight DECIMAL(18, 2),
    DaysToManufacture INT,
    ProductLine VARCHAR(50),
    DealerPrice DECIMAL(18, 2),
    ModelName VARCHAR(50),
    EnglishDescription TEXT,
    Date DATE,
    Status VARCHAR(50)
);

CREATE TABLE dimproduct (
    ProductKey INT PRIMARY KEY,
    UnitPrice DECIMAL(18, 2),
    ProductAlternateKey varchar(10),
    ProductSubcategoryKey INT,
    WeightUnitMeasureCode VARCHAR(10),
    SizeUnitMeasureCode VARCHAR(10),
    EnglishProductName VARCHAR(255),
    StandardCost DECIMAL(18, 2),
    Color VARCHAR(50),
    SafetyStockLevel INT,
    ReorderPoint INT,
    ListPrice DECIMAL(18, 2),
    Size VARCHAR(50),
    DaysToManufacture INT,
    ProductLine VARCHAR(50),
    Class VARCHAR(50),
    ModelName VARCHAR(255),
    EnglishDescription TEXT,
    StartDate DATE,
    Status VARCHAR(50)
);

CREATE TABLE ProductCategory (
    ProductCategoryKey INT PRIMARY KEY,
    ProductCategoryAlternateKey VARCHAR(50), 
    EnglishProductCategoryName VARCHAR(255) 
);

CREATE TABLE ProductSubcategory (
    ProductSubcategoryKey INT PRIMARY KEY, 
    ProductSubcategoryAlternateKey VARCHAR(50), 
    EnglishProductSubcategoryName VARCHAR(255), 
    ProductCategoryKey INT, 
    FOREIGN KEY (ProductCategoryKey) REFERENCES ProductCategory(ProductCategoryKey) 
);

CREATE TABLE DimSalesterritory (
    SalesTerritoryKey INT PRIMARY KEY,               
    SalesTerritoryAlternateKey VARCHAR(50),         
    SalesTerritoryRegion VARCHAR(100),              
    SalesTerritoryCountry VARCHAR(100),             
    SalesTerritoryGroup VARCHAR(100)                 
);

CREATE TABLE FactSaleInternet (
    ProductKey INT,              
    OrderDateKey INT,             
    DueDateKey INT,               
    ShipDateKey INT,              
    CustomerKey INT,              
    PromotionKey INT,             
    CurrencyKey INT,              
    SalesTerritoryKey INT,        
    SalesOrderNumber VARCHAR(50), 
    SalesOrderLineNumber INT,     
    OrderQuantity INT,            
    UnitPrice DECIMAL(18, 2),     
    ExtendedAmount DECIMAL(18, 2),
    ProductStandardCost DECIMAL(18, 2),
    TotalProductCost DECIMAL(18, 2),    
    SalesAmount DECIMAL(18, 2),   
    TaxAmt DECIMAL(18, 2),        
    Freight DECIMAL(18, 2),      
    OrderDate DATE,               
    DueDate DATE,                 
    ShipDate DATE,                
    PRIMARY KEY (SalesOrderNumber, SalesOrderLineNumber) 
);



select * from dimcustomer;

select * from dimdate; 

select * from dimproduct;
select * from ProductCategory;
select * from ProductSubcategory;
select * from DimSalesterritory;

select * from FactSaleInternet;









