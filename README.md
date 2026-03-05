## Adventure Works Sales Analysis Project

## Project Overview

This project analyzes sales data from the AdventureWorks dataset to understand product performance, customer behavior, and sales trends. The project integrates data from multiple sources, performs data cleaning and transformation, and builds interactive dashboards for business insights.

The analysis combines sales_Fact tables (FactInternetSales and Fact_Internet_Sales_New) and enriches them with product and customer information. Various KPIs such as Total Sales, Profit, Production Cost, Yearly Sales, Monthly Sales, and Quarterly Sales are calculated to support business decision-making.

The final output includes interactive dashboards and reports created in Power BI and Tableau for visualizing sales performance.

## Project Objectives

* Combine historical and new sales data using SQL.

* Perform data transformation and enrichment.

* Calculate important business KPIs.

* Analyze product, customer, and regional performance.

* Build interactive dashboards for decision making.

## Dataset Description

The project uses the AdventureWorks dataset, which contains information about:

* Sales transactions

* Products

* Customers

* Order dates

* Product costs

* Sales territories

## Key tables used:

* FactInternetSales

* Fact_Internet_Sales_New

* DimProduct

* DimCustomer

## Project Workflow

## Data Integration

Combined sales data from two tables using SQL UNION ALL to create a unified dataset.

Example:

SELECT * FROM FactInternetSales
UNION ALL
SELECT * FROM Fact_Internet_Sales_New;

## Data Enrichment

Joined the sales data with Product and Customer tables to include additional information like:

* Product Name

* Customer Full Name

## Date Transformation

Extracted important date fields from OrderDateKey:

* Order Year

* Month Number

* Month Name

* Quarter

* Financial Month

* Financial Quarter

* Weekday Name

## KPI Calculations

Key metrics calculated:

## Total Sales
* UnitPrice × OrderQuantity

## Production Cost
* TotalProductCost × OrderQuantity

## Profit
* Total Sales – Production Cost
  
## Sales Trend Analysis

Performed analysis such as:

* Year-wise Sales

* Month-wise Sales

* Quarter-wise Sales

* Product Performance

* Customer Performance

## Dashboard & Visualization

Interactive dashboards were created to visualize business insights including:

* Total Sales

* Total Profit

* Product Performance

* Customer Sales

* Sales Trends

* Regional Performance

## Tools & Technologies Used
Tool	Purpose
* Excel     -	 Data cleaning and preparation
* MySQL	    -  Data extraction and transformation
* Power BI	-  Dashboard development
* Tableau	  -  Data visualization

## Key Insights / Outcomes

* Identified top-performing products based on sales revenue.

* Analyzed customer purchasing patterns and order behavior.

* Measured overall business profitability.

* Observed sales trends across years, months, and quarters.

* Created interactive dashboards that help stakeholders quickly understand sales performance.

## Project Files

* Excel Project.xlsx – Data cleaning and preparation

* AdventureWorks Sales Report.sql – SQL queries and data transformation

* Adventure Works Project.pbix – Power BI dashboard

* Tableau Adventure Works Project.twbx – Tableau dashboard

## Aspiring Data Analyst skilled in:

* Excel

* SQL

* Power BI

* Tableau

* Data Cleaning

* Data Visualization

* Data Modelling & Data Relationship

* Power Query & power pivot

* DAX
  
## Adventure-Works
Adventure Works Sales Analysis project focuses on analyzing sales data to understand product performance, customer behavior, and sales trends. Data from multiple tables was combined and transformed using SQL, and insights were visualized using Power BI and Tableau dashboards to support better business decisions.
