ALTER PROCEDURE dbo.sp_NameSearch2(@NameToSearch varchar(10),@SearchPattern varchar(50),@MatchType int)
AS
BEGIN
DECLARE @DynamicSQL varchar(max)
DECLARE @WildcardJoiner varchar(10)
DECLARE @ExactMatchJoiner varchar(10)
DECLARE @Joiner varchar(10)

SET @NameToSearch = @NameToSearch + 'Name'
SET @WildcardJoiner = ' like + '''
SET @ExactMatchJoiner = ' = '''

BEGIN
    IF @MatchType = 1  
    SET @SearchPattern = '' + @SearchPattern + '''';
    IF @MatchType = 2
    SET @SearchPattern = '' + @SearchPattern + '%''';
    IF @MatchType = 3
    SET @SearchPattern = '%' + @SearchPattern + '''';
    IF @MatchType = 4
    SET @SearchPattern = '%' + @SearchPattern + '%''';
END

BEGIN IF @MatchType = 1
    SET @Joiner = @ExactMatchJoiner
    ELSE 
    SET @Joiner = @WildcardJoiner
END

SET @DynamicSQL = 'Select FirstName, MiddleName, LastName
    from AdventureWorks2019.Person.Person
    where '
SET @DynamicSQL = @DynamicSQL + @NameToSearch
SET @DynamicSQL = @DynamicSQL + @Joiner
SET @DynamicSQL = @DynamicSQL + @SearchPattern 
END

EXEC (@DynamicSQL)

exec dbo.sp_NameSearch2 'Last','dams',3