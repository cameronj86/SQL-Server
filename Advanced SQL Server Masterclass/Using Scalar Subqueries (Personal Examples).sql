Select BusinessEntityID, JobTitle, VacationHours
	--,MaxVacationHours = Max(VacationHours) Over() --Returns the same result, but commented out due to the eventual use of the WHERE clause
	,MaxVacationHours2 = (Select max(VacationHours) from AdventureWorks2019.HumanResources.Employee)
	--,1.0*VacationHours / Max(VacationHours) Over() as [% of Max Vacay] --Returns the same result, but commented out due to the eventual use of the WHERE clause
	,MaxVacationHours2 = 1.0*VacationHours / (Select max(VacationHours) from AdventureWorks2019.HumanResources.Employee)
from AdventureWorks2019.HumanResources.Employee
where 1.0*VacationHours / (Select max(VacationHours) from AdventureWorks2019.HumanResources.Employee) >= .8 --Only Scalar Subqueries can do this

