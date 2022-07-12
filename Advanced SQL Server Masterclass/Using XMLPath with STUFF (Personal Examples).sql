--Exercise #1
--A derived field called "Products" which displays, for each Subcategory in Production.ProductSubcategory, a semicolon-separated list of all products from Production.Product contained within the given subcategory
Select s.[Name] as SubCategoryName
	,[Products] = STUFF(
		(Select ', ' + p.Name 
		from Production.Product p
		where p.ProductSubcategoryID = s.ProductSubcategoryID
		FOR XML PATH ('')
		),
		1,2,'')
from Production.ProductSubcategory s

--NOTE: Your query should still include ALL product subcategories, but only list associated products greater than $50. But since there are certain product subcategories that don't have any associated products greater than $50, some rows in your query output may have a NULL value in the product field.
--Exercise #2
--Modify the query from Exercise 1 such that only products with a ListPrice value greater than $50 are listed in the "Products" field.
Select s.[Name] as SubCategoryName
	,[Products] = STUFF(
		(Select ', ' + p.Name 
		from Production.Product p
		where p.ProductSubcategoryID = s.ProductSubcategoryID
		and p.ListPrice >50
		FOR XML PATH ('')
		),
		1,2,'')
	,[Products Price] = STUFF(
			(Select ', ' + cast(cast(p.ListPrice as Money) as varchar(50))
			from Production.Product p
			where p.ProductSubcategoryID = s.ProductSubcategoryID
			and p.ListPrice >50
			FOR XML PATH ('')
			),
			1,2,'')
from Production.ProductSubcategory s