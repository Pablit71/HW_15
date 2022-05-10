CREATE TABLE if not exists colors
(
    id    integer primary key autoincrement,
    color varchar(50)
);

create table if not exists animals_colors
(
    animals_id integer,
    colors_id  integer,
    foreign key (animals_id) references animals ("index"),
    foreign key (colors_id) references colors (id)
);
-- --
INSERT INTO colors (color)
select distinct *
from (
         select distinct color1 as color
         from animals
         union all
         select distinct color2 as color
         from animals);
--
INSERT INTO animals_colors (animals_id, colors_id)
select distinct animals."index", colors.id
from animals
         join colors
              on colors.color = animals.color1
union all
select distinct animals."index", colors.id
from animals
         join colors
              on colors.color = animals.color2;
--
create table if not exists outcome
(
    id      integer primary key autoincrement,
    subtype varchar(50),
    "type"  varchar(50),
    "month" integer,
    "year"  integer
);
-- --
insert into outcome (subtype, "type", "month", "year")
select distinct animals.outcome_subtype,
                animals.outcome_type,
                animals.outcome_month,
                animals.outcome_year
from animals;

create table if not exists breed
(
    id    integer primary key autoincrement,
    breed varchar(50)
);

INSERT INTO breed (breed)
select distinct animals.breed
from animals;

create table if not exists type
(
    id     integer primary key autoincrement,
    "type" varchar(50)
);

INSERT INTO type (type)
select distinct animals.animal_type
from animals;


create table if not exists animals_end
(
    id               integer primary key autoincrement,
    age_upon_outcome varchar(50),
    animal_id        varchar(50),
    animal_type_id   integer,
    breed_id         integer,
    name             varchar(50),
    date_of_birth    varchar(50),
    outcome_id       integer,
    foreign key (outcome_id) references outcome (id),
    foreign key (breed_id) references breed (id),
    foreign key (animal_type_id) references type (id)

);

--
insert into animals_end (age_upon_outcome, animal_id, animal_type_id, breed_id, name, date_of_birth, outcome_id)
select animals.age_upon_outcome,
       animals.animal_id,
       type.id,
       breed.id,
       animals.name,
       animals.date_of_birth,
       outcome.id
from animals
         JOIN breed ON breed.breed = animals.breed
         join type on type.type = animals.animal_type
         left join outcome
                   on outcome.subtype = animals.outcome_subtype
                       and outcome."type" = animals.outcome_type
                       and outcome."month" = animals.outcome_month
                       and outcome."year" = animals.outcome_year;






