--Video Example
With DateSeries as 
    (
        Select cast('1.1.2021' as date) as MyDate
        
        UNION ALL
        
        Select DATEADD(day,1,MyDate)
        from DateSeries
        where MyDate < cast('12.31.2021' as date)
    )

Select MyDate
from DateSeries
OPTION(maxrecursion 365)

-- Exercise 1
-- Use a recursive CTE to generate a list of all odd numbers between 1 and 100.
With OddNumbers as 
(
    Select 1 as OddNum
    UNION ALL
    Select OddNum + 2
    from OddNumbers
    where OddNum < 100
)
Select *
from OddNumbers

-- Exercise #2
-- Use a recursive CTE to generate a date series of all FIRST days 
-- of the month (1/1/2021, 2/1/2021, etc.) from 1/1/2020 to 12/1/2029.
With FirstMoDays as (

    Select Cast('1.1.2020' as date) as FirstDate
    UNION ALL
    Select dateadd(day,1,eomonth(FirstDate))
    from FirstMoDays
    WHERE FirstDate < '12.1.2029'
)

Select FirstDate
from FirstMoDays
OPTION(Maxrecursion 1000)
