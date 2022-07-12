create table #PurchaseOrders
	( PurchaseOrderID int
	 ,OrderDate date
	 ,TotalDue money
     ,RejectedQty int)

insert into #PurchaseOrders 
Select purchaseOrderID, Orderdate, TotalDue, NULL
from AdventureWorks2019.Purchasing.PurchaseOrderHeader A

UPDATE P
SET RejectedQty = poh.RejectedQty
FROM #PurchaseOrders P
join AdventureWorks2019.Purchasing.PurchaseOrderDetail poh
    on poh.PurchaseOrderID = P.PurchaseOrderID
    and poh.rejectedqty > 5

Select *
from #PurchaseOrders
where RejectedQty is not null