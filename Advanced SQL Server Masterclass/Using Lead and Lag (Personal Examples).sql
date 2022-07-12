--Exercise #1
Select 
	 PurchaseOrderID
	,OrderDate
	,TotalDue
from Purchasing.PurchaseOrderHeader poh
	join Purchasing.Vendor vn
on vn.BusinessEntityID = poh.VendorID
and year(Orderdate) >= 2013
and poh.TotalDue > 500

--#2 - add PrevOrderFromVendorAmt
Select 
	 PurchaseOrderID
	,OrderDate
	,TotalDue
	,VendorID
	,PrevOrderFromVendorAmt = LAG(TotalDue,1) OVER(PARTITION BY VendorID Order by Orderdate) 
		--How much was spent in the last order (Grouped by VendorID)
from Purchasing.PurchaseOrderHeader poh
	join Purchasing.Vendor vn
on vn.BusinessEntityID = poh.VendorID
and year(Orderdate) >= 2013
and poh.TotalDue > 500

--#3 - add NextOrderByEmployeeVendor
Select 
	 PurchaseOrderID
	,OrderDate
	,TotalDue
	,VendorID
	,poh.EmployeeID
	,PrevOrderFromVendorAmt = LAG(TotalDue,1) OVER(PARTITION BY VendorID Order by Orderdate) 
	,NextOrderByEmployeeVendor = LEAD(vn.Name,1) OVER(PARTITION BY poh.EmployeeID Order by Orderdate) 
from Purchasing.PurchaseOrderHeader poh
	join Purchasing.Vendor vn
on vn.BusinessEntityID = poh.VendorID
and year(Orderdate) >= 2013
and poh.TotalDue > 500

--#4
Select 
	 PurchaseOrderID
	,OrderDate
	,TotalDue
	,VendorID
	,poh.EmployeeID
	,PrevOrderFromVendorAmt = LAG(TotalDue,1) OVER(PARTITION BY VendorID Order by Orderdate) 
	,NextOrderByEmployeeVendor = LEAD(vn.Name,1) OVER(PARTITION BY poh.EmployeeID Order by Orderdate) 
	,NextOrderByEmployeeVendor = LEAD(vn.Name,2) OVER(PARTITION BY poh.EmployeeID Order by Orderdate) 
from Purchasing.PurchaseOrderHeader poh
	join Purchasing.Vendor vn
on vn.BusinessEntityID = poh.VendorID
and year(Orderdate) >= 2013
and poh.TotalDue > 500