## Creating Database AdventureWorks.

create database AdventureWorks;

## ## Using a database is necessary to understandard My sql which database I am Using.

use AdventureWorks;

## To see the how many table present in a database.

show tables;

## Q0 - Union of FactInternetSales & Fact_Internet_Sales_New.

SELECT *
FROM FactInternetSales
UNION ALL
SELECT *
FROM Fact_Internet_Sales_New AS FactInternet_Sales;

## Count the total row after Union.

SELECT
    COUNT(ProductKey) AS RowCount
FROM (
    SELECT *
    FROM FactInternetSales

    UNION ALL

    SELECT *
    FROM Fact_Internet_Sales_New
) AS FactInternet_Sales;


## Q1 - Lookup the productname from the Product sheet to Sales sheet.
## "f" alias name for union of fact_internet_sales and fact_internet_sales_New.
## "p" indicates the Product Table.

SELECT
    f.*,
    p.EnglishProductName AS ProductName
FROM (
    SELECT *
    FROM FactInternetSales

    UNION ALL

    SELECT *
    FROM Fact_Internet_Sales_New
) AS f
LEFT JOIN DimProduct AS p
    ON f.ProductKey = p.ProductKey;

 
 
## Q2. Lookup the Customerfullname from the Customer and Unit Price from Product sheet to Sales sheet.   
## "f" alias name for union of fact_internet_sales and fact_internet_sales_New.
## "p" indicates the Product Table.
## "c" indicates the Customer Table.

 ## To see the full name  Dimcustomer table.
SELECT
    CustomerKey,
    CONCAT(
        FirstName,
        ' ',
        IFNULL(MiddleName, ''),
        CASE WHEN MiddleName IS NULL OR MiddleName = '' THEN '' ELSE ' ' END,
        LastName
    ) AS FullName
FROM DimCustomer;

 ## To see the full name  Sales table.
 
SELECT
    f.ProductKey,
    p.EnglishProductName AS ProductName,
    f.CustomerKey,
    CONCAT(
        c.FirstName,
        ' ',
        IFNULL(c.MiddleName, ''),
        CASE
            WHEN c.MiddleName IS NULL OR c.MiddleName = '' THEN ''
            ELSE ' '
        END,
        c.LastName
    ) AS FullName,
    f.SalesTerritoryKey,
    f.OrderQuantity,
    f.UnitPrice,
    f.TotalProductCost,
    f.SalesAmount,
    f.OrderDatekey
FROM (
    SELECT *
    FROM FactInternetSales

    UNION ALL

    SELECT *
    FROM Fact_Internet_Sales_New
) AS f
LEFT JOIN DimProduct AS p
    ON f.ProductKey = p.ProductKey
right JOIN DimCustomer AS c
    ON f.CustomerKey = c.CustomerKey;
    

## Q3A. Calcuate Year from the Orderdatekey field.

SELECT
    f.*,
    YEAR(f.OrderDateKey) AS OrderYear
FROM (
    SELECT * FROM FactInternetSales
    UNION ALL
    SELECT * FROM Fact_Internet_Sales_New
) AS f;


## Q3B. Calcuate Monthno from the Orderdatekey field.

SELECT
    f.*,
    YEAR (f.OrderDateKey)  AS OrderYear,
    MONTH (f.OrderDateKey) AS OrderMonth
FROM (
    SELECT * FROM FactInternetSales
    UNION ALL
    SELECT * FROM Fact_Internet_Sales_New
) AS f;



## Q3C. Calcuate Monthfullname from the Orderdatekey field.


SELECT
    f.*,
    YEAR(f.OrderDateKey)        AS OrderYear,
    monthname (f.OrderDateKey)  AS OrderMonthName
FROM (
    SELECT * FROM FactInternetSales
    UNION ALL
    SELECT * FROM Fact_Internet_Sales_New
) AS f;

## Q3D. Calcuate Quarter(Q1,Q2,Q3,Q4) from the Orderdatekey field.

SELECT
    f.*,
    YEAR(f.OrderDateKey) AS OrderYear,
    MONTHNAME(f.OrderDateKey) AS OrderMonthName,
    CONCAT('Q', QUARTER(f.OrderDateKey)) AS OrderQuarter,
    CONCAT(
        YEAR(f.OrderDateKey),
        '-',
        LEFT(MONTHNAME(f.OrderDateKey), 3)
    ) AS OrderYearMonth
FROM (
    SELECT * FROM FactInternetSales
    UNION ALL
    SELECT * FROM Fact_Internet_Sales_New
) AS f;


## Q3F. Calcuate Weekdayno from the Orderdatekey field.

