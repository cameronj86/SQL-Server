ALTER PROCEDURE [dbo].[OrdersAboveThreshold]
(@ThresholdNum int, @OrderType int, @StartYear int, @EndYear int )
as 
IF @OrderType = 1
    Begin
        Select *
        from AdventureWorks2019.Sales.SalesOrderHeader
        where TotalDue > @ThresholdNum
        and year(OrderDate) >= @StartYear
        and year(OrderDate) <= @EndYear
    End
ELSE
    BEGIN
        Select *
        from AdventureWorks2019.Purchasing.PurchaseOrderHeader
        where TotalDue > @ThresholdNum
        and year(OrderDate) >= @StartYear
        and year(OrderDate) <= @EndYear
    END


exec dbo.OrdersAboveThreshold 15,1,2012,2013