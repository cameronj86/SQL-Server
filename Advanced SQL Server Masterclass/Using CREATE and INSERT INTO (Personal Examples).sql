create table #SalesData (
    	OrderDate date
		,OrderMonth date
		,TotalDue	money
        ,OrderRank Int
)
Insert into #SalesData
SELECT 
		OrderDate
		,OrderMonth = DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1)
		,TotalDue
		,OrderRank = ROW_NUMBER() OVER(PARTITION BY DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) ORDER BY TotalDue DESC)
FROM AdventureWorks2019.Sales.SalesOrderHeader


create table #PurchaseData(
    OrderDate date
    ,OrderMonth date
    ,TotalDue	money
    ,OrderRank int
)

insert into #PurchaseData
SELECT 
	OrderDate
	,OrderMonth = DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1)
	,TotalDue
	,OrderRank = ROW_NUMBER() OVER(PARTITION BY DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) ORDER BY TotalDue DESC)
FROM   AdventureWorks2019.Purchasing.PurchaseOrderHeader

CREATE Table #Top10SalesExcluded
    (OrderMonth date
	,TotalSales money
    )

insert into #Top10SalesExcluded
Select OrderMonth
	,sum(TotalDue) as TotalSales
from #SalesData 
where OrderRank > 10
group by ordermonth

create table #Top10PurchasesExcluded
    (
     OrderMonth date
	,TotalPurchases money
    )

insert into #Top10PurchasesExcluded
Select OrderMonth
	,sum(TotalDue) as TotalPurchases
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