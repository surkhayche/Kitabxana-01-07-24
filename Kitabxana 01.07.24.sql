create database Kitabxana
use Kitabxana

create table Authors 
(
Id int primary key,
Name nvarchar(50),
Surname nvarchar(50)
);

insert into Authors (Id, Name, Surname) 
values
(1, 'Elxan', 'Elatli'),
(2, 'Chingiz', 'Abdullayev'),
(3, 'Rovhsan', 'Abdullaoglu');

create table Books 
(
Id int primary key,
Name nvarchar(100),
AuthorId int,
PageCount int,
foreign key (AuthorId) references Authors(Id)
);
select * From Books
insert into Books (Id, Name, AuthorId, PageCount) 
values
(1, 'Alternativ dedektiv', 1, 310),
(3, 'Hiyleger sherik', 2, 499),
(6, 'Bu sherde kimse yoxdur', 3, 557);

create view BooksView 
as
select b.Id, b.Name, b.PageCount, a.Name + ' ' + a.Surname as AuthorFullName
from Books b
join Authors a on b.AuthorId = a.Id;

create procedure SearchBooksProcedure
    @searchTerm nvarchar(100)
as
select b.Id, b.Name, b.PageCount, a.Name + ' ' + a.Surname as AuthorFullName
from Books b
join Authors a on b.AuthorId = a.Id
where b.Name like '%' + @searchTerm + '%'
or a.Name + ' ' + a.Surname like '%' + @searchTerm + '%';

create view AuthorsView as
select 
a.Id as Id,
a.Name + ' ' + a.Surname as FullName,
count(b.Id) as BooksCount,
max(b.PageCount) as MaxPageCount
from Authors a
left join Books b on a.Id = b.AuthorId
group by a.Id, a.Name, a.Surname;

select * from BooksView;
exec SearchBooksProcedure 'Alternativ';
select * from AuthorsView;