SELECT
    f.*,
    YEAR(f.OrderDateKey) AS OrderYear,
    MONTHNAME(f.OrderDateKey) AS OrderMonthName,
    CONCAT('Q', QUARTER(f.OrderDateKey)) AS OrderQuarter,
    CONCAT(
        YEAR(f.OrderDateKey),
        '-',
        LEFT(MONTHNAME(f.OrderDateKey), 3)
    ) AS OrderYearMonth,
    WEEKDAY(f.OrderDateKey) + 1 AS WeekDayNo   -- 1=Monday, 7=Sunday
FROM (
    SELECT * FROM FactInternetSales
    UNION ALL
    SELECT * FROM Fact_Internet_Sales_New
) AS f;

## Q3G. Calcuate Weekdayname from the Orderdatekey field.

SELECT
    f.*,
    YEAR(f.OrderDateKey) AS OrderYear,
    MONTHNAME(f.OrderDateKey) AS OrderMonthName,
    CONCAT('Q', QUARTER(f.OrderDateKey)) AS OrderQuarter,
    CONCAT(
        YEAR(f.OrderDateKey),
        '-',
        LEFT(MONTHNAME(f.OrderDateKey), 3)
    ) AS OrderYearMonth,
    WEEKDAY(f.OrderDateKey) + 1 AS WeekDayNo,     -- 1=Monday, 7=Sunday
    DAYNAME(f.OrderDateKey) AS WeekDayName,
    CONCAT(
        'FM',
        CASE
            WHEN MONTH(f.OrderDateKey) >= 4
                THEN MONTH(f.OrderDateKey) - 3
            ELSE MONTH(f.OrderDateKey) + 9
        END
    ) AS FinancialMonth
FROM (
    SELECT * FROM FactInternetSales
    UNION ALL
    SELECT * FROM Fact_Internet_Sales_New
) AS f;


## Q3I. Calcuate Financial Quarter (April - June: FQ1, July-Sept: FQ2, Oct-Dec:FQ3, Jan-March:FQ4) from the Orderdatekey field.


SELECT
    f.*,
    YEAR(f.OrderDateKey) AS OrderYear,
    MONTHNAME(f.OrderDateKey) AS OrderMonthName,
    CONCAT('Q', QUARTER(f.OrderDateKey)) AS OrderQuarter,
    CONCAT(
        YEAR(f.OrderDateKey),
        '-',
        LEFT(MONTHNAME(f.OrderDateKey), 3)
    ) AS OrderYearMonth,
    WEEKDAY(f.OrderDateKey) + 1 AS WeekDayNo,     -- 1=Monday, 7=Sunday
    DAYNAME(f.OrderDateKey) AS WeekDayName,

    -- Financial Month (Apr = FM1 ... Mar = FM12)
    CONCAT(
        'FM',
        CASE
            WHEN MONTH(f.OrderDateKey) >= 4
                THEN MONTH(f.OrderDateKey) - 3
            ELSE MONTH(f.OrderDateKey) + 9
        END
    ) AS FinancialMonth,

    -- Financial Quarter (India: Apr–Mar)
    CASE
        WHEN MONTH(f.OrderDateKey) BETWEEN 4 AND 6 THEN 'FQ1'
        WHEN MONTH(f.OrderDateKey) BETWEEN 7 AND 9 THEN 'FQ2'
        WHEN MONTH(f.OrderDateKey) BETWEEN 10 AND 12 THEN 'FQ3'
        ELSE 'FQ4'
    END AS FinancialQuarter

FROM (
    SELECT * FROM FactInternetSales
    UNION ALL
    SELECT * FROM Fact_Internet_Sales_New
) AS f;


## 4.Calculate the Sales amount uning the columns.
SELECT
    f.*,
    YEAR(f.OrderDateKey) AS OrderYear,
    MONTHNAME(f.OrderDateKey) AS OrderMonthName,
    CONCAT('Q', QUARTER(f.OrderDateKey)) AS OrderQuarter,
    CONCAT(
        YEAR(f.OrderDateKey),
        '-',
        LEFT(MONTHNAME(f.OrderDateKey), 3)
    ) AS OrderYearMonth,
    WEEKDAY(f.OrderDateKey) + 1 AS WeekDayNo,
    DAYNAME(f.OrderDateKey) AS WeekDayName,

    -- Financial Month (Apr = FM1 ... Mar = FM12)
    CONCAT(
        'FM',
        CASE
            WHEN MONTH(f.OrderDateKey) >= 4
                THEN MONTH(f.OrderDateKey) - 3
            ELSE MONTH(f.OrderDateKey) + 9
        END
    ) AS FinancialMonth,

    -- Financial Quarter (Apr–Mar)
    CASE
        WHEN MONTH(f.OrderDateKey) BETWEEN 4 AND 6 THEN 'FQ1'
        WHEN MONTH(f.OrderDateKey) BETWEEN 7 AND 9 THEN 'FQ2'
        WHEN MONTH(f.OrderDateKey) BETWEEN 10 AND 12 THEN 'FQ3'
        ELSE 'FQ4'
    END AS FinancialQuarter,

    -- Sales Amount
    (f.UnitPrice * f.OrderQuantity) AS TotalSalesAmount

