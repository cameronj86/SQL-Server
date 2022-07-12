-- Exercise #1
Create function dbo.udf_PctOfNumber
(
@num1 int, @num2 int
) 
RETURNS nvarchar(10) --varchar to acct for the '%' in the output
as 
BEGIN
DECLARE @dividednum decimal(4,1);

Select @dividednum = (100*@num1)/@num2 

return cast(@dividednum as varchar) + '%'; --Different solution from video
End
GO

-- Exercise #2
Declare @MaxVacationHrs int = 
        (Select max(VacationHours) 
        from AdventureWorks2019.HumanResources.Employee)

Select businessentityid
    ,Jobtitle
    ,VacationHours
    ,PctVacationHours = dbo.udf_PctOfNumber(vacationhours,@MaxVacationHrs)
from AdventureWorks2019.HumanResources.Employee
order by vacationhours desc
