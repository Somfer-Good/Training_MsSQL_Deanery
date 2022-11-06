use [2022_PMI_2]

--1.1
select *
from Student
order by Name

select *
from Student
order by Name desc

--1.2

select *
from Professor
where Cathedra=N'Дифференциальные уравнения'

select *
from Professor
where Cathedra=N'Компьютерной безопасности и математических методов обработки информации'

--1.3
select Cathedra, COUNT(ProfessorId)
from Professor
GROUP by Cathedra

select COUNT(*) as [PMI-32BO]
from Student
where GroupId=8

--1.4

--1.5
Select * 
from [Group]
where [Title] LIKE N'ПМИ%'

Select * 
from [Group]
where [Title] LIKE N'%2%'

--2.1
select s.Name, g.Title
from Student s, [Group] g
WHERE s.GroupId=g.GroupId

select g.Title,s.Title
from [Group] g, Specialty s
WHERE g.SpecId=s.SpecId

--2.2
select s.Name, g.Title
from Student s join [Group] g
on s.GroupId=g.GroupId

select g.Title,s.Title
from [Group] g join Specialty s
on g.SpecId=s.SpecId

--2.3
select g.Title, count(s.StudentId)
from [Group] g left join Student s
on g.GroupId=s.GroupId
GROUP by g.Title,g.GroupId

--2.4/2.5
select s.Title, COUNT(g.GroupId)
from [Group] g RIGHT JOIN Specialty s
on g.SpecId=s.SpecId
GROUP by s.SpecId,s.Title

--2.6
select s.Name, COUNT(r.PlanId)
from Report r JOIN Student s
on r.StudentId=s.StudentId
GROUP by s.Name
HAVING s.Name=N'Фурманец Сергей'

--2.7
select *
from [Group]
WHERE Title in (N'ПМИ-31БО', N'ПМИ-32БО', N'ПМИ-33БО',N'ПМИ-34БО')

select *
from [Group]
where exists
(select * 
from Student
WHERE Student.GroupId=[Group].GroupId
)
