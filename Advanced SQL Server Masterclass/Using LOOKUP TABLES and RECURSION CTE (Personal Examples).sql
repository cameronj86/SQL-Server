CREATE TABLE AdventureWorks2019.dbo.CalendarTable(

    DateValue date
    ,DayOfWeekNumber int
    ,DayOfWeekName varchar(10)
    ,DayOfMonthNumber INT
    ,MonthNumber int
    ,YearNumber int 
    ,WeekendFlag int
    ,HolidayFlag int
)
 GO

WITH DateRange as 
( Select cast('1.1.2010' as date) as Mydate

UNION ALL
Select dateadd(dd,+1,MyDate)
from DateRange
where MyDate <= cast('12.31.2020' as date)
)
Insert into AdventureWorks2019.dbo.CalendarTable (DateValue)
Select *
from DateRange
option(maxrecursion 10000)

UPDATE AdventureWorks2019.dbo.CalendarTable
SET  DayOfWeekNumber = datepart(w,DateValue)
    ,DayOfWeekName = format(DateValue,'dddd')
    ,DayOfMonthNumber = datepart(dd,DateValue)
    ,MonthNumber = datepart(mm,DateValue)
    ,YearNumber = datepart(yy,DateValue)
    ,WeekendFlag = case when datepart(w,DateValue) in (7,1) then 1 else 0 end
    ,HolidayFlag = case 
        when datepart(dd,DateValue) = 25 and datepart(mm,DateValue) = 12 then 1
        when datepart(dd,DateValue) = 1 and datepart(mm,DateValue) = 1 then 1
        when datepart(dd,DateValue) = 4 and datepart(mm,DateValue) = 7 then 1
        else 0 end

-- Exercise #2 Answer
Select poh.OrderDate, poh.*
From AdventureWorks2019.Purchasing.PurchaseOrderHeader poh
join AdventureWorks2019.dbo.CalendarTable ct
    on cast(poh.OrderDate as date) = ct.DateValue
    and ct.HolidayFlag = 1
 
 -- Exercise #3 Answer
Select poh.OrderDate, poh.*
From AdventureWorks2019.Purchasing.PurchaseOrderHeader poh
join AdventureWorks2019.dbo.CalendarTable ct
    on cast(poh.OrderDate as date) = ct.DateValue
    and ct.HolidayFlag = 1
    and ct.WeekendFlag = 1
