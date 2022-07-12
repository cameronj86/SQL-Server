-- Let's say your company pays once per month, on the 15th. If it's already the 15th of the current month (or later), the previous pay period will run 
-- from the 15th of the previous month, to the 14th of the current month. If on the other hand it's not yet the 15th of the current month, the previous 
-- pay period will run from the 15th two months ago to the 14th on the previous month. Set up variables defining the beginning and end of the previous 
-- pay period in this scenario. Select the variables to ensure they are working properly. 
-- Hint: In addition to incorporating date logic, you will probably also need to use CASE statements in one of your variable definitions.
declare @StartDate date 
declare @EndDate date 
declare @After15th date = DATEFROMPARTS(datepart(yy,current_timestamp),datepart(mm,dateadd(mm,-1,current_timestamp)),15)
declare @Before15th date = dateadd(mm,-1,@After15th)

Select 
    @StartDate = case when datepart(dd,CURRENT_TIMESTAMP) <=15 
    then @Before15th
    else @After15th end

set @EndDate = dateadd(dd,-1,dateadd(mm,+1,@StartDate))

Select @StartDate, @EndDate