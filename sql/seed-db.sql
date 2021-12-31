-- COUNTRIES
INSERT INTO country (country_name) VALUES ('Canada'), ('USA'), ('Mexico'), ('Italy'), ('Japan');
SELECT * FROM country;

-- CITIES
INSERT INTO city (city_name, fk_country_id) VALUES ('Toronto', 1), ('Los Angeles', 2), ('Mexico City', 3), ('Rome', 4), ('Tokyo', 5);

SELECT city_name, country_name FROM city
LEFT JOIN country ON fk_country_id = country_id;

-- SEXUAL ORIENTATIONS
INSERT INTO sexual_orientation (sexual_oreitnation_name) VALUES ('Straight'), ('Gay'), ('Bisexual'), ('Queer'), ('Asexual');

SELECT * FROM sexual_orientation;


-- USERS
INSERT INTO user_account (phone_number, email, registration_date, birthday) VALUES ('444-555-1234', 'julia@gmail.com', DEFAULT, '1994-08-15')

SELECT * FROM user_account    

-- COMPANIONS
INSERT INTO companion (companion_name, is_active, hourly_rate, gender, fk_user_id, fk_city_id) VALUES 
('Julia', true, 30, 'female', 1, 1),
-- ('Alexis', false, 35, 'female', 3, 2);

SELECT * FROM companion