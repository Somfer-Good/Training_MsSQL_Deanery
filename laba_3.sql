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

--3.1
CREATE VIEW v
AS SELECT StudentId, [Name] 
FROM Student;

select * from v

CREATE VIEW v1
AS SELECT GroupId, Title 
FROM [Group];

select * from v1

--3.2

WITH gr AS
    (select Title as t from [Group]) 
select * from gr

--4.1

select row_number() over(ORDER BY Title) num,*
from Specialty 

SELECT *, RANK() OVER(ORDER BY s.Title) rnk
from  Specialty s JOIN [Group] g
on g.SpecId=s.SpecId

SELECT *, DENSE_RANK() OVER(ORDER BY s.Title) rnk_dense
from  Specialty s JOIN [Group] g
on g.SpecId=s.SpecId

--5.1

--UNION удаляет повторяющиеся строки
--UNION ALL не удаляет повторяющиеся строки
--EXCEPT которые входят в первый и не входят во второй набор
--INTERSECT только совпадающие наборы

--6.1
select Title,case Title
    WHEN N'Прикладная математика и информатика' then N'ПМИ'
    WHEN N'Математика и компьютерные науки' then N'МКН'
    WHEN N'Информационная безопасность' then N'ИБ'
    WHEN N'Компьютерная безопасность' then N'КБ'
end as 'Сокращение'
from Specialty


--a
select distinct d.Title
from Specialty s join [Group] gr
on s.SpecId=gr.SpecId
join StudyPlan st on st.GroupId=gr.GroupId
join Discipline d on d.DisciplineId=st.DisciplineId 
where s.Title=N'Прикладная математика и информатика'

--b
--Зачет = практика. Лекция = экзамен
with Practic as(
    select *
    from StudyPlan
    where TypeReporting=N'Зачет'
),
Lectures as(
    select *
    from StudyPlan
    where TypeReporting=N'Экзамен'
)
select pr.Cathedra,pr.Name,ISNULL(SUM(Practic.AmountHours),0) 'Практика',ISNULL(SUM(Lectures.AmountHours),0) 'Лекции'
from Professor pr 
left JOIN Practic
on pr.ProfessorId=Practic.ProfessorId
left join Lectures
on pr.ProfessorId=Lectures.ProfessorId
GROUP by pr.ProfessorId, pr.Cathedra, pr.Name

--c
with EvaluationsMIN as(
    select top 1 with ties 
    d.Title as 'Плохо сдали'
    from Report rep join StudyPlan sp
    on sp.PlanId=rep.PlanId
    join Discipline d on d.DisciplineId=sp.DisciplineId
    group by rep.PlanId, d.Title
    order by sum(case 
    when rep.Reporting=N'Зачет' then 5
    when rep.Reporting=N'Незачет' then 2
    else cast(rep.Reporting as int)
    end)
),
EvaluationsMAX as(
    select top 1 with ties 
    d.Title as 'Хорошо сдали'
    from Report rep join StudyPlan sp
    on sp.PlanId=rep.PlanId
    join Discipline d on d.DisciplineId=sp.DisciplineId
    group by rep.PlanId, d.Title
    order by sum(case 
    when rep.Reporting=N'Зачет' then 5
    when rep.Reporting=N'Незачет' then 2
    else cast(rep.Reporting as int)
    end) desc
)
select *
from EvaluationsMIN,EvaluationsMAX

--d
with Bad as (
select distinct StudentId
from Report
where Reporting=N'Незачет' or Reporting='2' or Reporting='3'
)
select g.Title,count(distinct s.Name)
from Report rep join Student s
on s.StudentId=rep.StudentId 
right join [Group] g on g.GroupId=s.GroupId
where not exists (
    select 1 
    from Bad
    where rep.StudentId = Bad.StudentId) 
group by g.GroupId,g.Title

--e
with BadSID as (
select distinct StudentId
from Report
where Reporting=N'Незачет' or Reporting='2'
),
goodSID as (
select distinct StudentId
from Report r
where not exists(
select distinct StudentId
from Report
where (case 
    when Reporting=N'Зачет' then 5
    when Reporting=N'Незачет' then 2
    else cast(Reporting as int)
    end) <> 5 and StudentId=r.StudentId
)),
bad as(
    select g.GroupId as GroupIdB, s.StudentId as StudentId
    from Student s join BadSID
    on s.StudentId=BadSID.StudentId
    join [Group] g on s.GroupId=g.GroupId
),
good as(
    select g.GroupId as GroupId, s.StudentId as StudentId
    from Student s join goodSID
    on s.StudentId=goodSID.StudentId
    join [Group] g on s.GroupId=g.GroupId
)
select  g.Title,  count(distinct good.StudentId) 'Отличники',count(distinct bad.StudentId) 'Двоечники'
from [Group] g left join bad on bad.GroupIdB=g.GroupId
left join good on good.GroupId=g.GroupId
GROUP by g.GroupId, g.Title




