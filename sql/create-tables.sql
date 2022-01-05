DROP TABLE IF EXISTS meeting;
DROP TABLE IF EXISTS patron;
DROP TABLE IF EXISTS companion;
DROP TABLE IF EXISTS sexual_orientation;
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

-- create sexual orientation table
CREATE TABLE sexual_orientation (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

-- create companion table
CREATE TABLE companion (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    sex TEXT NOT NULL,
    hourly_rate SMALLINT DEFAULT 30,
    is_active BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    fk_user_account_id INT NOT NULL UNIQUE,
    fk_sexual_orientation_id SMALLINT NOT NULL, 
    fk_city_id INT NOT NULL,
    FOREIGN KEY (fk_user_account_id) REFERENCES user_account (id) ON DELETE CASCADE,
    FOREIGN KEY (fk_sexual_orientation_id) REFERENCES sexual_orientation (id) ON DELETE CASCADE,
    FOREIGN KEY (fk_city_id) REFERENCES city (id) ON DELETE CASCADE
);

-- create patron table
CREATE TABLE patron (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    sex TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    fk_user_account_id INT NOT NULL UNIQUE,
    fk_sexual_orientation_id SMALLINT NOT NULL,
    fk_city_id INT NOT NULL,
    FOREIGN KEY (fk_user_account_id) REFERENCES user_account (id) ON DELETE CASCADE,
    FOREIGN KEY (fk_sexual_orientation_id) REFERENCES sexual_orientation (id) ON DELETE CASCADE,
    FOREIGN KEY (fk_city_id) REFERENCES city (id) ON DELETE CASCADE
);

-- create meetings table; each meeting has a time, a companion, a patron, and a city
CREATE TABLE meeting (
    meeting_id SERIAL PRIMARY KEY,
    datetime TIMESTAMP NOT NULL,
    fk_patron_id INT NOT NULL,
    fk_companion_id INT NOT NULL,
    fk_city_id INT NOT NULL,
    FOREIGN KEY (fk_city_id) REFERENCES city (id) ON DELETE CASCADE,
    FOREIGN KEY (fk_patron_id) REFERENCES patron (id) ON DELETE CASCADE,
    FOREIGN KEY (fk_companion_id) REFERENCES companion (id) ON DELETE CASCADE
);