Select p.Name as ProductName, pc.name, p.ListPrice
	,PriceRank = Row_Number() Over(ORDER BY ListPrice desc) 
	,CategoryPriceRowNum = Row_Number() Over(PARTITION BY pc.Name ORDER BY ListPrice desc) 
	,CategoryPriceRank = RANK() Over(PARTITION BY pc.Name ORDER BY ListPrice desc) 
	,CategoryPriceDenseRank = DENSE_RANK() Over(PARTITION BY pc.Name ORDER BY ListPrice desc) 
	,Top5InCatg = case when Row_Number() Over(PARTITION BY pc.Name ORDER BY ListPrice desc) <=5 then 'Yes' else 'No' end
from Production.Product p
join Production.ProductSubCategory ps
	on p.ProductSubcategoryID = ps.ProductSubcategoryID
join Production.ProductCategory pc
	on ps.ProductCategoryID = pc.ProductCategoryID


--Using your solution query to Exercise 4 from the ROW_NUMBER exercises as a staring point, add a derived column called “Category Price Rank With Rank” that uses the RANK function to rank all products by ListPrice – within each category - in descending order. Observe the differences between the “Category Price Rank” and “Category Price Rank With Rank” field