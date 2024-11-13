-- ----------------------
-- integrity constraints
-- ----------------------

-- Primary key = unique, not null + index created implicitly
select * from persons where name like 'Steve McQueen';
-- ids: 537, 2588606

insert into persons (id, name) values (2588606, 'Steeve McQuin');
-- Error Code: 1062. Duplicate entry '2588606' for key 'persons.PRIMARY'

-- Foreign key: references a primary on another table => index created implicitly
-- Example: alter table movies add constraint FK_MOVIES_DIRECTOR FOREIGN KEY (director_id) 	references persons(id);

insert into movies (title, year, director_id) values ('L''amour ouf', 2024, 999999999);
-- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`dbmovie`.`movies`, CONSTRAINT `FK_MOVIES_DIRECTOR` FOREIGN KEY (`director_id`) REFERENCES `persons` (`id`))

select * from persons where name like 'Gilles Lellouche'; -- 500976
insert into movies (title, year, director_id) values ('L''amour ouf', 2024, 500976); -- ok: id=500976 exists in table persons

insert into movies (title, year) values ('Joker: Folie à Deux', 2024); -- ok: no director

select * from movies where year = 2024;



