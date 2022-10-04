use [2022_PMI_2]

Insert into [dbo].[Specialty] ([Title])
values (N'���������� ���������� � �����������'),
(N'���������� � ������������ �����'),
(N'�������������� ������������'),
(N'������������ ������������')

Insert into [dbo].[Group]([Title],[SpecId])
values 
(N'���-11��',1),(N'���-12��',1),(N'���-13��',1),(N'���-21��',1),(N'���-22��',1),(N'���-23��',1),(N'���-31��',1),(N'���-32��',1),(N'���-33��',1),(N'���-41��',1),(N'���-42��',1),(N'���-43��',1),(N'���-11��',1),(N'���-21��',1),
(N'���-11��',2),(N'���-13��',2),(N'���-21��',2),(N'���-31��',2),(N'���-41��',2),(N'���-11��',2),(N'���-21��',2),
(N'��-11��',3),(N'��-21��',3),(N'��-31��',3),(N'��-41��',3),(N'��-11��',3),(N'��-21��',3),
(N'��-11��',4),(N'��-21��',4),(N'��-31��',4),(N'��-41��',4),(N'��-51��',4)

Insert into [dbo].[Student]([Name],[GroupId])
values
(N'�������� �����',8),(N'������� �������',8),(N'�������� �����',8),(N'�������� �������',8),(N'������� �����',8),(N'�������� �������',8),(N'��������� ���������',8),
(N'��������� ���������',8),(N'������� ������',8),(N'������� ��������',8),(N'��������� ��������',8),(N'����� ����������',8),(N'�������� ������',8),(N'�������� ������',8),
(N'������� �����',8),(N'������ ������',8),(N'������ �����',8),(N'�������� ������',8)


Insert into [dbo].[Professor]([Name],[Cathedra])
values (N'�������� ������� ��������',N'���������������� ���������'),
(N'������� ������ �������',N'���������������� ���������'),
(N'������� �������� ����������',N'���������������� ���������'),
(N'������� ������� �����������',N'���������������� ���������'),
(N'�������� �������� ������������',N'���������������� ���������'),
(N'�������������� ����� ����������',N'���������������� ���������'),
(N'������� ����� ������������',N'������������ ������������ � �������������� ������� ��������� ����������'),
(N'������ ������� ����������',N'������������ ������������ � �������������� ������� ��������� ����������'),
(N'�������� ������� ��������',N'������������ ������������ � �������������� ������� ��������� ����������'),
(N'������� ������ ����������',N'�������������� ������'),
(N'������ �������� ����������',N'�������������� ������'),
(N'�������� ������� ��������',N'�������������� ������'),
(N'������ ������� �������',N'�������������� ������'),
(N'������� ���������� ���������',N'�������������� ������')

Insert into [dbo].[Discipline] ([Title])
values (N'�������������� ������'), (N'��������������� ���������'), (N'���� ������'), (N'������ ����������������'), (N'������ ������������'), 
(N'������ ������������ ������������ ������������ ������'),(N'������ ����������� � �������������� ����������'),(N'��������� ������������ ��������������'),(N'������ �����������'), (N'������������ �������'),
(N'���������� ����������'),(N'������� � ���������'),(N'����������� ������')

Insert into [dbo].[Lead]([DisciplineId],[ProfessorId])
values (1,13),(1,11),(1,14),(2,2),(3,7),(3,9),(4,7),(4,9),(5,2),(6,3),(7,1),(7,12),(8,4),(9,3),(10,5),(11,9),(11,8),(12,10),(13,13),(13,14)

Insert into [dbo].[StudyPlan]([TypeReporting],[AmountHours],[Semester],[ProfessorId],[DisciplineId],[GroupId])
values (N'�������',144,1,11,1,8),(N'�����',144,2,5,10,8)

Insert into [dbo].[Report]([StudentId],[PlanId],[Reporting])
values (18,1,'4'),(18,2,N'�����')

Select * from [dbo].[Specialty]

Select * from [dbo].[Group]

Select * from [dbo].[Student]

Select * from [dbo].[Professor]

Select * from [dbo].[Discipline]

Select * from [dbo].[Lead]

Select * from [dbo].[StudyPlan]

Select * from [dbo].[Report]
