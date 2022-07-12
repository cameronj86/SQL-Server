ALTER PROCEDURE dbo.OrdersAboveThreshold
(@ThresholdNum int, @StartYear int, @EndYear int )
as 
Select *
from AdventureWorks2019.Purchasing.PurchaseOrderHeader
where TotalDue > @ThresholdNum
and year(OrderDate) >= @StartYear
and year(OrderDate) <= @EndYear

ExEC dbo.OrdersAboveThreshold 10000,2011,2013

Select year(CURRENT_TIMESTAMP)