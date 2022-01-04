-- COUNTRIES
INSERT INTO country (country_name) VALUES ('Canada'), ('USA'), ('Mexico'), ('Italy'), ('Japan');
SELECT * FROM country;

-- CITIES
INSERT INTO city (city_name, fk_country_id) VALUES ('Toronto', 1), ('Los Angeles', 2), ('Mexico City', 3), ('Rome', 4), ('Tokyo', 5);

SELECT city_name, country_name FROM city
LEFT JOIN country ON city.fk_country_id = country.id;

-- SEXUAL ORIENTATIONS
INSERT INTO sexual_orientation (sexual_oreitnation_name) VALUES ('Straight'), ('Gay'), ('Bisexual'), ('Queer'), ('Asexual');

SELECT * FROM sexual_orientation;


-- USERS
INSERT INTO user_account (email, password, phone_number, birthday) VALUES 
('efg@g.com', 'abcdefg', '4445556666', '1980-01-01'),
('hij@g.com', 'abcdefg', '2223334455', '1977-01-01'),
('lmn@g.com', 'abcdefg', '9998887766', '1998-01-01'),
('opq@g.com', 'abcdefg', '5556667788', '1988-01-01');

SELECT * FROM user_account;

-- COMPANIONS
INSERT INTO companion (name, sex, hourly_rate, is_active, fk_user_account_id, fk_city_id) VALUES 
('Julia', 'female', 30, false, 1, 1), ('Alexis', 'female', 35, true, 2, 3);

SELECT * FROM companion;