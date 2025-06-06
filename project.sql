create database adventurework;
use adventurework;
-----------------------------------------------------------------------------------------------------------------------------------------------
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
-----------------------------------------------------------------------------------------------------------------------------------------------
select * from dimcustomer;

select * from dimdate; 

select * from dimproduct;
select * from ProductCategory;
select * from ProductSubcategory;
select * from DimSalesterritory;

select * from FactSaleInternet;
-----------------------------------------------------------------------------------------------------------------------------------------------

# Q.1 In SQL,we perform lookups by joining tables this can be done using JOIN operations.
# productname from the Product sheet to Sales sheet. 
select
    f.SalesOrderNumber,
    f.OrderQuantity,
    f.UnitPrice,
    p.EnglishProductName
from
    factsaleinternet f
join
    dimProduct p on f.ProductKey = p.ProductKey;

# Q.2 Customerfullname from the Customer and Unit Price from Product sheet to Sales sheet.
 select 
    f.SalesOrderNumber,
    f.OrderQuantity,
    f.UnitPrice,
    c.Name as CustomerFullName,
    p.EnglishProductName
from 
    factsaleinternet f
join 
    dimcustomer c on f.CustomerKey = c.CustomerKey
JOIN 
    dimproduct p on f.ProductKey = p.ProductKey;
---------------------------------------------------------------------------------------------------------------------------------------------    
    
#Q.3 YEAR
select
    d.CalendarYear as YEAR
from 
    factSaleInternet f
join 
    dimdate d on f.OrderDateKey = d.DateKey;
    
#MONTHNO
select 
    d.MonthNumberOfYear as MONTHNO
from 
    factsaleinternet f
join 
    dimdate d on f.OrderDateKey = d.DateKey;
    
#MONTH FULL NAME
select
    d.EnglishMonthName as MonthFullName
from
    factsaleinternet f
join
    dimdate d on f.OrderDateKey = d.DateKey;
  
#QUATER
select 
    case when d.MonthNumberOfYear between 1 and 3 then 'Q1'
        when d.MonthNumberOfYear between 4 and 6 then'Q2'
        when d.MonthNumberOfYear between 7 and 9 then 'Q3'
        else 'Q4'
    end as QUATER
from 
    factsaleinternet f
join 
    dimdate d on f.OrderDateKey = d.DateKey;
    
#YEARMONTH    
select concat(d.CalendarYear, '-', left(d.EnglishMonthName, 3)) as YEARMONTH
from factsaleinternet f
join dimdate d on f.OrderDateKey = d.DateKey;

#WEEKDAYNO
select
    d.DayNumberOfWeek as WEEKDAYNO
from 
    factsaleinternet f
join 
    dimdate d on f.OrderDateKey = d.DateKey;
    
#WEEKDAYNAME
select 
    d.EnglishDayNameOfWeek as WEEKDAYNAME
from
    factsaleinternet f
join
    dimdate d on f.OrderDateKey = d.DateKey;
    
#FINANCIALMONTH
select 
    case when d.MonthNumberOfYear BETWEEN 1 AND 3 THEN 'FM1'
        when d.MonthNumberOfYear BETWEEN 4 AND 6 THEN 'FM2'
        when d.MonthNumberOfYear BETWEEN 7 AND 9 THEN 'FM3'
        else 'FM4'
    end as FINANCIALMONTH
from 
    factsaleinternet f
join
    dimdate d on f.OrderDateKey = d.DateKey;
------------------------------------------------------------------------------------------------------------------------------------------
#Calculate unitdiscount 
select 
    f.SalesOrderNumber,
    f.UnitPrice,
    f.OrderQuantity,
    f.SalesAmount,
    (1 - (f.SalesAmount / (f.UnitPrice * f.OrderQuantity))) as UnitDiscount
from
    factsaleinternet f;

# Q.4 Calculate sales amount
select 
    f.SalesOrderNumber,
    f.UnitPrice * f.OrderQuantity  as SALESAMOUNT
from 
    factsaleinternet f;
select * from factsaleinternet;

