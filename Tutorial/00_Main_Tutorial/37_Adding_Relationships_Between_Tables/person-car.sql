create table person (
	id BIGSERIAL NOT NULL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	email VARCHAR(150),
	gender VARCHAR(10) NOT NULL,
	date_of_birth DATE NOT NULL,
	country_of_birth VARCHAR(50)
);

create table car (
	id BIGSERIAL NOT NULL PRIMARY KEY,
	make VARCHAR(100) NOT NULL,
	model VARCHAR(100) NOT NULL ,
	price NUMERIC(50) NOT NULL
);

insert into person (first_name, last_name, email, gender, date_of_birth, country_of_birth) values ('Coraline', 'Bellward', 'cbellward0@newsvine.com', 'Female', '2022-01-08', 'Sweden');
insert into person (first_name, last_name, email, gender, date_of_birth, country_of_birth) values ('Hayley', 'Volker', null, 'Female', '2022-07-05', 'Maldives');
insert into person (first_name, last_name, email, gender, date_of_birth, country_of_birth) values ('Mona', 'Targett', null, 'Female', '2021-09-14', 'Philippines');


insert into car (id, make, model, price) values (1, 'Cadillac', 'Escalade ESV', '76446.18');
insert into car (id, make, model, price) values (2, 'Nissan', 'Frontier', '21524.06');