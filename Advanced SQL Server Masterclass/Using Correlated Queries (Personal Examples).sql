--#1
Select 
	 PurchaseOrderID
	,VendorID
	,OrderDate
	,TotalDue
	,nonRejectedItems = 
		(Select count(*) 
		from AdventureWorks2019.Purchasing.PurchaseOrderDetail pod 
		where pod.RejectedQty = 0
		and pod.PurchaseOrderID = poh.PurchaseOrderID)
from AdventureWorks2019.Purchasing.PurchaseOrderHeader poh

--#2
Select 
	 PurchaseOrderID
	,VendorID
	,OrderDate
	,TotalDue
	,nonRejectedItems = 
		(Select count(*) 
		from AdventureWorks2019.Purchasing.PurchaseOrderDetail pod 
		where pod.RejectedQty = 0
		and pod.PurchaseOrderID = poh.PurchaseOrderID)
	,MostExpensiveItem =
		(Select max(pod.UnitPrice) 
		from AdventureWorks2019.Purchasing.PurchaseOrderDetail pod 
		where pod.PurchaseOrderID = poh.PurchaseOrderID)
from AdventureWorks2019.Purchasing.PurchaseOrderHeader poh