#Q.5 Calculate the Productioncost using the columns(unit cost ,order quantity)
select 
    f.SalesOrderNumber,
    p.StandardCost * f.OrderQuantity as ProductionCost
from 
    factsaleinternet f
join
    dimproduct p on f.ProductKey = p.ProductKey;
    
#Q.6 Calculate the Profit
select
    f.SalesOrderNumber,
    (f.UnitPrice * f.OrderQuantity ) - (p.StandardCost * f.OrderQuantity) as PROFIT
from 
    factsaleinternet f
join
    dimproduct p on f.ProductKey = p.ProductKey;
    
# pivot table in SQL can be done using GROUP BY and conditional aggregation
select 
    d.EnglishMonthName as Month,
    SUM(f.OrderQuantity * f.UnitPrice) as TotalSales
from 
    factsaleinternet f
join
    dimdate d on f.OrderDateKey = d.DateKey
group by 
    d.EnglishMonthName;

# yearwise sales
select 
    d.CalendarYear as Year,
    SUM(f.OrderQuantity * f.UnitPrice) as TotalSales
from 
    factsaleinternet f
join
    dimdate d on f.OrderDateKey = d.DateKey
group by 
    d.CalendarYear;

# monthwise sales
select 
    d.EnglishMonthName as Month,
    SUM(f.OrderQuantity * f.UnitPrice) as TotalSales
from 
    factsaleinternet f
join 
    dimdate d on f.OrderDateKey = d.DateKey
group by
    d.EnglishMonthName;
    
# Quaterwise sales
select case when d.MonthNumberOfYear between 1 and 3 then 'Q1'
			when d.MonthNumberOfYear between 4 and 6 then 'Q2'
			when d.MonthNumberOfYear between 7 and 9 then 'Q3'
        else 'Q4'
    end as QUATER,
    SUM(f.OrderQuantity * f.UnitPrice) as TotalSales
from factsaleinternet f
join 
    dimdate d on f.OrderDateKey = d.DateKey
group by
    QUATER;
    
# Salesamount and production cost together
select 
    d.EnglishMonthName as Month,
    SUM(f.OrderQuantity * f.UnitPrice) as TotalSales,
    SUM(p.StandardCost * f.OrderQuantity) as TotalProductionCost
from factsaleinternet f
join
    dimdate d on f.OrderDateKey = d.DateKey
join 
    dimproduct p on f.ProductKey = p.ProductKey
group by 
    d.EnglishMonthName;
 ----------------------------------------------------------------------------------------------------------------------------   
# additinal KPIs 
# Sales by product TOP 5 PRODUCT 
select
    p.EnglishProductName,
    SUM(f.OrderQuantity * f.UnitPrice) as TotalSales
from
    factsaleinternet f
join 
    dimproduct p on f.ProductKey = p.ProductKey
group by
    p.EnglishProductName
order by
    TotalSales DESC
limit 5;

# Sales by customer
select 
    c.Name as CustomerFullName,
    SUM(f.OrderQuantity * f.UnitPrice) as TotalSales
from 
    factsaleinternet f
join
    dimcustomer c on f.CustomerKey = c.CustomerKey
group by 
    c.Name;
    
# Sales by Region
select 
    st.SalesTerritoryRegion,
    SUM(f.OrderQuantity * f.UnitPrice) as TotalSales
from
    factsaleinternet f
join 
    dimsalesterritory st on f.SalesTerritoryKey = st.SalesTerritoryKey
group by 
    st.SalesTerritoryRegion;
    
#Top Performing Products by Sales:
SELECT ProductKey, SUM(SalesAmount) AS TotalSales 
FROM factsaleinternet
 GROUP BY ProductKey 
 ORDER BY TotalSales 
 DESC LIMIT 10;


#Top 10 Customers by Sales
SELECT CustomerKey, SUM(SalesAmount) AS TotalSales FROM factsaleinternet
 GROUP BY CustomerKey 
 ORDER BY TotalSales 
 DESC LIMIT 10;

#Average Sales per Order
SELECT AVG(SalesAmount) AS AvgSalesPerOrder 
FROM factsaleinternet;

