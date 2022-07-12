Declare @MaxVacationHours int = (SELECT MAX(VacationHours) FROM AdventureWorks2019.HumanResources.Employee)

--Starter code:

SELECT
	   BusinessEntityID
      ,JobTitle
      ,VacationHours
	  ,MaxVacationHours = @MaxVacationHours
	  ,PercentOfMaxVacationHours = (VacationHours * 1.0) / @MaxVacationHours

FROM AdventureWorks2019.HumanResources.Employee

WHERE (VacationHours * 1.0) / @MaxVacationHours >= 0.8

