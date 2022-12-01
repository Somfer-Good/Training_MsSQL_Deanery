use [2022_PMI_2]
go
--4
--Процедуры
----a
Create or alter PROCEDURE WinterSession
as
BEGIN
    select distinct name
    from Professor p 
    join StudyPlan s on p.ProfessorId=s.ProfessorId
    where s.Semester=1
END

go
----b
Create or alter PROCEDURE WinterSessionBySpecCursSem
@Spec nvarchar(200),
@Cours int,
@Sem int
as
BEGIN
    select distinct d.Title, st.TypeReporting
    from Specialty s 
    join [Group] g on g.SpecId=s.SpecId
    join StudyPlan st on st.GroupId=g.GroupId
    join Discipline d on d.DisciplineId=st.DisciplineId
    where s.Title=@Spec and st.Semester=@Sem and 
    (select 
    case
        when s.Title=N'Прикладная математика и информатика' or s.Title=N'Математика и компьютерные науки'
        then Cast(Substring(g.Title,5,1) as int)
        when s.Title=N'Информационная безопасность' or s.Title=N'Компьютерная безопасность'
        then Cast(Substring(g.Title,4,1) as int)
    end
    )=@Cours
END

go
----c
Create or alter PROCEDURE ProfessorLoad
@Name nvarchar(200),
@Count int output
as
BEGIN
    SET NOCOUNT ON;
    select @Count=Sum(s.AmountHours)
    from Professor p 
    join StudyPlan s on s.ProfessorId=p.ProfessorId
    where p.Name=@Name
END

go
------d
Create or alter PROCEDURE AverageHours
@AvgHours int output
as
BEGIN
    select @AvgHours=AVG(st.AmountHours)
    from StudyPlan st 
    join Discipline d on st.DisciplineId=d.DisciplineId
END

go

Create or alter PROCEDURE LessAverageHours
as
BEGIN
    declare @Average int
    execute AverageHours @Average output

    select d.Title,sum(st.AmountHours)
    from StudyPlan st 
    join Discipline d on st.DisciplineId=d.DisciplineId
    group by d.DisciplineId,d.Title
    having sum(st.AmountHours)<@Average
END