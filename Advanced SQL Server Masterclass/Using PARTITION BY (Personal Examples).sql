--Course Exercise #1&2
Select pn.[Name] Product, pc.Name as Category, ps.Name as SubCategory, pn.ListPrice
	,[Average Price by Category] = AVG(pn.ListPrice) Over(Partition By pc.Name)
from Production.Product as pn
join Production.ProductSubcategory ps
	on ps.ProductSubcategoryID = pn.ProductSubcategoryID
join Production.ProductCategory pc
	on pc.ProductCategoryID = ps.ProductCategoryID

--Course Exercise #3
Select pn.[Name] Product, pc.Name as Category, ps.Name as SubCategory, pn.ListPrice
	,[Average Price by Category] = AVG(pn.ListPrice) Over(Partition By pc.Name)
	,[Average Price by Category & SubCategory] = AVG(pn.ListPrice) Over(Partition By pc.Name, ps.Name)
from Production.Product as pn
join Production.ProductSubcategory ps
	on ps.ProductSubcategoryID = pn.ProductSubcategoryID
join Production.ProductCategory pc
	on pc.ProductCategoryID = ps.ProductCategoryID

--Course Exercise #4
Select pn.[Name] Product, pc.Name as Category, ps.Name as SubCategory, pn.ListPrice
	,[Average Price by Category] = AVG(pn.ListPrice) Over(Partition By pc.Name)
	,[Average Price by Category & SubCategory] = AVG(pn.ListPrice) Over(Partition By pc.Name, ps.Name)
	,[Product vs Category Delta] = pn.ListPrice - AVG(pn.ListPrice) Over(Partition By pc.Name)
from Production.Product as pn
join Production.ProductSubcategory ps
	on ps.ProductSubcategoryID = pn.ProductSubcategoryID
join Production.ProductCategory pc
	on pc.ProductCategoryID = ps.ProductCategoryID