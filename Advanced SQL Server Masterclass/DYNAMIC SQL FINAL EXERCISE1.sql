ALTER PROCEDURE dbo.sp_NameSearch(@NameToSearch varchar(10),@SearchPattern varchar(50))
AS
BEGIN
DECLARE @DynamicSQL varchar(max)
DECLARE @ColumnPicker varchar(10)

SET @ColumnPicker = @NameToSearch
SET @ColumnPicker = @ColumnPicker + 'Name'
SET @SearchPattern = '%' + @SearchPattern + '%''';


SET @DynamicSQL = 'Select FirstName, MiddleName, LastName
    from AdventureWorks2019.Person.Person
    where '
SET @DynamicSQL = @DynamicSQL + @ColumnPicker
SET @DynamicSQL = @DynamicSQL + ' like + '''
SET @DynamicSQL = @DynamicSQL + @SearchPattern 
END


EXEC (@DynamicSQL)

exec dbo.sp_NameSearch 'Last','Adam'


DECLARE @SearchPattern2 varchar(15) = 'Mic'
SET @SearchPattern2 = '%' + @SearchPattern2 + '%';
sELECT @SearchPattern2

    Select FirstName, MiddleName, LastName
    from AdventureWorks2019.Person.Person
    where Firstname like '%' + @SearchPattern2 + '%'

