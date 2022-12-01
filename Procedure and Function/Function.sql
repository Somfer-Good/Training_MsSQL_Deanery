use [2022_PMI_2]
go
--Функции
----a
Create or alter FUNCTION CountDisciplineByProfessor(
    @Name NVARCHAR(200)
)
Returns int 
as
BEGIN
    DECLARE @count int
    Select @count=count(st.DisciplineId)
    from Professor p
    join StudyPlan st on st.ProfessorId=p.ProfessorId
    where p.Name=@Name
    return @count
END

go
 
----b
Create or alter FUNCTION CountTwosByGroup(
)
Returns table
as
return(
    select g.Title 'Группа', sp.Title 'Специальность', count(r.Reporting) 'Количество двоек'
    from [Group] g 
    join StudyPlan s on s.GroupId=g.GroupId
    join Report r on s.PlanId=r.PlanId
    join Specialty sp on sp.SpecId=g.SpecId
    where r.Reporting='2' and s.Semester=1
    group by g.GroupId, g.Title, sp.SpecId, sp.Title
)
go

----c
Create or alter FUNCTION DataReporting(
    @Spec nvarchar(200),
    @Cours int,
    @rep nvarchar(8)
)
Returns table
as
return(
    select d.Title,count(r.Reporting) Reporting
    from Specialty s
    join [Group] g on s.SpecId=g.SpecId
    join StudyPlan sp on sp.GroupId=g.GroupId
    join Discipline d on sp.DisciplineId=d.DisciplineId
    join Report r on r.PlanId=sp.PlanId
    where (select 
    case
        when s.Title=N'Прикладная математика и информатика' or s.Title=N'Математика и компьютерные науки'
        then Cast(Substring(g.Title,5,1) as int)
        when s.Title=N'Информационная безопасность' or s.Title=N'Компьютерная безопасность'
        then Cast(Substring(g.Title,4,1) as int)
    end
    )=@Cours and s.Title=@Spec and r.Reporting=@rep
    group by d.DisciplineId,d.Title
)

go

Create or alter FUNCTION ResultsWinterSession(
    @Spec nvarchar(200),
    @Cours int
)
Returns @WinterSession table(
    Title nvarchar(200),
    [count 5] int,
    [count 4] int,
    [count 2] int
)
as
begin
    insert into @WinterSession
    select Title,two,four,five
    from (
        select Two.Title, Two.Reporting two, Four.Reporting four, Five.Reporting five
        from dbo.DataReporting(@Spec,@Cours,'2') Two 
        INNER JOIN  dbo.DataReporting(@Spec,@Cours,'4') Four on Two.Title=Four.Title
        INNER JOIN dbo.DataReporting(@Spec,@Cours,'5') Five on Two.Title=Five.Title
    ) tmp
    return
end