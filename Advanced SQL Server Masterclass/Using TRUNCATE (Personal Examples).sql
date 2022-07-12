--The purpose of this exercise is to use truncate instead of having a SALES table and a PURCHASE table

create table #OrderData (
    	OrderDate date
		,OrderMonth date
		,TotalDue	money
        ,OrderRank Int
)
Insert into #OrderData
SELECT 
		OrderDate
		,OrderMonth = DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1)
		,TotalDue
		,OrderRank = ROW_NUMBER() OVER(PARTITION BY DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) ORDER BY TotalDue DESC)
FROM AdventureWorks2019.Sales.SalesOrderHeader

CREATE Table #Top10OrdersExcluded
    (OrderMonth date
	,OrderType varchar(10)
	,OrderTotal money
    )

insert into #Top10OrdersExcluded
Select OrderMonth
	,OrderType = 'Sales'
    ,sum(TotalDue) as OrderTotal
from #OrderData 
where OrderRank > 10
group by ordermonth

truncate table #OrderData

Insert into #OrderData
SELECT 
		OrderDate
		,OrderMonth = DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1)
		,TotalDue
		,OrderRank = ROW_NUMBER() OVER(PARTITION BY DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) ORDER BY TotalDue DESC)
FROM AdventureWorks2019.Purchasing.PurchaseOrderHeader

insert into #Top10OrdersExcluded
Select OrderMonth
	,OrderType = 'Purchases'
    ,sum(TotalDue) as OrderTotal
from #OrderData 
where OrderRank > 10
group by ordermonth

--Query that matches the video example
-- Select 
-- 	 t1.OrderMonth
-- 	,t1.OrderType
--     ,t1.OrderTotal as CurrentMonthOrderTotal
--     ,t2.OrderTotal as PriorMonthOrderTotal
-- from #Top10OrdersExcluded t1
-- join #Top10OrdersExcluded t2
-- 	on t1.OrderMonth = dateadd(mm,-1,t2.OrderMonth)
--     and t1.ordertype = t2.ordertype
-- order by t1.ordertype, t1.ordermonth

--Query that matches the exercise
Select 
	 t1.OrderMonth
    ,t1.OrderTotal as TotalSales
    ,t2.OrderTotal as TotalPurchases
from #Top10OrdersExcluded t1
join #Top10OrdersExcluded t2
	on t1.OrderMonth =  t2.OrderMonth
    and t1.ordertype = 'Sales'
    and t2.ordertype = 'Purchases'
order by t1.ordermonth, t1.ordertype

DROP TABLE #Top10OrdersExcluded
DROP TABLE #OrderData

