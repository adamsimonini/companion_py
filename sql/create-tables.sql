DROP TABLE IF EXISTS companion_orientation;
DROP TABLE IF EXISTS patrion_orientation;
DROP TABLE IF EXISTS sexual_orientation;
DROP TABLE IF EXISTS meeting;
DROP TABLE IF EXISTS patrion;
DROP TABLE IF EXISTS companion;
DROP TABLE IF EXISTS city;
DROP TABLE IF EXISTS country;
DROP TABLE IF EXISTS user_account;

-- create the user_account table
CREATE TABLE user_account (
    id SERIAL PRIMARY KEY,
    email TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL,
    phone_number TEXT NOT NULL UNIQUE,
    birthday TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- create location tables city and country
CREATE TABLE country (
    id SERIAL PRIMARY KEY,
    country_name TEXT NOT NULL UNIQUE
);

CREATE TABLE city (
    id SERIAL PRIMARY KEY,
    city_name TEXT NOT NULL UNIQUE,
    fk_country_id INT NOT NULL,
    FOREIGN KEY (fk_country_id) REFERENCES country (id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- create companion table
CREATE TABLE companion (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    sex TEXT NOT NULL,
    hourly_rate INT DEFAULT 30,
    is_active BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    fk_user_account_id INT NOT NULL,
    fk_city_id INT NOT NULL,
    FOREIGN KEY (fk_user_account_id) REFERENCES user_account (id) ON DELETE CASCADE,
    FOREIGN KEY (fk_city_id) REFERENCES city (id) ON DELETE CASCADE
);

-- create patrion table
CREATE TABLE patrion (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    fk_user_id INT NOT NULL,
    fk_city_id INT NOT NULL,
    FOREIGN KEY (fk_user_id) REFERENCES user_account (id) ON DELETE CASCADE,
    FOREIGN KEY (fk_city_id) REFERENCES city (id) ON DELETE CASCADE
);

-- create sexual orientation table
CREATE TABLE sexual_orientation (
    id SERIAL PRIMARY KEY,
    sexual_oreitnation_name TEXT NOT NULL
);

-- create junction table for many-to-many relationship between the companion and sexual orientation tables
CREATE TABLE companion_orientation (
    companion_id INT REFERENCES companion (id) ON UPDATE CASCADE ON DELETE CASCADE,
	sexual_orientation_id INT REFERENCES sexual_orientation (id) ON UPDATE CASCADE,
    PRIMARY KEY (companion_id, sexual_orientation_id)
);

-- create junction table for many-to-many relationship between the patrion and sexual orientation tables
CREATE TABLE patrion_orientation (
    patrion_id INT REFERENCES patrion (id) ON UPDATE CASCADE ON DELETE CASCADE,
	sexual_orientation_id INT REFERENCES sexual_orientation (id) ON UPDATE CASCADE,
    PRIMARY KEY (patrion_id, sexual_orientation_id)
);

-- create meetings table; each meeting has a time, a companion, a patrion, and a city
CREATE TABLE meeting (
    meeting_id SERIAL PRIMARY KEY,
    datetime TIMESTAMP NOT NULL,
    fk_patrion_id INT NOT NULL,
    fk_companion_id INT NOT NULL,
    fk_city_id INT NOT NULL,
    FOREIGN KEY (fk_city_id) REFERENCES city (id) ON DELETE CASCADE,
    FOREIGN KEY (fk_patrion_id) REFERENCES patrion (id) ON DELETE CASCADE,
    FOREIGN KEY (fk_companion_id) REFERENCES companion (id) ON DELETE CASCADE
);