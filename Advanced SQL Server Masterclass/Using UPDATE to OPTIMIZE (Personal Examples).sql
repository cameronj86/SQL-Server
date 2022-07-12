SELECT 
	   A.BusinessEntityID
      ,A.Title
      ,A.FirstName
      ,A.MiddleName
      ,A.LastName
	  ,NULL as PhoneNumber
	  ,NULL as [PhoneNumberType]
	  ,NULL as EmailAddress
INTO #Person
FROM AdventureWorks2019.Person.Person A

alter table #Person
alter column PhoneNumber varchar(20)

UPDATE A 
Set PhoneNumber = cast(b.PhoneNumber as varchar(20))
FROM #Person A
left join AdventureWorks2019.Person.PersonPhone B
	on a.BusinessEntityID = b.BusinessEntityID

alter table #Person
alter column PhoneNumberType varchar(10)

UPDATE A 
Set A.PhoneNumberType = C.Name
FROM #Person A
join AdventureWorks2019.Person.PersonPhone P
    on p.PhoneNumber = a.PhoneNumber
left join AdventureWorks2019.Person.PhoneNumberType C
	ON P.PhoneNumberTypeID = C.PhoneNumberTypeID

alter table #Person
alter column emailaddress varchar(50)

UPDATE A 
Set A.EmailAddress = D.EmailAddress
FROM #Person A
left join  AdventureWorks2019.Person.EmailAddress D
	ON A.BusinessEntityID = D.BusinessEntityID

Select *
FROM #Person