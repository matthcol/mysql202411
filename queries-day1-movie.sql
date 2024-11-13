SELECT * FROM dbmovie.movies;
SELECT * FROM movies;

show databases;
show tables; -- CLI: mysql

-- Langage SQL
-- * DDL: Data Definition Language: CREATE, ALTER, DROP
--			database, table, index, view, user, stored procedure|function
-- * DML: Data Manipulation Language: SELECT, INSERT, UPDATE, DELETE

insert into movies (title, year) values ('Oppenheimer', 2023);
-- 1 row(s) affected	0.031 sec

select * from movies where year = 2023; -- id = 8079249 (Oppenheimer)

update movies set duration = 180 where id = 8079249; 
--  Rows matched: 1  Changed: 1 

update movies 
set duration = 180,
	synopsis = 'L''histoire du scientifique J. Robert Oppenheimer et de son rôle dans le développement de la bombe atomique.'
where id = 8079249; 

select * from movies where year = 2023; 

delete from movies where id = 8079249;
-- 1 row(s) affected
delete from movies where id = 8079249;
-- 0 row(s) affected	

select * from movies where year = 2023; 

-- films des années 80s
select * 
from movies 
where year between 1980 and 1989
order by year, title; 

-- films des années 80s de durée >= 2H
select * 
from movies 
where 
	year between 1980 and 1989
    and duration >= 120
order by year, title; 

-- operateurs de comparaisons:  
-- 		(in)égalité = <> !=
--      ordre: < <= > >= between
select * 
from movies 
where 
	year between 1980 and 1989
    and year <> 1982
    and duration >= 120
order by year, title; 

select * 
from movies 
where 
	year between 1980 and 1989
    and year != 1982
    and duration >= 120
order by year, title; 

select *
from movies
where title = 'Pulp Fiction'; -- ok 1 movie

select *
from movies
where title = 'pulp fiction'; -- ok 1 movie (car base installée en CI: Case Insensitive)

-- CI/CS: case (fr: casse)
-- AS/AI: accent
show databases;
SELECT @@character_set_database, @@collation_database;
-- utf8mb4	utf8mb4_0900_ai_ci

select * from persons where name like 'Irène%'; -- starts with
-- AI: Accent Insensitive

select * from movies where title like '%the%'; -- contains

-- Regexp
-- https://dev.mysql.com/doc/refman/8.4/en/regexp.html

-- titre commençant par star(s) ou finissant par star(s)
select * from movies where title regexp '^stars?|stars?$';

-- see also: full text search
-- https://dev.mysql.com/doc/refman/8.4/en/fulltext-search.html

select 
	*,
    char_length(title) as title_length
from movies 
where char_length(title) > 50;

select 
	title,
    char_length(title) as title_length,
    left(title, 10) as title_10l,
    right(title, 10) as title_10r,
    upper(title),
    year,
    concat(title, ' (', year, ')') as title_year 
from movies 
where char_length(title) > 50;

select 
	title,
    char_length(title) as title_length,
    left(title, 10) as title_10l,
    right(title, 10) as title_10r,
    upper(title),
    year,
    concat(title, ' (', year, ')') as title_year
from movies 
where char_length(title) < 15;

select * from movies where title = 'L''été meurtrier';
insert into movies (title, year) values ('L''été meurtrier', 1983);
select * from movies where title = 'L''été meurtrier';

-- character set: utf8mb4
insert into movies (title, year) values ('I 🙂 東京都', 2025);
select * from movies where title like '%🙂%';

select 
	title, 
    char_length(title) as title_length, 
    length(title) as title_length_bytes
from movies where title = 'L''été meurtrier';

select * from movies where year >= 2025;

-- calculs numeriques: ceil, floor, round
-- https://dev.mysql.com/doc/refman/8.4/en/mathematical-functions.html

-- persons born in 1950 (with function year or extract)
select * from persons where YEAR(birthdate) = 1950;
select * from persons where EXTRACT(YEAR FROM birthdate) = 1950;

-- les films d'il y a 10 ans
select 
	title,
    year,
    current_date(),
    YEAR(current_date()),
    YEAR(current_date()) - 10
from movies
limit 10;

select * from movies where year = YEAR(current_date()) - 10;

-- films des années 80s avec leur réalisateur
select * 
from movies 
where year between 1980 and 1989
order by year, title; 

select *
from persons
where id = 229;

select *
from
	movies
    join persons on movies.director_id = persons.id
;

select 
	m.title,
    m.year,
    p.name
from
	movies m
    join persons p on m.director_id = p.id
where m.year between 1980 and 1989
order by m.year, m.title;

-- les films de Clint Eastwood en tant que réalisateur
select 
	p.id,
	p.name,
    m.year,
	m.title
from
	movies m
    join persons p on m.director_id = p.id
where p.name = 'Clint Eastwood'
order by p.id, m.year desc, m.title;

-- with its id = 142
select 
	m.director_id,
    m.year,
	m.title
from
	movies m
where m.director_id = 142
order by m.year desc, m.title;


-- les films de Clint Eastwood en tant qu'acteur

-- join 3 tables starting with persons
select 
	pe.id,
    pe.name,
    m.year,
    m.title,
    pl.role
from
	persons pe
    join play pl on pe.id = pl.actor_id
    join movies m on pl.movie_id = m.id
where 
	pe.name = 'Clint Eastwood'
order by pe.id, m.year desc, m.title;

-- join 3 tables starting with movies
select 
	pe.id,
    pe.name,
    m.year,
    m.title,
    pl.role
from
	movies m
    join play pl on m.id = pl.movie_id
    join persons pe on pl.actor_id = pe.id
where 
	pe.name = 'Clint Eastwood'
order by pe.id, m.year desc, m.title;







