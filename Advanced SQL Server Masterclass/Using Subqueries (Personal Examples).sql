--#1
Select *
from
	(Select 
		 PurchaseOrderID
		,VendorID
		,OrderDate
		,TaxAmt
		,Freight
		,TotalDue
		,Ranking = row_number() over(PARTITION BY VendorID order by totaldue desc)
	from Purchasing.PurchaseOrderHeader) a
where Ranking <=3

--#2 
Select *
from
	(Select 
		 PurchaseOrderID
		,VendorID
		,OrderDate
		,TaxAmt
		,Freight
		,TotalDue
		,Ranking = row_number() over(PARTITION BY VendorID order by totaldue desc)
		,[Dense Ranking] = dense_rank() over(PARTITION BY VendorID order by totaldue desc)
	from Purchasing.PurchaseOrderHeader) a
where Ranking <=3