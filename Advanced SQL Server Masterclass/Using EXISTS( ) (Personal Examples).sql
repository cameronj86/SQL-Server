USE AdventureWorks2019 
GO
--#1 All Orders w/ a quantity of at least 500
Select 
PurchaseOrderID
,OrderDate
,SubTotal
,TaxAmt
from Purchasing.PurchaseOrderHeader poh
WHERE EXISTS (
Select 1
from Purchasing.PurchaseOrderDetail pod
where OrderQty > 500)
order by poh.PurchaseOrderID

--#2 
--Select all records from the PurchaseOrderHeader table such that there is at least one item 
--in the order with an order quantity greater than 500, AND a unit price greater than $50.00.
Select 
	poh.*
from Purchasing.PurchaseOrderHeader poh
WHERE EXISTS (
	Select 1
	from Purchasing.PurchaseOrderDetail pod
	where OrderQty > 500
	and UnitPrice > 50
	and pod.PurchaseOrderID = poh.PurchaseOrderID)
order by poh.PurchaseOrderID

--#3
--Select all records from the Purchasing.PurchaseOrderHeader table such that NONE of the items within the order have a rejected quantity greater than 0.
--Select ALL columns from the Purchasing.PurchaseOrderHeader table using the "SELECT *" shortcut.
Select 
	poh.*
from Purchasing.PurchaseOrderHeader poh
WHERE NOT EXISTS (
	Select 1
	from Purchasing.PurchaseOrderDetail pod
	where pod.PurchaseOrderID = poh.PurchaseOrderID
	and pod.RejectedQty = 0)
order by poh.PurchaseOrderID