FROM (
    SELECT * FROM FactInternetSales
    UNION ALL
    SELECT * FROM Fact_Internet_Sales_New
) AS f;




## Total Sales ammount.

SELECT 
    SUM(f.UnitPrice * f.OrderQuantity) AS TotalSalesAmount_NoDiscount
FROM (
    SELECT * FROM FactInternetSales
    UNION ALL
    SELECT * FROM Fact_Internet_Sales_New
) AS f;


## 5.Calculate the Productioncost uning the columns

SELECT 
    SUM(f.TotalProductCost * f.OrderQuantity) AS TotalProctioncost
FROM (
    SELECT * FROM FactInternetSales
    UNION ALL
    SELECT * FROM Fact_Internet_Sales_New
) AS f;


## 6.Calculate the profit.

SELECT 
    SUM(f.UnitPrice * f.OrderQuantity) - SUM(f.TotalProductCost * f.OrderQuantity) AS TotalProfit
FROM (
    SELECT * FROM FactInternetSales
    UNION ALL
    SELECT * FROM Fact_Internet_Sales_New
) AS f;


## 7.Calculate the yearwise sale.

SELECT
    YEAR(f.OrderDateKey) AS OrderYear,
    SUM(f.UnitPrice * f.OrderQuantity) AS TotalSales_NoDiscount
FROM (
    SELECT * FROM FactInternetSales
    UNION ALL
    SELECT * FROM Fact_Internet_Sales_New
) AS f
GROUP BY YEAR(f.OrderDateKey)
ORDER BY OrderYear;


## 8.Calculate the monthwise sale.

SELECT
    YEAR(f.OrderDateKey) AS OrderYear,
    MONTH(f.OrderDateKey) AS OrderMonth,
    MONTHNAME(f.OrderDateKey) AS MonthName,
    SUM(f.UnitPrice * f.OrderQuantity) AS MonthWiseSales
FROM (
    SELECT * FROM FactInternetSales
    UNION ALL
    SELECT * FROM Fact_Internet_Sales_New
) AS f
GROUP BY
    YEAR(f.OrderDateKey),
    MONTH(f.OrderDateKey),
    MONTHNAME(f.OrderDateKey)
ORDER BY
    OrderYear,
    OrderMonth;


## 9.Calculate the Quaterwise sale.
SELECT
    CONCAT('Q', QUARTER(f.OrderDateKey)) AS Quarter,
    SUM(f.UnitPrice * f.OrderQuantity) AS QuarterWiseSales
FROM (
    SELECT * FROM FactInternetSales
    UNION ALL
    SELECT * FROM Fact_Internet_Sales_New
) AS f
GROUP BY
    QUARTER(f.OrderDateKey)
ORDER BY
    QUARTER(f.OrderDateKey);
    
    
    ## Year-Quater..
    
    SELECT
    YEAR(f.OrderDateKey) AS OrderYear,
    CONCAT('Q', QUARTER(f.OrderDateKey)) AS OrderQuarter,
    SUM(f.UnitPrice * f.OrderQuantity) AS TotalSales
FROM (
    SELECT * FROM FactInternetSales
    UNION ALL
    SELECT * FROM Fact_Internet_Sales_New
) AS f
GROUP BY YEAR(f.OrderDateKey), QUARTER(f.OrderDateKey)
ORDER BY OrderYear, OrderQuarter;

## 10. Build addtional KPI /Charts for Performance by Products, Customers, Region


## a. Total Sales by Product.

SELECT
    p.EnglishProductName AS Product,
    SUM(f.UnitPrice * f.OrderQuantity) AS TotalSales,
    SUM(f.OrderQuantity) AS TotalQuantity,
    AVG(f.UnitPrice) AS AvgSellingPrice
FROM FactInternetSales f
JOIN DimProduct p ON f.ProductKey = p.ProductKey
GROUP BY p.EnglishProductName;


## b. 


SELECT
    c.CustomerKey,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    SUM(f.UnitPrice * f.OrderQuantity) AS TotalSales,
    COUNT(DISTINCT f.SalesOrderNumber) AS TotalOrders,
    SUM(f.UnitPrice * f.OrderQuantity) /
    COUNT(DISTINCT f.SalesOrderNumber) AS AvgOrderValue
FROM FactInternetSales f
JOIN DimCustomer c ON f.CustomerKey = c.CustomerKey
GROUP BY c.CustomerKey, CustomerName;

select * from  


 



    
