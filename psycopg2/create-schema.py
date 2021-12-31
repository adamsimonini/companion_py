import psycopg2

# Connect to your postgres DB
conn = psycopg2.connect(
    """
        dbname=week3 user=postgres host=localhost port=5432
    """
)
conn.set_session(autocommit=True)


# Open a cursor to perform database operations
cur = conn.cursor()

# DROP TABLES IF EXIST

cur.execute(
    """
        DROP TABLE IF EXISTS companion
    """
)

cur.execute(
    """
        DROP TABLE IF EXISTS city
    """
)

cur.execute(
    """
        DROP TABLE IF EXISTS country
    """
)

cur.execute(
    """
        DROP TABLE IF EXISTS user_account
    """
)

# CREATE TABLES
cur.execute(
    """
        CREATE TABLE user_account (
            user_id SERIAL PRIMARY KEY,
            email TEXT NOT NULL UNIQUE,
            phone_number TEXT NOT NULL UNIQUE,
            birthday TEXT
            created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
        );
    """
)

cur.execute(
    """
        CREATE TABLE country (
            country_id SERIAL PRIMARY KEY,
            country_name TEXT NOT NULL UNIQUE
        );
    """
)

cur.execute(
    """
        CREATE TABLE city (
            city_id SERIAL PRIMARY KEY,
            city_name TEXT NOT NULL UNIQUE,
            fk_country_id INT NOT NULL,
            FOREIGN KEY (fk_country_id) REFERENCES country (country_id) ON UPDATE CASCADE ON DELETE CASCADE
        );
    """
)

cur.execute(
    """
        CREATE TABLE companion (
            companion_id SERIAL PRIMARY KEY,
            companion_name TEXT NOT NULL,
            is_active BOOLEAN DEFAULT FALSE,
            hourly_rate INT DEFAULT 30,
            gender TEXT NOT NULL,
            fk_user_id INT NOT NULL,
            fk_city_id INT NOT NULL,
            FOREIGN KEY (fk_user_id) REFERENCES user_account (user_id) ON DELETE CASCADE,
            FOREIGN KEY (fk_city_id) REFERENCES city (city_id) ON DELETE CASCADE
        );
    """
)

# SEED TABLES
cur.execute(
    """
        INSERT INTO user_account VALUES 
        (1, 'abc@g.com', 'abcdefg', '1231231234', '1990-01-01'),
        (2, 'efg@g.com', 'abcdefg', '4445556666', '1980-01-01'),
        (3, 'hij@g.com', 'abcdefg', '2223334455', '1977-01-01'),
        (4, 'lmn@g.com', 'abcdefg', '9998887766', '1998-01-01'),
        (5, 'opq@g.com', 'abcdefg', '5556667788', '1988-01-01')
    """
)

# Execute a query
cur.execute(
    """
        SELECT * FROM user_account
    """
)

# Retrieve query results
records = cur.fetchall()

print("INSERTED users:", records, '\n')


# cur.execute(
#     """
#     SELECT color, name FROM veggies
#     """
# )

# veggie_records = cur.fetchall()

# for v in veggie_records:
#     print(v[0], v[1])

# print('')

# cur.execute(
#     """
#     SELECT color, name FROM veggies ORDER BY name, color
#     """
# )

# veggies_records = cur.fetchall()

# for i, v in enumerate(veggie_records):
#     print(f"{i + 1}: {v[0].capitalize()} {v[1].capitalize()}")
