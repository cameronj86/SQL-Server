--Example #1
Select p.Name as ProductName, ListPrice
from Production.Product p
join Production.ProductSubCategory ps
	on p.ProductSubcategoryID = ps.ProductSubcategoryID
join Production.ProductCategory pc
	on ps.ProductCategoryID = pc.ProductCategoryID

--Example #2
Select p.Name as ProductName, p.ListPrice
	,PriceRank = Row_Number() Over(ORDER BY ListPrice desc) 
from Production.Product p
join Production.ProductSubCategory ps
	on p.ProductSubcategoryID = ps.ProductSubcategoryID
join Production.ProductCategory pc
	on ps.ProductCategoryID = pc.ProductCategoryID

--Example #3 & 4
Select p.Name as ProductName, pc.name, p.ListPrice
	,PriceRank = Row_Number() Over(ORDER BY ListPrice desc) 
	,CategoryPriceRank = Row_Number() Over(PARTITION BY pc.Name ORDER BY ListPrice desc) 
	,Top5InCatg = case when Row_Number() Over(PARTITION BY pc.Name ORDER BY ListPrice desc) <=5 then 'Yes' else 'No' end
from Production.Product p
join Production.ProductSubCategory ps
	on p.ProductSubcategoryID = ps.ProductSubcategoryID
join Production.ProductCategory pc
	on ps.ProductCategoryID = pc.ProductCategoryID

--Personal Code - Limit to top 5 in each category
Select *
from 
	(Select p.Name as ProductName, pc.name, p.ListPrice
		,PriceRank = Row_Number() Over(ORDER BY ListPrice desc) 
		,CategoryPriceRank = Row_Number() Over(PARTITION BY pc.Name ORDER BY ListPrice desc) 
		,Top5InCatg = case when Row_Number() Over(PARTITION BY pc.Name ORDER BY ListPrice desc) <=5 then 'Yes' else 'No' end
	from Production.Product p
	join Production.ProductSubCategory ps
		on p.ProductSubcategoryID = ps.ProductSubcategoryID
	join Production.ProductCategory pc
		on ps.ProductCategoryID = pc.ProductCategoryID) nest
where Top5InCatg = 'Yes'
order by PriceRank