--Female Population stats using OVER
Select JobTitle
	,count(distinct case when Gender = 'F' then rowguid end) as TotalFemales
	,count(distinct rowguid) as TotalMbrs
	,1.0*count(distinct case when Gender = 'F' then rowguid end)/count(distinct rowguid) as [% Female]
	, COUNT(count(distinct case when gender = 'F' then rowguid end)) over () as [Total # of Females]
	,[% of Female Population] = 1.0*NULLIF(count(distinct case when Gender = 'F' then rowguid end),0)/COUNT(count(distinct case when gender = 'F' then rowguid end)) over ()
FROM AdventureWorks2019.[HumanResources].[Employee]
group by JobTitle
order by [% of Female Population] desc

--Pay Stats using OVER
Select Rate, TotalPay = sum(rate) over()
	,Rate / sum(rate) over() as [% Payout]
FROM AdventureWorks2019.[HumanResources].[EmployeePayHistory]
order by [% Payout] desc

--Course Exercise 
Select FirstName, LastName
	,JobTitle
	,Rate
	,averageRate = AVG(Rate) Over()
	,case when rate/AVG(Rate) Over() > 1 then 'Above Average'
		when rate/AVG(Rate) Over() < 1 then 'Below Average' else 'On Par' end as PayBracket
	,maximumRate = Max(Rate) Over()
	,Rate/Max(Rate) Over() * 100 as [% of Max achieved]
	--,diffFromAvg = 
from person.Person p
join HumanResources.Employee e
	on p.BusinessEntityID = e.BusinessEntityID
join HumanResources.EmployeePayHistory pay
	on p.BusinessEntityID = pay.BusinessEntityID
order by [% of Max achieved] desc
