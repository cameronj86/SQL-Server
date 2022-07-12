aLTER PROCEDURE [dbo].[sp_OrdersAboveThreshold]
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
IF @OrderType = 2
    BEGIN
        Select *
        from AdventureWorks2019.Purchasing.PurchaseOrderHeader
        where TotalDue > @ThresholdNum
        and year(OrderDate) >= @StartYear
        and year(OrderDate) <= @EndYear
    END
IF @OrderType = 3
    BEGIN
        Select 'Purchases' as OrderType, TotalDue, OrderDate
        from AdventureWorks2019.Purchasing.PurchaseOrderHeader
        where TotalDue > @ThresholdNum
        and year(OrderDate) >= @StartYear
        and year(OrderDate) <= @EndYear

        union ALL

        Select 'Sales' as OrderType, TotalDue, OrderDate
        from AdventureWorks2019.Sales.SalesOrderHeader
        where TotalDue > @ThresholdNum
        and year(OrderDate) >= @StartYear
        and year(OrderDate) <= @EndYear
        order by TotalDue desc
    END
    
exec dbo.sp_OrdersAboveThreshold 100000,3,2012,2013