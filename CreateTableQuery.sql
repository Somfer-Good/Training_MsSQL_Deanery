CREATE DATABASE [2022_PMI_2]

use [2022_PMI_2]
Create Table Specialty(
	SpecId int not null identity(1,1) primary key,
	Title nvarchar(200) not null,
)

Create Table [Group](
	GroupId int not null identity(1,1) primary key,
	Title nvarchar(200) not null,
	SpecId int not null foreign key references Specialty, 
)

Create Table Student(
	StudentId int not null identity(1,1) primary key,
	Name nvarchar(200) not null,
	GroupId int not null foreign key references [Group], 
)

Create Table Professor(
	ProfessorId int not null identity(1,1) primary key,
	Name nvarchar(200) not null,
	Cathedra nvarchar(200) not null, 
)

Create Table Discipline(
	DisciplineId int not null identity(1,1) primary key,
	Title nvarchar(200) not null,
)

Create Table [Lead](
	ProfessorId int not null foreign key references Professor,
	DisciplineId int not null foreign key references Discipline,	
	primary key(ProfessorId,DisciplineId)
)


Create Table StudyPlan(
	PlanId int not null identity(1,1) primary key,
	TypeReporting nvarchar(7) not null,
	AmountHours int not null,
	Semester  int not null,
	ProfessorId int not null foreign key references Professor,
	DisciplineId int not null foreign key references Discipline,
	GroupId int not null foreign key references [Group],
)

Create Table Report(
	StudentId int not null foreign key references Student,
	PlanId int not null foreign key references StudyPlan,
	Reporting nvarchar(8) not null,
	primary key (StudentId,PlanId)
)