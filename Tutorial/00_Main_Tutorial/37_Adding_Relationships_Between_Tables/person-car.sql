-- so what we are tyring to achive is 'a person can have one car' & 'car can only belong to one person' 

create table car (
	id BIGSERIAL NOT NULL PRIMARY KEY,
	make VARCHAR(100) NOT NULL,
	model VARCHAR(100) NOT NULL ,
	price NUMERIC(50) NOT NULL
);

create table person (
	id BIGSERIAL NOT NULL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	email VARCHAR(150),
	gender VARCHAR(10) NOT NULL,
	date_of_birth DATE NOT NULL,
	country_of_birth VARCHAR(50) NOT NULL,
	-- let's add relation between car
	car_id BIGINT REFERENCES car(id),
	UNIQUE(car_id)
	-- we can't add 'BIGSERIAL' here because it is a special datatype that is being managed by sequence
	-- rather we have to use 'BIGINT' and that are same in terms of actual size
	-- and also we will not add 'NOT NULL' because person may no have a car
	-- no to reference to another table column we have to use 'REFERENCES' keyword 
	-- and also we have says that 'car can only be own by one person' it means that we can add a unique constraint
);


insert into person (first_name, last_name, email, gender, date_of_birth, country_of_birth) values ('Coraline', 'Bellward', 'cbellward0@newsvine.com', 'Female', '2022-01-08', 'Sweden');
insert into person (first_name, last_name, email, gender, date_of_birth, country_of_birth) values ('Hayley', 'Volker', null, 'Female', '2022-07-05', 'Maldives');
insert into person (first_name, last_name, email, gender, date_of_birth, country_of_birth) values ('Mona', 'Targett', null, 'Female', '2021-09-14', 'Philippines');

insert into car (make, model, price) values ('Cadillac', 'Escalade ESV', '76446.18');
insert into car (make, model, price) values ('Nissan', 'Frontier', '21524.06');