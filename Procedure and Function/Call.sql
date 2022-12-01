use [2022_PMI_2]
--4
--Процедуры
----a
execute WinterSession

----b
execute WinterSessionBySpecCursSem N'Прикладная математика и информатика', 3,1

----c
declare @hours int
execute ProfessorLoad N'Власова Ольга Владимировна', @hours output
print @hours

----d
execute LessAverageHours

--Функции
----a
print dbo.CountDisciplineByProfessor(N'Власова Ольга Владимировна')

----b
select * from dbo.CountTwosByGroup()

----c
select * from dbo.ResultsWinterSession(N'Прикладная математика и информатика',3)