Olist E-Commerce Sales & Customer Analytics
Project Overview
This project analyzes the Brazilian Olist E-Commerce dataset using SQL and Tableau to uncover insights into sales performance, customer behavior, product demand, and operational efficiency.
The analysis focuses on revenue trends, customer satisfaction, regional product preferences, delivery performance, and seller activity. SQL was used for data extraction and KPI generation, while Tableau was used to create interactive dashboards for business decision-making.

Dataset Source

https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce

Tools & Technologies
	•	MySQL
	•	SQL
	•	Tableau
	•	GitHub

Dataset
The project uses the Olist Brazilian E-Commerce Dataset, which contains information about:
	•	Orders
	•	Customers
	•	Sellers
	•	Products
	•	Payments
	•	Reviews
	•	Delivery Information
The dataset represents real-world e-commerce transactions from Brazil and provides a comprehensive view of marketplace operations.

Business Questions Answered
Sales Performance
	•	What is the total revenue generated?
	•	How many orders were placed?
	•	What is the average order value?
	•	What is the repeat customer rate?
	•	How has revenue changed over time?
	•	Which states generate the highest revenue?
	•	Which product categories contribute the most revenue?
Customer & Operations
	•	What is the average customer review score?
	•	What percentage of orders are delivered on time?
	•	What is the average shipping duration?
	•	How many active sellers operate on the platform?
	•	Which categories dominate different states?
	•	Which categories sell the most units?
	•	Which categories receive the highest customer ratings?

Key KPIs
KPI
Value
Total Revenue
R$16.0M
Total Orders
99,441
Average Order Value
R$160.99
Repeat Customer Rate
3.12%
Average Review Score
4.09
On-Time Delivery Rate
91.89%
Average Shipping Days
12.5
Seller Count
289

Dashboard 1: Sales Performance Overview
KPIs
	•	Total Revenue
	•	Total Orders
	•	Average Order Value
	•	Repeat Customer Rate
Visualizations
	•	Quarterly Revenue Trend
	•	Revenue by State
	•	Top Categories by Revenue
Dashboard Preview
Add Dashboard 1 screenshot here.
![Sales Dashboard](dashboard/dashboard1.png)

Dashboard 2: Product & Customer Insights Dashboard
KPIs
	•	Average Review Score
	•	On-Time Delivery Rate
	•	Average Shipping Days
	•	Seller Count
Visualizations
	•	Top Categories by State Revenue
	•	Top Categories by Units Sold
	•	Highest Rated Categories (250+ Reviews)
Dashboard Preview
Add Dashboard 2 screenshot here.
![Customer Dashboard](dashboard/dashboard2.png)

Key Insights
Revenue & Sales
	•	Total revenue exceeded R$16 million.
	•	Revenue showed significant growth throughout 2017 and peaked during 2018.
	•	São Paulo generated the highest revenue among all states.
	•	A small number of states contributed a large share of total sales.
Products & Categories
	•	The category cama_mesa_banho recorded the highest unit sales.
	•	beleza_saude consistently appeared among the strongest-performing categories.
	•	Product demand varied significantly across Brazilian states.
Customer Experience
	•	Average customer ratings remained above 4.0.
	•	More than 91% of orders were delivered on time.
	•	Several categories maintained high ratings despite large review volumes.
Marketplace Operations
	•	The marketplace operated with 289 active sellers.
	•	Average shipping time remained approximately 12.5 days.

SQL Concepts Used
	•	INNER JOIN
	•	LEFT JOIN
	•	Aggregate Functions
	•	GROUP BY
	•	HAVING
	•	CASE Statements
	•	Common Table Expressions (CTEs)
	•	Window Functions
	•	Ranking Functions
	•	Date Functions
	•	KPI Calculations

Project Structure
olist-ecommerce-sql-tableau-analysis/
│
├── README.md
│
├── sql/
│   └── analysis_queries.sql
│
├── dashboard/
│   ├── dashboard1.png
│   ├── dashboard2.png
│   └── analysis_dashboard.twb
│
└── insights/
    └── business_insights.md

Learning Outcomes
Through this project, I developed practical experience in:
	•	Writing analytical SQL queries
	•	Building business KPIs
	•	Data cleaning and transformation
	•	Revenue and customer analysis
	•	Tableau dashboard design
	•	Business storytelling using data
	•	End-to-end analytics project development

Conclusion
This project demonstrates an end-to-end data analytics workflow, starting from SQL-based data extraction and KPI generation to dashboard development and business insight creation using Tableau. The analysis provides valuable insights into sales performance, customer satisfaction, product demand, and operational efficiency within an e-commerce marketplace.
