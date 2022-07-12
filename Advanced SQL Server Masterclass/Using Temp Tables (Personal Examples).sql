--For this exercise, assume the CEO of our fictional company decided that the top 10 orders per month are actually outliers that need to be clipped out of our data before doing meaningful analysis.
--Further, she would like the sum of sales AND purchases (minus these "outliers") listed side by side, by month.

--We've got a query that already does this (see the file "CTEs - Exercise Starter Code.sql" in the resources for this section), but it's messy and hard to read. Re-write it using a CTE so other analysts can read and understand the code.

--Hint: You are comparing data from two different sources (sales vs purchases), so you may not be able to re-use a CTE like we did in the video.


SELECT 
		OrderDate
		,OrderMonth = DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1)
		,TotalDue
		,OrderRank = ROW_NUMBER() OVER(PARTITION BY DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) ORDER BY TotalDue DESC)
INTO #SalesData
FROM AdventureWorks2019.Sales.SalesOrderHeader


SELECT 
	OrderDate
	,OrderMonth = DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1)
	,TotalDue
	,OrderRank = ROW_NUMBER() OVER(PARTITION BY DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) ORDER BY TotalDue DESC)
into #PurchaseData
FROM AdventureWorks2019.Purchasing.PurchaseOrderHeader



Select OrderMonth
	,sum(TotalDue) as TotalSales
into #Top10SalesExcluded
from #SalesData 
where OrderRank > 10
group by ordermonth

Select OrderMonth
	,sum(TotalDue) as TotalPurchases
into #Top10PurchasesExcluded
from #PurchaseData
where OrderRank > 10
group by ordermonth

Select 
	 ts.OrderMonth
	,ts.TotalSales
	,tp.TotalPurchases
from #Top10SalesExcluded ts
join #Top10PurchasesExcluded tp
	on ts.OrderMonth = tp.OrderMonth
order by ts.OrderMonth

DROP TABLE #Top10PurchasesExcluded
DROP TABLE #Top10SalesExcluded
DROP TABLE #SalesData
DROP TABLE #PurchaseData

--INITIAL STARTER CODE
-- SELECT
-- A.OrderMonth,
-- A.TotalSales,
-- B.TotalPurchases

-- FROM (
-- 	SELECT
-- 	OrderMonth,
-- 	TotalSales = SUM(TotalDue)
-- 	FROM (
-- 		SELECT 
-- 		   OrderDate
-- 		  ,OrderMonth = DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1)
-- 		  ,TotalDue
-- 		  ,OrderRank = ROW_NUMBER() OVER(PARTITION BY DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) ORDER BY TotalDue DESC)
-- 		FROM AdventureWorks2019.Sales.SalesOrderHeader
-- 		) S
-- 	WHERE OrderRank > 10
-- 	GROUP BY OrderMonth
-- ) A

-- JOIN (
-- 	SELECT
-- 	OrderMonth,
-- 	TotalPurchases = SUM(TotalDue)
-- 	FROM (
-- 		SELECT 
-- 		   OrderDate
-- 		  ,OrderMonth = DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1)
-- 		  ,TotalDue
-- 		  ,OrderRank = ROW_NUMBER() OVER(PARTITION BY DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) ORDER BY TotalDue DESC)
-- 		FROM AdventureWorks2019.Purchasing.PurchaseOrderHeader
-- 		) P
-- 	WHERE OrderRank > 10
-- 	GROUP BY OrderMonth
-- ) B	ON A.OrderMonth = B.OrderMonth
-- ORDER BY 1