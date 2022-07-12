--Exercise #1 Using PIVOT, write a query against the HumanResources.Employee table that summarizes 
--the average amount of vacation time for Sales Representatives, Buyers, and Janitors.
--Exercise #2 Modify your query from Exercise 1 such that the results are broken out by Gender. 
--Alias the Gender field as "Employee Gender" in your output.
Select *
from
	(	
	 Select JobTitle, VacationHours, gender
	 from HumanResources.Employee)a
PIVOT(
Avg(VacationHours)
FOR JobTitle IN([Sales Representative],[Buyer],[Janitor])) B
